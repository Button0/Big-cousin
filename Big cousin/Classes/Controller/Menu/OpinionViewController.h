//
//  opinionViewController.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/18.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UILabel *phoneLable;

@property (weak, nonatomic) IBOutlet UITextField *myTextFiled;

@property (weak, nonatomic) IBOutlet UIButton *whritInBut;

@property(nonatomic,strong)NSMutableArray *messageArray;

@property (weak, nonatomic) IBOutlet UIButton *cameraBtu;

@property (weak, nonatomic) IBOutlet UIButton *voiceBut;














@end
