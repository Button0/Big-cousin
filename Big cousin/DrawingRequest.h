//
//  DrawingRequest.h
//  Big cousin
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseRequest.h"
#import "ArrNetWorkRequest.h"

@interface DrawingRequest : BaseRequest

+ (instancetype)sharaDrawingRequest;

/** 最新 */
- (void)requestNewDrawingSuccess:(SuccessResponseArr)success
                         failurl:(FailureResponseArr)failurl;
/** 分类 */
- (void)requestHottesDrawingSuccess:(SuccessResponseArr)success
                            failurl:(FailureResponseArr)failurl;



@end
