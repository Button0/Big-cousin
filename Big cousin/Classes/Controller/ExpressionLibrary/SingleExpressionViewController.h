//
//  SingleExpressionViewController.h
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpressionLibraryModel.h"

@interface SingleExpressionViewController : BaseViewController
//push时传参数用
@property (nonatomic, strong) ExpressionLibraryModel *expressionModel;

@end
