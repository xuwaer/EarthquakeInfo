//
//  QuakeCell.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeCell.h"
#import "QuakeFeature.h"

@implementation QuakeCell

@synthesize datasource = _datasource;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateDisplayUI:(id)datasource
{
    if (datasource == nil)
        return;
    
    _datasource = datasource;
    
    QuakeFeature *feature = (QuakeFeature *)_datasource;
    self.magLabel.text = [NSString stringWithFormat:@"%.1f", feature.mag];
    self.placeLabel.text = feature.place;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"us"];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    self.timeLabel.text = [dateFormatter stringFromDate:feature.time];
}

@end
