//
//  VTCycleScrollView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "VTCycleScrollView.h"

@interface VTCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic) NSInteger currentIndex;

@property (nonatomic, strong) UIImageView *previousImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *nextImageView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation VTCycleScrollView

#pragma mark - life cycle
//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
        [self images];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setImageData:(NSArray *)imageData
{
    if (_imageData != imageData)
    {
        _imageData = [imageData copy];
        // update UI
        _pageControl.numberOfPages = [_imageData count];
        //获得图片后，更新scrollView中的图片
        _currentIndex = 1;
        [self scrollViewDidEndDecelerating:_scrollView];
    }
}

- (void)setupUI
{
    // scroll view
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled = YES;
    scroll.bounces = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(self.bounds.size.width *3, self.bounds.size.height);
    _scrollView = scroll;
    
    // image view
    _previousImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width *1, 0, self.bounds.size.width, self.bounds.size.height)];
    _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width *2, 0, self.bounds.size.width, self.bounds.size.height)];
    
    [_scrollView addSubview:_previousImageView];
    [_scrollView addSubview:_currentImageView];
    [_scrollView addSubview:_nextImageView];
    [self addSubview:_scrollView];
    
    // page control
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height -20.f, self.bounds.size.width, 20.f)];
    [page setCurrentPage:0];
    [page setNumberOfPages:1];
    [page addTarget:self action:@selector(pageAction:) forControlEvents:(UIControlEventValueChanged)];
    _pageControl = page;
    [self addSubview:_pageControl];
    
    //timer
    _timer = [NSTimer timerWithTimeInterval:1.3f target:self selector:@selector(nextPage) userInfo:nil repeats:YES] ;
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

#pragma mark - ScrollView Delegate
- (NSUInteger)getCorrectIndexWith:(NSInteger)index
{
    NSUInteger ret = index;
    if (index < 0)
    {
        ret = _pageControl.numberOfPages - 1;
    }
    else if (index > _pageControl.numberOfPages - 1)
    {
        ret = 0;
    }
    return ret;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0)
    {
        //滚动到 _previousImageView 的位置
        _currentIndex = [self getCorrectIndexWith:_currentIndex - 1];
    }
    else if (scrollView.contentOffset.x == self.bounds.size.width *2)
    {
        //滚动到 _nextImageView 的位置
        _currentIndex = [self getCorrectIndexWith:_currentIndex + 1];
    }
    
    //设置偏移为 _currentImageView 的位置
    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    //设置页码
    _pageControl.currentPage = _currentIndex;
    NSLog(@"currentPage: %ld",(long)_currentIndex);
    
    //设置图片
    _currentImageView.image = [UIImage imageWithContentsOfFile:[_imageData objectAtIndex:[self getCorrectIndexWith:_currentIndex]]];
    _previousImageView.image = [UIImage imageWithContentsOfFile:[_imageData objectAtIndex:[self getCorrectIndexWith:_currentIndex - 1]]];
    _nextImageView.image = [UIImage imageWithContentsOfFile:[_imageData objectAtIndex:[self getCorrectIndexWith:_currentIndex + 1]]];
}

- (void)pageAction:(UIPageControl *)sender
{
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width*(sender.currentPage -1), 0) animated:NO];
}

#pragma mark - timer
int pageNumber = -1;
- (void)nextPage
{
    pageNumber++;
    if (pageNumber == 3)
    {
        pageNumber = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width *pageNumber, 0)];
    [self.pageControl setCurrentPage:pageNumber];
}

- (void)images
{
    self.imageData = @[[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 0] ofType:@"jpg"],
                       [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 1] ofType:@"jpg"],
                       [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 2] ofType:@"jpg"],
                       [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 3] ofType:@"jpg"],
                       ];
}

@end
