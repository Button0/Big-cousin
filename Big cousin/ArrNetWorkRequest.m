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
            failureResponse:(FailureResponseArr)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager GET:url parameters:parameterArr progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

- (void)sendArrayDataWithUrl:(NSString *)url
                   parmeters:(NSArray *)parameterArr
             successPesponse:(SuccessResponseArr)success
             failureResponse:(FailureResponseArr)failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager POST:url parameters:parameterArr progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];

}

- (void)sendArrayImageWithUrl:(NSString *)url
                    parmeters:(NSArray *)parameterArr
                        image:(UIImage *)uploadImage
              successPesponse:(SuccessResponseArr)success
              failureResponse:(FailureResponseArr)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parameterArr constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(uploadImage,0.5) name:@"avatar" fileName:@"avatar.jpg" mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
    }];

    
    
}







@end
