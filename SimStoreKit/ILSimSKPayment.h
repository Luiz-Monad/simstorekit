//
//  ILSimSKPayment.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit

#import <Foundation/Foundation.h>

@class ILSimSKProduct;

NS_ASSUME_NONNULL_BEGIN

@interface ILSimSKPayment : NSObject <NSCopying, NSMutableCopying> {}

+ (instancetype)paymentWithProduct:(ILSimSKProduct*) product;
+ (instancetype)paymentWithProductIdentifier:(NSString*) identifier;

@property(nonatomic, copy, readonly) NSString* productIdentifier;
@property(nonatomic, copy, readonly, nullable) NSData* requestData;
@property(nonatomic, readonly) NSInteger quantity;

@end

@interface ILSimSKMutablePayment : ILSimSKPayment {}

@property(nonatomic, copy) NSString* productIdentifier;
@property(nonatomic, copy, nullable) NSData* requestData;
@property(nonatomic) NSInteger quantity;

@end

NS_ASSUME_NONNULL_END

#endif // #if kILSimAllowSimulatedStoreKit
