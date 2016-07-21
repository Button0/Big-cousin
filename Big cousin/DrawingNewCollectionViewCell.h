//
//  DrawingNewCollectionViewCell.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingModel.h"
#define DrawingNewCollectionViewCell_Identify @"DrawingNewCollectionViewCell_Identify"

@interface DrawingNewCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *drawingNewImageV;

@property (strong, nonatomic) DrawingModel *model;

@end
