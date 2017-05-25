//
//  DatePickerPresentationAnimationController.h
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface SBYDatePickerPresentationAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initForPresenting:(BOOL)presenting;

@end
