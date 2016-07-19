
//
//  LibraryCollectionViewCell.m
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "LibraryCollectionViewCell.h"
#import "PublicCollectionViewController.h"

@interface LibraryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *eID;

@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UILabel *towLabel;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fourImageView;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;


@end
@implementation LibraryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)more:(UIButton *)sender {
    
    [self.clickbtnDelegate ClickBtn:sender];    
}

-(void)cellPush:(UITapGestureRecognizer *)sender
{
    [self.clickbtnDelegate cellPush:sender];
}

- (void)addTapGestureRecognizerWithImage
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellPush:)];
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellPush:)];
    UITapGestureRecognizer *recognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellPush:)];
    UITapGestureRecognizer *recognizer4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellPush:)];
    [_oneImageView addGestureRecognizer:recognizer];
    [_twoImageView addGestureRecognizer:recognizer2];
    [_threeImageView addGestureRecognizer:recognizer3];
    [_fourImageView addGestureRecognizer:recognizer4];
}

#pragma mark - 数据
- (void)setTitleModel:(HomeTitleModel *)titleModel
{
    [self addTapGestureRecognizerWithImage];
    _titleModel = titleModel;
    _titleLabel.text = [NSString stringWithFormat:@"🐒 %@",titleModel.eName];
    _eID = titleModel.eId;
}

@end
