//
//  WeatherHourView.m
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherHourView.h"

@interface WeatherHourView()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *conditionsIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@end

@implementation WeatherHourView
@dynamic hours;


#pragma mark - Lifecycle


- (instancetype)initWithConditionsImage:(UIImage *)conditionsImage conditionsSelectedImage:(UIImage *)conditionsSelectedImage hours:(NSString *)hours delegate:(id<WeatherHourViewDelegate>)delegate
{
    if(self = [super initWithFrame:CGRectMake(0.0, 0.0, 22.0, 47.0)]) {
        [self xibSetup];
        _conditionsImage = conditionsImage;
        _conditionsIconImageView.image = _conditionsImage;
        _conditionsSelectedImage = conditionsSelectedImage;
        _hoursLabel.text = hours;
        _delegate = delegate;
    }
    return self;
}

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
}


#pragma mark - Properies


- (NSString *)hours
{
    return _hoursLabel.text;
}

- (void)setHours:(NSString *)hours
{
    _hoursLabel.text = hours;
}

- (IBAction)weatherHourTapped:(id)sender
{
    if(!_selected) {
        if([_delegate conformsToProtocol:@protocol(WeatherHourViewDelegate)]) {
            [_delegate shouldSelectWeatherHourView:self];
        }
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(_selected)
        _conditionsIconImageView.image = _conditionsSelectedImage;
    else
        _conditionsIconImageView.image = _conditionsImage;
}


@end
