//
//  UIViewController+Utils.h
//  GiphyTest
//
//  Created by Aft3rmath on 21.08.15.
//  Copyright (c) 2015 Aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

+ (UIViewController*) currentViewController;
+ (UIViewController *)topFullscreenViewControllerForController:(UIViewController *)vc;


@end
