//
//  UITableView+UnfoldingPicker.h
//  KODETestTask
//
//  Created by Aft3rmath on 14.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBYUnfoldingPicker;

@interface UITableView (UnfoldingPicker)

@property (weak, nonatomic) SBYUnfoldingPicker *associatedPicker;

@end
