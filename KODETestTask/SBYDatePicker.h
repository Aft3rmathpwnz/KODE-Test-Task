//
//  SBYDatePickerViewController.h
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBYDatePickerViewProtocol.h"
@class SBYDatePicker;

typedef NS_ENUM(NSInteger, SBYDatePickerMode) {
    SBYDatePickerModeInitial,
    SBYDatePickerModeCancellable,
    SBYDatePickerModeNonCancellable
};

@protocol SBYDatePickerDelegate <NSObject>

- (BOOL)datePicker:(SBYDatePicker *)datePicker shouldPickDate:(NSDate *)date;

@end

@interface SBYDatePicker : UIViewController

@property (copy, nonatomic) NSString *buttonText;
@property (copy, nonatomic) NSString *directionKey;
@property (copy, nonatomic) NSDate *date;
@property (nonatomic) NSDate *minimumDate;
@property (nonatomic) SBYDatePickerMinimumDateMode minimumDateMode;
@property (nonatomic, readonly) SBYDatePickerMode mode;
@property (weak, nonatomic) id<SBYDatePickerDelegate> delegate;

- (instancetype)initWithPickerMode:(SBYDatePickerMode)mode minimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode directionKey:(NSString *)directionKey;
- (instancetype)initWithPickerMode:(SBYDatePickerMode)mode minimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode buttonText:(NSString *)buttonText directionKey:(NSString *)directionKey;
- (instancetype)initWithPickerMode:(SBYDatePickerMode)mode minimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode buttonText:(NSString *)buttonText directionKey:(NSString *)directionKey date:(NSDate *)date;

- (void)reset;

@end
