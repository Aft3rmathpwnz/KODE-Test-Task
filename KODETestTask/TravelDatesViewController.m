//
//  TravelDatesViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 07.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "TravelDatesViewController.h"
#import "SBYDatePicker.h"
#import "UIView+Utils.h"
#import "NSDate+Utils.h"
#import "FlightAlertsManager.h"


static NSString *const kDepartureDatePickerDirectionKey = @"Туда";
static NSString *const kReturnDatePickerText = @"Обратно";


@interface TravelDatesViewController () <SBYDatePickerDelegate>

@property (weak, nonatomic) IBOutlet UIView *departureDatePickerContainer;
@property (weak, nonatomic) IBOutlet UIView *returnDatePickerContainer;
@property (strong, nonatomic) SBYDatePicker *departureDatePicker;
@property (strong, nonatomic) SBYDatePicker *returnDatePicker;

@end


@implementation TravelDatesViewController
@dynamic departureDate, returnDate;


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    _departureDatePicker = [[SBYDatePicker alloc] initWithPickerMode:SBYDatePickerModeNonCancellable minimumDateMode:SBYDatePickerMinimumDateModeCurrent directionKey:kDepartureDatePickerDirectionKey];
    _departureDatePicker.delegate = self;
    _departureDatePicker.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_departureDatePickerContainer addSubview:_departureDatePicker.view];
    [UIView layoutSubview:_departureDatePicker.view toEntireView:_departureDatePickerContainer];
    
    _returnDatePicker = [[SBYDatePicker alloc] initWithPickerMode:SBYDatePickerModeInitial minimumDateMode:SBYDatePickerMinimumDateModeCurrent buttonText:kReturnDatePickerText directionKey:kReturnDatePickerText];
    _returnDatePicker.delegate = self;
    _returnDatePicker.view.translatesAutoresizingMaskIntoConstraints = NO;
    [_returnDatePickerContainer addSubview:_returnDatePicker.view];
    [UIView layoutSubview:_returnDatePicker.view toEntireView:_returnDatePickerContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Lifecycle


- (NSDate *)departureDate
{
    return _departureDatePicker.date;
}

- (NSDate *)returnDate
{
    return _returnDatePicker.date;
}


#pragma mark - SBYDatePickerDelegate


- (BOOL)datePicker:(SBYDatePicker *)datePicker shouldPickDate:(NSDate *)date
{
    NSDate *pickedDate = [NSDate dateStartingFromBeginningOfTheDayFromDate:date];
    NSDate *todayDate = [NSDate dateStartingFromBeginningOfTheDayFromDate:[NSDate date]];
    if ([NSDate date:todayDate isMoreThanOneYearDifferentFromDate:date]) {
        [[FlightAlertsManager sharedManager] showAlertWithType:FlightAlertTypeDateIsNotWithinAYear];
        return NO;
    }
    
    if(datePicker == _departureDatePicker) {
        // if picked departure date that is later than return date - reset return date
        if([_returnDatePicker.date timeIntervalSinceDate:pickedDate] < 0) {
            [_returnDatePicker reset];
        }
        _returnDatePicker.minimumDate = pickedDate;
    }
    
    return YES;
}


@end
