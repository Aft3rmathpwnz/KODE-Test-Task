//
//  WeatherService.m
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherService.h"
#import "APIClient.h"
#import "NSDate+Utils.h"


static NSString *const kWeatherAPIURL = @"http://api.openweathermap.org/data/2.5/forecast";
static NSString *const kWeatherAPIKeyValue = @"b089a843bf6d0d945e81bb589c807e63";
static NSString *const kAppIdKey = @"appid";
static NSString *const kUnitsKey = @"units";
static NSString *const kLangKey = @"lang";


@implementation WeatherService

- (void)asyncGetWeatherForCity:(FlightCity *)city completion:(void (^)(BOOL successful, NSArray *weatherDays))completion
{
    NSDictionary *params = @{@"q":[NSString stringWithFormat:@"%@,%@", city.name, city.countryCode], kAppIdKey:kWeatherAPIKeyValue, kUnitsKey:@"metric", kLangKey:@"ru"};
    [[APIClient sharedClient] GET:kWeatherAPIURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *weatherByHours = [responseObject valueForKey:@"list"];
        if([weatherByHours isKindOfClass:[NSArray class]]) {
            NSArray *weatherDays = [self parseWeatherDaysForCityName:city.name fromWeatherByHours:weatherByHours];
            if(completion)
                completion(YES, weatherDays);
        }
        else {
            // Handling not array here
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // Handling error here
        if(completion)
            completion(NO, nil);
    }];
}


#pragma mark - Inner


- (NSArray *)parseWeatherDaysForCityName:(NSString *)cityName fromWeatherByHours:(NSArray *)weatherByHours
{
    NSMutableArray<WeatherDay *> *weatherDays = [NSMutableArray array];
    NSMutableArray<WeatherHour *> *weatherHours = [NSMutableArray array];
    
    for(NSDictionary *dateDictionary in weatherByHours) {
        if([dateDictionary isKindOfClass:[NSDictionary class]]) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dateDictionary valueForKey:@"dt"] doubleValue]];
            
            NSInteger temperature = (NSInteger) roundf([dateDictionary[@"main"][@"temp"] floatValue]);
            WeatherConditionsType conditionsType = [self conditionsTypeFromCode:[dateDictionary[@"weather"][0][@"id"] integerValue]];
            NSString *conditionsDescription = dateDictionary[@"weather"][0][@"description"];
            
            WeatherHour *weatherHour = [[WeatherHour alloc] initWithTemperature:temperature conditionsType:conditionsType conditions:conditionsDescription date:date];
            
            // if started new day and have previous day weather hours - add new weather day with collected weather hours
            if(![self weatherHours:weatherHours containDate:date] && weatherHours.count > 0) {
                NSDate *dateStart = [NSDate dateStartingFromBeginningOfTheDayFromDate:weatherHours.lastObject.date];
                WeatherDay *weatherDay = [[WeatherDay alloc] initWithCityName:cityName date:dateStart weatherHours:weatherHours];
                [weatherDays addObject:weatherDay];
                
                [weatherHours removeAllObjects];
                [weatherHours addObject:weatherHour];
            }
            else {
                // add weather hour as a part of a current day
                [weatherHours addObject:weatherHour];
            }
            
            // if hit the end of all received hours - add new weather day with collected weather hours
            if(dateDictionary == weatherByHours.lastObject) {
                NSDate *dateStart = [NSDate dateStartingFromBeginningOfTheDayFromDate:date];
                WeatherDay *weatherDay = [[WeatherDay alloc] initWithCityName:cityName date:dateStart weatherHours:weatherHours];
                [weatherDays addObject:weatherDay];
            }
        }
        else {
            // Handling not dictionary here
        }
    }
    
    return weatherDays;
}

- (BOOL)weatherHours:(NSArray<WeatherHour *> *)weatherHours containDate:(NSDate *)date
{
    if(weatherHours.count == 0) {
        return NO;
    }
    
    for(WeatherHour *weatherHour in weatherHours) {
        NSDate *weatherHourDayStart = [NSDate dateStartingFromBeginningOfTheDayFromDate:weatherHour.date];
        NSDate *givenDateDayStart = [NSDate dateStartingFromBeginningOfTheDayFromDate:date];
        if([weatherHourDayStart isEqualToDate:givenDateDayStart]) {
            return YES;
        }
    }
    
    return NO;
}

- (WeatherConditionsType)conditionsTypeFromCode:(NSInteger)code
{
    switch (code) {
        case 200 ... 299:
            return WeatherConditionsTypeThunder;
            break;
            
        case 300 ... 399:
            return WeatherConditionsTypeDrizzle;
            break;
            
        case 500 ... 599:
            return WeatherConditionsTypeRain;
            break;
            
        case 600 ... 699:
            return WeatherConditionsTypeSnow;
            break;
            
        case 700 ... 799:
            return WeatherConditionsTypeFog;
            break;
            
        case 800:
            return WeatherConditionsTypeClear;
            break;
            
        case 801 ... 899:
            return WeatherConditionsTypeClouds;
            break;
            
        default:
            return WeatherConditionsTypeClouds;
            break;
    }
}

@end
