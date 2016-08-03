//
//  NavigationMenuView.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "NavigationMenuView.h"
#import "MenuButton.h"
#import "QuartzCore/QuartzCore.h"
#import "MenuConfiguration.h"

@interface NavigationMenuView  ()
@property (nonatomic, strong) MenuButton *menuButton;
@property (nonatomic, strong) MenuTable *table;
@property (nonatomic, strong) UIView *menuContainer;
@end

@implementation NavigationMenuView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self)
    {
        frame.origin.y += 1.0;
        self.menuButton = [[MenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
    }
    return self;
}

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
}

#pragma mark - Actions
- (void)onHandleMenuTap:(id)sender
{
    if (self.menuButton.isActive)
    {
        NSLog(@"On show");
        [self onShowMenu];
    }
    else
    {
        NSLog(@"On hide");
        [self onHideMenu];
    }
}

- (void)onShowMenu
{
    if (!self.table)
    {
        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect frame = mainWindow.frame;
        frame.origin.y += self.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.table = [[MenuTable alloc] initWithFrame:frame items:self.items];
        self.table.menuDelegate = self;
    }
    [self.menuContainer addSubview:self.table];
    [self rotateArrow:M_PI];
    [self.table show];
}

- (void)onHideMenu
{
    [self rotateArrow:0];
    [self.table hide];
}

//点击时箭头旋转
- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:[MenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark - Delegate methods
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
    [self.delegate didSelectItemAtIndex:index];
}

- (void)didBackgroundTap
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
}

#pragma mark - Memory management
- (void)dealloc
{
    self.items = nil;
    self.menuButton = nil;
    self.menuContainer = nil;
}

@end
