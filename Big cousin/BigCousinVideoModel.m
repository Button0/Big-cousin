//
//  BigCousinVideoModel.m
//  Big cousin
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BigCousinVideoModel.h"

@implementation BigCousinVideoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _userId = value;
    }
    
}
@end
