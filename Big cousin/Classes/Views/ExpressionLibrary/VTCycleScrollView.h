//
//  VTCycleScrollView.h
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickImageDelegate <NSObject>
-(void)cycleImagePush:(UITapGestureRecognizer *)sender;
@end

@interface VTCycleScrollView : UIView
/** 时间管理器 */
//@property (nonatomic) CGFloat timePerPicture;
/** 图片数据 */
@property (nonatomic, retain) NSArray *imageData;
@property (nonatomic, weak) id<ClickImageDelegate> imageDelegate;

@end
