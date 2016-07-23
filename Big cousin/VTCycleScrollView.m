//
//  VTCycleScrollView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "VTCycleScrollView.h"
#import "LibraryRequest.h"
#import "SingleExpressionViewController.h"

@interface VTCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIImageView *previousImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIImageView *nextImageView;

@end

#define KSWidth self.bounds.size.width
#define KSHeight self.bounds.size.height

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
    scroll.contentSize = CGSizeMake(KSWidth *3, KSHeight);
    _scrollView = scroll;
    
    // image view
    _previousImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width *1, 0, self.bounds.size.width, self.bounds.size.height)];
    _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width *2, 0, self.bounds.size.width, self.bounds.size.height)];
    
    [_scrollView addSubview:_previousImageView];
    [_scrollView addSubview:_currentImageView];
    [_scrollView addSubview:_nextImageView];
    [self addSubview:_scrollView];
    [self addTapGestureRecognizerWithImages];
    
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

//加手势
- (void)addTapGestureRecognizerWithImages
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cycleImagePush:)];
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cycleImagePush:)];
    UITapGestureRecognizer *recognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cycleImagePush:)];
    [_previousImageView addGestureRecognizer:recognizer];
    [_currentImageView addGestureRecognizer:recognizer2];
    [_nextImageView addGestureRecognizer:recognizer3];
    _previousImageView.userInteractionEnabled = YES;
    _currentImageView.userInteractionEnabled = YES;
    _nextImageView.userInteractionEnabled = YES;

}

-(void)cycleImagePush:(UITapGestureRecognizer *)sender
{
//    [self requestHomeTitles];
//    SingleExpressionViewController *singleVC = [[SingleExpressionViewController alloc]init];
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

#pragma mark - 数据
/*
- (void)requestCycleImages
{
    __weak typeof(self) weakSelf = self;
    LibraryRequest *request = [[LibraryRequest alloc] init];
    [request requestCycleScrollExpressionSuccess:^(NSDictionary *dic) {
       
        NSDictionary *temp = [dic objectForKey:@"data"];
        for (NSDictionary *dict in temp)
        {
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestHomeTitles
{
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager GET:@"http://api.jiefu.tv/app2/api/bq/article/detail.html?id=4653"
 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray*  _Nullable responseObject) {
        
        //        NSLog(@"----%@",responseObject);
        NSMutableArray *array=responseObject.lastObject;
        for (NSMutableDictionary *dict in array)
        {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===%@",error);
    }];
}
//*/

- (void)images
{
    self.imageData = @[[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 0] ofType:@"jpg"],
                       [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 1] ofType:@"jpg"],
                       [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 2] ofType:@"jpg"],
                       [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"scrollview_%u", 3] ofType:@"jpg"],
                       ];
}

@end
