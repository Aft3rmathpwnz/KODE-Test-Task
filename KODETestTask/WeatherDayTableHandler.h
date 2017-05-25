//
//  WeatherDayTableViewController.h
//  KODETestTask
//
//  Created by Aft3rmath on 24.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherDay;
@class FlightCity;


@protocol WeatherDayTableHandlerDelegate <NSObject>

- (void)didSelectWeatherDay:(WeatherDay *)weatherDay;

@end


@interface WeatherDayTableHandler : UITableViewController

@property (weak, nonatomic) id<WeatherDayTableHandlerDelegate> delegate;

- (void)provideDataSourceForCity:(FlightCity *)city;

@end
