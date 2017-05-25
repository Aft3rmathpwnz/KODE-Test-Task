//
//  FlightCity.m
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "FlightCity.h"

@implementation FlightCity

- (instancetype)initWithName:(NSString *)name countryCode:(NSString *)countryCode cityDescription:(NSString *)cityDescription
{
    if(self = [super init]) {
        _name = name;
        _countryCode = countryCode;
        _cityDescription = cityDescription;
    }
    return self;
}

- (NSComparisonResult)compare:(FlightCity *)anotherCity
{
    return [self.name localizedCaseInsensitiveCompare:anotherCity.name];
}


#pragma mark - Equality


- (BOOL)isEqualToCity:(FlightCity *)city
{
    if(!city)
        return NO;
    
    BOOL haveEqualNames = (self.name == city.name) || [self.name isEqualToString:city.name];
    BOOL haveEqualCountryCodes = (self.countryCode == city.countryCode) || [self.countryCode isEqualToString:city.countryCode];
    BOOL haveEqualDescriptions = (self.cityDescription == city.cityDescription) || [self.cityDescription isEqualToString:city.cityDescription];
    
    return haveEqualNames && haveEqualCountryCodes && haveEqualDescriptions;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[FlightCity class]]) {
        return NO;
    }
    
    return [self isEqualToCity:(FlightCity *)object];
}

- (NSUInteger)hash
{
    return [self.name hash] ^ [self.countryCode hash] ^ [self.cityDescription hash];
}

@end
