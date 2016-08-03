//
//  goodsViewController.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TextCellOfFriends_Identify @"TextCellOfFriends_Identify"
@interface TextCellOfFriends : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *friendsMessageLabel;

-(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
@end
