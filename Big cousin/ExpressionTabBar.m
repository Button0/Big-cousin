//
//  ExpressionTabBar.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "ExpressionTabBar.h"

@implementation ExpressionTabBar

- (id)initWithItems:(NSArray *)items frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        for (int i = 0; i < items.count; i++)
        {
            UIButton *btn = (UIButton *)items[i];
            //定义宽度和高度
            CGFloat width = self.bounds.size.width / items.count;
            CGFloat height = self.bounds.size.height;
            //btn大小
            btn.frame = CGRectMake(i * width, 0, width, height);
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self addSubview:btn];
        }
        //赋值
        self.currentSelected = 0;
        self.currentSelectedItem = items[0];
        self.allItems = items;
    }
    
    return self;
}

- (void)btnClicked:(UIButton *)btn
{
    self.currentSelectedItem = btn;
    for (int i = 0; i < self.allItems.count; i++)
    {
        UIButton *tempButton = (UIButton *)self.allItems[i];
        
        if (btn == tempButton)
        {
            self.currentSelected = i;
            tempButton.selected = YES;
        }
        else
        {
            tempButton.selected = NO;
        }
    }
    
    if (_expressionDelegate)
    {
        [_expressionDelegate expressionItemDidClicked:self];
    }
}

@end
