//
//  WeatherHour.m
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherHour.h"
#import "NSDate+Utils.h"

@implementation WeatherHour
@dynamic conditionsIcon, conditionsSelectedIcon, conditionsBackgroundImage, hours;

- (instancetype)initWithTemperature:(NSInteger)temperature conditionsType:(WeatherConditionsType)conditionsType conditions:(NSString *)conditions date:(NSDate *)date
{
    if(self = [super init]) {
        _temperature = temperature;
        _conditionsType = conditionsType;
        _conditions = conditions;
        _date = date;
    }
    return self;
}

- (NSString *)hours
{
    return [NSDate formatHoursFromDate:_date];
}

- (UIImage *)conditionsIcon
{
    switch (_conditionsType) {
        case WeatherConditionsTypeClear:
            return [UIImage imageNamed:@"clearIcon"];
            break;
            
        case WeatherConditionsTypeClouds:
            return [UIImage imageNamed:@"cloudyIcon"];
            break;
            
        case WeatherConditionsTypeDrizzle:
            return [UIImage imageNamed:@"drizzleIcon"];
            break;
            
        case WeatherConditionsTypeFog:
            return [UIImage imageNamed:@"fogIcon"];
            break;
            
        case WeatherConditionsTypeRain:
            return [UIImage imageNamed:@"rainIcon"];
            break;
            
        case WeatherConditionsTypeSnow:
            return [UIImage imageNamed:@"snowIcon"];
            break;
            
        case WeatherConditionsTypeThunder:
            return [UIImage imageNamed:@"thunderIcon"];
            break;
    }
}

- (UIImage *)conditionsSelectedIcon
{
    switch (_conditionsType) {
        case WeatherConditionsTypeClear:
            return [UIImage imageNamed:@"clearSelectedIcon"];
            break;
            
        case WeatherConditionsTypeClouds:
            return [UIImage imageNamed:@"cloudySelectedIcon"];
            break;
            
        case WeatherConditionsTypeDrizzle:
            return [UIImage imageNamed:@"drizzleSelectedIcon"];
            break;
            
        case WeatherConditionsTypeFog:
            return [UIImage imageNamed:@"fogSelectedIcon"];
            break;
            
        case WeatherConditionsTypeRain:
            return [UIImage imageNamed:@"rainSelectedIcon"];
            break;
            
        case WeatherConditionsTypeSnow:
            return [UIImage imageNamed:@"snowSelectedIcon"];
            break;
            
        case WeatherConditionsTypeThunder:
            return [UIImage imageNamed:@"thunderSelectedIcon"];
            break;
    }
}

- (UIImage *)conditionsBackgroundImage
{
    switch (_conditionsType) {
        case WeatherConditionsTypeClear:
            return [UIImage imageNamed:@"clearBgImage"];
            break;
            
        case WeatherConditionsTypeClouds:
            return [UIImage imageNamed:@"cloudyBgImage"];
            break;
            
        case WeatherConditionsTypeDrizzle:
            return [UIImage imageNamed:@"drizzleBgImage"];
            break;
            
        case WeatherConditionsTypeFog:
            return [UIImage imageNamed:@"fogBgImage"];
            break;
            
        case WeatherConditionsTypeRain:
            return [UIImage imageNamed:@"rainBgImage"];
            break;
            
        case WeatherConditionsTypeSnow:
            return [UIImage imageNamed:@"snowBgImage"];
            break;
            
        case WeatherConditionsTypeThunder:
            return [UIImage imageNamed:@"thunderBgImage"];
            break;
    }
}

@end
