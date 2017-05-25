//
//  CityPickerView.m
//  KODETestTask
//
//  Created by Aft3rmath on 08.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "SBYUnfoldingPickerView.h"
#import "SBYUnfoldingPicker.h"
#import "UIColor+Hex.h"


@interface SBYUnfoldingPickerView () <UITextFieldDelegate, NSCopying>

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pickerImageView;

@end


@implementation SBYUnfoldingPickerView
@dynamic pickerImage, titleText, titlePlaceholder, descriptionText, titleIsEditing;


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
    UINib *nib = [UINib nibWithNibName:@"SBYUnfoldingPickerView" bundle:bundle];
    UIView *xibView = (UIView *)[nib instantiateWithOwner:self options:nil][0];
    return xibView;
}

- (void)xibSetup {
    self.view = [self loadViewFromNib];
    self.view.frame = self.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.view];
}

- (id)copyWithZone:(NSZone *)zone
{
    SBYUnfoldingPickerView *unfoldingPickerViewCopy = [[SBYUnfoldingPickerView allocWithZone:zone] initWithFrame:self.frame];
    unfoldingPickerViewCopy.pickerImage = [self.pickerImage copy];
    unfoldingPickerViewCopy.titlePlaceholder = [self.titlePlaceholder copy];
    if(![self.titleTextField.text isEqualToString:self.titlePlaceholder]) {
        unfoldingPickerViewCopy.titleTextField.text = [self.titleTextField.text copy];
    }
    unfoldingPickerViewCopy.descriptionText = [self.descriptionText copy];
    return unfoldingPickerViewCopy;
}


#pragma mark - Properties


- (void)setPickerImage:(UIImage *)pickerImage
{
    _pickerImageView.image = pickerImage;
}

- (UIImage *)pickerImage
{
    return _pickerImageView.image;
}

- (void)setTitleText:(NSString *)titleText
{
    _titleTextField.text = titleText;
}

- (NSString *)titleText
{
    return _titleTextField.text;
}

- (void)setTitlePlaceholder:(NSString *)titlePlaceholder
{
    if(!_titleTextField.text || [_titleTextField.text isEqualToString:@""])
        _titleTextField.text = titlePlaceholder;
    _titleTextField.placeholder = titlePlaceholder;
}

- (NSString *)titlePlaceholder
{
    return _titleTextField.placeholder;
}

- (void)setDescriptionText:(NSString *)descriptionText
{
    _descriptionLabel.text = descriptionText;
}

- (NSString *)descriptionText
{
    return _descriptionLabel.text;
}

- (BOOL)titleIsEditing
{
    return _titleTextField.isEditing;
}

- (void)setTitleIsEditing:(BOOL)titleIsEditing
{
    if(titleIsEditing)
        [_titleTextField becomeFirstResponder];
    else
        [_titleTextField resignFirstResponder];
}


#pragma mark - Events


- (IBAction)pickerTapped:(id)sender
{
    if(_delegate && [_delegate conformsToProtocol:@protocol(UnfoldingPickerViewDelegate)]) {
        [_delegate unfoldingPickerViewTappedAndShouldBeUnfolded];
    }
}


#pragma mark - Text Field Delegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([_delegate conformsToProtocol:@protocol(UnfoldingPickerViewDelegate)]) {
        return ![_delegate unfoldingPickerViewTappedAndShouldBeUnfolded];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = @"";
    if([string isEqualToString:@""]) {
        if(![textField.text isEqualToString:@""])
            text = [textField.text substringToIndex:textField.text.length - 1];
    }
    else {
        text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    }
    if([_delegate respondsToSelector:@selector(unfoldingPickerViewTextDidChange:)]) {
        [_delegate unfoldingPickerViewTextDidChange:text];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(unfoldingPickerViewTextDidChange:)]) {
        [_delegate unfoldingPickerViewTextDidChange:@""];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(unfoldingPickerViewTextDidChange:)]) {
        [_delegate unfoldingPickerViewTextDidChange:textField.text];
    }
}


@end
