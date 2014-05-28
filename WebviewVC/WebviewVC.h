//
//  WebviewVC.h
//
//  Created by Bob de Graaf on 26-01-11.
//  Copyright 2011 Mobile Pioneers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class WebviewVC;

@protocol WebviewVCDelegate <NSObject>
@optional
-(void)WVCdismissed:(WebviewVC *)webviewVC;
-(void)purchaseIAS:(NSString *)appStoreID;
@end

@interface WebviewVC : UIViewController <MFMailComposeViewControllerDelegate, UIWebViewDelegate>
{
	UIButton *closeButton;
    UIButton *backButton;
    UIButton *forwButton;
    UIButton *mailButton;
    UIButton *safaButton;
    
	UIWebView *web;
    UIViewController *parent;
    NSMutableDictionary *headersDict;
    
    int buttonDelay;
    bool hideButtons;
    bool fullRotation;
    bool alwaysReload;
    bool popAfterLeaving;
    bool pushedFromNavController;
}

-(void)openSafari;
-(void)nextWebpage;
-(void)previousWebPage;

@property(nonatomic,assign) id<WebviewVCDelegate> delegate;
@property(nonatomic) UIBarStyle barStyle;

@property(nonatomic,retain) NSString *urlStr;
@property(nonatomic,retain) NSString *htmlStr;
@property(nonatomic,retain) NSString *navTitle;
@property(nonatomic,retain) NSString *mailBody;
@property(nonatomic,retain) NSString *appStoreID;
@property(nonatomic,retain) NSString *mailSubject;
@property(nonatomic,retain) NSString *mailToAddress;
@property(nonatomic,strong) NSString *mailPopupText;

@property(nonatomic,retain) UIViewController *parent;
@property(nonatomic,strong) NSMutableDictionary *headersDict;

@property(nonatomic) int buttonDelay;
@property(nonatomic) bool hideButtons;
@property(nonatomic) bool fullRotation;
@property(nonatomic) bool alwaysReload;
@property(nonatomic) bool popAfterLeaving;
@property(nonatomic) bool pushedFromNavController;

@end