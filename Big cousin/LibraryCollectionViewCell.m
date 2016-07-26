
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

@interface LibraryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) NSNumber *eID;
@property (nonatomic) NSNumber *single_eId;

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
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager GET:ExpressionLibrary_Url(categroyId) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
        if (responseObject.count >= 3
            && [[responseObject objectAtIndex:2] isKindOfClass:[NSArray class]])
        {
            NSMutableArray *array = [responseObject objectAtIndex:2];
            NSMutableArray<ExpressionLibraryModel *> *categoryList = [[NSMutableArray alloc] init];
            
            for (int i=0; i< 4; i++)
            {
                NSDictionary *dataDictionary = [array objectAtIndex:i];
                
                ExpressionLibraryModel *model = [[ExpressionLibraryModel alloc] init];
                NSString *url = [dataDictionary objectForKey:@"coverUrl"];
                NSString *name = [dataDictionary objectForKey:@"eName"];
                NSNumber *eId = [dataDictionary objectForKey:@"eId"];
                model.coverUrl = url;
                model.eName = name;
                model.eId = eId;
                [weakSelf.clickbtnDelegate passValue:eId];
                [categoryList addObject:model];
            }
            //TODO:
            dispatch_async(dispatch_get_main_queue(), ^{
                [_oneImageView setImageWithURL:[NSURL URLWithString:categoryList[0].coverUrl]];
                [_twoImageView setImageWithURL:[NSURL URLWithString:categoryList[1].coverUrl]];
                [_threeImageView setImageWithURL:[NSURL URLWithString:categoryList[2].coverUrl]];
                [_fourImageView setImageWithURL:[NSURL URLWithString:categoryList[3].coverUrl]];
                
                _oneLabel.text = categoryList[0].eName;
                _towLabel.text = categoryList[1].eName;
                _threeLabel.text = categoryList[2].eName;
                _fourLabel.text = categoryList[3].eName;
            });
        }
        else
        {
            NSLog(@"Error: datat Error %@", responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];
}

@end
