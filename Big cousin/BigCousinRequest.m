//
//  BigCousinRequest.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BigCousinRequest.h"

@implementation BigCousinRequest
-(void)BigCousinRequestWithparameter:(NSDictionary *)paramterDic success:(SuccessResponse)success failure:(FailureResponse)failure{
    
    NetWorkRequest *request = [[NetWorkRequest alloc]init];
    [request requestWithUrl:BigCousinGIFAuthorsRequest_Url parameters:paramterDic successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}
@end
