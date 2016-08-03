//
//  CustomCollectionViewCell.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CustomCollectionViewCell_identify @"CustomCollectionViewCell_identify"
@interface CustomCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *Label;



@end
