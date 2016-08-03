//
//  ImageCellOfFriends.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ImageCellOfFriends.h"

@implementation ImageCellOfFriends

- (void)awakeFromNib {
    
    self.sendImageOfFriends.userInteractionEnabled = YES;
    
    //双击放大
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired=2;
    tap.numberOfTouchesRequired=1;
    [self.sendImageOfFriends addGestureRecognizer:tap];
    
    //长按缩小
    UILongPressGestureRecognizer *longP=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPAction:)];
    longP.numberOfTapsRequired=0;
    longP.numberOfTouchesRequired=1;
    longP.minimumPressDuration=1;//设置长按时间为1S
    [self.sendImageOfFriends addGestureRecognizer:longP];
    
    self.pointCenter = self.sendImageOfFriends.center;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)tapAction:(UITapGestureRecognizer *)sender{
    
    self.sendImageOfFriends.frame = CGRectMake(0, 50, self.contentView.frame.size.width, 300);
    
}

-(void)longPAction:(UITapGestureRecognizer *)sender{
    
    self.sendImageOfFriends.bounds = CGRectMake(0, 0, 118, 144);
    self.sendImageOfFriends.center = self.pointCenter ;


}




@end
