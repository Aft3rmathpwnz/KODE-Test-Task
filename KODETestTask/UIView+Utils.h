//
//  UIView+Utils.h
//
//  Created by Aft3rmath on 15.03.17.
//  Copyright © 2017 Aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (LayerProperties)

@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end


@interface UIView (Shadow)

@property (nonatomic) IBInspectable CGFloat shadowRadius;
@property (nonatomic) IBInspectable CGSize shadowOffset;
@property (nonatomic) IBInspectable float shadowOpacity;
@property (nonatomic, strong) IBInspectable UIColor *shadowColor;

@end


@interface UIView (Autolayout)

+ (void)layoutSubview:(UIView *)subview toEntireView:(UIView *)containingView;

@end

