//
//  ModalDatePickerViewController.h
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SBYModalDatePickerDelegate <NSObject>

- (BOOL)modalDatePickerShouldBeClosedAfterDateSelected:(NSDate *)selectedDate;

@end

@interface SBYModalDatePicker : UIViewController

@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (weak, nonatomic) id<SBYModalDatePickerDelegate> delegate;

- (instancetype)initWithSelectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate delegate:(id<SBYModalDatePickerDelegate>)delegate;
- (void)show;

@end

