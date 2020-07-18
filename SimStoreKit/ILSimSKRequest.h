//
//  ILSimSKRequest.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit

#import <Foundation/Foundation.h>

#import "ILSimSKProduct.h"
#import "ILSimSKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ILSimSKRequestDelegate;

@interface ILSimSKRequest : NSObject {}

- (void) start;
- (void) cancel;

@property(assign, nullable) id <ILSimSKRequestDelegate> delegate;

@end

@protocol ILSimSKRequestDelegate <NSObject>

@optional
- (void)request:(ILSimSKRequest *)request didFailWithError:(NSError *)error;
- (void)requestDidFinish:(ILSimSKRequest *)request;

@end

NS_ASSUME_NONNULL_END

#endif // #if kILSimAllowSimulatedStoreKit
