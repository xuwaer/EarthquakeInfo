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

@property (nonatomic, strong) NSString *format;

@end
