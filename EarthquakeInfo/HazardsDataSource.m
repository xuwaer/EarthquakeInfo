//
//  HazardsDataSource.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-28.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "HazardsDataSource.h"

#import "QuakeFeaturesResponse.h"
#import "QuakeFeature.h"

/**
 *	@brief	自定义数据源对象
 */
@implementation HazardsDataSource
{
    NSInteger cursor;
}

-(id)init
{
    self = [super init];
    if (self) {
        _data = [[NSMutableArray alloc] init];
        cursor = -1;
    }
    return self;
}

-(NSInteger)count
{
    return _data.count;
}

-(void)addToDataSource:(QuakeFeaturesResponse *)inData
{
    if (inData.features == nil || inData.features.count <= 0)
        return;
    
    [_data addObjectsFromArray:inData.features];
    _endDate = ((QuakeFeature *)[self firstFeature]).time;
}

-(id)featureAtIndex:(NSInteger)index
{
    return [_data objectAtIndex:index];
}

-(id)firstFeature
{
    if (_data.count <= 0)
        return nil;
    else
        return [_data firstObject];
}

-(id)lastFeature
{
    if (_data.count <= 0)
        return nil;
    else
        return [_data lastObject];
}

-(void)moveCursor:(NSInteger)cursorTo
{
    cursor = cursorTo;
}

-(id)nextFeature
{
    if (cursor + 1 >= _data.count)
        return nil;
    else
        return [self featureAtIndex:++cursor];
}

-(id)previousFeature
{
    if (cursor - 1 < 0)
        return nil;
    else
        return [self featureAtIndex:--cursor];
}

-(void)clear
{
    [_data removeAllObjects];
    cursor = -1;
}

@end