//
//  SBYCancellableDatePickerView.h
//  KODETestTask
//
//  Created by Aft3rmath on 15.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYAbstractDatePickerView.h"

@interface SBYCancellableDatePickerView : SBYAbstractDatePickerView

@property (nonatomic) NSString *directionKey;
@property (nonatomic) NSString *dateString;

- (instancetype)initWithDirectionKey:(NSString *)directionKey dateString:(NSString *)dateString delegate:(id<SBYDatePickerViewDelegate>)delegate;

@end
