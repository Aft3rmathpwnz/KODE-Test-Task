//
//  ModalDatePickerViewController.m
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYModalDatePicker.h"
#import "SBYDatePickerPresentationController.h"
#import "SBYDatePickerPresentationAnimationController.h"

@interface SBYModalDatePicker () <UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end


@implementation SBYModalDatePicker


#pragma mark - Lifecycle


- (instancetype)initWithSelectedDate:(NSDate *)selectedDate minimumDate:(NSDate *)minimumDate delegate:(id<SBYModalDatePickerDelegate>)delegate
{
    if(self = [super init]) {
        _delegate = delegate;
        _minimumDate = minimumDate;
        _selectedDate = selectedDate;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.transitioningDelegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if(_minimumDate) {
        _datePicker.minimumDate = _minimumDate;
    }
    if(_selectedDate) {
        if(_minimumDate) {
            if([_selectedDate timeIntervalSinceDate:_minimumDate] < 0)
                _datePicker.date = _minimumDate;
            else
                _datePicker.date = _selectedDate;
        }
        else {
            _datePicker.date = _selectedDate;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Events


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender
{
    if(_delegate && [_delegate conformsToProtocol:@protocol(SBYModalDatePickerDelegate)]) {
        if([_delegate modalDatePickerShouldBeClosedAfterDateSelected:_datePicker.date])
            [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - UIViewControllerTransitioningDelegate


- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    if(presented == self) {
        return [[SBYDatePickerPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if(presented == self) {
        return [[SBYDatePickerPresentationAnimationController alloc] initForPresenting:YES];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if(dismissed == self) {
        return [[SBYDatePickerPresentationAnimationController alloc] initForPresenting:NO];
    }
    return nil;
}


#pragma mark - Public


- (void)show
{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:self animated:YES completion:nil];
}


@end
