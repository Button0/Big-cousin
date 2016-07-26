//
//  PlayerView.m
//  LessonVideo
//
//  Created by CLT on 16/7/8.
//  Copyright © 2016年 yaxin.guo. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

- (id)initWithUrl:(NSString *)url frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor blackColor];
        _playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        [self.layer addSublayer:_playerLayer];
        _playerLayer.frame = self.bounds;
        [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self addInteractiveView];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        //当状态变为readytoPlay的时候，播放视频
//        NSLog(@"change == %@", change);
        if (_player.status == AVPlayerStatusReadyToPlay) {
            [_player play];
        }
    }
}

- (void)addInteractiveView
{
    self.interactiveBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.interactiveBackgroundView.backgroundColor = [UIColor clearColor];
//    self.interactiveBackgroundView.backgroundColor = [UIColor redColor];
    self.pauseOrPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pauseOrPlayBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.pauseOrPlayBtn addTarget:self action:@selector(pauseOrPlayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.pauseOrPlayBtn.frame = CGRectMake(40, 40, 40, 30);
    [self.interactiveBackgroundView addSubview:self.pauseOrPlayBtn];
    [self addSubview:self.interactiveBackgroundView];
    
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 140, self.bounds.size.width - 40, 20)];
    self.progressSlider.maximumValue = 1.0f;
    [self.progressSlider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.progressSlider setMinimumTrackTintColor:[UIColor greenColor]];
    [self.progressSlider setThumbTintColor:[UIColor whiteColor]];
    [self.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.interactiveBackgroundView addSubview:self.progressSlider];
}

- (void)progressSliderValueChanged:(UISlider *)progressSlider
{
    Float64 time = CMTimeGetSeconds(self.playerItem.duration);
    [self.player seekToTime:CMTimeMakeWithSeconds(progressSlider.value*time, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        NSLog(@"Complete. Current Time: %f", CMTimeGetSeconds(self.player.currentTime));
    }];
    if (progressSlider.value == 1) {
        [self.player seekToTime:kCMTimeZero];
        [self.player pause];
        [self.pauseOrPlayBtn setTitle:@"播放" forState:UIControlStateNormal];
        progressSlider.value = 0;
    }
    else {
//        [self.player pause];
    }
//    [self.player seekToTime:CMTimeMakeWithSeconds(progressSlider.value*time, 1)];
}

- (void)pauseOrPlayBtnClicked:(UIButton *)btn
{
    if ([[self.pauseOrPlayBtn titleForState:UIControlStateNormal] isEqualToString:@"暂停"]) {
        [self.pauseOrPlayBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_player pause];
    }
    else {
        [self.pauseOrPlayBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [_player play];
    }
}

-(void)dealloc
{
    [_player removeObserver:self forKeyPath:@"status" context:nil];
}

@end
