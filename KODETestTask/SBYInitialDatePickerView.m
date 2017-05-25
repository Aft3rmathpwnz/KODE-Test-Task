//
//  SBYInitialDatePickerView.m
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYInitialDatePickerView.h"


@interface SBYInitialDatePickerView()

@property (weak, nonatomic) IBOutlet UIButton *initialPickingButton;

@end


@implementation SBYInitialDatePickerView
@dynamic buttonText;


- (instancetype)initWithButtonText:(NSString *)buttonText delegate:(id<SBYDatePickerViewDelegate>)delegate
{
    if(self = [super init]) {
        self.buttonText = buttonText;
        self.delegate = delegate;
    }
    return self;
}

- (void)xibSetup {
    [super xibSetup];
    [self layoutButton];
}

- (void)layoutButton
{
    _initialPickingButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    _initialPickingButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}


#pragma mark - Abstract Class Methods Implementation


- (NSString *)nibName
{
    return @"SBYInitialDatePickerView";
}


#pragma mark - Properties


- (NSString *)buttonText
{
    return _initialPickingButton.titleLabel.text;
}

- (void)setButtonText:(NSString *)buttonText
{
    [_initialPickingButton setTitle:buttonText forState:UIControlStateNormal];
}

@end
