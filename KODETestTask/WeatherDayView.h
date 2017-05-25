//
//  WeatherDayView.h
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherHourView;

@interface WeatherDayView : UIView

IB_DESIGNABLE
@property (nonatomic) NSInteger temperature;
@property (nonatomic) NSString *conditions;
@property (nonatomic) NSString *cityName;
@property (nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic, readonly) NSArray<WeatherHourView *> *weatherHoursViews;
@property (nonatomic, readonly) NSUInteger selectedWeatherHourViewIndex;

- (void)addWeatherHourViews:(NSArray<WeatherHourView *> *)weatherHourViews;
- (void)selectWeatherHourView:(WeatherHourView *)weatherHourView;

@end
