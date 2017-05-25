//
//  SBYGenericDatePickerView.h
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBYDatePickerViewProtocol.h"

@interface SBYAbstractDatePickerView : UIView

@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (nonatomic) SBYDatePickerMinimumDateMode minimumDateMode;
@property (weak, nonatomic) id<SBYDatePickerViewDelegate> delegate;

- (void)xibSetup;
- (NSString *)nibName;

@end
