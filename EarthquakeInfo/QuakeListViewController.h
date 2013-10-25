//
//  QuakeListViewController.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuakeFeaturesResponse;

/**
 *	@brief	数据源对象
 */
@interface QuakeDataSource : NSObject

@property (nonatomic, strong, readonly) NSDate *endDate;

@property (nonatomic, strong, readonly) NSMutableArray *data;

@property (nonatomic, assign, readonly) NSInteger count;

- (void)addToDataSource:(QuakeFeaturesResponse *)data;

- (id)featureAtIndex:(NSInteger)index;

- (id)firstFeature;

- (id)lastFeature;

- (void)moveCursor:(NSInteger)cursorTo;

- (id)nextFeature;

- (id)previousFeature;

- (void)clear;

@end

/////////////////////////////////////////////////////////////////////////////////////////////

#import "RefreshTableViewController.h"

@interface QuakeListViewController : RefreshTableViewController

@property (nonatomic, strong) QuakeDataSource *datasource;

@end
