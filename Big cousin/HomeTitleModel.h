//
//  HomeTitleModel.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"
//#import "ExpressionLibraryModel.h"

@interface HomeTitleModel : BaseModel

/** eId */
@property (nonatomic, strong) NSNumber *eId;
/** title */
@property (nonatomic, strong) NSString *eName;
//@property (nonatomic, strong) ExpressionLibraryModel *libraryModel;

//+ (NSMutableArray *)parseTitlesWithDic:(NSDictionary *)dic;
@end
