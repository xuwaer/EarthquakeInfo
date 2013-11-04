//
//  InfoAnnotation.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-28.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"
#import "ZSPinAnnotation/ZSPinAnnotation.h"

@class QuakeFeature;

@interface InfoAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) QuakeFeature *feature;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) ZSPinAnnotationType annotationType;

- (id)initWithFeature:(QuakeFeature *)newFeature;

@end
