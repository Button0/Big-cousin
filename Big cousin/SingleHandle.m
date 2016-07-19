//
//  SingleHandle.m
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleHandle.h"

static SingleHandle *handle = nil;
@implementation SingleHandle

+ (instancetype)shareSingleHandle
{
    //线程 这个block中的（括号里写的）代码 在程序运行中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        handle = [[SingleHandle alloc] init];
    });
    return handle;
}

@end
