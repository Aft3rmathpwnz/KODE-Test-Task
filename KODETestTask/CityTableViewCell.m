//
//  CityTableViewCell.m
//  KODETestTask
//
//  Created by Aft3rmath on 13.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "CityTableViewCell.h"

@interface CityTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityDesctiptionLabel;

@end


@implementation CityTableViewCell
@dynamic cityTitle, cityDescription;


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - Properties


- (NSString *)cityTitle
{
    return _cityTitleLabel.text;
}

- (void)setCityTitle:(NSString *)cityTitle
{
    _cityTitleLabel.text = cityTitle;
}

- (NSString *)cityDescription
{
    return _cityDesctiptionLabel.text;
}

- (void)setCityDescription:(NSString *)cityDescription
{
    _cityDesctiptionLabel.text = cityDescription;
}

@end
