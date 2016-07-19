//
//  LibraryRequest.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface LibraryRequest : BaseRequest

+ (instancetype)shareLibraryRequest;

/** 请求首页标题 */
- (void)requestHomeTitleSuccess:(SuccessResponse)success
                        failure:(FailureResponse)failure;

/** 请求表情库 */
- (void)requestExpressionLibraryWithID:(NSString *)ID
                               Success:(SuccessResponse)success
                                failure:(FailureResponse)failure;

/** 请求最新表情 */
- (void)requestNewestExpressionSuccess:(SuccessResponse)success
                               failure:(FailureResponse)failure;

/** 请求最热表情 */
- (void)requestHottestExpressionSuccess:(SuccessResponse)success
                                failure:(FailureResponse)failure;

@end
