//
//  ShareSocially.m
//
//  Created by Bob de Graaf on 09-10-12.
//  Copyright (c) 2012 GraafICT. All rights reserved.
//

#import "ShareSocially.h"

@implementation ShareSocially
@synthesize delegate;

-(void)shareUsingServiceType:(NSString *)serviceType text:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result)
        {
            [controller dismissViewControllerAnimated:YES completion:nil];
            switch(result)
            {
                case SLComposeViewControllerResultCancelled:
                {
                    if([self.delegate respondsToSelector:@selector(BGSSshareCancelled)])
                    {
                        [self.delegate BGSSshareCancelled];
                    }
                    break;
                }
                case SLComposeViewControllerResultDone:
                {
                    if([self.delegate respondsToSelector:@selector(BGSSshareCompleted)])
                    {
                        [self.delegate BGSSshareCompleted];
                    }
                    break;
                }
            }};
        if(nil != image)
            [controller addImage:image];
        if(urlStr.length>0)
            [controller addURL:[NSURL URLWithString:urlStr]];
        if(text.length>0)
            [controller setInitialText:text];
        [controller setCompletionHandler:completionHandler];
        if([self.delegate respondsToSelector:@selector(BGSSpresentVC:)])
        {
            [self.delegate BGSSpresentVC:controller];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedStringFromTable(@"BGSSAlertIOS6", @"BGSS_Localizable", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
        if([self.delegate respondsToSelector:@selector(BGSSshareFailed)])
        {
            [self.delegate BGSSshareFailed];
        }
    }
}

-(void)shareTwitter:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image
{
    [self shareUsingServiceType:SLServiceTypeTwitter text:text urlStr:urlStr image:image];
}

-(void)shareFacebook:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image
{
    [self shareUsingServiceType:SLServiceTypeFacebook text:text urlStr:urlStr image:image];
}

-(void)shareWeibo:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image
{
    [self shareUsingServiceType:SLServiceTypeSinaWeibo text:text urlStr:urlStr image:image];
}

-(void)shareUsingActivityController:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
    {
        NSMutableArray *activities = [[NSMutableArray alloc] init];
        if(text.length>0)
            [activities addObject:text];
        if(urlStr.length>0)
            [activities addObject:[NSURL URLWithString:urlStr]];
        if(nil != image)
            [activities addObject:image];
        
        UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:activities applicationActivities:nil];        
        if([self.delegate respondsToSelector:@selector(BGSSpresentActivityVC:)])
        {
            [self.delegate BGSSpresentActivityVC:controller];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedStringFromTable(@"BGSSAlertIOS6", @"BGSS_Localizable", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
        if([self.delegate respondsToSelector:@selector(BGSSshareFailed)])
        {
            [self.delegate BGSSshareFailed];
        }
    }
}

#pragma mark Email

-(void)mailFailed
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedStringFromTable(@"BGSSAlertEmailFail", @"BGSS_Localizable", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
    if([self.delegate respondsToSelector:@selector(BGSSshareFailed)])
    {
        [self.delegate BGSSshareFailed];
    }
}

-(void)shareEmail:(NSString*)mailSubject mailBody:(NSString*)mailBody recipients:(NSArray *)recipients isHTML:(BOOL)isHTML
{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:recipients];
    [controller setSubject:mailSubject];
    [controller setMessageBody:mailBody isHTML:isHTML];
    if(controller != nil)
    {
        if([self.delegate respondsToSelector:@selector(BGSSpresentVC:)])
        {
            [self.delegate BGSSpresentVC:controller];
        }
    }
    else
    {
        [self mailFailed];
    }
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	if([self.delegate respondsToSelector:@selector(BGSSdismissVC)])
    {
        [self.delegate BGSSdismissVC];
    }
    if(result == MFMailComposeResultSent)
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareCompleted)])
        {
            [self.delegate BGSSshareCompleted];
        }
    }
    else if(result == MFMailComposeResultSaved)
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareCompleted)])
        {
            [self.delegate BGSSshareCompleted];
        }
    }
    else if(result == MFMailComposeResultCancelled)
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareCancelled)])
        {
            [self.delegate BGSSshareCancelled];
        }
    }    
    else
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareFailed)])
        {
            [self.delegate BGSSshareFailed];
        }
    }
}

#pragma mark SMS

-(void)smsFailed
{
    [[[UIAlertView alloc] initWithTitle:@"Error" message:NSLocalizedStringFromTable(@"BGSSAlertSMSFail", @"BGSS_Localizable", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
    if([self.delegate respondsToSelector:@selector(BGSSshareFailed)])
    {
        [self.delegate BGSSshareFailed];
    }
}

-(void)shareSMS:(NSString *)message recipient:(NSArray *)recipients
{
    Class smsClass = (NSClassFromString(@"MFMessageComposeViewController"));
	if(smsClass)
    {
		if([MFMessageComposeViewController canSendText])
        {
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
			controller.messageComposeDelegate = self;
			controller.body = message;
            controller.recipients = recipients;
            if(controller)
            {
                if([self.delegate respondsToSelector:@selector(BGSSpresentVC:)])
                {
                    [self.delegate BGSSpresentVC:controller];
                }
            }
            else
            {
                [self smsFailed];
            }
		}
		else
        {
            [self smsFailed];
		}
	}
	else
    {
        [self smsFailed];
	}
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	if([self.delegate respondsToSelector:@selector(BGSSdismissVC)])
    {
        [self.delegate BGSSdismissVC];
    }
    if(result == MessageComposeResultSent)
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareCompleted)])
        {
            [self.delegate BGSSshareCompleted];
        }
    }
    else if(result == MessageComposeResultCancelled)
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareCancelled)])
        {
            [self.delegate BGSSshareCancelled];
        }
    }
    else if(result == MessageComposeResultFailed)
    {
        if([self.delegate respondsToSelector:@selector(BGSSshareFailed)])
        {
            [self.delegate BGSSshareFailed];
        }
    }
}

@end






































