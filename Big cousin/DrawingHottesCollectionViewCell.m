//
//  DrawingHottesCollectionViewCell.m
//  Big cousin
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingHottesCollectionViewCell.h"
#import "HomeTitleModel.h"

@interface DrawingHottesCollectionViewCell ()
@end
@implementation DrawingHottesCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLibraryModel:(ExpressionLibraryModel *)libraryModel
{
    _libraryModel = libraryModel;
    [_hottesImageV setImageWithURL:[NSURL URLWithString:libraryModel.coverUrl]];
    _hottesLabel.text = libraryModel.eName;
}

@end
