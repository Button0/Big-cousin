//
//  LibraryCollectionViewCell.h
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTitleModel.h"
#import "ExpressionLibraryModel.h"

#define LibraryCollectionViewCell_Identity @"LibraryCollectionViewCell"

@class ExpressionLibraryModel;
@protocol ClickBtnDelegate <NSObject>
-(void)ClickBtn:(UIButton *)button;
-(void)cellPush:(UITapGestureRecognizer *)sender;
@end

@interface LibraryCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) HomeTitleModel *titleModel;
@property (nonatomic, strong, nonnull) NSArray<ExpressionLibraryModel *> *data;
@property (nonatomic, strong, null_unspecified) NSNumber *categoryId;
//代理属性
@property(nonatomic, weak, null_unspecified) id<ClickBtnDelegate>clickbtnDelegate;

@end
