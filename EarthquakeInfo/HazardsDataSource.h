//
//  HazardsDataSource.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-28.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuakeFeaturesResponse;

/**
 *	@brief	数据源对象
 */
@interface HazardsDataSource : NSObject

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