//
//  LibraryRequest.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseRequest.h"
#import "ArrNetWorkRequest.h"

@interface LibraryRequest : BaseRequest

+ (instancetype)shareLibraryRequest;

/** 请求首页标题 */
- (void)requestHomeTitleSuccess:(SuccessResponseArr)success
                        failure:(FailureResponseArr)failure;

/** 请求最新最热 */
- (void)requestPulicExpressionsWithUrl:(NSString *)url
                               success:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure;

/** 请求轮播图表情 */
- (void)requestCycleScrollExpressionWithID:(NSString *)ID
                                   success:(SuccessResponse)success
                                   failure:(FailureResponse)failure;

/** 请求表情库首页cell */
- (void)requestExpressionLibraryWithID:(NSString *)ID
                               Success:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure;

/** 请求单个表情组 */
- (void)requestSingleExpressionWithID:(NSString *)ID
                               Success:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure;

@end
