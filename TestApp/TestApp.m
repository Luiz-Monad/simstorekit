//
//  TestApp.m
//  SimStoreKit
//
//  Created by ∞ on 03/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestApp.h"

@implementation TestApp

- (id) init
{
#if TARGET_OS_MAC && !TARGET_OS_IPHONE
	setenv("ILSimSKProductsPlist", [[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"] fileSystemRepresentation], 1);
#endif
	
    self = [super init];
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    return self;
}

- (IBAction) buy;
{
	SKProductsRequest* pr = [[SKProductsRequest alloc] initWithProductIdentifiers:
							 [NSSet setWithObject:@"TestItem"]
							 ];
	pr.delegate = self;
	[pr start];
}

- (IBAction) restore;
{
	[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response;
{
	if ([response.products count] == 0)
		return;
	
	SKProduct* p = [response.products objectAtIndex:0];
	SKPayment* pay = [SKPayment paymentWithProduct:p];
	[[SKPaymentQueue defaultQueue] addPayment:pay];
}

- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
{
	NSLog(@"%@", transactions);
	
	for (SKPaymentTransaction* t in transactions) {
		if (t.transactionState == SKPaymentTransactionStatePurchased || t.transactionState == SKPaymentTransactionStateFailed) {
            NSLog(@"%@ -> state %ld", t, (long)t.transactionState);
			[queue finishTransaction:t];
		}
	}
}

@end
