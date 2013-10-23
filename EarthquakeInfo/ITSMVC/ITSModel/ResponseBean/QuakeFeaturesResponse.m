//
//  QuakeFeaturesResponse.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeFeaturesResponse.h"
#import "QuakeFeature.h"

#define ktype @"type"
#define kFeatureCollection @"FeatureCollection"

#define kmetadata       @"metadata"
#define kgenerated      @"generated"
#define kurl            @"url"
#define ktitle          @"title"
#define kapi            @"api"
#define kcount          @"count"
#define kstatus         @"status"

#define kbbox           @"bbox"

#define kfeatures       @"features"

@implementation QuakeFeaturesResponse

-(BOOL)decode
{
    if (_jSONData == nil)   return NO;
    
    id json = [_jSONData objectFromJSONData];
    
    if (json == nil)                                    return NO;
    if (![json isKindOfClass:[NSDictionary class]])     return NO;
    
    NSDictionary *resultJson = (NSDictionary *)json;
    
    /*** 解析metadata ***/
    NSDictionary *metadataJson = [resultJson valueForKey:kmetadata];
    self.title = [metadataJson valueForKey:ktitle];
    NSNumber *vgenerate = [metadataJson valueForKey:kgenerated];
    self.generate = [NSDate dateWithTimeIntervalSince1970:[vgenerate longLongValue]];
    self.count = [[metadataJson valueForKey:kcount] integerValue];
    self.status = [[metadataJson valueForKey:kstatus] intValue];
    self.api = [metadataJson valueForKey:kapi];
    
    /*** 解析bbox ***/
    NSArray *bboxJson = [resultJson valueForKey:kbbox];
    struct ResponseBBOX _box = {
    
        [bboxJson[0] floatValue],
        [bboxJson[1] floatValue],
        [bboxJson[2] floatValue],
        [bboxJson[3] floatValue],
        [bboxJson[4] floatValue],
        [bboxJson[5] floatValue]
    };
    self.bbox = _box;
    
    /*** 解析features ***/
    NSArray *featuresJson = [resultJson valueForKey:kfeatures];
    self.features = [[NSMutableArray alloc] init];
    for (NSDictionary *featureJson in featuresJson) {
        
        QuakeFeature *feature = [[QuakeFeature alloc] initWithDictionary:featureJson];
        
        if (feature && [feature decode])
            [self.features addObject:feature];
    }
    
//    [self.features sortUsingComparator:^(id objc1, id objc2) {
//     
//        double time1 = [((QuakeFeature *)objc1).time timeIntervalSince1970];
//        double time2 = [((QuakeFeature *)objc2).time timeIntervalSince1970];
//        
//        if (time1 > time2)
//            return (NSComparisonResult)NSOrderedAscending;
//        else if (time1 < time2)
//            return (NSComparisonResult)NSOrderedDescending;
//        else
//            return (NSComparisonResult)NSOrderedSame;
//        
//     }];
    
    return YES;
}

-(NSUInteger)tag
{
    return kActionTag_Response_Query;
}

@end
