//
//  ExpressionLibraryModel.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"

@interface ExpressionLibraryModel : BaseModel

/** id */
@property (nonatomic, strong) NSString *eId;
/** 图片 */
@property (nonatomic, strong) NSString *coverUrl;
/** 名字 */
@property (nonatomic, strong) NSString *eName;
/** 备忘标题 */
@property (nonatomic, strong) NSString *memo;

@end
