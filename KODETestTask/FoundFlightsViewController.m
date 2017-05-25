//
//  FoundFlightsViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 20.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "FoundFlightsViewController.h"
#import "FoundFlightsTitleView.h"
#import "WeatherService.h"
#import "AKASegmentedControl.h"
#import "WeatherDayTableHandler.h"
#import "WeatherDayViewController.h"
#import "UIColor+Hex.h"
#import "AKASegmentedControl+Flights.h"


static NSString *const kSelectedWeatherDaySegue = @"SelectedWeatherDaySegue";
static NSString *const kWeatherDaysTableSegue = @"WeatherDaysTableSegue";


@interface FoundFlightsViewController () <WeatherDayTableHandlerDelegate>

@property (weak, nonatomic) IBOutlet AKASegmentedControl *segmentedControl;
@property (strong, nonatomic) WeatherService *weatherService;
@property (weak, nonatomic) WeatherDayTableHandler *weatherDayTableHandler;
@property (weak, nonatomic) WeatherDayViewController *weatherDayViewController;

@end


@implementation FoundFlightsViewController


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    FoundFlightsTitleView *titleView = [[FoundFlightsTitleView alloc] init];
    titleView.departureTitle = _departureCity.name;
    titleView.destinationTitle = _destinationCity.name;
    self.navigationItem.titleView = titleView;
    
    [_segmentedControl configure];
    [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorwithHexString:@"#0F56D7"];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}


#pragma mark - Events


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kWeatherDaysTableSegue]) {
        _weatherDayTableHandler = (WeatherDayTableHandler *) [segue destinationViewController];
        _weatherDayTableHandler.delegate = self;
        [_weatherDayTableHandler provideDataSourceForCity:_departureCity];
    }
    else if ([segue.identifier isEqualToString:kSelectedWeatherDaySegue]) {
        _weatherDayViewController = (WeatherDayViewController *) [segue destinationViewController];
    }
}

- (void)segmentedControlValueChanged:(AKASegmentedControl *)segmentedControl
{
    switch (segmentedControl.selectedIndexes.firstIndex) {
        case 0:
            [_weatherDayTableHandler provideDataSourceForCity:_departureCity];
            break;
            
        case 1:
            [_weatherDayTableHandler provideDataSourceForCity:_destinationCity];
            break;
            
        default:
            break;
    }
}


#pragma mark - WeatherDayTableHandlerDelegate


- (void)didSelectWeatherDay:(WeatherDay *)weatherDay
{
    _weatherDayViewController.weatherDay = weatherDay;
    if(self.presentedViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark - Public


- (void)prepareForDepartureCity:(FlightCity *)departureCity destinationCity:(FlightCity *)destinationCity
{
    _departureCity = departureCity;
    _destinationCity = destinationCity;
}


@end
