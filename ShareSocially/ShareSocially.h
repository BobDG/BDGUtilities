//
//  ShareSocially.h
//
//  Created by Bob de Graaf on 09-10-12.
//  Copyright (c) 2012 GraafICT. All rights reserved.
//

#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <Foundation/Foundation.h>

@protocol BGShareDelegate <NSObject>
-(void)BGSSpresentVC:(UIViewController *)viewController;
-(void)BGSSpresentActivityVC:(UIViewController *)viewController;
-(void)BGSSdismissVC;
@optional
-(void)BGSSshareFailed;
-(void)BGSSshareCompleted;
-(void)BGSSshareCancelled;
@end


@interface ShareSocially : NSObject <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
{
    
}

@property(nonatomic,assign) id<BGShareDelegate> delegate;

-(void)shareSMS:(NSString *)message recipient:(NSArray *)recipients;
-(void)shareTwitter:(NSString *)text urlStr:(NSString *)url image:(UIImage *)image;
-(void)shareFacebook:(NSString *)text urlStr:(NSString *)url image:(UIImage *)image;
-(void)shareWeibo:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image;
-(void)shareUsingActivityController:(NSString *)text urlStr:(NSString *)urlStr image:(UIImage *)image;
-(void)shareEmail:(NSString*)mailSubject mailBody:(NSString*)mailBody recipients:(NSArray *)recipients isHTML:(BOOL)isHTML;

@end