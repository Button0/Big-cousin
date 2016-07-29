//
//  opinionViewController.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "OpinionViewController.h"
#import "ChatTableViewCell.h"
#import "ChatImageTableViewCell.h"

@interface OpinionViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户反馈";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(turn:)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.messageArray = [NSMutableArray array];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.myTableView.estimatedRowHeight = 240;
//    [self.myTableView registerNib:[UINib nibWithNibName:@"ChatImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"imageCell"];
    
//    [EMClient sharedClient].options.isAutoLogin = YES;

}

-(void)turn:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)whritInBtu:(id)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"联系方式" message:@"给个电话呗，我们会让你满意的" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入您的手机号码~~~";
        
    }];

    UIAlertAction *actinOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.phoneLable.text = alertVC.textFields.firstObject.text;
        [self.whritInBut setTitle:@"更改" forState:UIControlStateNormal];
    
    }];
    
    UIAlertAction *actinCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    
    [alertVC addAction:actinCancle];
    [alertVC addAction:actinOK];
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.messageArray == nil) {
        return 1000;
    }else
    {
        return self.messageArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.chatLable.text = self.messageArray[indexPath.row];
    cell.chatLable.numberOfLines = 0;
    
    return cell;
}




- (IBAction)voiceBtu:(id)sender {
    
    

}

- (IBAction)photoBtn:(id)sender {
   
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camelimage = [UIAlertAction actionWithTitle:@"去拍一张" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *photoImage = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagpick = [[UIImagePickerController alloc]init];
        imagpick.delegate = self;
        imagpick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置获取出来的照片是否可以编辑
        imagpick.allowsEditing = NO;
        [self presentViewController:imagpick animated:YES completion:^{
            
        }];
        
    }];

    
    UIAlertAction *actinCancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alertVC addAction:camelimage];
    [alertVC addAction:photoImage];
    [alertVC addAction:actinCancle];
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];

    
    
}


//pickerView的代理方法



- (IBAction)sendBtu:(id)sender {
    
//    NSString *text1 = self.myTextFiled.text;
//    [self.messageArray addObject:text1];
//    NSLog(@"+++++++%@",text1);
//    NSLog(@"=======%@",self.messageArray);
//    self.myTextFiled.text = nil;
//    [self.myTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


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
