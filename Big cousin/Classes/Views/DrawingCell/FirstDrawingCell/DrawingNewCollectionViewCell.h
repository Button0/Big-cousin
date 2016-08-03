//
//  DrawingNewCollectionViewCell.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingModel.h"
#import "DynamicModel.h"
#import "DALabeledCircularProgressView.h"

#define DrawingNewCollectionViewCell_Identify @"DrawingNewCollectionViewCell_Identify"

@class ExpressionLibraryModel;

@interface DrawingNewCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *drawingNewImageV;
/** 单个表情 */
@property (nonatomic, strong) ExpressionLibraryModel *libraryModel;

@property (strong, nonatomic) DrawingModel *model;

@property (strong, nonatomic) DynamicModel *dynamicModel;

@property (nonatomic,strong) DALabeledCircularProgressView *progressView;
@end
