//
//  InAppPurchase.h
//  MPAds
//
//  Created by Bob de Graaf on 01-02-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import <Foundation/Foundation.h>

@protocol IAPDelegate <NSObject>
-(void)didFailIAP;
-(void)didCancelIAP;
-(void)didPurchaseIAP;
-(void)didRestoreIAP:(NSString *)productID;
-(void)dismissVC;
-(void)presentVC:(UIViewController *)viewController;
@end

@interface InAppPurchase : NSObject <SKRequestDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    NSString *productID;
}

-(void)restoreIAP;
-(void)purchaseIAP;

@property(nonatomic,strong) NSString *productID;
@property(nonatomic,assign) id<IAPDelegate> delegate;

+(InAppPurchase *)sharedInAppPurchase;

@end