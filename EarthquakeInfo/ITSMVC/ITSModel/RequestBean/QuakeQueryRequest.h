//
//  QuakeQueryRequest.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "BaseRequest.h"

@interface QuakeQueryRequest : BaseRequest

@property (nonatomic, assign) float minmag;

@property (nonatomic, strong) NSDate *starttime;

@property (nonatomic, strong) NSDate *endtime;

@property (nonatomic, strong, readonly) NSString *format;

@property (nonatomic, strong) NSString *alertlevel;

@property (nonatomic, strong, readonly) NSString *eventtype;

@property (nonatomic, strong, readonly) NSString *orderby;

@property (nonatomic, strong, readonly) NSString *reviewstatus;

@property (nonatomic, assign) NSInteger minsig;

@property (nonatomic, assign) NSInteger limit;

@end
