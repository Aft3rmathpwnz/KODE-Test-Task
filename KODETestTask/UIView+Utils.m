//
//  UIView+Utils.m
//
//  Created by Aft3rmath on 15.03.17.
//  Copyright © 2017 Aft3rmath. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (LayerProperties)

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

@end


@implementation UIView (Shadow)

- (CGFloat)shadowRadius
{
    return self.layer.shadowRadius;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    self.layer.shadowRadius = shadowRadius;
}

- (CGSize)shadowOffset
{
    return self.layer.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowOffset = shadowOffset;
}

- (float)shadowOpacity
{
    return self.layer.shadowOpacity;
}

- (void)setShadowOpacity:(float)shadowOpacity
{
    self.layer.shadowOpacity = shadowOpacity;
}

- (UIColor *)shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

-(void)setShadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}

@end


@implementation UIView (Autolayout)

+ (void)layoutSubview:(UIView *)subview toEntireView:(UIView *)containingView
{
    [NSLayoutConstraint activateConstraints:@[
                                              [NSLayoutConstraint
                                               constraintWithItem:subview
                                               attribute:NSLayoutAttributeTop
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:containingView
                                               attribute:NSLayoutAttributeTop
                                               multiplier:1.0
                                               constant:0.0],
                                              [NSLayoutConstraint
                                               constraintWithItem:subview
                                               attribute:NSLayoutAttributeBottom
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:containingView
                                               attribute:NSLayoutAttributeBottom
                                               multiplier:1.0
                                               constant:0.0],
                                              [NSLayoutConstraint
                                               constraintWithItem:subview
                                               attribute:NSLayoutAttributeLeading
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:containingView
                                               attribute:NSLayoutAttributeLeading
                                               multiplier:1.0
                                               constant:0.0],
                                              [NSLayoutConstraint
                                               constraintWithItem:subview
                                               attribute:NSLayoutAttributeTrailing
                                               relatedBy:NSLayoutRelationEqual
                                               toItem:containingView
                                               attribute:NSLayoutAttributeTrailing
                                               multiplier:1.0
                                               constant:0.0]
                                              ]
     ];
}

@end
