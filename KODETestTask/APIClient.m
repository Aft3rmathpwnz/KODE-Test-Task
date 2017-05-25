//
//  APIClient.m
//  KODETestTask
//
//  Created by Aft3rmath on 20.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import "APIClient.h"

//171721174b95d2a226e1579242d7d11

@implementation APIClient

+ (id)sharedClient
{
    static APIClient *apiClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiClient = [[self alloc] init];
    });
    return apiClient;
}

- (instancetype)init
{
    if(self = [super init]) {
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self setResponseSerializer:[AFJSONResponseSerializer serializer]];
    }
    return self;
}


@end
