//
//  UnfoldingPicker.m
//  KODETestTask
//
//  Created by Aft3rmath on 11.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYUnfoldingPicker.h"
#import "SBYUnfoldingPickerView.h"
#import "SBYUnfoldingPickerController.h"
#import "UIViewController+Utils.h"


@interface SBYUnfoldingPicker() <UnfoldingPickerViewDelegate>

@property (strong, nonatomic) SBYUnfoldingPickerController *pickerViewController;
@property (strong, nonatomic) SBYUnfoldingPickerView *innerPickerView;
@property (weak, nonatomic) id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate> pickingDataSource;
@property (weak, nonatomic) id<UITableViewDelegate> pickingDelegate;
@property (copy, nonatomic) NSString *cellNibName;
@property (copy, nonatomic) NSString *cellReuseIdentifier;

@end


@implementation SBYUnfoldingPicker
@dynamic pickerImage, titleText, titlePlaceholder, descriptionText, pickerView;


#pragma mark - Initialization


- (instancetype)initWithPickerImage:(UIImage *)pickerImage
                   titlePlaceholder:(NSString *)titlePlaceholder
                    descriptionText:(NSString *)descriptionText
                  pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
                    pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
                        cellNibName:(NSString *)cellNibName
                cellReuseIdentifier:(NSString *)cellReuseIdentifier
{
    if (self = [super init]) {
        _innerPickerView = [[SBYUnfoldingPickerView alloc] init];
        _innerPickerView.pickerImage = pickerImage;
        _innerPickerView.titlePlaceholder = titlePlaceholder;
        _innerPickerView.descriptionText = descriptionText;
        _innerPickerView.delegate = self;
        _pickingDataSource = pickingDataSource;
        _pickingDelegate = pickingDelegate;
        _cellNibName = cellNibName;
        _cellReuseIdentifier = cellReuseIdentifier;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  pickerImage:(UIImage *)pickerImage
             titlePlaceholder:(NSString *)titlePlaceholder
              descriptionText:(NSString *)descriptionText
            pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
              pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
                  cellNibName:(NSString *)cellNibName
          cellReuseIdentifier:(NSString *)cellReuseIdentifier
{
    if (self = [super init]) {
        _innerPickerView = [[SBYUnfoldingPickerView alloc] initWithFrame:frame];
        _innerPickerView.pickerImage = pickerImage;
        _innerPickerView.titlePlaceholder = titlePlaceholder;
        _innerPickerView.descriptionText = descriptionText;
        _innerPickerView.delegate = self;
        _pickingDataSource = pickingDataSource;
        _pickingDelegate = pickingDelegate;
        _cellNibName = cellNibName;
        _cellReuseIdentifier = cellReuseIdentifier;
    }
    return self;
}


#pragma mark - Properties


- (SBYUnfoldingPickerView *)pickerView
{
    return _innerPickerView;
}

- (UIImage *)pickerImage
{
    return _innerPickerView.pickerImage;
}

- (void)setPickerImage:(UIImage *)pickerImage
{
    _innerPickerView.pickerImage = pickerImage;
}

- (NSString *)titleText
{
    if(_pickerViewController) {
        return _pickerViewController.titleText;
    }
    return _innerPickerView.titleText;
}

- (void)setTitleText:(NSString *)titleText
{
    if(_pickerViewController) {
        _pickerViewController.titleText = titleText;
    }
    _innerPickerView.titleText = titleText;
}

- (NSString *)titlePlaceholder
{
    return _innerPickerView.titlePlaceholder;
}

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    _innerPickerView.titlePlaceholder = titlePlaceholder;
}

- (NSString *)descriptionText
{
    if(_pickerViewController) {
        return _pickerViewController.descriptionText;
    }
    return _innerPickerView.descriptionText;
}

- (void)setDescriptionText:(NSString *)titleDescriptionText
{
    if(_pickerViewController) {
        _pickerViewController.descriptionText = titleDescriptionText;
    }
    _innerPickerView.descriptionText = titleDescriptionText;
}


#pragma mark - Events


- (void)unfoldingControllerCloseButtonTapped:(id)sender
{
    [self foldAnimated:YES];
}


#pragma mark - UnfoldingPickerViewDelegate


- (BOOL)unfoldingPickerViewTappedAndShouldBeUnfolded
{
    if(_pickerMode == UnfoldingPickerModeFolded) {
        [self unfoldAnimated:YES];
        _pickerMode = UnfoldingPickerModeUnfolded;
        return YES;
    }
    return NO;
}

- (void)unfoldingPickerViewTextDidChange:(NSString *)text
{
    if([_delegate conformsToProtocol:@protocol(UnfoldingPickerDelegate) ]) {
        [_delegate unfoldingPickerTextDidChange:text forTableView:_pickerViewController.citiesTableView];
    }
}


#pragma mark - Public


- (void)unfoldAnimated:(BOOL)animated
{
    UIViewController *rootVC =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UIViewController *containingVC = [UIViewController topFullscreenViewControllerForController:rootVC];
    
    // add close button
    if(containingVC.navigationItem) {
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"closeButton"] style:UIBarButtonItemStyleDone target:self action:@selector(unfoldingControllerCloseButtonTapped:)];
        containingVC.navigationItem.rightBarButtonItem = rightButtonItem;
    }
    
    _pickerViewController = [[SBYUnfoldingPickerController alloc]
                             initWithInitialView:_innerPickerView
                             containingViewController:containingVC
                             pickerViewDelegate:self
                             pickingDataSource:_pickingDataSource
                             pickingDelegate:_pickingDelegate
                             cellNibName:_cellNibName
                             cellReuseIdentifier:_cellReuseIdentifier];
    
    [containingVC.view addSubview:_pickerViewController.view];
    [_pickerViewController unfoldAnimated:animated];
}

- (void)foldAnimated:(BOOL)animated
{
    UIViewController *rootVC =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UIViewController *containingVC = [UIViewController topFullscreenViewControllerForController:rootVC];
    if(containingVC.navigationItem) {
        containingVC.navigationItem.rightBarButtonItem = nil;
    }
    
    [_pickerViewController foldAnimated:animated completion:^(BOOL finished) {
        [_pickerViewController.view removeFromSuperview];
        self.pickerViewController = nil;
        _pickerMode = UnfoldingPickerModeFolded;
    }];
}


@end
