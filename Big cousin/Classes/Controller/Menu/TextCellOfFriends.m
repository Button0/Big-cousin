//
//  TextCellOfFriends.m
//
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "TextCellOfFriends.h"

@implementation TextCellOfFriends

- (void)awakeFromNib {
    // Initialization code
//    self.friendsMessageLabel.layer.cornerRadius=20;
//    self.friendsMessageLabel.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{

    self.friendsMessageLabel.text = title;
    self.friendsMessageLabel.font = font;
    self.friendsMessageLabel.numberOfLines = 0;
    [self.friendsMessageLabel sizeToFit];
    CGFloat height = self.friendsMessageLabel.frame.size.height;
    
    return height;
}


@end
