//
//  InAppPurchase.m
//  MPAds
//
//  Created by Bob de Graaf on 01-02-13.
//  Copyright (c) 2013 MobilePioneers. All rights reserved.
//

#import "InAppPurchase.h"

@implementation InAppPurchase
@synthesize productID;

+(id)sharedInAppPurchase
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

-(id)init
{
    self = [super init];
    if (self)
	{
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void)purchaseIAP
{
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
    request.delegate = self;
    [request start];
}

-(void)restoreIAP
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - SKProductsRequestDelegate methods

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *myProducts = response.products;
    for(SKProduct *product in myProducts)
    {
        if([product.productIdentifier isEqualToString:self.productID])
        {
            NSLog(@"Requesting: %@ %@ %@", product.localizedDescription, product.productIdentifier, product.price);
            SKPayment *payment = [SKPayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            break;
        }
    }
}

#pragma mark - Updating transaction methods

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

#pragma mark - Restoring transactions

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"Restored transactions completed: %d", queue.transactions.count);    
    for(SKPaymentTransaction *transaction in queue.transactions)
    {  
        if([self.delegate respondsToSelector:@selector(didRestoreIAP:)])
        {
            [self.delegate performSelector:@selector(didRestoreIAP:) withObject:transaction.payment.productIdentifier];
        }
    }
}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"Restore completed transactions failed, error: %@",error);
}

#pragma mark - Private methods

-(void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"Completed transaction");
    if([transaction.payment.productIdentifier isEqualToString:self.productID])
    {        
        if([self.delegate respondsToSelector:@selector(didPurchaseIAP)])
        {
            [self.delegate performSelector:@selector(didPurchaseIAP)];
        }
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"Restored transaction");
    if([self.delegate respondsToSelector:@selector(didRestoreIAP:)])
    {
        [self.delegate performSelector:@selector(didRestoreIAP:) withObject:transaction.payment.productIdentifier];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)failedTransaction:(SKPaymentTransaction *)transaction
{    
    if(transaction.error.code == SKErrorPaymentCancelled)
    {
        NSLog(@"Cancelled transaction");
        if([self.delegate respondsToSelector:@selector(didCancelIAP)])
        {
            [self.delegate performSelector:@selector(didCancelIAP)];
        }
    }
    else
    {
        NSLog(@"Failed transaction, error: %@", transaction.error.description);
        if([self.delegate respondsToSelector:@selector(didFailIAP)])
        {
            [self.delegate performSelector:@selector(didFailIAP)];
        }
    }    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

@end














