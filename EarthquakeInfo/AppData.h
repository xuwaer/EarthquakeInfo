//
//  AppData.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-25.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MapViewController;
@interface AppData : NSObject

@property (nonatomic, strong) MapViewController *mapController;

+(AppData *)appData;

@end
