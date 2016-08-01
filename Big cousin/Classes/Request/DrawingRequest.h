//
//  DrawingRequest.h
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseRequest.h"
#import "ArrNetWorkRequest.h"

@interface DrawingRequest : BaseRequest

+ (instancetype)sharaDrawingRequest;
//-------------------- 静态模板 ----------------------------**//
/** 最新 */
- (void)requestNewDrawingSuccess:(SuccessResponseArr)success
                         failurl:(FailureResponseArr)failurl;
/** 分类 */
- (void)requestHottesDrawingSuccess:(SuccessResponseArr)success
                            failurl:(FailureResponseArr)failurl;
//**------------------ 动态模板 ------------------------------**//
/** 最新 */
- (void)requestDynameicNewWithSuccess:(SuccessResponseArr)success
                              failure:(FailureResponseArr)failure;


/** 最热 */
- (void)requestDynameicHottestWithSuccess:(SuccessResponseArr)succcess
                                  failure:(FailureResponseArr)failure;
//------------------------ 抠脸 ------------------------------**//
- (void)requestMiserlySuccess:(SuccessResponseArr)success
                      failure:(FailureResponseArr)failure;


@end
