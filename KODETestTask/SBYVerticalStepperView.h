//
//  SBYVerticalStepperView.h
//  KODETestTask
//
//  Created by Aft3rmath on 17.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBYVerticalStepperView;
@protocol SBYVerticalStepperViewDelegate <NSObject>

- (void)addTappedForVerticalStepperView:(SBYVerticalStepperView *)stepperView;
- (void)subtractTappedForVerticalStepperView:(SBYVerticalStepperView *)stepperView;

@end

IB_DESIGNABLE
@interface SBYVerticalStepperView : UIView

@property (nonatomic) IBInspectable NSUInteger count;
@property (nonatomic) IBInspectable UIImage *iconImage;
@property (nonatomic) IBInspectable NSString *descriptionText;
@property (nonatomic) IBInspectable NSUInteger minimumCount;
@property (nonatomic) IBInspectable NSUInteger maximumCount;
@property (weak, nonatomic) id<SBYVerticalStepperViewDelegate> delegate;

@end
