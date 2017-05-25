//
//  CitiesService.h
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightCity.h"

@interface CitiesService : NSObject

- (void)asyncGetCitiesWithCompletion:(void (^)(BOOL successful, NSArray *cities))completion;

@end
