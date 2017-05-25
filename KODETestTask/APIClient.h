//
//  APIClient.h
//  KODETestTask
//
//  Created by Aft3rmath on 20.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface APIClient : AFHTTPSessionManager

+(id)sharedClient;

@end
