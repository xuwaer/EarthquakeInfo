//
//  QuakeCell.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "QuakeCell.h"
#import "QuakeFeature.h"
#import "ModelUtil.h"

enum ALERT_LEVEL {
    ALERT_LEVEL_NONE = 0,
    ALERT_LEVEL_GREEN = 1,
    ALERT_LEVEL_YELLOW = 2,
    ALERT_LEVEL_ORANGE = 3,
    ALERT_LEVEL_RED = 4
    };

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
    self.timeLabel.text = [ModelUtil convertDateToUTCType2:feature.time];
    
    [self setAlert:feature.alert];
    if (feature.alert != [UIColor blackColor]) {
        self.magLabel.font = [UIFont boldSystemFontOfSize:24.0];
    }
    else {
        self.magLabel.font = [UIFont systemFontOfSize:24.0];
    }
    
    self.depthLabel.text = [ModelUtil formatDepthData:feature.geoemtry.depth];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    QuakeFeature *feature = (QuakeFeature *)_datasource;
    if (feature.alert == [UIColor blackColor])
        [self setAnimate:ALERT_LEVEL_NONE];
    else if (feature.alert == [UIColor greenColor])
        [self setAnimate:ALERT_LEVEL_GREEN];
    else if (feature.alert == [UIColor yellowColor])
        [self setAnimate:ALERT_LEVEL_YELLOW];
    else if (feature.alert == [UIColor orangeColor])
        [self setAnimate:ALERT_LEVEL_ORANGE];
    else if (feature.alert == [UIColor redColor])
        [self setAnimate:ALERT_LEVEL_RED];
}

-(void)setAnimate:(enum ALERT_LEVEL)alertlevel
{
    float duration = 1.0;
    switch (alertlevel) {
        case ALERT_LEVEL_NONE:
            duration = 0;
            break;
        case ALERT_LEVEL_GREEN:
            duration = 1;
            break;
        case ALERT_LEVEL_YELLOW:
            duration = 0.75;
            break;
        case ALERT_LEVEL_ORANGE:
            duration = 0.5;
            break;
        case ALERT_LEVEL_RED:
            duration = 0.25;
            break;
        default:
            duration = 0;
            break;
    }
    
    if (duration == 0)
        return;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationRepeatCount:FLT_MAX];
    [UIView setAnimationRepeatAutoreverses:YES];
    [self setAlpha:0.2];
    [UIView commitAnimations];
}

-(void)setAlert:(UIColor *)alert
{
    self.magLabel.textColor = alert;
    self.placeLabel.textColor = alert;
    self.timeLabel.textColor = alert;
    self.depthLabel.textColor = alert;
}

-(void)setAlpha:(float)alpha
{
    self.magLabel.alpha = alpha;
    self.placeLabel.alpha = alpha;
    self.timeLabel.alpha = alpha;
    self.depthLabel.alpha = alpha;
}

@end
