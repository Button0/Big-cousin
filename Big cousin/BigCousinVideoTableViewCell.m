//
//  BigCousinVideoTableViewCell.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BigCousinVideoTableViewCell.h"

@implementation BigCousinVideoTableViewCell

- (void)awakeFromNib {

    self.VideoView.layer.cornerRadius = 6.0;
    self.VideoView.layer.borderWidth = 3.0;
    self.VideoView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}


-(void)setModel:(BigCousinVideoModel *)model{
    self.titleLabel.text = model.title;
    self.thumbUpLabel.text = [NSString stringWithFormat:@"%ld",(long)model.upNum];
    self.stepOnLabel.text = [NSString stringWithFormat:@"%ld",(long)model.downNum];
    self.commentsLabel.text = [NSString stringWithFormat:@"%ld",(long)model.commentNum];
    self.reprintedLabel.text = [NSString stringWithFormat:@"%ld",(long)model.shareNum];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
