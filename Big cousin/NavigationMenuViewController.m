//
//  NavigationMenuViewController.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "NavigationMenuViewController.h"
#import "NavigationMenuView.h"

@interface NavigationMenuViewController ()<NavigationMenuDelegate>

@end

@implementation NavigationMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if (self.navigationItem)
    {
        CGRect frame = CGRectMake(0.0, 0.0, 100.0, self.navigationController.navigationBar.bounds.size.height);
        NavigationMenuView *menu = [[NavigationMenuView alloc] initWithFrame:frame title:@"Menu"];
        [menu displayMenuInView:self.navigationController.view];
        menu.items = @[@"最新表情", @"热门表情", @"原创表情", @"聊天场景", @"萌娃", @"金馆长系列", @"明星大咖",@"实力派网红",@"综艺影视",@"可爱形象",@"真人GIF"];
        menu.delegate = self;
        self.navigationItem.titleView = menu;
    }
}

- (void)didSelectItemAtIndex:(NSUInteger)index
{
    NSLog(@"did selected item at index %lu", (unsigned long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
