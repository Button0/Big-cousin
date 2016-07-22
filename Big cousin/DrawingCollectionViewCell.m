//
//  DrawingCollectionViewCell.m
//  Big cousin
//
//  Created by HMS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingCollectionViewCell.h"

@implementation DrawingCollectionViewCell

- (void)awakeFromNib {
    
    self.DrowingImageV.layer.masksToBounds = YES;
    self.DrowingImageV.layer.cornerRadius = self.DrowingImageV.bounds.size.width/2.0;
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = self.contentView.bounds.size.width/2.0;    
}

@end
