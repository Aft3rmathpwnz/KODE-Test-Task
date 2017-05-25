//
//  CityViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 09.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYUnfoldingPickerController.h"
#import "SBYUnfoldingPickerView.h"
#import "UITableView+UnfoldingPicker.h"
#import "UIColor+Hex.h"

@interface SBYUnfoldingPickerController ()

@property (strong, nonatomic) SBYUnfoldingPickerView *unfoldedPickerView;
@property (nonatomic) CGRect containigFrame;
@property (nonatomic) CGRect relativeFrame;
@property (nonatomic) BOOL dataSourceProvided;
@property (nonatomic) BOOL unfoldingAnimationCompleted;

@end


@implementation SBYUnfoldingPickerController
@dynamic titleText, descriptionText;


#pragma mark - Lifecycle


- (instancetype)initWithInitialView:(SBYUnfoldingPickerView *)pickerView
           containingViewController:(UIViewController *)containingViewController
                 pickerViewDelegate:(SBYUnfoldingPicker<UnfoldingPickerViewDelegate> *)pickerViewDelegate
                  pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
                    pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
{
    return [self initWithInitialView:pickerView
            containingViewController:containingViewController
                  pickerViewDelegate:pickerViewDelegate
                   pickingDataSource:pickingDataSource
                     pickingDelegate:pickingDelegate
                         cellNibName:nil
                 cellReuseIdentifier:nil];
}

- (instancetype)initWithInitialView:(SBYUnfoldingPickerView *)pickerView
           containingViewController:(UIViewController *)containingViewController
                 pickerViewDelegate:(SBYUnfoldingPicker<UnfoldingPickerViewDelegate> *)pickerViewDelegate
                  pickingDataSource:(id<UITableViewDataSource, UnfoldingPickerDataSourceProviderDelegate>)pickingDataSource
                    pickingDelegate:(id<UITableViewDelegate>)pickingDelegate
                        cellNibName:(NSString *)cellNibName
                cellReuseIdentifier:(NSString*)cellReuseIdentifier
{
    if(self = [super init]) {
        _containigFrame = containingViewController.view.frame;
        _relativeFrame = [containingViewController.view convertRect:pickerView.frame fromView:pickerView.superview];
        if(containingViewController.navigationController && (containingViewController.edgesForExtendedLayout & UIRectEdgeTop) != 0) {
            // if containingViewController is in navigation stack and the content is visible under navigation bar
            _containigFrame.origin.y = 64.0;
            _containigFrame.size.height -= 64.0;
        }
        _unfoldedPickerView = [pickerView copy];
        _unfoldedPickerView.delegate = pickerViewDelegate;
        
        _citiesTableView = [[UITableView alloc] init];
        _citiesTableView.contentInset = UIEdgeInsetsMake(15,0,0,0);
        _citiesTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if(cellNibName && ![cellNibName isEqualToString:@""] && cellReuseIdentifier && ![cellReuseIdentifier isEqualToString:@""])
            [_citiesTableView registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
        
        _citiesTableView.associatedPicker = pickerViewDelegate;
        
        if([pickingDataSource conformsToProtocol:@protocol(UnfoldingPickerDataSourceProviderDelegate)]) {
            [pickingDataSource dataSourceShouldBeProvidedForTableView:_citiesTableView completion:^(BOOL successful) {
                if(successful) {
                    _dataSourceProvided = YES;
                    if(_unfoldingAnimationCompleted) {
                        [self animateTableViewUnfoldingCompletion:nil];
                    }
                }
            }];
        }
        
        _citiesTableView.dataSource = pickingDataSource;
        _citiesTableView.delegate = pickingDelegate;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorwithHexString:@"#0F56D7"];
    
    self.view.frame = CGRectMake(0.0, _relativeFrame.origin.y, _containigFrame.size.width, _relativeFrame.size.height);
    _unfoldedPickerView.frame = CGRectMake(_relativeFrame.origin.x, 0.0, _relativeFrame.size.width, _relativeFrame.size.height);
    [self.view addSubview:_unfoldedPickerView];
    
    CGRect tableFrame = CGRectMake(0, _containigFrame.size.height, _containigFrame.size.width, _containigFrame.size.height - _unfoldedPickerView.frame.size.height);
    _citiesTableView.frame = tableFrame;
    _citiesTableView.backgroundColor = [UIColor clearColor];
    _citiesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_citiesTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _unfoldedPickerView.titleIsEditing = YES;
    if([_unfoldedPickerView.titleText isEqualToString:_unfoldedPickerView.titlePlaceholder])
        _unfoldedPickerView.titleText = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Properties


- (NSString *)titleText
{
    return _unfoldedPickerView.titleText;
}

- (void)setTitleText:(NSString *)titleText
{
    _unfoldedPickerView.titleText = titleText;
}

- (NSString *)descriptionText
{
    return _unfoldedPickerView.descriptionText;
}

- (void)setDescriptionText:(NSString *)descriptionText
{
    _unfoldedPickerView.descriptionText = descriptionText;
}


#pragma mark - Inner


- (void)animateTableViewUnfoldingCompletion:(void (^)(BOOL finished))completion
{
    [UIView animateWithDuration:0.3 animations:^{
        _citiesTableView.frame = CGRectMake(_citiesTableView.frame.origin.x, CGRectGetMaxY(_unfoldedPickerView.frame), _citiesTableView.frame.size.width, _citiesTableView.frame.size.height);
    } completion:^(BOOL finished) {
        if(completion) {
            completion(finished);
        }
    }];
}


#pragma mark - Public


- (void)foldAnimated:(BOOL)animated
{
    [self foldAnimated:animated completion:nil];
}

- (void)foldAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    // folding text field with to the original frame
    if(animated) {
        [UIView animateWithDuration:0.3 animations:^{
            _citiesTableView.frame = CGRectMake(_citiesTableView.frame.origin.x, _containigFrame.size.height, _citiesTableView.frame.size.width, _citiesTableView.frame.size.height);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                self.view.frame = _relativeFrame;
                _unfoldedPickerView.frame = CGRectMake(0.0, 0.0, _unfoldedPickerView.frame.size.width, _unfoldedPickerView.frame.size.height);
            } completion:^(BOOL finished) {
                if(completion) {
                    completion(finished);
                }
            }];
        }];
    }
    else {
        self.view.frame = CGRectMake(_containigFrame.origin.x, _containigFrame.origin.y, _containigFrame.size.width, _containigFrame.size.height);
        _citiesTableView.frame = CGRectMake(_citiesTableView.frame.origin.x, CGRectGetMaxY(_unfoldedPickerView.frame), _citiesTableView.frame.size.width, _citiesTableView.frame.size.height);
    }
}

- (void)unfoldAnimated:(BOOL)animated
{
    [self unfoldAnimated:animated completion:nil];
}

- (void)unfoldAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    // unfolding text field with table to the whole available screen
    if(animated) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(_containigFrame.origin.x, _containigFrame.origin.y, _containigFrame.size.width, _containigFrame.size.height);
        } completion:^(BOOL finished) {
            _unfoldingAnimationCompleted = YES;
            if(_dataSourceProvided) {
                [self animateTableViewUnfoldingCompletion:^(BOOL finished) {
                    if(completion)
                        completion(YES);
                }];
            }
        }];
    }
    else {
        self.view.frame = CGRectMake(_containigFrame.origin.x, _containigFrame.origin.y, _containigFrame.size.width, _containigFrame.size.height);
        _citiesTableView.frame = CGRectMake(_citiesTableView.frame.origin.x, CGRectGetMaxY(_unfoldedPickerView.frame), _citiesTableView.frame.size.width, _citiesTableView.frame.size.height);
    }
}


@end
