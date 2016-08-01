//
//  MiserlyModel.h
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"

@interface MiserlyModel : BaseModel
@property(strong, nonatomic) NSString *URL;

+ (NSMutableArray *)presentMiserlyWithArray:(NSArray *)array;
@end
