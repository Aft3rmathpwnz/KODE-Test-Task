//
//  CityViewController.h
//  KODETestTask
//
//  Created by Aft3rmath on 09.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBYUnfoldingPickerView.h"
#import "SBYUnfoldingPickerDataSourceProviderProtocol.h"
@class SBYUnfoldingPicker;


@interface SBYUnfoldingPickerController : UIViewController

@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *descriptionText;
@property (strong, nonatomic, readonly) UITableView *citiesTableView;

- (instancetype)initWithInitialView:(SBYUnfoldingPickerView *)pickerView
           containingViewController:(UIViewController *)containingViewController
                 pickerViewDelegate:(SBYUnfoldingPicker<UnfoldingPickerViewDelegate> *)pickerViewDelegate
                  pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
                    pickingDelegate:(id<UITableViewDelegate>)pickingDelegate;

- (instancetype)initWithInitialView:(SBYUnfoldingPickerView *)pickerView
           containingViewController:(UIViewController *)containingViewController
                 pickerViewDelegate:(SBYUnfoldingPicker<UnfoldingPickerViewDelegate> *)pickerViewDelegate
                  pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
                    pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
                        cellNibName:(NSString *)cellNibName
                cellReuseIdentifier:(NSString*)cellReuseIdentifier;

- (void)foldAnimated:(BOOL)animated;
- (void)foldAnimated:(BOOL)animated
          completion:(void (^)(BOOL finished))completion;

- (void)unfoldAnimated:(BOOL)animated;
- (void)unfoldAnimated:(BOOL)animated
            completion:(void (^)(BOOL finished))completion;


@end
