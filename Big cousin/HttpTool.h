//
//  HttpTool.h
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/7/23.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id json))success
                                                                 failure:(void (^)(NSError *error))failure;

@end
