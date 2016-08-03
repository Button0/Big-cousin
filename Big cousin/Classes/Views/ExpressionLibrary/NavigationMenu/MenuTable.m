//
//  MenuTable.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "MenuTable.h"
#import "MenuCell.h"
#import "MenuConfiguration.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Extension.h"
#import "CellSelection.h"

@interface MenuTable () {
    CGRect endFrame;
    CGRect startFrame;
    NSIndexPath *currentIndexPath;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *items;
@end

@implementation MenuTable

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.items = [NSArray arrayWithArray:items];
        
        self.layer.backgroundColor = [UIColor color:[MenuConfiguration mainColor] withAlpha:0.0].CGColor;
        self.clipsToBounds = YES;
        
        endFrame = self.bounds;
        startFrame = endFrame;
        startFrame.origin.y -= self.items.count*[MenuConfiguration itemCellHeight];
        
        self.table = [[UITableView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.table.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, [MenuConfiguration menuWidth], self.table.bounds.size.height)];
        header.backgroundColor = [UIColor color:[MenuConfiguration itemsColor] withAlpha:[MenuConfiguration menuAlpha]];
        header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.table addSubview:header];
        
    }
    return self;
}

- (void)show
{
    [self addSubview:self.table];
    if (!self.table.tableFooterView)
    {
        [self addFooter];
    }
    [UIView animateWithDuration:[MenuConfiguration animationDuration] animations:^{
        self.layer.backgroundColor = [UIColor color:[MenuConfiguration mainColor] withAlpha:[MenuConfiguration backgroundAlpha]].CGColor;
        self.table.frame = endFrame;
        self.table.contentOffset = CGPointMake(0, [MenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
            self.table.contentOffset = CGPointMake(0, 0);
        }];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
        self.table.contentOffset = CGPointMake(0, [MenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[MenuConfiguration animationDuration] animations:^{
            self.layer.backgroundColor = [UIColor color:[MenuConfiguration mainColor] withAlpha:0.0].CGColor;
            self.table.frame = startFrame;
        } completion:^(BOOL finished) {
            //            [self.table deselectRowAtIndexPath:currentIndexPath animated:NO];
            MenuCell *cell = (MenuCell *)[self.table cellForRowAtIndexPath:currentIndexPath];
            [cell setSelected:NO withCompletionBlock:^{
                
            }];
            currentIndexPath = nil;
            [self removeFooter];
            [self.table removeFromSuperview];
            [self removeFromSuperview];
        }];
    }];
}

//弹跳效果
- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    return [MenuConfiguration animationDuration]*percentage/100.0;
}

- (void)addFooter
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [MenuConfiguration menuWidth], self.table.bounds.size.height - (self.items.count * [MenuConfiguration itemCellHeight]))];
    self.table.tableFooterView = footer;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
    [footer addGestureRecognizer:tap];
}

- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MenuConfiguration itemCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MenuCell *cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentIndexPath = indexPath;
    
    MenuCell *cell = (MenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES withCompletionBlock:^{
        [self.menuDelegate didSelectItemAtIndex:indexPath.row];
    }];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = (MenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO withCompletionBlock:^{
        
    }];
}

@end
