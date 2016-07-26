
//
//  LibraryCollectionViewCell.m
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "LibraryCollectionViewCell.h"
#import "PublicCollectionViewController.h"
#import "ExpressionLibraryModel.h"
#import "LibraryRequest.h"

@interface LibraryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) NSNumber *eID;

@property (weak, nonatomic) IBOutlet UIView *oneView;
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
//    _oneImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _twoImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _threeImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _fourImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (IBAction)more:(UIButton *)sender {
    if (_clickbtnDelegate
        && [_clickbtnDelegate respondsToSelector:@selector(ClickBtn:)])
    {
        sender.tag = [_categoryId integerValue];
        [self.clickbtnDelegate ClickBtn:sender];
    }
}

-(void)cellPush:(UITapGestureRecognizer *)sender
{
    [self.clickbtnDelegate cellPush:sender];
}

//- (void)cellImagePushOfName:(ExpressionLibraryModel *)eName
//{
//    [self.clickbtnDelegate cellImagePushOfName:eName];
//}

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

- (void)setCategoryId:(NSNumber *)categoryId
{
    _categoryId = categoryId;
    [self requestCategoryListById:categoryId];
}

- (void)requestCategoryListById:(NSNumber *)categroyId
{
    [[LibraryRequest shareLibraryRequest] requestExpressionLibraryWithID:categroyId Success:^(NSArray *arr) {
        
        NSMutableArray<ExpressionLibraryModel *> *categoryList = [ExpressionLibraryModel presentLibraryCellWithArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_oneImageView setImageWithURL:[NSURL URLWithString:categoryList[0].coverUrl]];
            [_twoImageView setImageWithURL:[NSURL URLWithString:categoryList[1].coverUrl]];
            [_threeImageView setImageWithURL:[NSURL URLWithString:categoryList[2].coverUrl]];
            [_fourImageView setImageWithURL:[NSURL URLWithString:categoryList[3].coverUrl]];
            
            _oneImageView.tag = [categoryList[0].eId integerValue];
            _twoImageView.tag = [categoryList[1].eId integerValue];
            _threeImageView.tag = [categoryList[2].eId integerValue];
            _fourImageView.tag = [categoryList[3].eId integerValue];
            
            _oneLabel.text = categoryList[0].eName;
            _towLabel.text = categoryList[1].eName;
            _threeLabel.text = categoryList[2].eName;
            _fourLabel.text = categoryList[3].eName;
        });
    } failure:^(NSError *error) {
        NSLog(@"===%@",error);
    }];
}

@end
