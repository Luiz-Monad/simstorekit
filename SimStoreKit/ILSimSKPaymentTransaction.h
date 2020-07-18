//
//  ILSimSKPaymentTransaction.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit

#import <Foundation/Foundation.h>

#import "ILSimSKPayment.h"

typedef NS_ENUM(NSInteger, ILSimSKPaymentTransactionState) {
    ILSimSKPaymentTransactionStatePurchasing,    // Transaction is being added to the server queue.
    ILSimSKPaymentTransactionStatePurchased,     // Transaction is in queue, user has been charged.  Client should complete the transaction.
    ILSimSKPaymentTransactionStateFailed,        // Transaction was cancelled or failed before being added to the server queue.
    ILSimSKPaymentTransactionStateRestored,      // Transaction was restored from user's purchase history.  Client should complete the transaction.
    ILSimSKPaymentTransactionStateDeferred       // The transaction is in the queue, but its final status is pending external action.
};

NS_ASSUME_NONNULL_BEGIN

@interface ILSimSKPaymentTransaction : NSObject {}

@property(nonatomic, readonly, copy, nullable) NSError* error;
@property(nonatomic, readonly, retain, nullable) ILSimSKPaymentTransaction* originalTransaction;
@property(nonatomic, readonly, copy) ILSimSKPayment* payment;
@property(nonatomic, readonly, copy, nullable) NSDate* transactionDate;
@property(nonatomic, readonly, copy, nullable) NSString* transactionIdentifier;
@property(nonatomic, readonly, copy, nullable) NSData* transactionReceipt;
@property(nonatomic, readonly, assign) ILSimSKPaymentTransactionState transactionState;

@end

NS_ASSUME_NONNULL_END

#endif // #if kILSimAllowSimulatedStoreKit
