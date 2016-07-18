//
//  SegmentView.h
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentView : UIView
/** 首页 */
@property (nonatomic, strong) UIView *homeView;
/** 最新 */
@property (nonatomic, strong) UIView *newestView;
/** 最热 */
@property (nonatomic, strong) UIView *hottestView;

@end
