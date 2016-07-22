//
//  DrawingNewCollectionViewCell.h
//  Big cousin
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DrawingNewCollectionViewCell_Identify @"DrawingNewCollectionViewCell_Identify"
@class ExpressionLibraryModel;

@interface DrawingNewCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *drawingNewImageV;
/** 单个表情 */
@property (nonatomic, strong) ExpressionLibraryModel *libraryModel;

@end
