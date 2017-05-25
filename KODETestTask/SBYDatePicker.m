//
//  SBYDatePickerViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYDatePicker.h"
#import "SBYInitialDatePickerView.h"
#import "SBYCancellableDatePickerView.h"
#import "SBYNonCancellableDatePickerView.h"
#import "UIView+Utils.h"
#import "NSDate+Utils.h"


static NSString *const kDefaultDirectionKey = @"Туда";
static NSString *const kDefaultButtonText = @"Обратно";


@interface SBYDatePicker () <SBYDatePickerViewDelegate>

@property (strong, nonatomic) SBYAbstractDatePickerView *datePickerView;

@end


@implementation SBYDatePicker
@dynamic minimumDate, minimumDateMode;


#pragma mark - Initializers


- (instancetype)initWithPickerMode:(SBYDatePickerMode)mode minimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode buttonText:(NSString *)buttonText directionKey:(NSString *)directionKey date:(NSDate *)date
{
    if(self = [super init]) {
        
        _mode = mode;
        _buttonText = buttonText;
        _directionKey = directionKey;
        _date = date;
        
        switch (mode) {
            case SBYDatePickerModeInitial:
                _datePickerView = [[SBYInitialDatePickerView alloc] initWithButtonText:buttonText delegate:self];
                break;
                
            case SBYDatePickerModeCancellable:
                _datePickerView = [[SBYCancellableDatePickerView alloc] initWithDirectionKey:directionKey dateString:[NSDate formatShortFromDate:_date] delegate:self];
                
                break;
                
            case SBYDatePickerModeNonCancellable:
                _datePickerView = [[SBYNonCancellableDatePickerView alloc] initWithDirectionKey:directionKey dateString:[NSDate formatShortFromDate:_date] delegate:self];
                break;
        }
        _datePickerView.minimumDateMode = minimumDateMode;
    }
    return self;
}

- (instancetype)initWithPickerMode:(SBYDatePickerMode)mode minimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode directionKey:(NSString *)directionKey
{
    return [self initWithPickerMode:mode minimumDateMode:minimumDateMode buttonText:kDefaultButtonText directionKey:directionKey date:[NSDate dateStartingFromBeginningOfTheDayFromDate:[NSDate date]]];
}

- (instancetype)initWithPickerMode:(SBYDatePickerMode)mode minimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode buttonText:(NSString *)buttonText directionKey:(NSString *)directionKey
{
    return [self initWithPickerMode:mode minimumDateMode:minimumDateMode buttonText:buttonText directionKey:directionKey date:[NSDate dateStartingFromBeginningOfTheDayFromDate:[NSDate date]]];
}


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutPickerView];
}

- (void)layoutPickerView
{
    _datePickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_datePickerView];
    [UIView layoutSubview:_datePickerView toEntireView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Properties


- (SBYDatePickerMinimumDateMode)minimumDateMode
{
    return _datePickerView.minimumDateMode;
}

- (void)setMinimumDateMode:(SBYDatePickerMinimumDateMode)minimumDateMode
{
    _datePickerView.minimumDateMode = minimumDateMode;
}

- (NSDate *)minimumDate
{
    return _datePickerView.minimumDate;
}

- (void)setMinimumDate:(NSDate *)minimumDate
{
    _datePickerView.minimumDate = minimumDate;
}


#pragma mark - Inner


- (void)pickDate:(NSDate *)date
{
    _date = [NSDate dateStartingFromBeginningOfTheDayFromDate:date];
    NSString *formattedDate = [NSDate formatShortFromDate:_date];
    
    switch (_mode) {
        case SBYDatePickerModeInitial: {
            SBYDatePickerMinimumDateMode minimumDateMode = _datePickerView.minimumDateMode;
            NSDate *minimumDate = _datePickerView.minimumDate;
            [_datePickerView removeFromSuperview];
            _datePickerView = nil;
            _datePickerView = [[SBYCancellableDatePickerView alloc] initWithDirectionKey:_directionKey dateString:formattedDate delegate:self];
            _datePickerView.minimumDateMode = minimumDateMode;
            _datePickerView.minimumDate = minimumDate;
            [self layoutPickerView];
            _mode = SBYDatePickerModeCancellable;
        }
            break;
            
        case SBYDatePickerModeCancellable: {
            SBYCancellableDatePickerView *cancellableDatePickerView = (SBYCancellableDatePickerView *)_datePickerView;
            cancellableDatePickerView.dateString = formattedDate;
        }
            break;
            
        case SBYDatePickerModeNonCancellable: {
            SBYNonCancellableDatePickerView *nonCancellableDatePickerView = (SBYNonCancellableDatePickerView *)_datePickerView;
            nonCancellableDatePickerView.dateString = formattedDate;
        }
            break;
    }
    _datePickerView.selectedDate = _date;
}

- (void)resetPicker
{
    SBYDatePickerMinimumDateMode minimumDateMode = _datePickerView.minimumDateMode;
    NSDate *minimumDate = _datePickerView.minimumDate;
    _date = nil;
    [_datePickerView removeFromSuperview];
    _datePickerView = nil;
    _datePickerView = [[SBYInitialDatePickerView alloc] initWithButtonText:_buttonText delegate:self];
    _datePickerView.minimumDateMode = minimumDateMode;
    _datePickerView.minimumDate = minimumDate;
    [self layoutPickerView];
    _mode = SBYDatePickerModeInitial;
}


#pragma mark - SBYDatePickerViewDelegate


- (BOOL)datePickerShouldBeClosedAfterDidSelectDate:(NSDate *)date
{
    if([_delegate conformsToProtocol:@protocol(SBYDatePickerDelegate)]) {
        if([_delegate datePicker:self shouldPickDate:date]){
            [self pickDate:date];
        }
        else {
            return NO;
        }
    }
    else {
        [self pickDate:date];
    }
    return YES;
}

- (void)datePickerDateCancelled
{
    [self resetPicker];
}


#pragma mark - Public


- (void)reset
{
    if(_mode != SBYDatePickerModeInitial) {
        [self resetPicker];
    }
}


@end
