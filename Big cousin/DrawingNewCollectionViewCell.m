//
//  DrawingNewCollectionViewCell.m
//  Big cousin
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingNewCollectionViewCell.h"
#import "ExpressionLibraryModel.h"

@implementation DrawingNewCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setLibraryModel:(ExpressionLibraryModel *)libraryModel
{
    _libraryModel = libraryModel;
    [_drawingNewImageV setImageWithURL:[NSURL URLWithString:[libraryModel.Url replacingStringToURL]]];
}

@end
