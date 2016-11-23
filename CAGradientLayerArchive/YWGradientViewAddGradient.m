//
//  YWGradientViewAddGradient.m
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/23.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import "YWGradientViewAddGradient.h"
#import "UIView+Frame.h"

@implementation YWGradientViewAddGradient
{
    CAGradientLayer * _maskLayer;
}

+(void)gradientViewWithFrame:(CGRect)frame WithImage:(UIImage *)image joinInSuperView:(UIView *)view;
{
    YWGradientViewAddGradient * gradientView = [[YWGradientViewAddGradient alloc]initWithFrame:frame];
    
    gradientView.layer.contents = (__bridge id)image.CGImage;
    
    [view addSubview:gradientView];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self buildMaskLayer];
        
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self buildMaskLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self buildMaskLayer];
    }
    return self;
}


-(void)buildMaskLayer
{
    
    _maskLayer                   = [CAGradientLayer layer];
    _maskLayer.frame             = CGRectMake(0, 0, self.width, self.height);
    _maskLayer.colors            = @[(__bridge id)[[UIColor clearColor]colorWithAlphaComponent:0.05f].CGColor,
                                    (__bridge id)[[UIColor cyanColor]colorWithAlphaComponent:1.f].CGColor];
    _maskLayer.startPoint        = CGPointMake(0, 0);
    _maskLayer.endPoint          = CGPointMake(0, 1);
    _maskLayer.locations         = @[@0.7f,@1.f];
    [self.layer addSublayer:_maskLayer];
    
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:1.f];
    
    
}


-(void)changeColor
{
    _maskLayer.colors    = @[(__bridge id)[[UIColor clearColor]colorWithAlphaComponent:0.05f].CGColor,
                          (__bridge id)[UIColor colorWithHue:arc4random()%361*0.1 saturation:1.f brightness:1.f alpha:1.f].CGColor];
    _maskLayer.locations = @[[NSNumber numberWithFloat:arc4random()%100/100.0],@1.f];
    
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:1.f];
    
    
}


@end
