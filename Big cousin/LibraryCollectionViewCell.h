//
//  LibraryCollectionViewCell.h
//  Big cousin
//
//  Created by Mushroom on 16/7/15.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LibraryCollectionViewCell_Identity @"LibraryCollectionViewCell"
@interface LibraryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

- (void)addTarget:(id)target action:(SEL)action;

@end
