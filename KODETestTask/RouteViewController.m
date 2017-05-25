//
//  RouteViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 07.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "RouteViewController.h"
#import "SBYUnfoldingPicker.h"
#import "CityPickerTableHandler.h"
#import "FlightCity.h"
#import "FlightAlertsManager.h"
#import "UIView+Utils.h"


static NSString *const kDeparturePlaceholder        = @"Откуда";
static NSString *const kDestinationPlaceholder      = @"Куда";
static NSString *const kPickerDefaultDescription    = @"Выберите направление";


@interface RouteViewController () <CityPickerTableHandlerDelegate, UnfoldingPickerDelegate>

@property (weak, nonatomic) IBOutlet UIView *departureViewContainer;
@property (weak, nonatomic) IBOutlet UIView *destinationViewContainer;
@property (strong, nonatomic) SBYUnfoldingPicker *departurePicker;
@property (strong, nonatomic) SBYUnfoldingPicker *destinationPicker;
@property (strong, nonatomic) CityPickerTableHandler *cityPickerTableHandler;

@end


@implementation RouteViewController


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cityPickerTableHandler = [[CityPickerTableHandler alloc] init];
    _cityPickerTableHandler.delegate = self;
    
    _departurePicker = [[SBYUnfoldingPicker alloc]
                        initWithPickerImage:[UIImage imageNamed:@"departureDot"]
                        titlePlaceholder:kDeparturePlaceholder
                        descriptionText:kPickerDefaultDescription
                        pickingDataSource:_cityPickerTableHandler
                        pickingDelegate:_cityPickerTableHandler
                        cellNibName:CityPickerTableHandlerNibName
                        cellReuseIdentifier:CityPickerTableHandlerCellIdentifier];
    _departurePicker.delegate = self;
    _departurePicker.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [_departureViewContainer addSubview:_departurePicker.pickerView];
    [UIView layoutSubview:_departurePicker.pickerView toEntireView:_departureViewContainer];
    
    _destinationPicker = [[SBYUnfoldingPicker alloc]
                          initWithPickerImage:[UIImage imageNamed:@"destinationDot"]
                          titlePlaceholder:kDestinationPlaceholder
                          descriptionText:kPickerDefaultDescription
                          pickingDataSource:_cityPickerTableHandler
                          pickingDelegate:_cityPickerTableHandler
                          cellNibName:CityPickerTableHandlerNibName
                          cellReuseIdentifier:CityPickerTableHandlerCellIdentifier];
    _destinationPicker.delegate = self;
    _destinationPicker.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [_destinationViewContainer addSubview:_destinationPicker.pickerView];
    [UIView layoutSubview:_destinationPicker.pickerView toEntireView:_destinationViewContainer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Events


- (IBAction)swapCitiesButtonTapped:(id)sender
{
    if(_departureCity && !_destinationCity) {
        _destinationPicker.titleText = _departurePicker.titleText;
        _departurePicker.titleText = _departurePicker.titlePlaceholder;
        
        _destinationCity = _departureCity;
        _departureCity = nil;
    }
    else if(!_departureCity && _destinationCity) {
        _departurePicker.titleText = _destinationPicker.titleText;
        _destinationPicker.titleText = _destinationPicker.titlePlaceholder;
        
        _departureCity = _destinationCity;
        _destinationCity = nil;
    }
    else if(_departureCity && _destinationCity) {
        NSString *departureCityName = _departureCity.name;
        _departurePicker.titleText = _destinationCity.name;
        _destinationPicker.titleText = departureCityName;
        
        FlightCity *departureCity = _departureCity;
        _departureCity = _destinationCity;
        _destinationCity = departureCity;
    }
}


#pragma mark - CityPickerTableHandlerDelegate


- (void)unfoldingPicker:(SBYUnfoldingPicker *)unfoldingPicker didPickCity:(FlightCity *)city
{
    if(unfoldingPicker == _departurePicker)
        _departureCity = city;
    else
        _destinationCity = city;
    
    unfoldingPicker.titleText = city.name;
    unfoldingPicker.descriptionText = city.cityDescription;
    [unfoldingPicker foldAnimated:YES];
}


#pragma mark - UnfoldingPickerDelegate


- (void)unfoldingPickerTextDidChange:(NSString *)text forTableView:(UITableView *)tableView
{
    [_cityPickerTableHandler searchForText:text inTableView:tableView];
}


#pragma mark - Public


- (BOOL)validateRouteData
{
    if(!_departureCity || !_destinationCity) {
        [[FlightAlertsManager sharedManager] showAlertWithType:FlightAlertTypeNoDirection];
        return NO;
    }
    
    if([_departureCity isEqualToCity:_destinationCity]) {
        [[FlightAlertsManager sharedManager] showAlertWithType:FlightAlertTypeSameCities];
        return NO;
    }
    
    return YES;
}


@end
