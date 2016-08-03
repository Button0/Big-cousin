//
//  setViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "setViewController.h"
#import "setTableViewCell.h"
#import "WeiboViewController.h"
#import "StatementViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "AppStoreViewController.h"
#import "ChatViewController.h"
#import "smileViewController.h"


#define mWidth self.view.bounds.size.width
#define mHight self.view.bounds.size.height

@interface setViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIImageView *myImageView;

@property(nonatomic,strong)UILabel *lable;

@property(nonatomic,strong)UILabel *cacheLable;

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
    return 5;

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
        cell.myLable.text = @"关于";
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
                
            case 4:
            {
                cell.myLable.text = @"给你的手机洗洗澡吧";
                cell.myImageView.image = [UIImage imageNamed:@"lajixiang.png"];
                self.cacheLable = [[UILabel alloc]initWithFrame:CGRectMake(330, 12, 65, 20)];
                self.cacheLable.text = [NSString stringWithFormat:@"%.2fM",[self getFilePath]];                self.cacheLable.textColor = [UIColor blueColor];
                [cell addSubview:self.cacheLable];
               
            }
                break;
                
            default:
                break;
        }
    
    }

    return cell;
}


- (void)appearCache{
    self.cacheLable.text = [NSString stringWithFormat:@"%.2fM",[self getFilePath]];
    [self.myTableView reloadData];
}


//获取缓存大小
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
        NSDictionary * cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
        
    }
    
    //单位MB
    
    return cacheFolderSize/1024/1024;
    
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
        smileViewController *smileVC = [[smileViewController alloc]init];
        [self.navigationController pushViewController:smileVC animated:YES];
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
        AppStoreViewController *appVC = [[AppStoreViewController alloc]init];
        [self.navigationController pushViewController:appVC animated:YES];
            
            }
                break;
                
            case 1:
            {
              
                //构造 分享内容
                UIImage *image = [UIImage imageNamed:@"e.jpg"];
                NSArray *imageArray = [NSArray arrayWithObject:image];
                //参数字典
                NSMutableDictionary *params = [NSMutableDictionary new];
                [params SSDKSetupShareParamsByText:@"聊天用Big-cousin真是爽歪歪" images:imageArray url:[NSURL URLWithString:@"http://weibo.com/5982507523/profile?rightmod=1&wvr=6&mod=personnumber&is_all=1"] title:@"来自Big-cousin的分享" type:SSDKContentTypeAuto];
                //展示分享视图
                [ShareSDK showShareActionSheet:nil items:nil shareParams:params onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                    //分享结果
                    switch (state) {
                        case SSDKResponseStateSuccess:
                            NSLog(@"分享成功");
                            break;
                        case SSDKResponseStateFail:
                            NSLog(@"分享失败");
                            break;
                            
                        default:
                            break;
                    }
                }];

                
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
    
            }
                break;

            case 4:
            {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"是否确定清空您的缓存?" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                     NSString* cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    [self clearCache:cacheDir];
                    
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


//清理缓存方法
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [self appearCache];
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
