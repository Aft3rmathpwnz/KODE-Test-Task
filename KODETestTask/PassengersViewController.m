//
//  PassengersViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 17.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "PassengersViewController.h"
#import "SBYVerticalStepperView.h"
#import "FlightAlertsManager.h"


static NSUInteger const kMaximumPassengers = 9;


@interface PassengersViewController () <SBYVerticalStepperViewDelegate>

@property (weak, nonatomic) IBOutlet SBYVerticalStepperView *adultsStepperView;
@property (weak, nonatomic) IBOutlet SBYVerticalStepperView *kidsStepperView;
@property (weak, nonatomic) IBOutlet SBYVerticalStepperView *babiesStepperView;

@end


@implementation PassengersViewController
@dynamic adultsCount, kidsCount, babiesCount;


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _adultsStepperView.delegate = self;
    _kidsStepperView.delegate = self;
    _babiesStepperView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Properties


- (NSUInteger)adultsCount
{
    return _adultsStepperView.count;
}

- (NSUInteger)kidsCount
{
    return _kidsStepperView.count;
}

- (NSUInteger)babiesCount
{
    return _babiesStepperView.count;
}


#pragma mark - Inner


- (NSUInteger)totalCount
{
    return _adultsStepperView.count + _kidsStepperView.count + _babiesStepperView.count;
}


#pragma mark - SBYVerticalStepperViewDelegate


- (void)addTappedForVerticalStepperView:(SBYVerticalStepperView *)stepperView
{
    if([self totalCount] >=  kMaximumPassengers) {
        [[FlightAlertsManager sharedManager] showAlertWithType:FlightAlertTypePassengersCountIsMoreThanMaximum];
        return;
    }
    
    if(stepperView == _babiesStepperView && _adultsStepperView.count == _babiesStepperView.count) {
        [[FlightAlertsManager sharedManager] showAlertWithType:FlightAlertTypeBabiesCountIsMoreThanAdults];
        return;
    }
    
    stepperView.count++;
}

- (void)subtractTappedForVerticalStepperView:(SBYVerticalStepperView *)stepperView
{
    if(stepperView.minimumCount == stepperView.count) {
        return;
    }
    
    stepperView.count--;
    if(stepperView == _adultsStepperView && _adultsStepperView.count < _babiesStepperView.count) {
        _babiesStepperView.count--;
    }
}


@end
