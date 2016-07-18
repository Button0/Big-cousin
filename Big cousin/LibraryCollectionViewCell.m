
//
//  LibraryCollectionViewCell.m
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "LibraryCollectionViewCell.h"
#import "CollectionViewController.h"

@interface LibraryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

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
    self.userInteractionEnabled = YES;

}

- (IBAction)more:(UIButton *)sender {
        
}

- (void)addTarget:(id)target action:(SEL)action
{
    if (_oneImageView!=nil) {
        [self removeGestureRecognizer:_oneImageView];
    }
    _oneImageView = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:_oneImageView];
}

@end
