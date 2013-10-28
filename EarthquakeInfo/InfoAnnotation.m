//
//  InfoAnnotation.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-28.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "InfoAnnotation.h"

@implementation InfoAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self = [super init];
    if (self) {
        self.coordinate = newCoordinate;
    }
    return self;
}

@end
