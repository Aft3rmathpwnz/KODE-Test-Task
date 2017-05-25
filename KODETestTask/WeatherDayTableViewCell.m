//
//  WeatherDayTableViewCell.m
//  KODETestTask
//
//  Created by Aft3rmath on 24.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "WeatherDayTableViewCell.h"
#import "NSDate+Utils.h"

NSString *const WeatherDayTableViewCellIdentifier = @"WeatherDayTableViewCell";

@interface WeatherDayTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *selectionIndicatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionsImageView;

@end

@implementation WeatherDayTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if(selected) {
        _selectionIndicatorImageView.image = [UIImage imageNamed:@"cellSelectedIndicator"];
    }
    else {
        _selectionIndicatorImageView.image = nil;
    }
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    _dayOfWeekLabel.text = [NSDate formatDayOfWeekFromDate:date];
    _dateLabel.text = [NSDate formatDDMMYYYYFromDate:date];
}

- (void)setTemperature:(NSInteger)temperature
{
    _temperature = temperature;
    _temperatureLabel.text = [NSString stringWithFormat:@"%ld°", (long)temperature];
}

- (void)setConditionsImage:(UIImage *)conditionsImage
{
    _conditionsImage = conditionsImage;
    _conditionsImageView.image = conditionsImage;
}

@end
