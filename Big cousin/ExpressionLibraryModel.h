//
//  ExpressionLibraryModel.h
//  Big cousin
//
//  Created by Mushroom on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseModel.h"

@interface ExpressionLibraryModel : BaseModel

/** 图片 */
@property (nonatomic, strong) NSString *coverUrl;
/** 名字 */
@property (nonatomic, strong) NSString *eName;
/** id */
@property (nonatomic, strong) NSNumber *eId;
/** 备忘标题 */
@property (nonatomic, strong) NSString *memo1;


//singleExpression key
/** 单个图片url */
@property (nonatomic, strong) NSString *Url;

@end
