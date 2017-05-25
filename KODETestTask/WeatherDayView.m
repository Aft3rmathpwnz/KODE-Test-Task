//
//  WeatherDayView.m
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherDayView.h"
#import "WeatherHourView.h"
#import "UIColor+Hex.h"
#import "UIImageEffects.h"


@interface WeatherDayView()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UIView *hoursWeatherContainingView;

@end


@implementation WeatherDayView
@dynamic cityName, temperature, conditions, backgroundImage;


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
}


#pragma mark - Properties


- (NSString *)cityName
{
    return _cityNameLabel.text;
}

- (void)setCityName:(NSString *)cityName
{
    _cityNameLabel.text = cityName;
}

- (NSInteger)temperature
{
    return [_temperatureLabel.text integerValue];
}

- (void)setTemperature:(NSInteger)temperature
{
    _temperatureLabel.text = [@(temperature) stringValue];
}

- (NSString *)conditions
{
    return _conditionsLabel.text;
}

- (void)setConditions:(NSString *)conditions
{
    _conditionsLabel.text = conditions;
}

- (UIImage *)backgroundImage
{
    return _backgroundImageView.image;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    // build blur image's tint color
    UIColor *blurTintColor = [UIColor colorwithHexString:@"#0F56D7" alpha:0.3];
    
    // calculate blur radius multiplier to keep effect the same for different image scales
    CGFloat blurRadiusMultiplier = backgroundImage.scale > 0.0f ? 1.0f/backgroundImage.scale : 1.0f;
    
    // apply blur to the image
    UIImage *bluredImage = [UIImageEffects imageByApplyingBlurToImage:backgroundImage withRadius:8.0f*blurRadiusMultiplier tintColor:blurTintColor saturationDeltaFactor:1.0f maskImage:nil];
    
    [UIView transitionWithView:_backgroundImageView
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _backgroundImageView.image = bluredImage;
                    }
                    completion:nil];
}


#pragma mark - Public


- (void)selectWeatherHourView:(WeatherHourView *)weatherHourView
{
    if(_weatherHoursViews.count > _selectedWeatherHourViewIndex) {
        _weatherHoursViews[_selectedWeatherHourViewIndex].selected = NO;
    }
    weatherHourView.selected = YES;
    _selectedWeatherHourViewIndex = [_weatherHoursViews indexOfObject:weatherHourView];
}

- (void)addWeatherHourViews:(NSArray<WeatherHourView *> *)weatherHourViews
{
    if(_weatherHoursViews.count) {
        for(WeatherHourView *weatherHourView in _weatherHoursViews) {
            [weatherHourView removeFromSuperview];
        }
        _weatherHoursViews = nil;
    }

    _weatherHoursViews = weatherHourViews;
    if(weatherHourViews.count > 0) {
        CGFloat takenPlace = weatherHourViews.count * weatherHourViews[0].bounds.size.width;
        CGFloat freeSpace = self.bounds.size.width - takenPlace;
        CGFloat space = freeSpace / (weatherHourViews.count + 1);
        
        for(int i = 0; i < weatherHourViews.count; i++) {
            WeatherHourView *weatherHourView = weatherHourViews[i];
            UIView *viewLeadingTo;
            if(i > 0) {
                viewLeadingTo = weatherHourViews[i-1];
            }
            else {
                viewLeadingTo = _hoursWeatherContainingView;
            }
            
            weatherHourView.translatesAutoresizingMaskIntoConstraints = NO;
            [_hoursWeatherContainingView addSubview:weatherHourView];
            
            NSLayoutConstraint *top =  [NSLayoutConstraint
                                        constraintWithItem:weatherHourView
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:_hoursWeatherContainingView
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1.0
                                        constant:0.0];
            
            NSLayoutConstraint *bottom = [NSLayoutConstraint
                                            constraintWithItem:weatherHourView
                                            attribute:NSLayoutAttributeBottom
                                            relatedBy:NSLayoutRelationLessThanOrEqual
                                            toItem:_hoursWeatherContainingView
                                            attribute:NSLayoutAttributeBottom
                                            multiplier:1.0
                                            constant:0.0];
            
            NSLayoutConstraint *leading = [NSLayoutConstraint
                                            constraintWithItem:weatherHourView
                                            attribute:NSLayoutAttributeLeading
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:viewLeadingTo
                                           attribute:(viewLeadingTo == _hoursWeatherContainingView) ? NSLayoutAttributeLeading : NSLayoutAttributeTrailing
                                            multiplier:1.0
                                            constant:space];
            
            NSLayoutConstraint *width = [NSLayoutConstraint
                                         constraintWithItem:weatherHourView
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0
                                         constant:weatherHourView.bounds.size.width];
            
            [NSLayoutConstraint activateConstraints:@[top, bottom, leading, width]];
        }
    }
}


@end
