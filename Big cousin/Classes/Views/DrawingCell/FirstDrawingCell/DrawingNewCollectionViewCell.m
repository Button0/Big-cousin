//
//  DrawingNewCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingNewCollectionViewCell.h"
#import "ExpressionLibraryModel.h"
#import "UIImageView+WebCache.h"

@implementation DrawingNewCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
//    [self loadImage];
}

- (void)setLibraryModel:(ExpressionLibraryModel *)libraryModel
{
    _libraryModel = libraryModel;
    if (libraryModel.Url != nil)
    {
        [_drawingNewImageV sd_setImageWithURL:[NSURL URLWithString:[libraryModel.Url replacingStringToURL]]];
    }
    else if (libraryModel.gifPath != nil)
    {
        [_drawingNewImageV sd_setImageWithURL:[NSURL URLWithString:libraryModel.gifPath]];
    }
}

- (void)setModel:(DrawingModel *)model
{
    [_drawingNewImageV sd_setImageWithURL:[NSURL URLWithString:model.url]];
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel
{
    [_drawingNewImageV sd_setImageWithURL:[NSURL URLWithString:[dynamicModel.URL replacingStringToURL]]];
    //NSLog(@"dynamicModel.url ======= %@",[dynamicModel.URL replacingStringToURL]);
}

-(void)loadImage {
    
    [_drawingNewImageV sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:self.libraryModel.Url] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
}

@end
