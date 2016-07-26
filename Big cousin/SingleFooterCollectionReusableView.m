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
        _memoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, self.bounds.size.height)];
        [self addSubview:_memoLabel];
        _memoLabel.textColor = KColorHighGray;
        _memoLabel.numberOfLines = 0;
        _memoLabel.adjustsFontSizeToFitWidth = YES;
        [_memoLabel sizeToFit];
        _memoLabel.frame = CGRectMake(0, 0, 310, self.bounds.size.height);
    }
    return self;
}

- (void)setMemo1:(NSString *)memo1
{
    _memo1 = memo1;
    _memoLabel.text = memo1;
}

@end
