//
//  customView.m
//  Big cousin
//
//  Created by wuhan107 on 16/7/19.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "customView.h"
#import "CustomCollectionViewCell.h"
@implementation customView

//初始化collectView
-(UICollectionView *)collectView{
    
    if (_collectView == nil) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing =30;
        flowLayout.minimumInteritemSpacing=20;
        flowLayout.itemSize=CGSizeMake(60, 70);
        flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 50, 20, 50);
        
        _collectView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectView.dataSource=self;
        _collectView.delegate=self;
        _collectView.pagingEnabled=YES;
        _collectView.backgroundColor=[UIColor whiteColor];
        _index = 0;
        
        [_collectView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CustomCollectionViewCell_identify];
    }
    
    return _collectView;
}

//初始化view
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.collectView];
    }
    
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 7;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CustomCollectionViewCell_identify forIndexPath:indexPath];
    
    switch (indexPath.row) {
            
        case 0:{
            cell.imageV.image =[UIImage imageNamed:@"tupian"]; cell.Label.text=@"图片";
            break;
        }
            
//        default:{
//            cell.imageV.image =[UIImage imageNamed:@"tupian"]; cell.Label.text=@"图片";
//            break;
//        }
    }
    return cell;
}

//cell点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.index = indexPath.row;
    
}















@end
