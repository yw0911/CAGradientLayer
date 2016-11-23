//
//  YWGradientView.h
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/21.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"



@interface YWGradientView : UIView

typedef NS_OPTIONS(NSInteger, direction)
{
    LeftToRight         = 0,
    RightToLeft         = 1 << 0,
    UpToDown            = 1 << 1,
    DownToUp            = 1 << 2
};


@property(nonatomic ,strong)UIImage *       image;
@property(nonatomic ,assign)direction       mode;
@property(nonatomic ,assign)NSTimeInterval  duration;

+(void)gradientViewWithFrame:(CGRect)frame WithImages:(NSArray *)images joinInSuperView:(id)view;
-(void)buildAnimationWithImages:(NSArray *)images;

@end
