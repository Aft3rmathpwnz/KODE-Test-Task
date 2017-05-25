//
//  WeatherDayTableViewCell.h
//  KODETestTask
//
//  Created by Aft3rmath on 24.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const WeatherDayTableViewCellIdentifier;

@interface WeatherDayTableViewCell : UITableViewCell

@property (strong, nonatomic) NSDate *date;
@property (nonatomic) NSInteger temperature;
@property (strong, nonatomic) UIImage *conditionsImage;

@end
