//
//  SingleExpressionViewController.h
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BaseViewController.h"

@class ExpressionLibraryModel;

@interface SingleExpressionViewController : BaseViewController

@property (nonatomic, strong) ExpressionLibraryModel *expressionModel;
@property (nonatomic, strong) NSNumber *single_Id;

@end
