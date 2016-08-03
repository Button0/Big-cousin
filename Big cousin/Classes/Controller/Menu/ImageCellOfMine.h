//
//  ImageCellOfMine.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImageCellOfMine_identify @"ImageCellOfMine_identify"
@interface ImageCellOfMine : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *sendImageOfMine;

@property(nonatomic)CGPoint pointCenter;

@end
