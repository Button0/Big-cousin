//
//  HomeTitleModel.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"

@interface HomeTitleModel : BaseModel

/** eId */
@property (nonatomic, strong) NSString *eId;
/** title */
@property (nonatomic, strong) NSString *eName;

//+ (NSMutableArray *)parseTitlesWithDic:(NSDictionary *)dic;
@end
