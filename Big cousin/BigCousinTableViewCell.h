//
//  BigCousinTableViewCell.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "BigCousinGIFModel.h"
#define BigCousinTableViewCell_identify @"BigCousinTableViewCell_identify"

@interface BigCousinTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *VideoImageView;
@property (strong, nonatomic) IBOutlet UILabel *thumbUpLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepOnLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *reprintedLabel;

@property (strong, nonatomic) IBOutlet UIView *VideoView;

@property (strong, nonatomic) BigCousinGIFModel * model;

-(void)setModel:(BigCousinGIFModel *)model;
@end
