//
//  DrawingHottestCollectionViewCell.h
//  Big cousin
//
//  Created by HMS,CK,SS,LYB3g on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicHottestModel.h"
#define DrawingHottestCollectionViewCell_Identify @"DrawingHottestCollectionViewCell_Identify"

@interface DrawingHottestCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *HottestImageV;

@property (strong, nonatomic) DynamicHottestModel *model;


@end
