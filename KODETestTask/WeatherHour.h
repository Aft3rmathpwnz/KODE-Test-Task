//
//  WeatherHour.h
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WeatherConditionsType) {
    WeatherConditionsTypeClear,
    WeatherConditionsTypeClouds,
    WeatherConditionsTypeThunder,
    WeatherConditionsTypeDrizzle,
    WeatherConditionsTypeRain,
    WeatherConditionsTypeSnow,
    WeatherConditionsTypeFog
};

@interface WeatherHour : NSObject

@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) WeatherConditionsType conditionsType;
@property (nonatomic, readonly) NSString *hours;
@property (nonatomic, readonly) NSString *conditions;
@property (nonatomic, readonly) UIImage *conditionsIcon;
@property (nonatomic, readonly) UIImage *conditionsSelectedIcon;
@property (nonatomic, readonly) UIImage *conditionsBackgroundImage;
@property (strong, nonatomic, readonly) NSDate *date;


- (instancetype)initWithTemperature:(NSInteger)temperature conditionsType:(WeatherConditionsType)conditionsType conditions:(NSString *)conditions date:(NSDate *)date;

@end
