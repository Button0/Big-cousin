//
//  XFVideoViewController.m
//  XFBaiSiBuDeJie
//
//  Created by shishuai on 16/7/23.
//  Copyright © 2016年 shishuai. All rights reserved.
//

#import "XFVideoViewController.h"
#import "XFTopicCell.h"
#import "XFModuleDataTool.h"
#import "MJRefresh.h"
#import "XFCommentViewController.h"
#import "XFLatestViewController.h"
#import "XFContentVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import "KRVideoPlayerController.h"



static NSString *const CellID = @"topic";

@interface XFVideoViewController()
@property (nonatomic,strong) XFModuleDataTool *tool;
@property (nonatomic,strong) NSMutableArray *topicFrames;
@property (nonatomic, strong) KRVideoPlayerController *videoController;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时需要的参数 */
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation XFVideoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settableView];
    
    [self setRefresh];
    
    [self setupPlayBtnNotification];
    
    
    
    
}

//添加播放按钮通知
-(void)setupPlayBtnNotification {

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"playVideo" object:nil] subscribeNext:^(NSNotification *noti) {
        XFTopicModel *topic = noti.userInfo[@"Video"];
        [self playVideoWithURL:[NSURL URLWithString:topic.videouri]];
    }];

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
- (NSString *)parameterA {
    return [self.parentViewController isKindOfClass:[XFLatestViewController class]] ? @"newlist" : @"list";
}

//获取最新数据
-(void)getNewData {
    self.page = 0;//清空
    [self.topicFrames removeAllObjects];
    @weakify(self)
    [self.tool getDataWithArrayType:TopicTypeVideo parameterA:self.parameterA block:^(id json, NSString *maxtime) {
        @strongify(self)
        for (XFTopicModel *topic in json) {
            XFTopicFrame *topicFrame = [[XFTopicFrame alloc]init];
            topicFrame.topic = topic;
            [self.topicFrames addObject:topicFrame];
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
    [self.tool getDataWithMaxtime:self.maxtime page:@(page) TopicType:TopicTypeVideo parameterA:self.parameterA block:^(id json,NSString *maxtime) {
        @strongify(self)
        NSMutableArray *newArray = [NSMutableArray array];
        for (XFTopicModel *topic in json) {
            XFTopicFrame *topicFrame = [[XFTopicFrame alloc]init];
            topicFrame.topic = topic;
            [newArray addObject:topicFrame];
        }
        [self.topicFrames addObjectsFromArray:newArray];
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

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    XFCommentViewController * commentVC = [[XFCommentViewController alloc]init];
    commentVC.topicFrame = topicFrame;
    
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.topicFrame = self.topicFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //计算文字高度
    XFTopicFrame *topicFrame = self.topicFrames[indexPath.row];
    return topicFrame.cellHeight;
}

#pragma mark - getter and setter

- (XFModuleDataTool *)tool{
    if (_tool == nil) {
        _tool = [[XFModuleDataTool alloc]init];
    }
    return _tool;
}

- (NSMutableArray *)topicFrames{
    if (_topicFrames == nil) {
        _topicFrames = [NSMutableArray array];
        
    }
    return _topicFrames;
}

- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

@end
