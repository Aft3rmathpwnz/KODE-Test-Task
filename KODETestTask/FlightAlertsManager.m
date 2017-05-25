//
//  FlightValidationManager.m
//  KODETestTask
//
//  Created by Aft3rmath on 19.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "FlightAlertsManager.h"
#import "RMessage.h"
#import "RMessageView.h"
#import "UIColor+Hex.h"


static NSString *const kFlightAlertTypeNoDirectionMessage = @"Укажите направление рейса";
static NSString *const kFlightAlertTypeSameCitiesMessage = @"Пункты вылета и прилета совпадают";
static NSString *const kFlightAlertTypeDateIsNotWithinAYearMessage = @"Дата должна быть в пределах одного года от текущей";
static NSString *const kFlightAlertTypePassengersCountIsMoreThanMaximumMessage = @"Пассажиров не должно быть больше девяти";
static NSString *const kFlightAlertTypeBabiesCountIsMoreThanAdultsMessage = @"Младенцев не должно быть больше, чем взрослых";


@interface FlightAlertsManager()<RMessageProtocol>
@end


@implementation FlightAlertsManager


#pragma mark - Lifecyle


+ (id)sharedManager
{
    static FlightAlertsManager *fvManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fvManager = [[self alloc] init];
    });
    return fvManager;
}

- (instancetype)init
{
    if(self = [super init]) {
        [RMessage setDefaultViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    }
    return self;
}


#pragma mark - RMessageProtocol


- (void)customizeMessageView:(RMessageView *)messageView
{
    messageView.backgroundColor = [UIColor colorwithHexString:@"#0F329E"];
    messageView.subtitleTextColor = [UIColor whiteColor];
    messageView.subtitleFont = [UIFont systemFontOfSize:13.0];
}


#pragma mark - Public


- (void)showAlertWithType:(FlightAlertType)type
{
    NSString *message = nil;
    NSString *iconImage = nil;
    switch (type) {
        case FlightAlertTypeNoDirection:
            message = kFlightAlertTypeNoDirectionMessage;
            iconImage = @"alertTriangle";
            break;
            
        case FlightAlertTypeSameCities:
            message = kFlightAlertTypeSameCitiesMessage;
            iconImage = @"alertTriangle";
            break;
            
        case FlightAlertTypeDateIsNotWithinAYear:
            message = kFlightAlertTypeDateIsNotWithinAYearMessage;
            iconImage = @"bigCircledCancelButton";
            break;
            
        case FlightAlertTypePassengersCountIsMoreThanMaximum:
            message = kFlightAlertTypePassengersCountIsMoreThanMaximumMessage;
            iconImage = @"bigCircledCancelButton";
            break;
            
        case FlightAlertTypeBabiesCountIsMoreThanAdults:
            message = kFlightAlertTypeBabiesCountIsMoreThanAdultsMessage;
            iconImage = @"bigCircledCancelButton";
            break;
    }
    
    if(message) {
        [RMessage setDelegate:self];
        [RMessage showNotificationWithTitle:nil
                                   subtitle:message
                                  iconImage:[UIImage imageNamed:iconImage]
                                       type:RMessageTypeNormal
                             customTypeName:nil
                                   duration:3.0
                                   callback:nil
                                buttonTitle:nil
                             buttonCallback:nil
                                 atPosition:RMessagePositionNavBarOverlay
                       canBeDismissedByUser:YES];
    }
}


@end
