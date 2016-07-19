//
//  BigCousinVideoTableViewCell.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigCousinVideoModel.h"
#define BigCousinVideoTableViewCell_identify @"BigCousinVideoTableViewCell_identify"
@interface BigCousinVideoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *VideoView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *thumbUpLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepOnLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *reprintedLabel;

-(void)setModel:(BigCousinVideoModel *)model;
@end
