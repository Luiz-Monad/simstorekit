//
//  ILSimTransactionSimulator.m
//  SimStoreKit
//
//  Created by ∞ on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit

#import "ILSimTransactionSimulator.h"

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface ILSimDefaultTransactionSimulator_iOS : NSObject <ILSimTransactionSimulator, UIAlertViewDelegate>
@end

typedef NS_ENUM(NSInteger, Result) {
    Success,
    Failure,
    Cancel
};

@implementation ILSimDefaultTransactionSimulator_iOS

- (void) simulateTransaction:(ILSimSKPaymentTransaction *)transaction product:(ILSimSKProduct*) p forQueue:(ILSimSKPaymentQueue *)queue completionHandler:(void (^)(NSError *))handler;
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter new] autorelease];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:p.priceLocale];
    NSString* formattedPrice = [numberFormatter stringFromNumber:p.price];
    NSString* title =
        [NSString stringWithFormat:@"SIMULATED: Would you like to buy %ld x '%@' at %@?", (long)transaction.payment.quantity, p.localizedTitle, formattedPrice];

    UIAlertController* a =
        [UIAlertController
            alertControllerWithTitle:title
            message:@"Message"
            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* yesButton =
        [UIAlertAction
            actionWithTitle:@"Succeed Transaction"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
            [self transactionDone:transaction withResult:Success completionHandler:handler];
        }];

    UIAlertAction* noButton =
        [UIAlertAction
            actionWithTitle:@"Fail Transaction"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
            [self transactionDone:transaction withResult:Failure completionHandler:handler];
        }];

    UIAlertAction* cancelButton =
        [UIAlertAction
            actionWithTitle:@"Cancel Transaction"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * action) {
            [self transactionDone:transaction withResult:Cancel completionHandler:handler];
        }];
    
    [a addAction:yesButton];
    [a addAction:noButton];
    [a addAction:cancelButton];

    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:a animated:YES completion:nil];
}

- (void)transactionDone:(ILSimSKPaymentTransaction *)transaction withResult:(Result)result completionHandler:(void (^)(NSError *))completionHandler;
{
	if (!completionHandler)
		return;
	
	switch (result) {
		case Success:
			completionHandler(nil);
			break;
		case Failure:
			completionHandler([NSError errorWithDomain:kILSimSKErrorDomain code:ILSimSKErrorUnknown userInfo:nil]);
			break;
		case Cancel:
		default:
			completionHandler([NSError errorWithDomain:kILSimSKErrorDomain code:ILSimSKErrorPaymentCancelled userInfo:nil]);
			break;
	}
}

@end

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

#import <Cocoa/Cocoa.h>

@interface ILSimDefaultTransactionSimulator_Mac : NSObject <ILSimTransactionSimulator>
@end

@implementation ILSimDefaultTransactionSimulator_Mac

- (void) simulateTransaction:(ILSimSKPaymentTransaction *)transaction product:(ILSimSKProduct*) p forQueue:(ILSimSKPaymentQueue *)queue completionHandler:(void (^)(NSError *))block;
{
	NSAlert* a = [[NSAlert new] autorelease];
	
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter new] autorelease];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:p.priceLocale];
	NSString* formattedPrice = [numberFormatter stringFromNumber:p.price];
	
	[a setMessageText:[NSString stringWithFormat:@"Simulated StoreKit: Would you like to buy %d x '%@' at %@?", transaction.payment.quantity, p.localizedTitle, formattedPrice]];

	[a addButtonWithTitle:@"Succeed Transaction"];
	[a addButtonWithTitle:@"Cancel"];
	[a addButtonWithTitle:@"Fail Transaction"];

	NSInteger result = [a runModal];
	switch (result) {
		case NSAlertFirstButtonReturn:
			block(nil);
			break;
			
		case NSAlertSecondButtonReturn:
			block([NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSKErrorUnknown userInfo:nil]);
			break;
			
		case NSAlertThirdButtonReturn:
			block([NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSKErrorUnknown userInfo:nil]);
			break;
	}
}

@end

#endif


id <ILSimTransactionSimulator> ILSimDefaultTransactionSimulator() {
	static id simulator = nil; if (!simulator) {
#if TARGET_OS_IPHONE
		simulator = [ILSimDefaultTransactionSimulator_iOS new];
#elif TARGET_OS_MAC && !TARGET_OS_IPHONE
		simulator = [ILSimDefaultTransactionSimulator_Mac new];
#endif
	}
	
	return simulator;
}


#endif // kILSimAllowSimulatedStoreKit
