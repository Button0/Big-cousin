//
//  MenuCell.h
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion;
@end
