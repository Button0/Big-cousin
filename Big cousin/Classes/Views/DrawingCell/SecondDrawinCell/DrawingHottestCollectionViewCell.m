//
//  DrawingHottestCollectionViewCell.m
//  Big cousin
//
//  Created by HMS,CK,SS,LYB3g on 16/7/21.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "DrawingHottestCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DrawingHottestCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self loadImage];
}

-(void)setModel:(DynamicHottestModel *)model
{
    [_HottestImageV sd_setImageWithURL:[NSURL URLWithString:[model.URL replacingStringToURL]]];
}

-(void)loadImage {
    
    [_HottestImageV sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:self.model.URL] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
    
}



@end
