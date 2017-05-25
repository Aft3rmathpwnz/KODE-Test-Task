//
//  WeatherService.h
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherDay.h"
#import "FlightCity.h"

@interface WeatherService : NSObject

- (void)asyncGetWeatherForCity:(FlightCity *)city completion:(void (^)(BOOL successful, NSArray *weatherDays))completion;

@end
