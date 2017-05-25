//
//  DatePickerPresentationController.m
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYDatePickerPresentationController.h"

@interface SBYDatePickerPresentationController() 


@end

@implementation SBYDatePickerPresentationController


- (void)presentationTransitionWillBegin
{
    [self.containerView addSubview:self.presentedView];
}

@end
