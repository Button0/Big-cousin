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
- (void)requestHomeTitleSuccess:(SuccessResponseArr)success
                        failure:(FailureResponseArr)failure;
{
    [self requestAllHomeTitleWithUrl:HomeTitle_Url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
//    [self requestAllHomeTitleWithUrl:HomeTitle_Url success:^(NSDictionary *dic) {
//        success(dic);
//    } faolure:^(NSError *error) {
//        failure(error);
//    }];
}

//请求表情库
- (void)requestExpressionLibraryWithID:(NSString *)ID
                               Success:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:ExpressionLibrary_Url(ID) success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
//    [self requestAllHomeTitleWithUrl:ExpressionLibrary_Url(ID) success:^(NSDictionary *dic) {
//        success(dic);
//    } faolure:^(NSError *error) {
//        failure(error);
//    }];
}

//请求最新表情
- (void)requestNewestExpressionSuccess:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:NewestExpression_Url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//请求最热表情
- (void)requestHottestExpressionSuccess:(SuccessResponseArr)success
                                failure:(FailureResponseArr)failure
{
    [self requestAllHomeTitleWithUrl:HottestExpression_Url success:^(NSArray *arr) {
        success(arr);
    } failure:^(NSError *error) {
        failure(error);
    }];
//    [self requestAllHomeTitleWithUrl:HottestExpression_Url success:^(NSDictionary *dic) {
//        success(dic);
//    } faolure:^(NSError *error) {
//        failure(error);
//    }];
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
//    [request requestWithUrl:url parameters:nil successResponse:^(NSDictionary *dic) {
//        success(dic);
//    } failureResponse:^(NSError *error) {
//        failure(error);
//    }];
}

@end
