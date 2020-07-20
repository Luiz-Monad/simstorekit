//
//  XibView.m
//  TestSimStoreKit
//
//  Created by Ohanar on 2020/7/19.
//  Copyright © 2020 Monadic Software. All rights reserved.
//

#import "XibView.h"

@implementation XibView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self xibSetup];
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    [self xibSetup];
    if ([self contentView]) [[self contentView] prepareForInterfaceBuilder];
}

- (void)xibSetup {
    UIView * view = [self loadViewFromNib];
    if (!view) { return; }
    [view setFrame:[self bounds]];
    [view setAutoresizingMask:
        (UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight)];
    [self addSubview: view];
    [self setContentView: view];
}

- (UIView *)loadViewFromNib {
    NSString * nibName = [self nibName];
    if (!nibName) { return nil; }
    NSBundle * bundle = [NSBundle bundleForClass: [self class]];
    UINib * nib = [UINib nibWithNibName: nibName bundle: bundle];
    return [[nib instantiateWithOwner: self options: nil] firstObject];
}

@end
