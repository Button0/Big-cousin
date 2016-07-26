//
//  XFTalkViewController.m
//  XFBaiSiBuDeJie
//
//  Created by 谢飞 on 16/2/21.
//  Copyright © 2016年 谢飞. All rights reserved.
//

#import "XFTalkViewController.h"
#import "XFTopicCell.h"
#import "XFTopicModel.h"
#import "XFModuleDataTool.h"
#import "MJRefresh.h"
#import "XFCommentViewController.h"
#import "XFLatestViewController.h"


static NSString *const CellID = @"topic";

@interface XFTalkViewController ()<UITableViewDelegate>
@property (nonatomic,strong) XFModuleDataTool *tool;
@property (nonatomic,strong) NSMutableArray *topicsFrame;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要的参数 */
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation XFTalkViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settableView];
    
    [self setRefresh];
    
    
}

//设置刷新控件
-(void)setRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
                            
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];

}

#pragma mark - a参数
- (NSString *)parameterA
{
    return [self.parentViewController isKindOfClass:[XFLatestViewController class]] ? @"newlist" : @"list";
}

//获取最新数据
-(void)getNewData {
    self.page = 0;//清空
    [self.topicsFrame removeAllObjects];
     @weakify(self)
    [self.tool getDataWithArrayType:TopicTypeTalk parameterA:self.parameterA block:^(id json, NSString *maxtime) {
        @strongify(self)
        for (XFTopicModel *topic in json) {
            XFTopicFrame *topicFrame = [[XFTopicFrame alloc]init];
            topicFrame.topic = topic;
            [self.topicsFrame addObject:topicFrame];
        }
            self.maxtime = maxtime;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
    }];
}

//获取更多数据
-(void)getMoreData {
    //计算页码
    NSInteger page = self.page+1;
    @weakify(self)
    [self.tool getDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypeTalk parameterA:self.parameterA block:^(id json,NSString *maxtime) {
        @strongify(self)
        NSMutableArray *newFrames = [NSMutableArray array];
        for (XFTopicModel *topic in json) {
            XFTopicFrame *topicFrame = [[XFTopicFrame alloc]init];
            topicFrame.topic = topic;
            [newFrames addObject:topicFrame];
        }
    
        [self.topicsFrame addObjectsFromArray:newFrames];
        [self.tableView reloadData];
        self.page = page;
        self.maxtime = maxtime;
        [self.tableView.mj_footer endRefreshing];
    }];
}

//设置tableView
-(void)settableView{
    self.view.backgroundColor = BackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"XFTopicCell" bundle:nil] forCellReuseIdentifier:CellID];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFTopicFrame *topicFrame = self.topicsFrame[indexPath.row];
    XFCommentViewController * commentVC = [[XFCommentViewController alloc]init];
    commentVC.topicFrame = topicFrame;

    [self.navigationController pushViewController:commentVC animated:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.topicFrame = self.topicsFrame[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出frame模型
    XFTopicFrame *topicFrame = self.topicsFrame[indexPath.row];
    return topicFrame.cellHeight;
}

#pragma mark - getter and setter

- (XFModuleDataTool *)tool{
    if (_tool == nil) {
        _tool = [[XFModuleDataTool alloc]init];
    }
    return _tool;
}

- (NSMutableArray *)topicsFrame{
    if (_topicsFrame == nil) {
        _topicsFrame = [NSMutableArray array];
        
    }
    return _topicsFrame;
}

@end
