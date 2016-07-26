//
//  UIImageView+Header.m
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/3/3.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import "UIImageView+Header.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (Header)
- (void)setHeader:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
