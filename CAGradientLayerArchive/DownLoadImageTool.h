//
//  DownLoadImageTool.h
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/21.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^callBack)( NSArray * images);

@interface DownLoadImageTool : NSObject

@property(nonatomic ,copy)callBack loadImage;

@property(nonatomic ,strong)NSArray * images;

+(instancetype)share;

-(void)downLoadImageWithUrl:(NSArray *)urls;




@end
