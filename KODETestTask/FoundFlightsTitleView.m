//
//  FoundFlightsTitleView.m
//  KODETestTask
//
//  Created by Aft3rmath on 21.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "FoundFlightsTitleView.h"
#import "UIView+Utils.h"


@interface FoundFlightsTitleView()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *departureCityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationCityNameLabel;

@end


@implementation FoundFlightsTitleView
@dynamic departureTitle, destinationTitle;


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
    self.bounds = CGRectMake(0.0, 0.0, 239.0, 44.0);
}


#pragma mark - Properties


- (NSString *)departureTitle
{
    return _departureCityNameLabel.text;
}

- (void)setDepartureTitle:(NSString *)departureTitle
{
    _departureCityNameLabel.text = departureTitle;
}

- (NSString *)destinationTitle
{
    return _destinationCityNameLabel.text;
}

- (void)setDestinationTitle:(NSString *)destinationTitle
{
    _destinationCityNameLabel.text = destinationTitle;
}


@end
