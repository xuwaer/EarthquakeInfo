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
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        CGRect oldNaviFrame = self.navigationBar.frame;
        self.navigationBar.frame = CGRectMake(oldNaviFrame.origin.x, oldNaviFrame.origin.y, oldNaviFrame.size.width, 64);
    }
    
    // 添加弹出菜单
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showmenu:)];
    UINavigationItem *item = [self.navigationBar.items objectAtIndex:0];
    item.rightBarButtonItem = menuItem;
}

#pragma mark - 弹出菜单相关动作

- (void)showmenu:(id)sender
{
    CGRect fromRect;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        
        UIView *view = (UIView *)[self.navigationBar.subviews objectAtIndex:2];
        fromRect = view.frame;
        // 调整popover位置
        fromRect = CGRectMake(fromRect.origin.x, 64, view.frame.size.width, 1);
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
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(feature.geoemtry.latitude, feature.geoemtry.longitude);
        InfoAnnotation *annotation = [[InfoAnnotation alloc] initWithCoordinate:coordinate];
        [self.mapView addAnnotation:annotation];
        [self.hazardsAnnotations addObject:annotation];
    }
}

@end
