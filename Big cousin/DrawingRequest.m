//
//  DrawingRequest.m
//  Big cousin
//
//  Created by lanou3g on 16/7/19.
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
