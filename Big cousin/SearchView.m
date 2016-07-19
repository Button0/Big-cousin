//
//  SearchView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addView];
    }
    return self;
}

- (void)addView
{    
    self.backgroundColor = [UIColor yellowColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.frame style:(UITableViewStyleGrouped)];
    
    //初始化搜索结果与控制器 位置为nil
    UISearchController *searchC = [[UISearchController alloc]initWithSearchResultsController:nil];
    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    searchC.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    searchC.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    searchC.hidesNavigationBarDuringPresentation = NO;
    //设置搜索栏的位置
    searchC.searchBar.frame = CGRectMake(searchC.searchBar.frame.origin.x, searchC.searchBar.frame.origin.y, searchC.searchBar.frame.size.width, 44.0);
    self.searchController = searchC;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    [self addSubview:self.tableView];
}

@end
