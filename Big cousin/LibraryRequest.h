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

/** 请求表情库 */
- (void)requestExpressionLibraryWithID:(NSString *)ID
                               Success:(SuccessResponseArr)success
                                failure:(FailureResponseArr)failure;

/** 请求最新表情 */
- (void)requestNewestExpressionSuccess:(SuccessResponseArr)success
                               failure:(FailureResponseArr)failure;

/** 请求最热表情 */
- (void)requestHottestExpressionSuccess:(SuccessResponseArr)success
                                failure:(FailureResponseArr)failure;

@end
