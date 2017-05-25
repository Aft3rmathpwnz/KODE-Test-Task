//
//  WeatherDay.h
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherHour.h"

@interface WeatherDay : NSObject

@property (strong, nonatomic, readonly) NSString *cityName;
@property (strong, nonatomic, readonly) NSDate *date;
@property (strong, nonatomic, readonly) NSArray<WeatherHour *> *weatherHours;
@property (nonatomic, readonly) NSInteger dayTemperature;
@property (nonatomic, readonly) UIImage *conditionsIcon;



- (instancetype)initWithCityName:(NSString *)cityName date:(NSDate *)date weatherHours:(NSArray<WeatherHour *> *)weatherHours;

@end
