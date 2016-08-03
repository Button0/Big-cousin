//
//  MiserlyCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "MiserlyCollectionViewCell.h"

@implementation MiserlyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(MiserlyModel *)model
{
    [_miserlyImageV setImageWithURL:[NSURL URLWithString:[model.URL replacingStringToURL]]];

}




@end
