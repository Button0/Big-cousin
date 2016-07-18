//
//  CollectionViewController.h
//  
//
//  Created by Mushroom on 16/7/15.
//
//

#import "BaseViewController.h"

@interface CollectionViewController : BaseViewController
/** 公用 */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 最新 */
@property (nonatomic, strong) UIView *newestView;
/** 最热 */
@property (nonatomic, strong) UIView *hottestView;

@end
