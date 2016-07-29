//
//  CompileViewController.m
//  Big cousin
//
//  Created by HMS3g on 16/7/22.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "CompileViewController.h"

@interface CompileViewController ()

@property (strong, nonatomic) UIView *comipleView;

@property (strong, nonatomic) UILabel *myLabel;

@property (strong, nonatomic) UIImageView *imageV;

@end

@implementation CompileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = KColorGrayedLavender;
    
//    self.view.backgroundColor = KColorFeiGray;
    //添加一个view
    _comipleView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, self.view.frame.size.width - 200, 300)];
    _comipleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_comipleView];
    //约束
    [_comipleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(80);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-80);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-300);
    }];
    

    
    /** 字 */
    UIButton *wordButton = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
    wordButton.frame = CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 150 , 50, 50);
    [wordButton setTitle:@"字" forState:(UIControlStateNormal)];
    wordButton.layer.cornerRadius = 25;
    [wordButton addTarget:self action:@selector(wordButtonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    wordButton.backgroundColor = [UIColor redColor];
    wordButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:wordButton];
    [wordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-50);
        make.bottom.equalTo(self.view).with.offset(-50);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];

    _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 50)];
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
//    CGFloat width = self.comipleView.frame.size.width - 20;
//    CGRect rect = [_myLabel.text boundingRectWithSize:CGSizeMake(width, self.comipleView.frame.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:_myLabel.font} context:nil];
//    self.myLabel.frame = CGRectMake(10, 10, 200, self.myLabel.frame.size.height);
    //边框粗细
    _myLabel.layer.borderWidth = 2.0;
    //边框颜色
    _myLabel.layer.borderColor = [[UIColor redColor]CGColor];
    
    [_comipleView addSubview:_myLabel];
    //约束
    [_myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageV.mas_top).with.offset(10);
        make.left.mas_equalTo(_imageV.mas_left).with.offset(40);
        make.right.mas_equalTo(_imageV.mas_right).with.offset(-40);
Drawing/CompileViewController.m
    }];
    
    _imageV = [[UIImageView alloc]init];
    _imageV.backgroundColor = [UIColor orangeColor];
    [_comipleView addSubview:_imageV];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(_comipleView.mas_centerX);
        make.bottom.mas_equalTo(_comipleView.mas_bottom).with.offset(-10);
    }];
//    _imageV.image = [UIImage imageNamed:self.imageString];
    [_imageV setImageWithURL:[NSURL URLWithString:self.imageString ]];
    
    
    [self addRightItem];
}


- (void)addRightItem
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(10, 10, 40, 30);
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    button.backgroundColor = kColorGreenSea;
    button.layer.cornerRadius = 10;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)buttonClicked:(UIButton *)sender
{
    FinshedViewController *finshVC = [[FinshedViewController alloc]init];
   
//    NSData *data = UIImageJPEGRepresentation(self.imageV.image, 1.0f);
    
//    NSString *string = [data base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    finshVC.imageVString = _imageString;

    [self.navigationController pushViewController:finshVC animated:YES];
    
    
}

- (void)wordButtonClicked:(UIButton *)sender
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
//        CGFloat width = self.comipleView.frame.size.width - 20;
//        CGRect rect = [_myLabel.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:_myLabel.font} context:nil];
        self.myLabel.frame = CGRectMake(10, 10, 200, self.myLabel.frame.size.height);
        //添加水印
        UIImage *watermarkImage = [UIImage imageNamed:@""];
        UIImage *imageWithImageWatermark = [UIImage imageWithUIImage:self.imageV.image watermarkOfImage:watermarkImage position:ATWatermarkPositonTopRight];
        //    self.imageView.image = imageWithImageWatermark;
        
        NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
        attrDict[NSForegroundColorAttributeName] = [UIColor redColor];
        attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:22.f];
        
        NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.myLabel.text attributes:attrDict];
        UIImage *imageWithImageAndTextWatermark = [UIImage imageWithUIImage:imageWithImageWatermark watermarkOfText:attrString position:(ATWatermarkPositonBottom)];
        self.imageV.image = imageWithImageAndTextWatermark;

Drawing/CompileViewController.m
        
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
