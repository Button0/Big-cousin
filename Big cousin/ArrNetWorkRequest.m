//
//  ArrNetWorkRequest.m
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ArrNetWorkRequest.h"

@implementation ArrNetWorkRequest

- (void)requestArrayWithUrl:(NSString *)url
                  parmeters:(NSArray *)parameterArr
            successPesponse:(SuccessResponseArr)success
            failureResponse:(FailureResponseArr)failure;
{}

- (void)sendArrayDataWithUrl:(NSString *)url
                   parmeters:(NSArray *)parameterArr
             successPesponse:(SuccessResponseArr)success
             failureResponse:(FailureResponseArr)failure
{}

- (void)sendArrayImageWithUrl:(NSString *)url
                    parmeters:(NSArray *)parameterArr
                        image:(UIImage *)uploadImage
              successPesponse:(SuccessResponseArr)success
              failureResponse:(FailureResponseArr)failure
{}

@end
