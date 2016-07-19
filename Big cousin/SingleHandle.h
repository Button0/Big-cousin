//
//  SingleHandle.h
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleHandle : NSObject

+ (instancetype)shareSingleHandle;

/** title */
@property (nonatomic, strong) NSString *title;
/** id */
@property (nonatomic, strong) NSString *eId;

@end
