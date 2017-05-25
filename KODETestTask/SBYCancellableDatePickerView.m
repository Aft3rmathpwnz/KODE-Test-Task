//
//  SBYCancellableDatePickerView.m
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYCancellableDatePickerView.h"

@interface SBYCancellableDatePickerView()

@property (weak, nonatomic) IBOutlet UILabel *directionKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation SBYCancellableDatePickerView
@dynamic directionKey, dateString;


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
    return @"SBYCancellableDatePickerView";
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

- (IBAction)cancelButtonTapped:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(datePickerDateCancelled)]) {
        [self.delegate datePickerDateCancelled];
    }
}




@end
