//
//  QuakeListViewController.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeListViewController.h"
#import "QuakeListQueue.h"
#import "QuakeQueryRequest.h"
#import "QuakeFeaturesResponse.h"

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
        [self setupHttpQueue];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupHttpQueue];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
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
    
    [self requestList];
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
    if (self.datasource == nil || ((QuakeFeaturesResponse *)self.datasource).features == nil)
        return 0;
    else
        return [((QuakeFeaturesResponse *)self.datasource).features count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"QuakeCell";
    
    QuakeCell *cell = (QuakeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[QuakeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell updateDisplayUI:((QuakeFeaturesResponse *)self.datasource).features[indexPath.row]];
    
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

- (void)requestList
{
    QuakeQueryRequest *request = [[QuakeQueryRequest alloc] init];
    request.minmag = 4.9;

    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    dateFormate.dateFormat = @"yyyy-MM-dd";
    request.starttime = [dateFormate dateFromString:@"2013-09-22"];
    request.endtime = [dateFormate dateFromString:@"2013-10-22"];
    
    [quakeListControl sendRequest:request target:self selector:@selector(displayUI:)];
}

- (void)displayUI:(id)note
{
    if (![note isKindOfClass:[QuakeFeaturesResponse class]])
        return;
    
    self.datasource = note;
    
    [self.tableView reloadData];
}

@end
