//
//  ExpressionTabBar.h
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExpressionTabBar;
//自定义代理
@protocol ExpressionTabBarDelegate

- (void) expressionItemDidClicked:(ExpressionTabBar *)tabbar;

@end

@interface ExpressionTabBar : UITabBar

/** 当前选中tabBar的下标 */
@property(assign, nonatomic) int currentSelected;
/** 当前选中的item */
@property(strong ,nonatomic)UIButton *currentSelectedItem;
/** tabBar上面所有的item */
@property (strong, nonatomic) NSArray *allItems;
/** tabBar代理 */
@property(nonatomic, weak) id<ExpressionTabBarDelegate>expressionDelegate;

/** 初始化方法：根根据items初始化items */
- (id)initWithItems:(NSArray *)items frame:(CGRect)frame;

@end
