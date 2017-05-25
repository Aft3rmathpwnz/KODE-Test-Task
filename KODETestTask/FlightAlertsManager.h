//
//  FlightValidationManager.h
//  KODETestTask
//
//  Created by Aft3rmath on 19.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FlightAlertType) {
    FlightAlertTypeNoDirection,
    FlightAlertTypeSameCities,
    FlightAlertTypeDateIsNotWithinAYear,
    FlightAlertTypePassengersCountIsMoreThanMaximum,
    FlightAlertTypeBabiesCountIsMoreThanAdults
};

@interface FlightAlertsManager : NSObject

+(id)sharedManager;

- (void)showAlertWithType:(FlightAlertType)type;

@end
