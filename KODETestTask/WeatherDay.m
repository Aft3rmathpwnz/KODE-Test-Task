//
//  WeatherDay.m
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherDay.h"

@implementation WeatherDay

- (instancetype)initWithCityName:(NSString *)cityName date:(NSDate *)date weatherHours:(NSArray<WeatherHour *> *)weatherHours
{
    if(self = [super init]) {
        _cityName = cityName;
        _date = date;
        _weatherHours = [weatherHours copy];
    }
    return self;
}

- (NSInteger)dayTemperature
{
    float dayTemp = 0;
    for(WeatherHour *weatherHour in _weatherHours) {
        dayTemp += weatherHour.temperature;
    }

    return roundf(dayTemp / _weatherHours.count);
}

- (UIImage *)conditionsIcon
{
   return _weatherHours[(NSInteger)floorf(_weatherHours.count / 2.0)].conditionsIcon;
}

@end
