//
//  VoiceCellOfMine.h
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VoiceCellOfMine_identify @"VoiceCellOfMine_identify"
@class VoiceCellOfMine;

@protocol VoiceCellOfMineDelegate <NSObject>

- (void)playVoiceOnMineCell:(VoiceCellOfMine*)MineCell;

@end

@interface VoiceCellOfMine : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *guestureLabel;

@property(nonatomic,strong)NSString *path;

@property (assign , nonatomic) id<VoiceCellOfMineDelegate> dellegate;

@end
