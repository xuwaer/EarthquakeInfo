//
//  Constant.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SERVER_CONNECTION 
#define SERVER_CONNECTION_HOST @"http://comcat.cr.usgs.gov/fdsnws/event/1"
#endif

#ifndef EVENT_TYPE
#define EVENTT_YPE @"earthquake"     //地震
#endif

@interface Constant : NSObject

@end
