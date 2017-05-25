//
//  AKASegmentedControl+Flights.m
//  KODETestTask
//
//  Created by Aft3rmath on 25.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "AKASegmentedControl+Flights.h"
#import "UIColor+Hex.h"
#import "UIButton+tintImage.h"


static NSString *const kThereTitle = @"Туда";
static NSString *const kBackTitle = @"Обратно";
static NSString *const kInactiveColor = @"#D0D6DF";
static NSString *const kActiveColor = @"#0F56D7";


@implementation AKASegmentedControl (Flights)

- (void)configure
{
    [self setSegmentedControlMode:AKASegmentedControlModeSticky];
    [self setSeparatorImage:[UIImage imageNamed:@"segmentSeparator"]];
    
    // Button "There"
    UIButton *thereButton = [[UIButton alloc] init];
    UIImage *thereButtonImageNormal = [UIImage imageNamed:@"lilPlaneDirectionIcon"];
    
    thereButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    thereButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [thereButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [thereButton setTitleColor:[UIColor colorwithHexString:kInactiveColor] forState:UIControlStateNormal];
    [thereButton setTitleColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateHighlighted];
    [thereButton setTitleColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateSelected];
    
    [thereButton setImage:thereButtonImageNormal forState:UIControlStateNormal];
    [thereButton setImageTintColor:[UIColor colorwithHexString:kInactiveColor] forState:UIControlStateNormal];
    [thereButton setImageTintColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateHighlighted];
    [thereButton setImageTintColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateSelected];
    [thereButton setTitle:kThereTitle forState:UIControlStateNormal];
    
    // Button "Back"
    UIButton *backButton = [[UIButton alloc] init];
    UIImage *backButtonImageNormal = [UIImage imageNamed:@"lilRevertedPlaneDirectionIcon"];
    
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [backButton setTitleColor:[UIColor colorwithHexString:kInactiveColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateSelected];
    [backButton setImage:backButtonImageNormal forState:UIControlStateNormal];
    [backButton setImageTintColor:[UIColor colorwithHexString:kInactiveColor] forState:UIControlStateNormal];
    [backButton setImageTintColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateHighlighted];
    [backButton setImageTintColor:[UIColor colorwithHexString:kActiveColor] forState:UIControlStateSelected];
    [backButton setTitle:kBackTitle forState:UIControlStateNormal];
    
    // Setting the UIButtons used in the segmented control
    [self setButtonsArray:@[thereButton, backButton]];
    
    // Setting "There" selected
    [self setSelectedIndex:0];
}

@end
