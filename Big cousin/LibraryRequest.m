//
//  LibraryRequest.m
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "LibraryRequest.h"
#import "NetWorkRequest.h"

@implementation LibraryRequest

static LibraryRequest *request = nil;

+ (instancetype)shareLibraryRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = [[LibraryRequest alloc] init];
    });
    
    return request;
}

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

//请求首页标题
- (void)requestHomeTitleSuccess:(SuccessResponseArr)success
                        failure:(FailureResponseArr)failure;
{
    [self requestAllHomeTitleWithUrl:HomeTitle_Url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//最新最热
- (void)requestPulicExpressionsWithUrl:(NSString *)url
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

//请求轮播图表情
- (void)requestCycleScrollExpressionWithID:(NSNumber *)ID
                                   success:(SuccessResponse)success
                                   failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:VTCycleScrollView_Url(ID) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

//请求表情库首页cell
- (void)requestExpressionLibraryWithID:(NSNumber *)ID
                               Success:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:ExpressionLibrary_Url(ID) success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//请求单个表情组
- (void)requestSingleExpressionWithID:(NSNumber *)ID
                              Success:(SuccessResponseArr)success
                              failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:SingleExpression_Url(ID) success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
