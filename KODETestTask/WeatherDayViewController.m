//
//  WeatherDayViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 23.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherDayViewController.h"
#import "WeatherDayView.h"
#import "WeatherDay.h"
#import "WeatherHourView.h"


@interface WeatherDayViewController () <WeatherHourViewDelegate>

@property (weak, nonatomic) IBOutlet WeatherDayView *weatherDayView;

@end


@implementation WeatherDayViewController


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    if(_weatherDay) {
        [self configureWeatherDayView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Properties


- (void)setWeatherDay:(WeatherDay *)weatherDay
{
    if(_weatherDay != weatherDay) {
        _weatherDay = weatherDay;
        if(self.isViewLoaded) {
            [self configureWeatherDayView];
        }
    }
}


#pragma mark - Inner


- (void)configureWeatherDayView
{
    _weatherDayView.cityName = _weatherDay.cityName;
    _weatherDayView.temperature = _weatherDay.weatherHours[0].temperature;
    
    NSMutableArray<WeatherHourView *> *weatherHourViews = [NSMutableArray array];
    for(WeatherHour *weatherHour in _weatherDay.weatherHours) {
        WeatherHourView *weatherHourView = [[WeatherHourView alloc] initWithConditionsImage:weatherHour.conditionsIcon conditionsSelectedImage:weatherHour.conditionsSelectedIcon hours:weatherHour.hours delegate:self];
        [weatherHourViews addObject:weatherHourView];
    }
    [_weatherDayView addWeatherHourViews:weatherHourViews];
    
    [self selectWeatherHour:_weatherDay.weatherHours[0]];
    [_weatherDayView selectWeatherHourView:weatherHourViews[0]];
}

- (void)selectWeatherHour:(WeatherHour *)weatherHour
{
    _weatherDayView.backgroundImage = weatherHour.conditionsBackgroundImage;
    _weatherDayView.temperature = weatherHour.temperature;
    _weatherDayView.conditions = weatherHour.conditions;
}


#pragma mark - WeatherHourViewDelegate


- (void)shouldSelectWeatherHourView:(WeatherHourView *)weatherHourView
{
    [_weatherDayView selectWeatherHourView:weatherHourView];
    [self selectWeatherHour:_weatherDay.weatherHours[_weatherDayView.selectedWeatherHourViewIndex]];
}


@end
