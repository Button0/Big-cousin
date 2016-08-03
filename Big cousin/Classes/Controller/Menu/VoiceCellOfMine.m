//
//  VoiceCellOfMine.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "VoiceCellOfMine.h"

@implementation VoiceCellOfMine

- (void)awakeFromNib {
    // Initialization code
    
    self.guestureLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];

    [self.guestureLabel addGestureRecognizer:tapGesture];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)tapGestureAction:(UIGestureRecognizer* )sender{
    
    if (_dellegate && [_dellegate respondsToSelector:@selector(playVoiceOnMineCell:)]) {
        
        [_dellegate playVoiceOnMineCell:self];
    }
}



@end
