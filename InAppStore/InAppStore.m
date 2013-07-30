//
//  InAppStore.m
//  MPAds
//
//  Created by Bob de Graaf on 28-05-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import "InAppStore.h"

@implementation InAppStore
@synthesize delegate;

+(id)sharedInAppStore
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)openURL:(NSString *)urlStr
{
    if(self.tradeDoublerPrefix.length>0)
    {
        urlStr = [NSString stringWithFormat:@"%@%@", self.tradeDoublerPrefix, urlStr];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

-(void)buyApp:(NSString *)appID
{
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@", appID];
    [self openURL:urlStr];
}

-(void)giftApp:(NSString *)appID
{
    NSString *urlStr = [NSString stringWithFormat:@"itms-appss://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=%@&productType=C&pricingParameter=STDQ&mt=8&ign-mscache=1", appID];
    [self openURL:urlStr];
}

-(void)reviewApp:(NSString *)appID
{    
    //NSString *urlStr = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appID];
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appID];
    [self openURL:urlStr];    
}

-(void)buyAppInApp:(NSString *)appID
{
    if(([[UIDevice currentDevice] systemVersion].floatValue >= 6.0))
    {
        SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
        [storeProductViewController setDelegate:self];
        [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appID} completionBlock:^(BOOL result, NSError *error)
         {
             if(error)
             {
                 NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
                 if([delegate respondsToSelector:@selector(didFailIAS)])
                 {
                     [delegate performSelector:@selector(didFailIAS)];
                 }
             }
             else
             {
                 if([delegate respondsToSelector:@selector(presentVC:)])
                 {
                     [delegate performSelector:@selector(presentVC:) withObject:storeProductViewController];
                 }
             }
         }];
    }
    else
    {
        NSLog(@"No iOS6, will open AppStore");
        [self buyApp:appID];
    }
}

-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    if([delegate respondsToSelector:@selector(dismissVC)])
    {
        [delegate performSelector:@selector(dismissVC)];
    }
    if([delegate respondsToSelector:@selector(didEndIAS)])
    {
        [delegate performSelector:@selector(didEndIAS)];
    }
}

@end