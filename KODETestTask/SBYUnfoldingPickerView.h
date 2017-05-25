//
//  PickerView.h
//  KODETestTask
//
//  Created by Aft3rmath on 11.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@protocol UnfoldingPickerViewDelegate <NSObject>

- (BOOL)unfoldingPickerViewTappedAndShouldBeUnfolded;

@optional
- (void)unfoldingPickerViewTextDidChange:(NSString *)text;

@end

@interface SBYUnfoldingPickerView : UIView

@property (nonatomic) UIImage *pickerImage;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *titlePlaceholder;
@property (nonatomic) NSString *descriptionText;
@property (nonatomic) BOOL titleIsEditing;
@property (weak, nonatomic) id<UnfoldingPickerViewDelegate>delegate;

@end

