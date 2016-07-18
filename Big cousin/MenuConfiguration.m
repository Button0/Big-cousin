//
//  MenuConfiguration.m
//  NavigationMenu
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "MenuConfiguration.h"

@implementation MenuConfiguration
//Menu width
+ (float)menuWidth
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return window.frame.size.width- 100;
}

//Menu item height
+ (float)itemCellHeight
{
    return 44.0f;
}

//菜单动画出现的时间
+ (float)animationDuration
{
    return 0.3f;
}

//菜单衬底alpha值
+ (float)backgroundAlpha
{
    return 0.3;
}

//Menu alpha value
+ (float)menuAlpha
{
    return 0.5;
}

//Value of bounce
+ (float)bounceOffset
{
    return -7.0;
}

//标题最近的箭头图像
+ (UIImage *)arrowImage
{
    return [UIImage imageNamed:@"arrow_down.png"];
}

//标题和箭图像之间的距离
+ (float)arrowPadding
{
    return 13.0;
}

//Items color in menu
+ (UIColor *)itemsColor
{
    return [UIColor lightGrayColor];
}

+ (UIColor *)mainColor
{
    return [UIColor clearColor];
}

+ (float)selectionSpeed
{
    return 0.15;
}

+ (UIColor *)itemTextColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)selectionColor
{
    return [UIColor colorWithRed:178.0/255.0 green:221.0/255.0 blue:247.0/255.0 alpha:0.8];
}
@end
