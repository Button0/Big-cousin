//
//  SegmentView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SegmentView.h"
#import "LibraryCollectionViewCell.h"

#define SWidth self.bounds.size.width
#define SHeight self.bounds.size.height

@interface SegmentView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SegmentView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    //分段控件
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"首页",@"最新",@"最热"]];
    segmentedControl.frame = CGRectMake(0, 0, SWidth, 20);
    [segmentedControl addTarget:self action:@selector(segmentedClicked:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:segmentedControl];
    self.segment = segmentedControl;

    //ScrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, SWidth, SHeight)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SWidth *3.0f, SHeight);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];

    //容器
    self.homeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWidth, SHeight)];
    [self.scrollView addSubview:_homeView];
    
    self.newestView = [[UIView alloc] initWithFrame:CGRectMake(SWidth, 0, SWidth, SHeight)];
    [self.scrollView addSubview:_newestView];
    _newestView.backgroundColor = [UIColor cyanColor];
    
    self.hottestView = [[UIView alloc] initWithFrame:CGRectMake(SWidth *2.0f, 0, SWidth, SHeight)];
    [self.scrollView addSubview:_hottestView];
    
    [self bringSubviewToFront:self.segment];
    [self bringSubviewToFront:self.homeView];
}



- (void)segmentedClicked:(UISegmentedControl *)sender
{
    self.scrollView.contentOffset = CGPointMake(SWidth * sender.selectedSegmentIndex, 0.0f);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.segment.selectedSegmentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
}


@end
