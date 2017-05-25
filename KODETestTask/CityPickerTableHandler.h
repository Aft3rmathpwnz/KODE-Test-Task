//
//  CityPickerDataSource.h
//  KODETestTask
//
//  Created by Aft3rmath on 09.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "FlightCity.h"
#import "SBYUnfoldingPicker.h"

extern NSString *const CityPickerTableHandlerCellIdentifier;
extern NSString *const CityPickerTableHandlerNibName;

@protocol CityPickerTableHandlerDelegate <NSObject>

- (void)unfoldingPicker:(SBYUnfoldingPicker *)unfoldingPicker didPickCity:(FlightCity *)city;

@end

@interface CityPickerTableHandler : NSObject <UITableViewDataSource, UITableViewDelegate, UnfoldingPickerDataSourceProviderDelegate>

@property (weak, nonatomic) id<CityPickerTableHandlerDelegate> delegate;

- (void)searchForText:(NSString *)text inTableView:(UITableView *)tableView;

@end
