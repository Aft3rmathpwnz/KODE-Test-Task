//
//  UITableView+UnfoldingPicker.m
//  KODETestTask
//
//  Created by Aft3rmath on 14.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "UITableView+UnfoldingPicker.h"
#import <objc/runtime.h>


static char kAssociatedPickerKey;

@implementation UITableView (UnfoldingPicker)
@dynamic associatedPicker;

- (void)setAssociatedPicker:(SBYUnfoldingPicker *)associatedPicker
{
    objc_setAssociatedObject(self, &kAssociatedPickerKey, associatedPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedPicker {
    return objc_getAssociatedObject(self, &kAssociatedPickerKey);
}

@end
