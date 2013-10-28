//
//  QuakeListViewController.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-21.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HazardsDataSource;

/////////////////////////////////////////////////////////////////////////////////////////////

#import "RefreshTableViewController.h"

@interface QuakeListViewController : RefreshTableViewController

@property (nonatomic, strong) HazardsDataSource *datasource;

@end
