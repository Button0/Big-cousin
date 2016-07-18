//
//  RootViewController.h
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpressionTabBar.h"

@interface RootViewController : UITabBarController
/** 自定义tabBar */
@property (strong, nonatomic) ExpressionTabBar *expressionTabBar;

@end
