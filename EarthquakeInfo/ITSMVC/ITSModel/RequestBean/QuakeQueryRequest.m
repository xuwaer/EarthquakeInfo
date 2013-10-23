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
        
        self.format = @"geojson";
        self.alertlevel = @"green";
        self.eventtype = @"earthquake";
        self.orderby = @"time";
        self.reviewstatus = @"reviewed";
        self.minsig = 600;
    }
    
    return self;
}

-(NSUInteger)tag
{
    return kActionTag_Request_Query;
}

@end
