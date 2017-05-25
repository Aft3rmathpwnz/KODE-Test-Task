//
//  SBYDatePickerViewProtocol.h
//  KODETestTask
//
//  Created by Aft3rmath on 17.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SBYDatePickerMinimumDateMode) {
    SBYDatePickerMinimumDateModeNone,
    SBYDatePickerMinimumDateModeCurrent
};

@protocol SBYDatePickerViewDelegate <NSObject>

- (BOOL)datePickerShouldBeClosedAfterDidSelectDate:(NSDate *)date;

@optional
- (void)datePickerDateCancelled;

@end
