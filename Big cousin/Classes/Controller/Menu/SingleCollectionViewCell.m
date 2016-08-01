//
//  SingleCollectionViewCell.m
//  Big cousin
//
//  Created by HMS on 16/7/28.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "SingleCollectionViewCell.h"
#import "LibraryRequest.h"
#import "ExpressionLibraryModel.h"

@interface SingleCollectionViewCell ()
@property (nonatomic, strong) NSString *Url;
@property (strong, nonatomic) IBOutlet UIImageView *singleImage;
@end

@implementation SingleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setEId:(NSString *)eId
{
    if (_eId != eId)
    {
        _eId = eId;
        [self requestDataById:_eId];
    }
}

- (void)requestDataById:(NSString *)theId
{
    NSString *urlString = SingleExpression_Url(theId);
    [[LibraryRequest shareLibraryRequest] requestPulicExpressionsWithUrl:urlString success:^(NSArray *arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray <ExpressionLibraryModel*> *array = [ExpressionLibraryModel presentPublicWithArray:arr];
            [_singleImage setImageWithURL:[NSURL URLWithString:[array[0].Url replacingStringToURL]]];
        });
    } failure:^(NSError *error) {
        NSLog(@"error === %@",error);
    }];
}

@end
