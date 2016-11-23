//
//  YWGradientView.m
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/21.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import "YWGradientView.h"
#import <objc/runtime.h>
#define UIColorFromHexAlpha(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]


@interface YWGradientView ()<CAAnimationDelegate>

@end

@implementation YWGradientView
{
    CALayer *           _backgroundLayer;
    CALayer *           _foregroundLayer;
    CAGradientLayer *   _gradientLayer;
    CGPoint             _newPoint;
}

+(void)gradientViewWithFrame:(CGRect)frame WithImages:(NSArray *)images joinInSuperView:(id)view
{
    YWGradientView * gradientView = [[YWGradientView alloc]initWithFrame:frame];
    [view addSubview:gradientView];
    
    [gradientView buildAnimationWithImages:images];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    [self layoutLayer];
}



-(void)layoutLayer
{

    _backgroundLayer        = [CALayer layer];
 
    _backgroundLayer.frame  = (CGRect){CGPointZero,self.size};
    if (!_foregroundLayer) {
        
        _foregroundLayer    = [CALayer layer];
        
    }
    _foregroundLayer.frame  = (CGRect){CGPointZero,self.size};
    _gradientLayer          = [CAGradientLayer layer];
    
    //渐变原理:跟png图片带透明像素一样, 不透明的能够显示, 透明的就无法显示.
    _gradientLayer.colors   =@[(__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.99) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.95) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.9) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.8) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.7) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.6) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.5) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.4) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.3) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.2) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.1) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.05) CGColor],
                               (__bridge id)[UIColorFromHexAlpha(0xffffff, 0.01) CGColor]];
    
    _foregroundLayer.mask   = _gradientLayer;
    
    [self.layer addSublayer:_backgroundLayer];
    [self.layer addSublayer:_foregroundLayer];

}


-(void)layoutMask
{
    switch (self.mode) {
        case 0:
            _gradientLayer.frame        = CGRectMake(-2*self.width, 0, 2*self.width, self.height);
            _gradientLayer.startPoint   = CGPointMake(0, 0);
            _gradientLayer.endPoint     = CGPointMake(1, 0);
            
            break;
        case 1:
            _gradientLayer.frame        = CGRectMake(self.width, 0, 2*self.width, self.height);
            _gradientLayer.startPoint   = CGPointMake(1, 0);
            _gradientLayer.endPoint     = CGPointMake(0, 0);
            
            break;
        case 2:
            _gradientLayer.frame        = CGRectMake(0, -2*self.height, self.width, 2*self.height);
            _gradientLayer.startPoint   = CGPointMake(0, 0);
            _gradientLayer.endPoint     = CGPointMake(0, 1);
            
            break;
        case 4:
            _gradientLayer.frame        = CGRectMake(0, self.height, self.width, 2*self.height);
            _gradientLayer.startPoint   = CGPointMake(0, 1);
            _gradientLayer.endPoint     = CGPointMake(0, 0);
            
            break;
 
        default:
            
            _gradientLayer.frame        = CGRectMake(-2*self.width, 0, 2*self.width, self.height);
            _gradientLayer.startPoint   = CGPointMake(0, 0);
            _gradientLayer.endPoint     = CGPointMake(1, 0);
            
            break;
    }
}


-(void)setImage:(UIImage *)image
{
    
    
    if (self.image) {
        
        [self layoutLayer];
        _backgroundLayer.contents = (__bridge id)self.image.CGImage;
        _foregroundLayer.contents = (__bridge id)image.CGImage;
        _image = image;
        [self layoutMask];
        [self startAnimation];
    }else
    {
        _image = image;
        _backgroundLayer.contents = (__bridge id)self.image.CGImage;
    }
    
}

-(NSTimeInterval)duration
{
    if (!_duration) {
        
        self.duration = 3.f;
        return _duration;
    }
    return _duration;
}


-(void)startAnimation
{
    CGPoint current   = [[_gradientLayer valueForKey:@"position"]CGPointValue];
    switch (self.mode) {
        case 0:
            
            _newPoint = CGPointMake(current.x+2*self.width,current.y);
            
            break;
        case 1:
            
            _newPoint = CGPointMake(current.x-2*self.width,current.y);
            
            break;
        case 2:
            
            _newPoint = CGPointMake(current.x,current.y+2*self.height);
            
            break;
        case 4:
            
            _newPoint = CGPointMake(current.x,current.y-2*self.height);
            
            break;

        default:
            
            _newPoint = CGPointMake(current.x+2*self.width,current.y);
            
            break;
    }
    
    CABasicAnimation * annimation   = [CABasicAnimation animationWithKeyPath:@"position"];
    annimation.delegate             = self;
    annimation.duration             = self.duration;
    annimation.fillMode             = kCAFillModeForwards;
    annimation.removedOnCompletion  = NO;
    annimation.repeatCount          = 1;
    annimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    annimation.fromValue            = [NSValue valueWithCGPoint:current];
    annimation.toValue              = [NSValue valueWithCGPoint:_newPoint];
    [annimation setValue:@"position" forKey:@"annimationFlag"];
    [_gradientLayer addAnimation:annimation forKey:@"position"];

}


-(void)clearLayer
{
    [_gradientLayer removeAllAnimations];
    [_gradientLayer  removeFromSuperlayer];
    _gradientLayer      = nil;
    [_backgroundLayer removeFromSuperlayer];
    _backgroundLayer    = nil;
    _foregroundLayer.contents = (__bridge id)self.image.CGImage;
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString * value = [anim valueForKey:@"annimationFlag"];
    if ([value isEqualToString:@"position"]) {
        
        [self clearLayer];
        
    }
}

-(void)buildAnimationWithImages:(NSArray *)images
{
    
    
    self.mode       = 0;
    self.image      = images[0];
    
    for (int i = 0; i < images.count; i++) {
        if (i >0) {
            
            
            CGFloat delay   = self.duration*i+1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.mode   = 1<<(i-1)%4;
                
                NSLog(@"%ld", self.mode);
                
                self.image  = images[i];
                
                if (i == images.count-1) {
                    
                     CGFloat time  = self.duration+1;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( time* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self buildAnimationWithImages:images];
                    });
                }
                
            });
        }
        
    }

    
    
    
}



@end
