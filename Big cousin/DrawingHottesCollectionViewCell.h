//
//  DrawingHottesCollectionViewCell.h
//  Big cousin
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DrawingHottesCollectionViewCell_Identify @"DrawingHottesCollectionViewCell_Identify"

@interface DrawingHottesCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *hottesImageV;
@property (strong, nonatomic) IBOutlet UILabel *hottesLabel;

@end
