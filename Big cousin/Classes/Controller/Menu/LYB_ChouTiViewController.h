//
//  LYB_ChouTiViewController.h
//  ChouTi_FengZhuang
//
//  Created by wuhan107 on 16/7/14.
//  Copyright © 2016年 wuhan107. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理传值
@protocol MenuClickDelegate <NSObject>

-(void)ClickMenuIndex:(NSInteger)Index Title:(NSString *)title;


-(void)ClickBut:(UIButton *)button;

@end

@interface LYB_ChouTiViewController : UIViewController


//左侧视图
@property(nonatomic,strong)UIViewController *leftViewController;

//中间视图
@property(nonatomic,strong)UIViewController *centerViewController;

//当前菜单状态
@property(nonatomic,assign,readonly)BOOL isShowing;

//菜单中的菜单项
@property(nonatomic,strong)NSMutableArray *menuArray;

//代理的属性
@property(nonatomic,weak)id<MenuClickDelegate>menuClickDelegate;

//初始化方法
+(instancetype)leftViewController:(UIViewController *)leftVC centerViewController:(UIViewController *)centerVC;

//获取抽屉的方法
+(instancetype)getMenuViewController;

//展示左侧视图控制器
-(void)showLeftViewController;

//隐藏左侧视图控制器
-(void)hideLeftViewController;






@end
