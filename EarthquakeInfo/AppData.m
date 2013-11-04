//
//  AppData.m
//  EarthquakeInfo
//
//  Created by xukj on 13-10-25.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "AppData.h"
#import "Constant.h"

static AppData *staticAppData = nil;

@interface AppData ()

@property (nonatomic, strong) NSUserDefaults *userDefault;

@end

@implementation AppData

+(AppData *)appData
{
    if (staticAppData == nil) {
        staticAppData = [[AppData alloc] init];
    }
    
    return staticAppData;
}

#pragma mark AppData使用

- (id)init
{
    self = [super init];
    if (self) {
        self.userDefault = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

/**
 *	@brief	初始化状态
 */
- (void)defaultSetting
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:nil];
}

/**
 *	@brief	加载配置
 */
- (NSDictionary *)loadSetting
{
    return nil;
}

/**
 *	@brief	保存配置
 */
- (void)saveSetting
{

}

@end
