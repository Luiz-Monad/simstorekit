//
//  TestApp.h
//  SimStoreKit
//
//  Created by ∞ on 03/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@import UIKit;
@import SimStoreKit;

@interface TestApp : NSObject <UIApplicationDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate> {
	IBOutlet UIWindow* window;
}

- (IBAction) buy;
- (IBAction) restore;

@end
