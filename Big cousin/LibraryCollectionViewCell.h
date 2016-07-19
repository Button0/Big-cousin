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

@protocol ClickBtnDelegate <NSObject>
-(void)ClickBtn:(UIButton *)btn;
-(void)cellPush:(UITapGestureRecognizer *)sender;
@end

@interface LibraryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HomeTitleModel *titleModel;
@property (nonatomic, strong) ExpressionLibraryModel *libraryModel;

- (void)addTapGestureRecognizerWithImage;
//代理属性
@property(nonatomic, weak) id<ClickBtnDelegate>clickbtnDelegate;

@end
