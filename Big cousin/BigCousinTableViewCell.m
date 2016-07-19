//
//  BigCousinTableViewCell.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BigCousinTableViewCell.h"

@implementation BigCousinTableViewCell

- (void)awakeFromNib {

    self.VideoView.layer.cornerRadius = 6.0;
    self.VideoView.layer.borderWidth = 3.0;
    self.VideoView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    
}

-(void)setModel:(BigCousinGIFModel *)model{
    
    _model = model;
    
    //读取gif数据
//    NSData *gifData = [NSData dataWithContentsOfURL:];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    //取消回弹效果
//    webView.scrollView.bounces=NO;
//    webView.backgroundColor = [UIColor clearColor];
//    //设置缩放模式
//    webView.scalesPageToFit = YES;
//    //用webView加载数据
//    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    
    self.titleLabel.text = model.title;
    self.thumbUpLabel.text = [NSString stringWithFormat:@"%ld",model.upNum];
    self.stepOnLabel.text = [NSString stringWithFormat:@"%ld",model.downNum];
    self.commentsLabel.text = [NSString stringWithFormat:@"%ld",model.commentNum];
    self.reprintedLabel.text = [NSString stringWithFormat:@"%ld",model.shareNum];
//    self.VideoImageView setImageWithURL:[NSURL URLWithString:model.mainPicPath]];
    [self.VideoImageView setImageWithURL:[NSURL URLWithString:model.gifPath] placeholderImage:nil];

    
}



- (IBAction)praiseBtn:(UIButton *)sender {
    
    
}

- (IBAction)StepOn:(UIButton *)sender {
    
    
}

- (IBAction)CommentsBtn:(UIButton *)sender {
    
    
}

- (IBAction)ShareBtn:(UIButton *)sender {
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
