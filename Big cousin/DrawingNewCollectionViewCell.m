//
//  DrawingNewCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
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

- (void)setModel:(DrawingModel *)model
{
    [_drawingNewImageV setImageWithURL:[NSURL URLWithString:model.url]];
}

@end
