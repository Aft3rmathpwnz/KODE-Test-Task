//
//  SBYGenericDatePickerView.m
//  KODETestTask
//
//  Created by Aft3rmath on 16.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYAbstractDatePickerView.h"
#import "SBYModalDatePicker.h"
#import "NSDate+Utils.h"

@interface SBYAbstractDatePickerView()<SBYModalDatePickerDelegate>

@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation SBYAbstractDatePickerView


#pragma mark - Lifecycle


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self xibSetup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        [self xibSetup];
    }
    return self;
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:[self nibName] bundle:bundle];
    UIView *xibView = (UIView *)[nib instantiateWithOwner:self options:nil][0];
    return xibView;
}

- (void)xibSetup {
    self.view = [self loadViewFromNib];
    self.view.frame = self.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.view];
}

- (NSDate *)minimumDate
{
    if(_minimumDate)
        return _minimumDate;
    else if(_minimumDateMode == SBYDatePickerMinimumDateModeCurrent)
        return [NSDate dateStartingFromBeginningOfTheDayFromDate:[NSDate date]];
    return nil;
}

- (NSString *)nibName
{
    [NSException raise:@"Invoked abstract method" format:@"Invoked abstract method for %s",  __func__];
    return nil;
}

- (IBAction)showPickerTapped:(id)sender
{
    SBYModalDatePicker *modalDatePicker = [[SBYModalDatePicker alloc] initWithSelectedDate:_selectedDate minimumDate:self.minimumDate delegate:self];
    [modalDatePicker show];
}


#pragma mark - SBYModalDatePickerDelegate


- (BOOL)modalDatePickerShouldBeClosedAfterDateSelected:(NSDate *)selectedDate
{
    if(_delegate && [_delegate conformsToProtocol:@protocol(SBYDatePickerViewDelegate)]) {
        return [_delegate datePickerShouldBeClosedAfterDidSelectDate:selectedDate];
    }
    return YES;
}



@end
