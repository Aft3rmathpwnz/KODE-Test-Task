//
//  FoundFlightsViewController.h
//  KODETestTask
//
//  Created by Aft3rmath on 20.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlightCity;

@interface FoundFlightsViewController : UIViewController

@property (strong, nonatomic, readonly) FlightCity *departureCity;
@property (strong, nonatomic, readonly) FlightCity *destinationCity;

- (void)prepareForDepartureCity:(FlightCity *)departureCity destinationCity:(FlightCity *)destinationCity;

@end
