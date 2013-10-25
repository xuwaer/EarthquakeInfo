//
//  AppData.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-25.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "AppData.h"

static AppData *staticAppData = nil;

@implementation AppData

+(AppData *)appData
{
    if (staticAppData == nil) {
        staticAppData = [[AppData alloc] init];
    }
    
    return staticAppData;
}

@end
