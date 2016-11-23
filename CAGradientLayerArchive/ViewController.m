//
//  ViewController.m
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/21.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import "ViewController.h"
#import "YWGradientView.h"
#import "DownLoadImageTool.h"
#import "YWGradientViewAddGradient.h"
#import "YWGradientViewMaskGradient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //方案1: 使用RemoteImageSource
    DownLoadImageTool * tool = [DownLoadImageTool share];
    
    [tool downLoadImageWithUrl:@[@"http://img4.duitang.com/uploads/item/201410/12/20141012121323_hkRnw.jpeg",@"http://img5q.duitang.com/uploads/item/201406/12/20140612194320_VAZ8T.thumb.700_0.jpeg",@"http://img4.duitang.com/uploads/item/201409/04/20140904205231_JQXME.thumb.700_0.jpeg",@"http://img4.duitang.com/uploads/blog/201406/18/20140618171138_eKLKm.jpeg",@"http://e.hiphotos.baidu.com/zhidao/pic/item/ae51f3deb48f8c54f873d7cc3a292df5e1fe7fb4.jpg"]];

    
    [tool setLoadImage:^(NSArray * images){
    
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //一句代码解决渐变浏览效果
            [YWGradientView gradientViewWithFrame:(CGRect){CGPointZero,CGSizeMake(self.view.width, 400)} WithImages:images joinInSuperView:self.view];
        });

    }];
    
    //方案2: 使用LocalImageSource

    //    NSArray * images = @[[UIImage imageNamed:@"bg1"],[UIImage imageNamed:@"bg2"],[UIImage imageNamed:@"bg3.jpeg"]];

//    [YWGradientView gradientViewWithFrame:(CGRect){CGPointZero,CGSizeMake(self.view.width, 400)} WithImages:images joinInSuperView:self.view];
    
    
//效果2:
    [YWGradientViewAddGradient gradientViewWithFrame:CGRectMake(0, 400, 300, 300) WithImage:[UIImage imageNamed:@"bg1"] joinInSuperView:self.view];
  
    
    //效果3:
    
    [YWGradientViewMaskGradient gradientViewWithFrame:CGRectMake(300, 400, self.view.width-300, 300) WithImage:[UIImage imageNamed:@"bg2"] WithAnyView:self.view];
//    
    

}





@end
