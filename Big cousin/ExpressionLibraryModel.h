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
/** 更多 ID */
@property (nonatomic, strong) NSString *coverId;
/** 图片 */
@property (nonatomic, strong) NSString *coverUrl;
/** 名字 */
@property (nonatomic, strong) NSString *eName;

//singleExpression key
/** 备忘标题 */
@property (nonatomic, strong) NSString *memo1;
/** 照片个数 */
@property (nonatomic, strong) NSString *picCount;
/** 单个图片url */
@property (nonatomic, strong) NSString *Url;

@end
