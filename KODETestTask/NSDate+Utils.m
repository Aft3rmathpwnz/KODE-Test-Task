//
//  NSDate+Utils.m
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

+ (NSString *)formatShortFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    [dateFormatter setDateFormat:@"dd MMM, EE"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateStartingFromBeginningOfTheDayFromDate:(NSDate *)date
{
    /*
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *morningStart = [calendar dateFromComponents:components];
    
    return morningStart;
     */
    return [[NSCalendar currentCalendar] startOfDayForDate:date];
}

+ (BOOL)date:(NSDate *)firstDate isMoreThanOneYearDifferentFromDate:(NSDate *)secondDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:firstDate toDate:secondDate
                                                options:0];
    if(components.year == 0)
        return NO;
    else if(components.year == 1 && components.month == 0 && components.day == 0)
        return NO;
    return YES;
}


+ (NSString *)formatDDMMYYYYFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)formatDayOfWeekFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)formatHoursFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    [dateFormatter setDateFormat:@"HH"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
