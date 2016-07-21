//
//  DrawingNewCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingNewCollectionViewCell.h"

@implementation DrawingNewCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(DrawingModel *)model
{
    [_drawingNewImageV setImageWithURL:[NSURL URLWithString:model.url]];
}




@end
