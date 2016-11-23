//
//  YWGradientViewMaskGradient.m
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/23.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import "YWGradientViewMaskGradient.h"
#import "UIView+Frame.h"

@implementation YWGradientViewMaskGradient
{
    UIView * _maskView;
}

+(void)gradientViewWithFrame:(CGRect)frame WithImage:(UIImage *)image WithAnyView:(UIView*)view;
{
    YWGradientViewMaskGradient * gradientView = [[YWGradientViewMaskGradient alloc]initWithFrame:frame];
    
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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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

-(void)buildMaskLayer
{
    //注意此时的坐标系,由于要将_maskView 作为self 的maskView 此时的坐标系是当前对象(self)的坐标系,而不是当先对象(self)的父视图的坐标系,frame设置错误会导致视图显示为空白,因为此时的maskView 可能已经超出视图(self)显示范围.
    _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame             = self.bounds;
    
    gradientLayer.colors            = @[(__bridge id)[UIColor clearColor].CGColor,
                                        (__bridge id)[UIColor blackColor].CGColor,
                                        (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.startPoint        = CGPointMake(0,0);
    gradientLayer.endPoint          = CGPointMake(0,1);
    gradientLayer.locations         = @[@0.3f,@0.5f,@0.7f];
    
    [_maskView.layer addSublayer:gradientLayer];
    CGRect frame   = _maskView.frame;
    frame.origin.y = -self.height;
    _maskView.frame = frame;
    
    
   [self performSelector:@selector(changeAnimatation) withObject:nil afterDelay:3.f];
    self.maskView  = _maskView;
    
    
}

-(void)changeAnimatation
{
    CGRect frame   = _maskView.frame;
    frame.origin.y = -self.height;
    _maskView.frame = frame;
    
    [UIView animateWithDuration:3.f animations:^{
        
        CGRect frame    = _maskView.frame;
        frame.origin.y += 2*self.height;
        _maskView.frame  = frame;
        
    }];
    
    [self performSelector:@selector(changeAnimatation) withObject:nil afterDelay:3.f];
}

@end
