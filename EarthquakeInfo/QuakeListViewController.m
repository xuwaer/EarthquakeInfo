//
//  QuakeListViewController.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeListViewController.h"
#import "QuakeFeaturesResponse.h"
#import "QuakeFeature.h"

#ifndef kRefreshType
#define kRefreshType_All @"kRefreshType_All"        //刷新
#define kRefreshType_More @"kRefreshType_More"      //加载更过
#endif

@implementation QuakeDataSource
{
    NSInteger cursor;
}

-(id)init
{
    self = [super init];
    if (self) {
        _data = [[NSMutableArray alloc] init];
        cursor = -1;
    }
    return self;
}

-(NSInteger)count
{
    return _data.count;
}

-(void)addToDataSource:(QuakeFeaturesResponse *)inData
{
    if (inData.features == nil || inData.features.count <= 0)
        return;
    
    [_data addObjectsFromArray:inData.features];
    _earlyDate = ((QuakeFeature *)[self lastFeature]).time;
}

-(id)featureAtIndex:(NSInteger)index
{
    return [_data objectAtIndex:index];
}

-(id)firstFeature
{
    if (_data.count <= 0)
        return nil;
    else
        return [_data firstObject];
}

-(id)lastFeature
{
    if (_data.count <= 0)
        return nil;
    else
        return [_data lastObject];
}

-(void)moveCursor:(NSInteger)cursorTo
{
    cursor = cursorTo;
}

-(id)nextFeature
{
    if (cursor + 1 >= _data.count)
        return nil;
    else
        return [self featureAtIndex:++cursor];
}

-(id)previousFeature
{
    if (cursor - 1 < 0)
        return nil;
    else
        return [self featureAtIndex:--cursor];
}

-(void)clear
{
    [_data removeAllObjects];
    cursor = -1;
}

@end


/////////////////////////////////////////////////////////////////////////////////////////////

#import "QuakeListQueue.h"
#import "QuakeQueryRequest.h"

#import "QuakeCell.h"

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
        self.datasource = [[QuakeDataSource alloc] init];
        [self setupHttpQueue];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.datasource = [[QuakeDataSource alloc] init];
        [self setupHttpQueue];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.datasource = [[QuakeDataSource alloc] init];
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
    
    [self refreshQuakeInfo:kRefreshType_All];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

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
//    request.minmag = 4.9;
//    
//    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
//    dateFormate.dateFormat = @"yyyy-MM-dd";
//    request.starttime = [dateFormate dateFromString:@"2013-09-22"];
//    request.endtime = [dateFormate dateFromString:@"2013-10-22"];
    request.userinfo = kRefreshType_All;
    
    [quakeListControl sendRequest:request target:self selector:@selector(displayUI:)];
}

/**
 *	@brief	加载更多，以最后一条的时间作为基准
 */
- (void)requestMoreQuakeInfo
{
    NSDate *endDate = [self.datasource earlyDate];
    // 如果datasource为空，默认刷新数据
    if (endDate == nil)
        [self requestAllQuakeInfo];
    
    QuakeQueryRequest *request = [[QuakeQueryRequest alloc] init];
//    request.minmag = 4.9;
    
//    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
//    dateFormate.dateFormat = @"yyyy-MM-dd";
//    request.starttime = endDate;
//    request.endtime = [dateFormate dateFromString:@"2013-10-22"];
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