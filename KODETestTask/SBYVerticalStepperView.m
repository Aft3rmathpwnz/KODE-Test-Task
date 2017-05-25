//
//  SBYVerticalStepperView.m
//  KODETestTask
//
//  Created by Aft3rmath on 17.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYVerticalStepperView.h"
#import "ZCDuangLabel.h"
#import "UIColor+Hex.h"

@interface SBYVerticalStepperView()


@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet ZCDuangLabel *countDuangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic) BOOL isDimmed;

@end


@implementation SBYVerticalStepperView
@dynamic count, iconImage, descriptionText;

#pragma mark - Lifecycle


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self xibSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self xibSetup];
    }
    return self;
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    UIView *xibView = (UIView *)[nib instantiateWithOwner:self options:nil][0];
    return xibView;
}

- (void)xibSetup {
    self.view = [self loadViewFromNib];
    self.view.frame = self.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.view];
    _isDimmed = YES;
    _countDuangLabel.textColor = [UIColor colorwithHexString:@"#82BDF5"];
    _iconImageView.tintColor = [UIColor colorwithHexString:@"#82BDF5"];
    _descriptionLabel.textColor = [UIColor colorwithHexString:@"#82BDF5"];
}

- (NSUInteger)count
{
    return [_countDuangLabel.attributedString.string integerValue];
}

- (void)setCount:(NSUInteger)count
{
    if(count == 0 && !_isDimmed) {
        _isDimmed = YES;
        _countDuangLabel.textColor = [UIColor colorwithHexString:@"#82BDF5"];
        _iconImageView.tintColor = [UIColor colorwithHexString:@"#82BDF5"];
        _descriptionLabel.textColor = [UIColor colorwithHexString:@"#82BDF5"];
    }
    else if(count > 0 && _isDimmed) {
        _isDimmed = NO;
        _countDuangLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _iconImageView.tintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        _descriptionLabel.textColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    }
    _countDuangLabel.attributedString = [[NSAttributedString alloc] initWithString:[@(count) stringValue] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:24], NSForegroundColorAttributeName:_countDuangLabel.textColor}];

    [_countDuangLabel startAppearAnimation];
}

- (UIImage *)iconImage
{
    return _iconImageView.image;
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImageView.image = iconImage;
}

- (NSString *)descriptionText
{
    return _descriptionLabel.text;
}

- (void)setDescriptionText:(NSString *)descriptionText
{
    _descriptionLabel.text = descriptionText;
}

- (IBAction)addButtonTapped:(id)sender
{
    if(_delegate && [_delegate conformsToProtocol:@protocol(SBYVerticalStepperViewDelegate)]) {
        [_delegate addTappedForVerticalStepperView:self];
    }
}

- (IBAction)subtractButtonTapped:(id)sender
{
    if(_delegate && [_delegate conformsToProtocol:@protocol(SBYVerticalStepperViewDelegate)]) {
        [_delegate subtractTappedForVerticalStepperView:self];
    }
}



@end
