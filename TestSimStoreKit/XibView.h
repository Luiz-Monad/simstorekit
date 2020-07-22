//
//  XibView.h
//  TestApp
//
//  Created by Ohanar on 2020/7/19.
//  Copyright © 2020 Monadic Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestApp.h"

IB_DESIGNABLE
@interface XibView : UIView

@property (strong, nonatomic, nullable) UIView * contentView;
@property (strong, nonatomic, nullable) IBInspectable NSString * nibName;

- (void)awakeFromNib;
- (void)prepareForInterfaceBuilder;
- (void)xibSetup;
- (UIView * _Nullable)loadViewFromNib;

@end
