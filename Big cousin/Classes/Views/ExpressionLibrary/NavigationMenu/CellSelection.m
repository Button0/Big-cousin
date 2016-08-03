//
//  CellSelection.m
//  Big cousin
//
//  Created by Mushroom on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#import "CellSelection.h"
#import <QuartzCore/QuartzCore.h>

@interface CellSelection ()
@property (nonatomic, strong) UIColor *baseColor;
@end

@implementation CellSelection

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)baseColor_
{
    self = [super initWithFrame:frame];
    if (self) {
        self.baseColor = baseColor_;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat hue; //色彩
    CGFloat saturation; //饱和度
    CGFloat brightness; //亮度
    CGFloat alpha;      //透明度
    
    if([self.baseColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]){
        brightness -= 0.35;
    }
    
    UIColor * highColor = self.baseColor;
    UIColor * lowColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    
    CAGradientLayer * gradient = [CAGradientLayer layer];
    [gradient setFrame:[self bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    [[self layer] addSublayer:gradient];
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    self.baseColor = nil;
}

@end
