//
//  PlayerView.h
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import <UIKit/UIKit.h>
//引入视频播放器框架
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView

//播放单元
@property (nonatomic, strong) AVPlayerItem *playerItem;
//播放视频的layer（注意类型）
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//播放器
@property (nonatomic, strong) AVPlayer *player;

- (id)initWithUrl:(NSString *)url frame:(CGRect)frame;

@property (nonatomic, strong) UIView *interactiveBackgroundView;
@property (nonatomic, strong) UIButton *pauseOrPlayBtn;
@property (nonatomic, strong) UISlider *progressSlider;


@end
