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
@property (nonatomic,assign) CGPoint startPoint;
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
    NSString *hint = @"   下拉耍耍💃🏻";
    if (memo1 == nil)
    {
        _memoLabel.text = hint;
    }
    else
    {
        _memoLabel.text = [hint stringByAppendingString:memo1];
    }
}

//任意位置拖动
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:_myLabel];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint destPoint = [touch locationInView:_myLabel];
    
    float x = destPoint.x - _startPoint.x;
    float y = destPoint.y - _startPoint.y;
    
    CGPoint center = _myLabel.center;
    center.x += x;
    center.y += y;
    
    _myLabel.center = center;
}
//*/

@end
