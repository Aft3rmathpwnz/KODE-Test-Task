//
//  SBYInitialDatePickerView.h
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYAbstractDatePickerView.h"

@interface SBYInitialDatePickerView : SBYAbstractDatePickerView

@property (nonatomic) NSString *buttonText;

- (instancetype)initWithButtonText:(NSString *)buttonText delegate:(id<SBYDatePickerViewDelegate>)delegate;

@end
