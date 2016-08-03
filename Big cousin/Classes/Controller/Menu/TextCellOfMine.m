//
//  TextCellOfMine.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "TextCellOfMine.h"

@implementation TextCellOfMine

- (void)awakeFromNib {
    // Initialization code
    
    _messageLabel.layer.cornerRadius = 5;
    
    _messageLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    self.messageLabel.text = title;
    self.messageLabel.font = font;
    self.messageLabel.numberOfLines = 0;
    [self.messageLabel sizeToFit];
    CGFloat height = self.messageLabel.frame.size.height;
    
    return height;
}



@end
