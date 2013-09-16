//
//  WebviewVC.m
//
//  Created by Bob de Graaf on 26-01-11.
//  Copyright 2011 Mobile Pioneers. All rights reserved.

#import "WebviewVC.h"
#import "TransparentToolbar.h"

@implementation WebviewVC
@synthesize buttonDelay, parent, hideButtons, fullRotation, headersDict, pushedFromNavController;
@synthesize alwaysReload, popAfterLeaving, appStoreID, delegate;

-(void)dealloc
{
    web.delegate = nil;
    self.parent = nil;
    self.urlStr = nil;
    self.navTitle = nil;
    self.appStoreID = nil;
}

#pragma mark Init

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    //navigation item
    if(self.navTitle.length>0)
    {
        self.title = self.navTitle;
    }
    
    if(!pushedFromNavController)
    {
        //close button
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(0, 0, 24, 24);
        closeButton.showsTouchWhenHighlighted = TRUE;
        [closeButton setImage:[UIImage imageNamed:@"WVC_Exit.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    }
    
    //webview
    web = [[UIWebView alloc] initWithFrame:CGRectZero];
    web.backgroundColor = [UIColor clearColor];
    web.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    web.scalesPageToFit = TRUE;
    web.delegate = self;
    self.view = web;
    
    if(!hideButtons)
    {
        //back button
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 25, 25);
        backButton.showsTouchWhenHighlighted = TRUE;
        [backButton setImage:[UIImage imageNamed:@"WVC_Back.png"] forState:UIControlStateNormal];
        [backButton addTarget:web action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //forward button
        forwButton = [UIButton buttonWithType:UIButtonTypeCustom];
        forwButton.frame = CGRectMake(0, 0, 25, 25);
        forwButton.showsTouchWhenHighlighted = TRUE;
        [forwButton setImage:[UIImage imageNamed:@"WVC_Forward.png"] forState:UIControlStateNormal];
        [forwButton addTarget:web action:@selector(goForward) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *forwItem = [[UIBarButtonItem alloc] initWithCustomView:forwButton];
        
        //mail button
        mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mailButton.frame = CGRectMake(0, 0, 24, 16);
        [mailButton setImage:[UIImage imageNamed:@"WVC_Mail.png"] forState:UIControlStateNormal];
        [mailButton addTarget:self action:@selector(openMail) forControlEvents:UIControlEventTouchUpInside];
        mailButton.showsTouchWhenHighlighted = TRUE;
        UIBarButtonItem *mailItem = [[UIBarButtonItem alloc] initWithCustomView:mailButton];
        
        //safari button
        safaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        safaButton.frame = CGRectMake(0, 0, 24, 24);
        safaButton.showsTouchWhenHighlighted = TRUE;
        [safaButton setImage:[UIImage imageNamed:@"WVC_Safari.png"] forState:UIControlStateNormal];
        [safaButton addTarget:self action:@selector(openSafari) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *safaItem = [[UIBarButtonItem alloc] initWithCustomView:safaButton];
        
        UIBarButtonItem *space1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *space2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *space3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        //toolbar
        TransparentToolbar *tBar = [[TransparentToolbar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        [tBar setItems:[NSArray arrayWithObjects:backItem, space1, forwItem, space2, mailItem, space3, safaItem, nil]];
        UIBarButtonItem *tBarButton = [[UIBarButtonItem alloc] initWithCustomView:tBar];
        self.navigationItem.rightBarButtonItem = tBarButton;
        
        if(buttonDelay != 0)
        {
            backButton.hidden = TRUE;
            forwButton.hidden = TRUE;
            mailButton.hidden = TRUE;
            safaButton.hidden = TRUE;
            closeButton.hidden = TRUE;
            [self performSelector:@selector(setButtonsEnabled) withObject:nil afterDelay:buttonDelay];
        }
    }
    else if(buttonDelay != 0 && !pushedFromNavController)
    {
        closeButton.hidden = TRUE;
        [self performSelector:@selector(setCloseButtonEnabled) withObject:nil afterDelay:buttonDelay];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//[self performSelector:@selector(loadURL) withObject:nil afterDelay:0.01];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[self performSelector:@selector(loadURL) withObject:nil afterDelay:0.01];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    web.delegate = nil;
}

-(void)popControllerDelayed
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.navigationController popViewControllerAnimated:FALSE];
}

#pragma mark webview delegate

-(BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    //First check if we should just open the AppStore
    if(inType == UIWebViewNavigationTypeLinkClicked)
	{
        if(self.appStoreID.length>0 && [[UIDevice currentDevice] systemVersion].floatValue >= 6.0)
        {
            if([self.delegate respondsToSelector:@selector(purchaseIAS:)])
            {
                [self.delegate performSelector:@selector(purchaseIAS:) withObject:self.appStoreID];
                return NO;
            }
        }
        else if(self.mailToAddress.length>0)
        {
            [self openInAppEmail:self.mailSubject mailBody:self.mailBody mailTo:self.mailToAddress isHtml:FALSE];
            return NO;
        }
    }
    
    //NSLog(@"Start: %@", [[inRequest URL] absoluteString]);
	bool safari = false;
	if([[[inRequest URL] absoluteString] rangeOfString:@"itunes.apple.com"].location != NSNotFound)
	{
		safari = true;
	}
	else if([[[inRequest URL] absoluteString] rangeOfString:@"openinsafari"].location != NSNotFound)
	{
		safari = true;
	}
	else if([[[inRequest URL] absoluteString] isEqualToString:@"https://m.facebook.com/plugins/login_success.php"])
	{
		//Open facebook login in ModalViewController
        if(![self.title isEqualToString:NSLocalizedStringFromTable(@"FacebookLogin", @"WVCLocalizable", @"")])
        {
            WebviewVC *wvc = [[WebviewVC alloc] init];
            wvc.urlStr = [[inRequest URL] absoluteString];
            wvc.hideButtons = TRUE;
            wvc.parent = self.parent;
            wvc.barStyle = self.barStyle;
            wvc.title = NSLocalizedStringFromTable(@"FacebookLogin", @"WVCLocalizable", @"");
            wvc.pushedFromNavController = FALSE;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:wvc];
            [self.parent presentModalViewController:nav animated:TRUE];
            return NO;
        }
        return TRUE;
	}
	if(safari)
	{
		[[UIApplication sharedApplication] openURL:[inRequest URL]];
        if(popAfterLeaving)
        {
            [self performSelector:@selector(popControllerDelayed) withObject:nil afterDelay:0.5];
        }
        else
        {
            //Check whether I'm a modal viewcontroller
            if(inType != UIWebViewNavigationTypeLinkClicked && ((self.presentingViewController && self.presentingViewController.modalViewController == self) || (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController)))
            {
                NSLog(@"I was presented as a modal viewcontroller, will remove myself");
                [self dismissModalViewControllerAnimated:TRUE];
            }
        }        
		return NO;
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Fail: %@", [error description]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)w
{
    //NSLog(@"Finish");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)loadURL
{
    if(self.urlStr.length>0)
    {
        //NSLog(@"url string load: %@", self.urlStr);
        NSURL *url = [NSURL URLWithString:self.urlStr];
        NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url];
        [requestObj setAllHTTPHeaderFields:headersDict];
        [web loadRequest:requestObj];
    }
    else if(self.htmlStr.length>0)
    {
        //NSLog(@"html string load: %@", self.htmlStr);
        [web loadHTMLString:self.htmlStr baseURL:nil];
    }
}

#pragma mark alertview delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// NO = 0, YES = 1
	if(buttonIndex == 1)
	{
		[[UIApplication sharedApplication] openURL:web.request.URL];
	}
}

#pragma mark email

-(void)openInAppEmail:(NSString*)subject mailBody:(NSString*)body mailTo:(NSString *)mailTo isHtml:(BOOL)isHtml
{
	@try
	{
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:subject];
		[controller setMessageBody:body isHTML:isHtml];
        [controller.navigationBar setBarStyle:self.barStyle];
        if(mailTo.length>0)
        {
            [controller setToRecipients:[NSArray arrayWithObject:mailTo]];
        }
        if(controller != nil)
        {
            if(parent.modalViewController)
                [self.parent.modalViewController presentModalViewController:controller animated:TRUE];
            else
                [self.parent presentModalViewController:controller animated:YES];
        }
	}
	@catch (NSException * e)
	{
        NSLog(@"Mail account niet actief, Apple geeft vanzelf bericht. %@", [e description]);
	}
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if(result == MFMailComposeResultSent)
    {
        if(self.mailPopupText.length>0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:self.mailPopupText delegate:nil cancelButtonTitle:NSLocalizedStringFromTable(@"OK", @"WVCLocalizable", @"") otherButtonTitles:nil];
            [alert show];
        }
    }
	[self.parent dismissModalViewControllerAnimated:YES];
}

#pragma mark Button Actions

-(void)openMail
{
	NSString *pag = [web.request.URL absoluteString];
	NSString *subject = NSLocalizedStringFromTable(@"PageLink", @"WVCLocalizable", @"");
	[self openInAppEmail:subject mailBody:pag mailTo:nil isHtml:FALSE];
}

-(void)nextWebpage
{
    [web goForward];
}

-(void)previousWebPage
{
    [web goBack];
}

-(void)openSafari
{
	UIAlertView *a = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"OpenInSafari", @"WVCLocalizable", @"") message:NSLocalizedStringFromTable(@"OpenInSafariDetails", @"WVCLocalizable", @"") delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"Cancel", @"WVCLocalizable", @"") otherButtonTitles:NSLocalizedStringFromTable(@"Yes", @"WVCLocalizable", @""), nil];
	[a show];
}

-(void)done
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self dismissModalViewControllerAnimated:YES];
}

-(void)setButtonsEnabled
{
    closeButton.hidden = FALSE;
    backButton.hidden = FALSE;
    forwButton.hidden = FALSE;
    mailButton.hidden = FALSE;
    safaButton.hidden = FALSE;
}

-(void)setCloseButtonEnabled
{
    closeButton.hidden = FALSE;
}

#pragma mark Rotation

-(NSUInteger)supportedInterfaceOrientations
{
    if(fullRotation)
    {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(fullRotation)
    {
        return TRUE;
    }
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end





















