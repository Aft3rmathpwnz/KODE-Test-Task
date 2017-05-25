//
//  WeatherDayTableViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 24.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherDayTableHandler.h"
#import "WeatherDayTableViewCell.h"
#import "WeatherService.h"
#import "UIColor+Hex.h"
#import "SVProgressHUD.h"


@interface WeatherDayTableHandler ()

@property (strong, nonatomic) WeatherService *weatherService;
@property (strong, nonatomic) NSArray<WeatherDay *> *weatherDays;

@end


@implementation WeatherDayTableHandler


#pragma mark - Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Data Source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weatherDays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherDayTableViewCell *cell = (WeatherDayTableViewCell *)[tableView dequeueReusableCellWithIdentifier:WeatherDayTableViewCellIdentifier forIndexPath:indexPath];
    
    WeatherDay *weatherDay = _weatherDays[indexPath.row];
    cell.date = weatherDay.date;
    cell.temperature = weatherDay.dayTemperature;
    cell.conditionsImage = weatherDay.conditionsIcon;
    
    return cell;
}


#pragma mark - Table View Delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_delegate conformsToProtocol:@protocol(WeatherDayTableHandlerDelegate)]) {
        [_delegate didSelectWeatherDay:_weatherDays[indexPath.row]];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // selected state background workaround
    UIView *selectedView =[UIView new];
    selectedView.backgroundColor = [UIColor colorwithHexString:@"#F4F7FD"];
    cell.selectedBackgroundView = selectedView;
}


#pragma mark - Public


- (void)provideDataSourceForCity:(FlightCity *)city
{
    if(!_weatherService)
        _weatherService = [[WeatherService alloc] init];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD show];
    [_weatherService asyncGetWeatherForCity:city completion:^(BOOL successful, NSArray *days) {
        if(successful) {
            _weatherDays = days;
            [self.tableView reloadData];
            
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            if([_delegate conformsToProtocol:@protocol(WeatherDayTableHandlerDelegate)]) {
                [_delegate didSelectWeatherDay:_weatherDays[0]];
            }
            
            [SVProgressHUD dismiss];
        }
    }];
}


@end
