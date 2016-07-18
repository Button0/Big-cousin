//
//  MenuConfiguration.h
//  NavigationMenu
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuConfiguration : NSObject
//Menu width
+ (float)menuWidth;

//Menu item height
+ (float)itemCellHeight;

//菜单动画出现的时间
+ (float)animationDuration;

//菜单衬底alpha值
+ (float)backgroundAlpha;

//Menu alpha value
+ (float)menuAlpha;

//Value of bounce
+ (float)bounceOffset;

//标题最近的箭头图像
//Arrow image near title
+ (UIImage *)arrowImage;

//标题和箭图像之间的距离
+ (float)arrowPadding;

//Items color in menu
+ (UIColor *)itemsColor;

//Menu color
+ (UIColor *)mainColor;

//item 选择的动画速度
+ (float)selectionSpeed;

//Menu item text color
+ (UIColor *)itemTextColor;

//Selection color
+ (UIColor *)selectionColor;

@end
