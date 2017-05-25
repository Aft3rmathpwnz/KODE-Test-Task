//
//  RouteViewController.h
//  KODETestTask
//
//  Created by Aft3rmath on 07.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlightCity;

@interface RouteViewController : UIViewController

@property (strong, nonatomic, readonly) FlightCity *departureCity;
@property (strong, nonatomic, readonly) FlightCity *destinationCity;

- (BOOL)validateRouteData;

@end
