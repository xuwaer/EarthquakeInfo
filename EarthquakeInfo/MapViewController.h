//
//  MapViewController.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-25.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class HazardsDataSource;

@interface MapViewController : UIViewController<MKMapViewDelegate>

//@property (nonatomic, assign) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, assign) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) HazardsDataSource *datasource;

- (void)showHazards:(HazardsDataSource *)inDatasource;

@end
