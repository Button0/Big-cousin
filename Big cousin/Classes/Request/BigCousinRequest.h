//
//  BigCousinRequest.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigCousinRequest : NSObject
-(void)BigCousinRequestWithparameter:(NSDictionary *)paramterDic success:(SuccessResponse)success failure:(FailureResponse)failure;
@end
