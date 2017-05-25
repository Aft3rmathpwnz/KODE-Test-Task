//
//  SBYUnfoldingPickerDataSourceProviderProtocol.h
//  KODETestTask
//
//  Created by Aft3rmath on 22.05.17.
//  Copyright © 2017 aft3rmath. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UnfoldingPickerDataSourceProviderDelegate <NSObject>

- (void)dataSourceShouldBeProvidedForTableView:(UITableView *)tableView completion:(void (^)(BOOL successful))completion;;

@end
