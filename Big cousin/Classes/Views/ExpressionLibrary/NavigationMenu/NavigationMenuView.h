//
//  NavigationMenuView.h
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTable.h"

//menu 协议
@protocol NavigationMenuDelegate <NSObject>
/** menu 选择的下标 */
- (void)didSelectItemAtIndex:(NSUInteger)index;

@end

@interface NavigationMenuView : UIView <MenuDelegate>
/** 导航栏下拉菜单代理 */
@property (nonatomic, weak) id <NavigationMenuDelegate> delegate;
/** menu 元素下标数组 */
@property (nonatomic, strong) NSArray *items;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)displayMenuInView:(UIView *)view;

@end
