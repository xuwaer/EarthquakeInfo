//
//  InfoAnnotation.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-28.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "InfoAnnotation.h"
#import "QuakeFeature.h"

@interface InfoAnnotation ()
{
    QuakeFeature *_feature;
}

@end

@implementation InfoAnnotation

-(id)initWithFeature:(QuakeFeature *)newFeature
{
    self = [super init];
    if (self) {
        self.feature = newFeature;
    }
    return self;
}

-(void)setFeature:(QuakeFeature *)feature
{
    _feature = feature;
    self.coordinate = CLLocationCoordinate2DMake(self.feature.geoemtry.latitude, self.feature.geoemtry.longitude);
    self.title = [NSString stringWithFormat:@"%.1f %@", self.feature.mag, self.feature.place];
    
    self.color = self.feature.alert;
    if (self.color == [UIColor blackColor]) {
        self.color = [UIColor blueColor];
    }
}

-(QuakeFeature *)feature
{
    return _feature;
}

@end
