//
//  ImageCellOfFriends.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImageCellOfFriends_identify @"ImageCellOfFriends_identify"
@interface ImageCellOfFriends : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *sendImageOfFriends;

@property(nonatomic)CGPoint pointCenter;

@end
