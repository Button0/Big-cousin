//
//  setViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "setViewController.h"
#import "setTableViewCell.h"
#import "OpinionViewController.h"
#import "WeiboViewController.h"
#import "StatementViewController.h"

#define mWidth self.view.bounds.size.width
#define mHight self.view.bounds.size.height

@interface setViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIImageView *myImageView;

@property(nonatomic,strong)UILabel *lable;

@end

@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"设置";
    
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    //注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:@"setTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, mHight - 320, mWidth - 140, 140)];
    self.myImageView.backgroundColor = [UIColor redColor];
    self.myImageView.image = [UIImage imageNamed:@"meng.jpg"];
    [self.myTableView addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.myTableView.mas_centerX);
        make.top.mas_equalTo(self.myTableView.mas_top).offset(400);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(55);
        
    }];
    
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(90, mHight - 350 + 140, mWidth - 200, 40)];
    self.lable.text = @"v 1.0";
    self.lable.textAlignment = NSTextAlignmentCenter;
    [self.myTableView addSubview:self.lable];
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myImageView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.myImageView.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 6;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }

    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    setTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        cell.myLable.text = @"意见反馈";
        cell.myImageView.image = [UIImage imageNamed:@"yijian.png"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                cell.myLable.text = @"亲支持下呗";
                cell.myImageView.image = [UIImage imageNamed:@"haoping.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
                break;
                
            case 1:
            {
                cell.myLable.text = @"好东西要分享哦";
                cell.myImageView.image = [UIImage imageNamed:@"fengxiang.png"];
           cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
                
            case 2:
            {
                cell.myLable.text = @"我们的声明";
                cell.myImageView.image = [UIImage imageNamed:@"banquan.png"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
                
            case 3:
            {
                cell.myLable.text = @"我们的微博";
                cell.myImageView.image = [UIImage imageNamed:@"weibo.png"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
                
            case 4:
            {
                cell.myLable.text = @"我们的微信~(主人可是美女哦)";
                cell.myImageView.image = [UIImage imageNamed:@"weixin.png"];
                
                UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
                [copyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                copyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                copyBtn.backgroundColor = [UIColor colorWithRed:250.0f/255.0 green:235.0f/255.0 blue:215.0f/255.0 alpha:0.95];
                [copyBtn addTarget:self action:@selector(copyBut:) forControlEvents:UIControlEventTouchUpInside];
                copyBtn.frame = CGRectMake(355, 12, 40, 20);
                [cell addSubview:copyBtn];

            }
                break;
                
            case 5:
            {
                cell.myLable.text = @"给你的手机洗洗澡吧";
                cell.myImageView.image = [UIImage imageNamed:@"lajixiang.png"];
                UILabel *cacheLable = [[UILabel alloc]initWithFrame:CGRectMake(345, 12, 50, 20)];
                cacheLable.text = @"10.0M";
                cacheLable.textColor = [UIColor blueColor];
                [cell addSubview:cacheLable];
 
            }
                break;
                
            default:
                break;
        }
    
    }

    return cell;
}

-(void)copyBut:(UIButton *)sender
{

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"关注公众号" message:@"已复制公众号，快去添加吧！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:actionCancle];
    [alertVC addAction:actionOK];
    [self presentViewController:alertVC animated:YES completion:^{
        
        
    }];
    


}

//点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OpinionViewController *opinionVC = [[OpinionViewController alloc]init];
        [self.navigationController pushViewController:opinionVC animated:YES];
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"]];
            }
                break;
                
            case 1:
            {
                
            }
                break;

            case 2:
            {
                StatementViewController *statementVC = [[StatementViewController alloc]init];
                [self.navigationController pushViewController:statementVC animated:YES];
            }
                break;

            case 3:
            {
                WeiboViewController *weiboVC = [[WeiboViewController alloc]init];
                [self.navigationController pushViewController:weiboVC animated:YES];
                
                
            }
                break;

            case 4:
            {
    
            }
                break;

            case 5:
            {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"您手机有10.0M垃圾，是否清空?" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertVC addAction:actionCancle];
                [alertVC addAction:actionOK];
                [self presentViewController:alertVC animated:YES completion:^{
                    
                    
                }];
  
                
            }
                break;

                
            default:
                break;
        }
    
    }

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
