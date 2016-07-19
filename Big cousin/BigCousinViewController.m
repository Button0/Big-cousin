//
//  BgiCousinViewController.m
//  Big cousin
//
//  Created by HMS on 16/7/13.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "BigCousinViewController.h"
#import "NavigationMenuViewController.h"
#import "BigCousinTableViewCell.h"
#import "BigCousinRequest.h"
#import "BigCousinVideoRequest.h"
#import "BigCousinGIFModel.h"
#import "BigCousinVideoModel.h"
#import "BigCousinVideoTableViewCell.h"

@interface BigCousinViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * bigCousintableView;
@property (nonatomic,strong) UITableView * GIFtableView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray * bigCousinArray;
@property (nonatomic,strong) NSMutableArray * GIFArray;
@end

@implementation BigCousinViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
 
//    NavigationMenuViewController *na = [NavigationMenuViewController new];
//    [self.navigationController pushViewController:na animated:YES];
    
    self.title = @"大表姐";

    
    self.bigCousinArray = [NSMutableArray array];
    self.GIFArray = [NSMutableArray array];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    UIScrollView * scrollView = [[UIScrollView init] initWithCGRect:CGRectMake(0, 0, self.view.frame.size.width * 2, self.view.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.bigCousintableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 100)];
    self.bigCousintableView.backgroundColor = [UIColor whiteColor];

    _bigCousintableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.GIFtableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 110, self.view.frame.size.width, self.view.frame.size.height-100)];
    self.GIFtableView.backgroundColor = [UIColor whiteColor];
    
    self.bigCousintableView.delegate = self;
    self.bigCousintableView.dataSource = self;
    self.GIFtableView.delegate = self;
    self.GIFtableView.dataSource = self;

    //两个tableview 注册cell
    [self.bigCousintableView registerNib:[UINib nibWithNibName:@"BigCousinVideoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:BigCousinVideoTableViewCell_identify];
    [self.GIFtableView registerNib:[UINib nibWithNibName:@"BigCousinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:BigCousinTableViewCell_identify];
        [self.scrollView addSubview:self.bigCousintableView];
        [self.scrollView addSubview:self.GIFtableView];
    [self.view addSubview:self.scrollView];
    [self initSegmentedControl];
    [self requestBigCousinGIFData];
    [self requestBigCousinVideoData];
    
}

-(void)requestBigCousinGIFData{
    
    __weak typeof (self)weakSelf = self;
    BigCousinRequest *request = [[BigCousinRequest alloc]init];
    [request BigCousinRequestWithparameter:nil success:^(NSDictionary *dic) {
        
        NSArray *tempEvents = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in tempEvents) {
            BigCousinGIFModel *model = [[BigCousinGIFModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.GIFArray addObject:model];
        }
            NSLog(@"self.activitise = %@",weakSelf.GIFArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.GIFtableView reloadData];
        });
    } failure:^(NSError *error) {
        
            NSLog(@"activitise.error = %@",error);
    }];

}

-(void)requestBigCousinVideoData{
    __weak typeof (self)weakSelf = self;
    BigCousinVideoRequest *request = [[BigCousinVideoRequest alloc]init];
    [request BigCousinVideoRequestWithparameter:nil success:^(NSDictionary *dic) {
        
        NSArray *tempEvents = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in tempEvents) {
            BigCousinVideoModel *model = [[BigCousinVideoModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.bigCousinArray addObject:model];
        }
        NSLog(@"self.activitise = %@",weakSelf.GIFArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.bigCousintableView reloadData];
        });
    } failure:^(NSError *error) {
        
        NSLog(@"activitise.error = %@",error);
    }];

    
    
}

- (void)initSegmentedControl
{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"动态gif",@"短片",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(CGRectGetMinX(self.view.frame) + 20, 65, self.view.frame.size.width - 40, 40);
    /*
     这个是设置按下按钮时的颜色
     */
    segmentedControl.tintColor = [UIColor colorWithRed:72/256.0 green:209/256.0 blue:204/256.0 alpha:1];
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引

    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.bigCousintableView) {
        return self.bigCousinArray.count;
    }
    else {
        return self.GIFArray.count;
    }
//    return self.GIFArray.count;
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    if (Seg.selectedSegmentIndex == 1) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }else
    {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.GIFtableView){
        BigCousinTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BigCousinTableViewCell_identify];
        BigCousinGIFModel *model = self.GIFArray[indexPath.row];
        cell.model = model;
        return cell;
    }else{
        BigCousinVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:BigCousinVideoTableViewCell_identify];
        BigCousinVideoModel *model = self.bigCousinArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.GIFtableView){
        return 200;
    }else{
        return 230;
    }
    
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 50;
//    
//}


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
