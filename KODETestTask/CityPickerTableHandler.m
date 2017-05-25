//
//  CityPickerDataSource.m
//  KODETestTask
//
//  Created by Aft3rmath on 09.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "CityPickerTableHandler.h"
#import "CityTableViewCell.h"
#import "UITableView+UnfoldingPicker.h"
#import "CitiesService.h"


NSString *const CityPickerTableHandlerCellIdentifier = @"CityPickerCellIdentifier";
NSString *const CityPickerTableHandlerNibName = @"CityTableViewCell";


@interface CityPickerTableHandler()

@property (strong, nonatomic) CitiesService *citiesService;
@property (strong, nonatomic) NSArray<FlightCity *> *cities;
@property (strong, nonatomic) NSMutableArray<FlightCity *> *filteredCities;

@end


@implementation CityPickerTableHandler


#pragma mark - Table View Data Source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"ROWS %lu", (unsigned long)_filteredCities.count);
    return _filteredCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CityPickerTableHandlerCellIdentifier forIndexPath:indexPath];

    FlightCity *city = _filteredCities[indexPath.row];
    cell.cityTitle = city.name;
    cell.cityDescription = city.cityDescription;
    
    return cell;
}


#pragma mark - Table View Delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate && [_delegate conformsToProtocol:@protocol(CityPickerTableHandlerDelegate)]) {
        [_delegate unfoldingPicker:tableView.associatedPicker didPickCity:_filteredCities[indexPath.row]];
    }
}


#pragma mark - Unfolding Picker Data Source Provider


// table view is about to be displayed and needs data source
- (void)dataSourceShouldBeProvidedForTableView:(UITableView *)tableView completion:(void (^)(BOOL))completion
{
    if(!_citiesService)
        _citiesService = [[CitiesService alloc] init];
    
        [_citiesService asyncGetCitiesWithCompletion:^(BOOL successful, NSArray *cities) {
            if(successful) {
                _cities = cities;
                if(!_filteredCities || _filteredCities.count == 0)
                    _filteredCities = [NSMutableArray arrayWithArray:_cities];
                [tableView reloadData];
            }
            if(completion)
                completion(successful);
        }];
}


#pragma mark - Public


- (void)searchForText:(NSString *)text inTableView:(UITableView *)tableView
{
    if([[text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        [_filteredCities removeAllObjects];
        [_filteredCities addObjectsFromArray:_cities];
        [tableView reloadData];
    }
    else {
        //Local filtering
        [_filteredCities removeAllObjects];
        for(FlightCity *city in _cities) {
            if([city.name localizedCaseInsensitiveContainsString:text]) {
                [_filteredCities addObject:city];
            }
        }
        
        [tableView reloadData];
    }
    NSLog(@"searchForText %@", text);
}

@end
