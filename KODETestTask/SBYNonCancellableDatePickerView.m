//
//  SBYDatePickerView.m
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYNonCancellableDatePickerView.h"

@interface SBYNonCancellableDatePickerView()

@property (weak, nonatomic) IBOutlet UILabel *directionKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation SBYNonCancellableDatePickerView
@dynamic directionKey, dateString;


#pragma mark - Initializers


- (instancetype)initWithDirectionKey:(NSString *)directionKey dateString:(NSString *)dateString delegate:(id<SBYDatePickerViewDelegate>)delegate
{
    if(self = [super init]) {
        self.directionKey = directionKey;
        self.dateString = dateString;
        self.delegate = delegate;
    }
    return self;
}


#pragma mark - Abstract Class Methods Implementation


- (NSString *)nibName
{
    return @"SBYNonCancellableDatePickerView";
}


#pragma mark - Properties


- (NSString *)directionKey
{
    return _directionKeyLabel.text;
}

- (void)setDirectionKey:(NSString *)directionKey
{
    _directionKeyLabel.text = directionKey;
}

- (NSString *)dateString
{
    return _dateLabel.text;
}

- (void)setDateString:(NSString *)dateString
{
    _dateLabel.text = dateString;
}


@end
