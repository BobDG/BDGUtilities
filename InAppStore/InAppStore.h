//
//  InAppStore.h
//  MPAds
//
//  Created by Bob de Graaf on 28-05-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol IASDelegate <NSObject>
-(void)didEndIAS;
-(void)didFailIAS;
-(void)dismissVC;
-(void)presentVC:(UIViewController *)viewController;
@end

@interface InAppStore : NSObject <SKStoreProductViewControllerDelegate>
{
    
}

-(void)buyApp:(NSString *)appID;
-(void)giftApp:(NSString *)appID;
-(void)reviewApp:(NSString *)appID;
-(void)buyAppInApp:(NSString *)appID;

@property(nonatomic,assign) id<IASDelegate> delegate;
@property(nonatomic,strong) NSString *tradeDoublerPrefix;

+(InAppStore *)sharedInAppStore;

@end
