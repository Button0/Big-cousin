//
//  LibraryRequest.m
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "LibraryRequest.h"

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

//请求首页标题
- (void)requestHomeTitleSuccess:(SuccessResponse)success
                        failure:(FailureResponse)failure;
{
    [self requestAllHomeTitleWithUrl:HomeTitle_Url success:^(NSDictionary *dic) {
        success(dic);
    } faolure:^(NSError *error) {
        failure(error);
    }];
}

//请求表情库
- (void)requestExpressionLibraryWithID:(NSString *)ID
                               Success:(SuccessResponse)success
                               failure:(FailureResponse)failure
{
    [self requestAllHomeTitleWithUrl:ExpressionLibrary_Url(ID) success:^(NSDictionary *dic) {
        success(dic);
    } faolure:^(NSError *error) {
        failure(error);
    }];
}

//请求最新表情
- (void)requestNewestExpressionSuccess:(SuccessResponse)success
                               failure:(FailureResponse)failure
{
    [self requestAllHomeTitleWithUrl:NewestExpression_Url success:^(NSDictionary *dic) {
        success(dic);
    } faolure:^(NSError *error) {
        failure(error);
    }];

}

//请求最热表情
- (void)requestHottestExpressionSuccess:(SuccessResponse)success
                                failure:(FailureResponse)failure
{
    [self requestAllHomeTitleWithUrl:HottestExpression_Url success:^(NSDictionary *dic) {
        success(dic);
    } faolure:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestAllHomeTitleWithUrl:(NSString *)url
                           success:(SuccessResponse)success
                           faolure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}

@end
