//
//  MoreExpressionViewController.m
//  Big cousin
//
//  Created by Mushroom on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "MoreExpressionViewController.h"
#import "NavigationMenuView.h"
#import "ExpressionLibraryModel.h"
#import "HomeTitleModel.h"

@interface MoreExpressionViewController ()<NavigationMenuDelegate>
@property (nonatomic, strong) NSMutableArray *moreExpressions;
@end

@implementation MoreExpressionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = _titleModel.eName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self titles];
    [self requestAllExpressions];
}

//title引导栏
- (void)titles
{
    if (self.navigationItem)
    {
        CGRect frame = CGRectMake(0.0, 0.0, 100.0, self.navigationController.navigationBar.bounds.size.height);
        NavigationMenuView *menu = [[NavigationMenuView alloc] initWithFrame:frame title:@"Menu"];
        [menu displayMenuInView:self.navigationController.view];
        menu.items = super.expressionModel.eName;
//        menu.items = @[@"原创表情",@"聊天场景",@"萌娃",@"金馆长系列",@"明星大咖",@"实力派网红",@"综艺影视",@"可爱形象",@"真人GIF"];
        menu.delegate = self;
        self.navigationItem.titleView = menu;
    }
}

- (void)didSelectItemAtIndex:(NSUInteger)index
{
    NSLog(@"did selected item at index %lu", (unsigned long)index);
}

#pragma mark - 数据
- (void)requestAllExpressions
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager GET:_url_ID parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
        NSLog(@"----%@",responseObject);
        NSMutableArray*array=responseObject.lastObject;
        for (NSMutableDictionary*dict in array)
        {
            ExpressionLibraryModel *model = [ExpressionLibraryModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.moreExpressions addObject:model];
        }
        [self.pulicCollectionView  reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];
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
