//
//  NSDate+Utils.h
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utils)

+ (NSString *)formatShortFromDate:(NSDate *)date;
+ (NSString *)formatDDMMYYYYFromDate:(NSDate *)date;
+ (NSString *)formatDayOfWeekFromDate:(NSDate *)date;
+ (NSString *)formatHoursFromDate:(NSDate *)date;

+ (NSDate *)dateStartingFromBeginningOfTheDayFromDate:(NSDate *)date;
+ (BOOL)date:(NSDate *)firstDate isMoreThanOneYearDifferentFromDate:(NSDate *)secondDate;

@end
