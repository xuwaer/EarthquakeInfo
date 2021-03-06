//
//  QuakeListViewController.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeListViewController.h"
#import "MapViewController.h"
#import "QuakeCell.h"
#import "KxMenu/KxMenu.h"

#import "QuakeQueryRequest.h"
#import "QuakeFeaturesResponse.h"
#import "QuakeFeature.h"

#import "AppData.h"
#import "HazardsDataSource.h"

#import "QuakeListQueue.h"


#ifndef kRefreshType
#define kRefreshType_All @"kRefreshType_All"        //刷新
#define kRefreshType_More @"kRefreshType_More"      //加载更过
#endif

@interface QuakeListViewController ()
{
    QuakeListQueue *quakeListControl;
}

@end

@implementation QuakeListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.datasource = [[HazardsDataSource alloc] init];
        [self setupHttpQueue];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.datasource = [[HazardsDataSource alloc] init];
        [self setupHttpQueue];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.datasource = [[HazardsDataSource alloc] init];
        [self setupHttpQueue];
    }
    return self;
}

-(void)dealloc
{
    [self destoryHttpQueue];
}

#pragma mark - 绑定请求应答通知

- (void)setupHttpQueue
{
    quakeListControl = [[QuakeListQueue alloc] init];
    [[ITSTransManager defaultManager] add:quakeListControl];
}

- (void)destoryHttpQueue
{
    if (quakeListControl)
        [[ITSTransManager defaultManager] remove:quakeListControl];
    quakeListControl = nil;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showmenu:)];
    self.navigationItem.rightBarButtonItem = menuItem;
    
    [self refreshQuakeInfo:kRefreshType_All];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showmenu:(id)sender
{
    CGRect fromRect;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        
        UIView *view = (UIView *)[self.navigationController.navigationBar.subviews objectAtIndex:2];
        fromRect = view.frame;
        // 调整popover位置
        fromRect = CGRectMake(fromRect.origin.x, 64, view.frame.size.width, 1);
    }
    else {
        fromRect = ((UIView *)sender).frame;
    }
    
    NSArray *menuItems =
  @[
        [KxMenuItem menuItem:@"Map" image:[UIImage imageNamed:@"map"] target:self action:@selector(viewInMap:)],
        [KxMenuItem menuItem:@"Search" image:[UIImage imageNamed:@"search"] target:self action:@selector(setSearch:)]
    ];
    
    [KxMenu showMenuInView:self.navigationController.view fromRect:fromRect menuItems:menuItems];
}

- (void)viewInMap:(id)sender
{
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:[AppData appData].mapController];
    [self presentViewController:naviController animated:YES completion:^{
    
        [[AppData appData].mapController showHazards:self.datasource];
    }];
}

- (void)setSearch:(id)sender
{
    [self performSegueWithIdentifier:@"listsearch" sender:sender];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [super tableView:tableView numberOfRowsInSection:section];
    
    return [self.datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuakeCell";
    
    QuakeCell *cell = (QuakeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[QuakeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell updateDisplayUI:[self.datasource featureAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - 数据请求/应答

- (void)refreshQuakeInfo:(NSString *)tag
{
    if ([tag isEqualToString:kRefreshType_All])
        [self requestAllQuakeInfo];
    else if ([tag isEqualToString:kRefreshType_More])
        [self requestMoreQuakeInfo];
}

/**
 *	@brief	刷新数据
 */
- (void)requestAllQuakeInfo
{
    QuakeQueryRequest *request = [[QuakeQueryRequest alloc] init];
    request.userinfo = kRefreshType_All;
    
    [quakeListControl sendRequest:request target:self selector:@selector(displayUI:)];
}

/**
 *	@brief	加载更多，以最后一条的时间作为基准
 */
- (void)requestMoreQuakeInfo
{
    if ([self.datasource count] <= 0)
        [self requestAllQuakeInfo];
    
    QuakeQueryRequest *request = [[QuakeQueryRequest alloc] init];
    request.userinfo = kRefreshType_More;
    request.offset = [self.datasource count] + 1;
    
    [quakeListControl sendRequest:request target:self selector:@selector(displayUI:)];
}

- (void)displayUI:(id)note
{
    if (![note isKindOfClass:[QuakeFeaturesResponse class]])
        return;
    
    // 如果是刷新，需要清空datasource
    if ([((QuakeFeaturesResponse *)note).userinfo isEqualToString:kRefreshType_All]) {
        [self.datasource clear];
    }
    
    [self.datasource addToDataSource:note];
    
    [self.tableView reloadData];
}

#pragma mark - 列表刷新相关

-(void)refreshAll
{
    [self refreshQuakeInfo:kRefreshType_All];
}

-(void)loadMore
{
    [self refreshQuakeInfo:kRefreshType_More];
}

@end