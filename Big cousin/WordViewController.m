//
//  WordViewController.m
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "WordViewController.h"
#import "FinshedViewController.h"
static NSString *aText;

@interface WordViewController ()

@property (strong, nonatomic) UIView* changeView;

@property (strong, nonatomic) UIBarButtonItem *scaleItem;

@property (strong, nonatomic) UILabel * myLabel;

@property (nonatomic,assign) CGPoint startPoint;

@end


@implementation WordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/256.0 green:238/256.0 blue:238/256.0 alpha:1];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"👈🏿" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
    
    
    [self addRightnavigationItem];
    self.hidesBottomBarWhenPushed = YES;

}
//点击方法
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
//自定义navigationItem
- (void)addRightnavigationItem
{
    //完成按钮
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"完成" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor colorWithRed:38.0/255.0 green:217.0/255 blue:165.0/255 alpha:1] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(0, 0, 40, 30);
    btn.layer.cornerRadius = 10;

    [btn addTarget:self action:@selector(rightBarItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
 
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    //比例按钮
    _scaleItem = [[UIBarButtonItem alloc]initWithTitle:@"2:1" style:(UIBarButtonItemStylePlain) target:self action:@selector(scaleItemClicked:)];
    self.navigationItem.rightBarButtonItems = @[finishItem,_scaleItem];
    //添加一个textView
    _changeView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 250)];
    _changeView.backgroundColor = [UIColor whiteColor];
    _changeView.clipsToBounds = YES;
    [self.view addSubview:self.changeView];

    
    /** 字 */
    UIButton *wordButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    wordButton.frame = CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 150 , 50, 50);
    [wordButton setTitle:@"字" forState:(UIControlStateNormal)];
    wordButton.layer.cornerRadius = 25;
    [wordButton addTarget:self action:@selector(wordButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    wordButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:wordButton];
    _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 0)];
//    _myLabel.backgroundColor= [UIColor yellowColor];
    //字体颜色
    _myLabel.textColor = [UIColor blackColor];
    //字体大小
    _myLabel.font = [UIFont systemFontOfSize:24.0f];
    //自动换行
    _myLabel.numberOfLines = 0;
    //文本居中
    _myLabel.textAlignment = NSTextAlignmentCenter;
    //添加边框
    _myLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _myLabel.layer.borderWidth = 1.0;
    //label自适应
    [self.myLabel sizeToFit];
    //计算文本的空间：MAXFLOAT为无限大
    CGFloat width = self.changeView.frame.size.width - 20;
    CGRect rect = [_myLabel.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:_myLabel.font} context:nil];
    self.myLabel.frame = CGRectMake(_myLabel.frame.origin.x, _myLabel.frame.origin.y, width, rect.size.height);
    //边框粗细
    _myLabel.layer.borderWidth = 2.0;
    //边框颜色
    _myLabel.layer.borderColor = [[UIColor redColor]CGColor];
    
    [_changeView addSubview:_myLabel];
    //给label添加手势
    [self makeGestureWithLabel];
}
#pragma mark - 手势
/** 旋转手势 */
- (void)makeGestureWithLabel
{
    //打开label的用户交互
    self.myLabel.userInteractionEnabled = YES;
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationClicked:)];
    [self.myLabel addGestureRecognizer:rotation];
    //缩放手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchClicked:)];
    [self.myLabel addGestureRecognizer:pinch];
    //拖动手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panClicked:)];
//    [self.myLabel addGestureRecognizer:pan];
}

//旋转手势
- (void)rotationClicked:(UIRotationGestureRecognizer *)sender
{
    //设置旋转。第一个参数是保持旋转后的状态，第二个参数是操作后的旋转角度
    sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
    //旋转的手指
    sender.rotation = 0;
    
}

//缩放手势
- (void)pinchClicked:(UIPinchGestureRecognizer *)sender
{
    //缩放比例
    sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
    sender.scale = 1;
}

//TODO:拖动问题未完成
//任意位置拖动
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:_myLabel];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint destPoint = [touch locationInView:_myLabel];
    
    float x = destPoint.x - _startPoint.x;
    float y = destPoint.y - _startPoint.y;
    
    CGPoint center = _myLabel.center;
    center.x += x;
    center.y += y;
    
    _myLabel.center = center;
}

//手势拖动
/*
- (void)panClicked:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) 
 {
        //开始拖动
        NSLog(@"开始拖动");
        _startPoint = [sender locationInView:_myLabel];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"正在移动");
        CGPoint destPoint = [sender locationInView:_myLabel];
        
        float x = destPoint.x - _startPoint.x;
        float y = destPoint.y - _startPoint.y;
        
        CGPoint center = _myLabel.center;
        center.x += x;
        center.y += y;
        _myLabel.center = center;
    }
    else if (sender.state == UIGestureRecognizerStateEnded)
    {
        //结束拖动
        NSLog(@"结束拖动");
    }
}
//*/

#pragma mark - button 点击方法
//button点击方法
- (void)rightBarItemClicked:(UIButton *)btn
{
    
    FinshedViewController *finshed = [FinshedViewController new];
    [self.navigationController pushViewController:finshed animated:YES];
    finshed.labelText = self.myLabel.text;
    
}

- (void)scaleItemClicked:(UIButton *)btn
{
    if ([self.scaleItem.title isEqualToString:@"2:1"]) {
        ;
        self.scaleItem.title = @"1:1";
        self.changeView.frame = CGRectMake(0, 100, self.view.frame.size.width, 350);
        
    }else if ([self.scaleItem.title isEqualToString:@"1:1"]){

        self.scaleItem.title = @"3:4";
        self.changeView.frame =CGRectMake(100, 100, self.view.frame.size.width - 200, 300);
        
    }else if ([self.scaleItem.title isEqualToString:@"3:4"]) {
        self.scaleItem.title = @"2:1";
        self.changeView.frame = CGRectMake(0, 150, self.view.frame.size.width, 250);
        
    }
    
}

- (void)wordButtonClicked:(UIButtonType *)btn
{
    [self addAlertingColler];
    
    
}

/** 添加弹框 */
-(void)viewWillAppear:(BOOL)animated
{
    
     [self addAlertingColler];
}

//弹框
- (void)addAlertingColler
{
    //定义一个中间变量
    __block UITextField * tempFeild = [[UITextField alloc] init];
    __weak typeof(self)weakSelf = self;
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"编辑文字" message:@"输入内容" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //赋值
        weakSelf.myLabel.text = tempFeild.text;
        weakSelf.myLabel.numberOfLines = 0;
        [weakSelf.myLabel sizeToFit];
        //计算文本的空间：MAXFLOAT为无限大
            CGFloat width = self.changeView.frame.size.width - 20;
            CGRect rect = [_myLabel.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName:_myLabel.font} context:nil];
        self.myLabel.frame = CGRectMake(100, 10, rect.size.width, rect.size.height);
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
         tempFeild = textField;
         tempFeild.placeholder = @"请输入文字";
        
    }];
    [alertC addAction:action];
    [alertC addAction:cancel];
    
    [self presentViewController:alertC animated:YES completion:^{
        
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
