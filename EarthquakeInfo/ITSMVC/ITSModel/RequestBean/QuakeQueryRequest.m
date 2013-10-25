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
        _format = @"geojson";
        //目前只考虑地震数据
        _eventtype = @"earthquake";
        //时间排序
        _orderby = @"time";
        //发布的
        _reviewstatus = @"reviewed";
        //默认请求20条
        self.limit = 20;
    }
    
    return self;
}

-(NSUInteger)tag
{
    return kActionTag_Request_Query;
}

@end
