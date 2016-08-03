//
//  TextCellOfMine.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TextCellOfMine_identify @"TextCellOfMine_identify"
@interface TextCellOfMine : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

-(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;





@end
