//
//  DrawingHottesCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/16.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingHottesCollectionViewCell.h"
#import "SingleExpressionViewController.h"

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

- (void)setHottesModel:(DrawingHottesModel *)hottesModel
{
    _hottesModel = hottesModel;
    [_hottesImageV setImageWithURL:[NSURL URLWithString:hottesModel.url]];
    _hottesLabel.text = hottesModel.eName;
}

@end
