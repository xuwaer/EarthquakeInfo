//
//  QuakeFeature.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "BaseResponse.h"

struct GEOMETRY {
    
    float longitude;
    float latitude;
    float depth;
};

@interface QuakeFeature : SubResponse

@property (nonatomic, assign) float mag;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSDate *updated;
@property (nonatomic, assign) NSInteger tz;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, assign) NSInteger felt;
@property (nonatomic, assign) float cdi;
@property (nonatomic, assign) float mmi;
@property (nonatomic, strong) NSString *alert;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) NSInteger tsunami;
@property (nonatomic, assign) NSInteger sig;
@property (nonatomic, strong) NSString *net;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *ids;
@property (nonatomic, strong) NSString *sources;
@property (nonatomic, strong) NSString *types;
@property (nonatomic, assign) NSInteger nst;
@property (nonatomic, assign) float dmin;
@property (nonatomic, assign) float rms;
@property (nonatomic, assign) float gap;
@property (nonatomic, strong) NSString *magType;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) struct GEOMETRY geoemtry;

@property (nonatomic, strong) NSString *eventId;

@end
