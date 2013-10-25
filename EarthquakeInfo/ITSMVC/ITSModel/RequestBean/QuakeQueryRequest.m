//
//  QuakeQueryRequest.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeQueryRequest.h"

@implementation QuakeQueryRequest

-(id)init
{
    self = [super initWithCommand:kActionCommand_Query type:HttpRequestTypeGet];
    
    if (self) {
        [self setDefaultValue];
    }
    
    return self;
}

/**
 *	@brief	设置默认查询条件
 */
- (void)setDefaultValue
{
    /*** 固定数据 ***/
    //json格式
    _format = @"geojson";
    //目前只考虑地震数据
    _eventtype = @"earthquake";
    //时间排序
    _orderby = @"time";
    //发布的
    _reviewstatus = @"reviewed";
    //默认请求20条
    _limit = 20;
    
    /*** 查询条件 ***/
    // 默认查询，震级0级以上,10级以下
    _minmag = 0;
    _maxmag = 10;
    
    //默认查询24小时内
    _endtime = [NSDate date];
    _starttime = [_endtime dateByAddingTimeInterval:-24 * 60 * 60];
    
    // 默认从1开始查询
    _offset = 1;
}

-(NSUInteger)tag
{
    return kActionTag_Request_Query;
}

-(void)setOffset:(NSInteger)inOffset
{
    _offset = inOffset > 0 ? inOffset : 0;
}

@end
