//
//  QuakeFeaturesResponse.h
//  EarthquakeInfo
//
//  Created by xukj on 13-10-22.
//  Copyright (c) 2013年 xukj. All rights reserved.
//

#import "BaseResponse.h"

/**
 *	@brief	应答状态码
 */
enum ResponseStatus {
    
    SUCCESS = 200,                                  //成功
    NO_CONENT = 204,                                //没有数据
    BAD_PARAM = 400,                                //错误参数
    UNAUTHORIZED = 401,                             //需要认证
    AUTHORIZE_FAIL_OR_ACCESS_BLOCKED = 403,         //认证失败
    RESULT_TOOLARGE = 413,                          //结果数据太大
    REQUEST_URI_TOOLARGE = 414,                     //过大的URI
    INTERNAL_SERVER_ERROR = 500,                    //服务器错误
    SERVER_TEMPORARILY_UNAVAILABLE = 504            //服务器暂时无法访问
};

/**
 *	@brief	结果经纬度范围
 */
struct ResponseBBOX {
    
    float minlongitude;
    float minlatitude;
    float mindepth;
    float maxlongitude;
    float maxlatitude;
    float maxdepth;
};

@interface QuakeFeaturesResponse : BaseResponse

#pragma mark - 数据相关

/**
 *	@brief	数据来源
 */
@property (nonatomic, strong) NSString *title;

/**
 *	@brief	生成时间
 */
@property (nonatomic, strong) NSDate *generate;

/**
 *	@brief	数据数组
 */
@property (nonatomic, strong) NSMutableArray *features;

/**
 *	@brief	数据个数
 */
@property (nonatomic, assign) NSInteger count;

/**
 *	@brief	数据所在的经纬度范围
 */
@property (nonatomic, assign) struct ResponseBBOX bbox;

#pragma mark - 连接相关

/**
 *	@brief	请求状态
 */
@property (nonatomic, assign) enum ResponseStatus status;

/**
 *	@brief	版本号
 */
@property (nonatomic, strong) NSString *api;

@end
