//
//  CitiesService.m
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "CitiesService.h"
#import "APIClient.h"

static NSString *const kDefaultDescription = @"Все аэропорты";
static NSString *const kCitiesAPIURL = @"https://api.meetup.com/2/cities";
static NSString *const kCountryKey = @"country";
static NSString *const kPageKey = @"page";

@implementation CitiesService

- (void)asyncGetCitiesWithCompletion:(void (^)(BOOL successful, NSArray *cities))completion
{
    NSDictionary *params = @{kCountryKey:@"RU", kPageKey:@10};
    [[APIClient sharedClient] GET:kCitiesAPIURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *receivedCities = [responseObject valueForKey:@"results"];
        if([receivedCities isKindOfClass:[NSArray class]]) {
            NSMutableArray *flightCities = [NSMutableArray array];
            for(NSDictionary *cityDictionary in receivedCities) {
                FlightCity *flightCity = [[FlightCity alloc] initWithName:[cityDictionary valueForKey:@"city"] countryCode:[cityDictionary valueForKey:@"country"] cityDescription:kDefaultDescription];
                [flightCities addObject:flightCity];
            }
            NSArray *orderedCities = [flightCities sortedArrayUsingSelector:@selector(compare:)];
            if(completion)
                completion(YES, orderedCities);
        }
        else {
            // Handling not array here
            if(completion)
                completion(NO, nil);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // Handling error here
        if(completion)
            completion(NO, nil);
    }];
}

@end
