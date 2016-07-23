//
//  DrawingHottestCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB3g on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingHottestCollectionViewCell.h"

@implementation DrawingHottestCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(DynamicHottestModel *)model
{
    [_HottestImageV setImageWithURL:[NSURL URLWithString:[model.URL replacingStringToURL]]];
}



@end
