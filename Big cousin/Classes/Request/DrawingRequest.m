//
//  DrawingRequest.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingRequest.h"

static DrawingRequest *request = nil;
@implementation DrawingRequest


+ (instancetype)sharaDrawingRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[DrawingRequest alloc]init];
    });
    return request;
}
#pragma mark --------------------------- 静态模板 -------------------
//最新
- (void)requestNewDrawingSuccess:(SuccessResponseArr)success
                         failurl:(FailureResponseArr)failurl
{
    [self requestAllHomeTitleWithUrl:staticDrawingnews_url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failurl(error);
    }];
    
}

//分类
- (void)requestHottesDrawingSuccess:(SuccessResponseArr)success
                            failurl:(FailureResponseArr)failurl
{
    [self requestAllHomeTitleWithUrl:staticDrawingHottes_url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failurl(error);
    }];
}
#pragma mark ------------------------ 动态模板 ---------------------

//最新
- (void)requestDynameicNewWithSuccess:(SuccessResponseArr)success failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:DynamicDrawingNews_Url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//最热
- (void)requestDynameicHottestWithSuccess:(SuccessResponseArr)succcess failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:DynamicDrawingHottest_Url success:^(NSArray *arr) {
        succcess(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark ------------------------抠脸 -------------------------

- (void)requestMiserlySuccess:(SuccessResponseArr)success failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:MiserlyDrawingHottest_Url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


#pragma mark ---------------------------------------------------

- (void)requestAllHomeTitleWithUrl:(NSString *)url
                           success:(SuccessResponseArr)success
                           failure:(FailureResponseArr)failure
{
    ArrNetWorkRequest *request = [[ArrNetWorkRequest alloc] init];
    
    [request requestArrayWithUrl:url parmeters:nil successPesponse:^(NSArray *arr) {
        success(arr);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];

}

@end
