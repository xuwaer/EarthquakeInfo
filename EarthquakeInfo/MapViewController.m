//
//  MapViewController.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-25.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "MapViewController.h"
#import "KxMenu/KxMenu.h"

#import "HazardsDataSource.h"
#import "QuakeFeature.h"

#import "InfoAnnotation.h"
#import "ZSPinAnnotation.h"

@interface MapViewController ()

@property (nonatomic, strong) NSMutableArray *hazardsAnnotations;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // iOS7调整导航栏高度
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
//        CGRect oldNaviFrame = self.navigationBar.frame;
//        self.navigationBar.frame = CGRectMake(oldNaviFrame.origin.x, oldNaviFrame.origin.y, oldNaviFrame.size.width, 64);
//    }
//    
//    // 添加弹出菜单
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showmenu:)];
    menuItem.tag = 987;
    self.navigationItem.rightBarButtonItem = menuItem;
}

#pragma mark - 弹出菜单相关动作

- (void)showmenu:(id)sender
{
    CGRect fromRect;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        
        for (UIView *view in self.navigationController.navigationBar.subviews) {

            if ([view isKindOfClass:[UIButton class]]) {
                fromRect = view.frame;
                // 调整popover位置
                fromRect = CGRectMake(fromRect.origin.x, 64, view.frame.size.width, 1);
                break;
            }
        }
    }
    else {
        fromRect = ((UIView *)sender).frame;
    }
    
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"List" image:[UIImage imageNamed:@"comment"] target:self action:@selector(viewInMap:)],
      [KxMenuItem menuItem:@"Search" image:[UIImage imageNamed:@"search"] target:self action:@selector(setSearch:)]
      ];
    
    [KxMenu showMenuInView:self.view fromRect:fromRect menuItems:menuItems];
}

- (void)viewInMap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setSearch:(id)sender
{
    [self performSegueWithIdentifier:@"mapsearch" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 地图标注相关

- (void)showHazards:(HazardsDataSource *)inDatasource
{
    if (self.hazardsAnnotations) {
        [self.mapView removeAnnotations:self.hazardsAnnotations];
        [self.hazardsAnnotations removeAllObjects];
    }
    
    if (inDatasource != nil)
        self.datasource = inDatasource;
    
    if (self.datasource == nil || [self.datasource count] <= 0)
        return;
    
    for (int i = 0; i < self.datasource.data.count; i++) {
        
        QuakeFeature *feature = [self.datasource featureAtIndex:i];
        InfoAnnotation *annotation = [[InfoAnnotation alloc] initWithFeature:feature];
        [self.mapView addAnnotation:annotation];
        [self.hazardsAnnotations addObject:annotation];
    }
}

//-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
//{
//    for (MKPinAnnotationView *aView in views) {
//        
//        aView.pinColor = MKPinAnnotationColorGreen;
//        aView.animatesDrop = YES;
//        aView.canShowCallout = NO;
//        aView.rightCalloutAccessoryView = NO;
//    }
//}

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
	
	MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
	
	return flyTo;
	
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(![annotation isKindOfClass:[InfoAnnotation class]])
        return nil;
    
    InfoAnnotation *infoAnnotation = (InfoAnnotation *)annotation;
    static NSString *defaultPinID = @"StandardIdentifier";
    
    // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        UIButton *accessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = accessory;
    }
    
    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeDisc;
    pinView.canShowCallout = YES;
    pinView.annotationColor = infoAnnotation.color;

    return pinView;
}

@end
