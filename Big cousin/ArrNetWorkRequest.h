//
//  ArrNetWorkRequest.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ArrNetWorkRequest : NSObject

//成功回调
typedef void(^SuccessResponseArr)(NSArray *arr);
//失败回调
typedef void(^FailureResponseArr)(NSError *error);



@interface ArrNetWorkRequest : NSObject

- (void)requestArrayWithUrl:(NSString *)url
                  parmeters:(NSArray *)parameterArr
            successPesponse:(SuccessResponseArr)success
            failureResponse:(FailureResponseArr)failure;

- (void)sendArrayDataWithUrl:(NSString *)url
                   parmeters:(NSArray *)parameterArr
             successPesponse:(SuccessResponseArr)success
             failureResponse:(FailureResponseArr)failure;

- (void)sendArrayImageWithUrl:(NSString *)url
                    parmeters:(NSArray *)parameterArr
                        image:(UIImage *)uploadImage
              successPesponse:(SuccessResponseArr)success
              failureResponse:(FailureResponseArr)failure;

@end
