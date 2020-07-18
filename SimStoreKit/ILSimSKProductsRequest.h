//
//  ILSimSKProductRequest.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit

#import <Foundation/Foundation.h>

#import "ILSimSKRequest.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ILSimSKProductsRequestDelegate;

@interface ILSimSKProductsRequest : ILSimSKRequest {
	BOOL cancelled;
	NSSet* ids;
}

- (instancetype) initWithProductIdentifiers:(NSSet*) productIdentifiers;

@property(assign, nullable) id <ILSimSKProductsRequestDelegate> delegate;

+ (ILSimSKProduct*) simulatedProductForIdentifier:(NSString*) ident;

@end

@interface ILSimSKProductsResponse : NSObject {
}

@property(nonatomic, readonly) NSArray<NSString*>* invalidProductIdentifiers;
@property(nonatomic, readonly) NSArray<ILSimSKProduct*>* products;

@end

@protocol ILSimSKProductsRequestDelegate <ILSimSKRequestDelegate>

- (void) productsRequest:(ILSimSKProductsRequest*) request didReceiveResponse:(ILSimSKProductsResponse*) response;

@end

NS_ASSUME_NONNULL_END

#endif // #if kILSimAllowSimulatedStoreKit
