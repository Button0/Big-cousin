//
//  MiserlyCollectionViewCell.h
//  Big cousin
//
//  Created by HMS,CK,SS,LYB3g on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiserlyModel.h"

#define MiserlyCollectionViewCell_Identify @"MiserlyCollectionViewCell_Identify"

@interface MiserlyCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *miserlyImageV;

@property (strong, nonatomic) MiserlyModel *model;

@end
