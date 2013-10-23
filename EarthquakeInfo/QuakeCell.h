//
//  QuakeCell.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuakeCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UILabel *magLabel;
@property (nonatomic, assign) IBOutlet UILabel *placeLabel;
@property (nonatomic, assign) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong, readonly) id datasource;

- (void)updateDisplayUI:(id)datasource;

@end
