//
//  HomeTitleModel.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"

@interface HomeTitleModel : BaseModel

/** title */
@property (nonatomic, strong) NSString *eName;
/** eId */
@property (nonatomic, strong) NSNumber *eId;

//+ (NSMutableArray *)parseTitlesWithDic:(NSDictionary *)dic;
@end
