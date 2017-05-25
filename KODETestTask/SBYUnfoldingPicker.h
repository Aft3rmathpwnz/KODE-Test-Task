//
//  UnfoldingPicker.h
//  KODETestTask
//
//  Created by Aft3rmath on 11.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "SBYUnfoldingPickerView.h"
#import "SBYUnfoldingPickerDataSourceProviderProtocol.h"


typedef NS_ENUM(NSInteger, UnfoldingPickerMode) {
    UnfoldingPickerModeFolded,
    UnfoldingPickerModeUnfolded
};


@protocol UnfoldingPickerDelegate <NSObject>

- (void)unfoldingPickerTextDidChange:(NSString *)text forTableView:(UITableView *)tableView;

@end


@interface SBYUnfoldingPicker : NSObject

@property (nonatomic, readonly) UnfoldingPickerMode pickerMode;
@property (nonatomic, readonly) SBYUnfoldingPickerView *pickerView;
@property (nonatomic) UIImage *pickerImage;
@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *titlePlaceholder;
@property (nonatomic) NSString *descriptionText;
@property (weak, nonatomic) id<UnfoldingPickerDelegate> delegate;

- (instancetype)initWithPickerImage:(UIImage *)pickerImage
                   titlePlaceholder:(NSString *)titlePlaceholder
                    descriptionText:(NSString *)descriptionText
                  pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
                    pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
                        cellNibName:(NSString *)cellNibName
                cellReuseIdentifier:(NSString *)cellReuseIdentifier;

- (instancetype)initWithFrame:(CGRect)frame
                  pickerImage:(UIImage *)pickerImage
             titlePlaceholder:(NSString *)titlePlaceholder
              descriptionText:(NSString *)descriptionText
            pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
              pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
                  cellNibName:(NSString *)cellNibName
          cellReuseIdentifier:(NSString *)cellReuseIdentifier;

- (void)unfoldAnimated:(BOOL)animated;
- (void)foldAnimated:(BOOL)animated;

@end

