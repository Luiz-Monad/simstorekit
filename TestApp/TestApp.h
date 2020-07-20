//
//  TestApp.h
//  SimStoreKit
//
//  Created by ∞ on 03/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@import UIKit;
@import SimStoreKit;

@interface TestApp : NSObject <SKPaymentTransactionObserver, SKProductsRequestDelegate>

@property (weak, nonatomic, nullable) IBOutlet UIWindow * window;

- (instancetype _Nonnull) init;
- (IBAction) buy;
- (IBAction) restore;

@end
