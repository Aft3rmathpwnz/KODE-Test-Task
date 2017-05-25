//
//  WeatherHourView.h
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherHourView;

@protocol WeatherHourViewDelegate <NSObject>

- (void)shouldSelectWeatherHourView:(WeatherHourView *)weatherHourView;

@end

@interface WeatherHourView : UIView

@property (strong, nonatomic) UIImage *conditionsImage;
@property (strong, nonatomic) UIImage *conditionsSelectedImage;
@property (nonatomic) NSString *hours;
@property (nonatomic) BOOL selected;
@property (weak, nonatomic) id<WeatherHourViewDelegate> delegate;

- (instancetype)initWithConditionsImage:(UIImage *)conditionsImage conditionsSelectedImage:(UIImage *)conditionsSelectedImage hours:(NSString *)hours delegate:(id<WeatherHourViewDelegate>) delegate;

@end
