//
//  QuakeFeature.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeFeature.h"
#import "NSNull+Fix.h"

#define kFeature        @"Feature"
#define kproperties     @"properties"
#define kmag            @"mag"
#define kplace          @"place"
#define ktime           @"time"
#define kupdated        @"updated"
#define ktz             @"tz"
#define kurl            @"url"
#define kdetail         @"detail"
#define kfelt           @"felt"
#define kcdi            @"cdi"
#define kmmi            @"mmi"
#define kalert          @"alert"
#define kstatus         @"status"
#define ktsunami        @"sunami"
#define ksig            @"sig"
#define knet            @"net"
#define kcode           @"code"
#define kids            @"ids"
#define ksources        @"sources"
#define ktypes          @"types"
#define knst            @"nst"
#define kdmin           @"dmin"
#define krms            @"rms"
#define kgap            @"gap"
#define kmagType        @"magType"
#define ktype           @"type"
#define kid             @"id"

#define kgeometry       @"geometry"
#define kcoordinates    @"coordinates"
#define kPoint          @"Point"

@implementation QuakeFeature

-(BOOL)decode
{
    if (_subDic == nil)
        return NO;
    
    NSString *featureType = [_subDic valueForKey:ktype];
    if (featureType == nil || ![featureType isEqualToString:kFeature])
        return NO;
    
    self.eventId = [_subDic valueForKey:kid];
    
    /*** 解析properties ***/
    NSDictionary *propertiesJson = [_subDic valueForKey:kproperties];
    if (propertiesJson == nil)
        return NO;
    
    self.mag = [[propertiesJson valueForKey:kmag] floatValue];
    self.place = [propertiesJson valueForKey:kplace];
    self.time = [NSDate dateWithTimeIntervalSince1970:[[propertiesJson valueForKey:ktime] longLongValue] / 1000];
    self.updated = [NSDate dateWithTimeIntervalSince1970:[[propertiesJson valueForKey:kupdated] longLongValue] / 1000];
    self.tz = [[propertiesJson valueForKey:ktz] integerValue];
    self.url = [propertiesJson valueForKey:kurl];
    self.detail = [propertiesJson valueForKey:kdetail];
    self.felt = [[propertiesJson valueForKey:kfelt] integerValue];
    self.cdi = [[propertiesJson valueForKey:kcdi] floatValue];
    self.mmi = [[propertiesJson valueForKey:kmmi] floatValue];
    self.alert = [propertiesJson valueForKey:kalert];
    self.status = [propertiesJson valueForKey:kstatus];
    self.tsunami = [[propertiesJson valueForKey:ktsunami] integerValue];
    self.sig = [[propertiesJson valueForKey:ksig] integerValue];
    self.net = [propertiesJson valueForKey:knet];
    self.code = [propertiesJson valueForKey:kcode];
    self.ids = [propertiesJson valueForKey:kids];
    self.sources = [propertiesJson valueForKey:ksources];
    self.types = [propertiesJson valueForKey:ktypes];
    self.nst = [[propertiesJson valueForKey:knst] integerValue];
    self.dmin = [[propertiesJson valueForKey:kdmin] floatValue];
    self.rms = [[propertiesJson valueForKey:krms] floatValue];
    self.gap = [[propertiesJson valueForKey:kgap] floatValue];
    self.magType = [propertiesJson valueForKey:kmagType];
    self.type = [propertiesJson valueForKey:ktype];
    
    /*** 解析geometry ****/
    NSDictionary *geometryJson = [_subDic valueForKey:kgeometry];
    if (geometryJson == nil)
        return NO;
    
    NSString *metryType = [geometryJson valueForKey:ktype];
    if (metryType == nil || ![metryType isEqualToString:kPoint])
        return NO;
    
    NSArray *coordinatesJson = [geometryJson valueForKey:kcoordinates];
    if (coordinatesJson == nil)
        return NO;
    
    struct GEOMETRY metryStruct = {
    
        [coordinatesJson[0] floatValue],
        [coordinatesJson[1] floatValue],
        [coordinatesJson[2] floatValue]
    };
    self.geoemtry = metryStruct;
    
    return YES;
}

@end
