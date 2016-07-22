//
//  SingleFooterCollectionReusableView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/20.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleFooterCollectionReusableView.h"

@interface SingleFooterCollectionReusableView ()
@property (nonatomic, strong) UILabel *memoLabel;

@end

@implementation SingleFooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _memoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 30)];
        _memoLabel.textColor = KColorHighGray;
//        [_memoLabel sizeToFit];
//        _memoLabel.frame = CGRectMake(0, 30, _memoLabel.frame.size.width, 30);
        [self addSubview:_memoLabel];
    }
    return self;
}

- (void)setMemo1:(NSString *)memo1
{
    _memo1 = memo1;
    _memoLabel.text = memo1;
}

@end
