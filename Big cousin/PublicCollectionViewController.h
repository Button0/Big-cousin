//
//  PublicCollectionViewController.h
//  
//
//  Created by Mushroom on 16/7/15.
//
//

#import "BaseViewController.h"

@class ExpressionLibraryModel;
@interface PublicCollectionViewController : BaseViewController
/** 公用 */
@property (nonatomic, strong) UICollectionView *pulicCollectionView;
/** 最新 */
@property (nonatomic, strong) UIView *newestView;
/** 最热 */
@property (nonatomic, strong) UIView *hottestView;
/** url */
@property (nonatomic, strong) NSString *url;
//@property (nonatomic, strong) NSString *url_ID;
@property (nonatomic, strong) ExpressionLibraryModel *expressionModel;

@end
