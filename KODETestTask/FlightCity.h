//
//  FlightCity.h
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightCity : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *countryCode;
@property (strong, nonatomic, readonly) NSString *cityDescription;

- (instancetype)initWithName:(NSString *)name countryCode:(NSString *)countryCode cityDescription:(NSString *)cityDescription;
- (BOOL)isEqualToCity:(FlightCity *)city;

@end
