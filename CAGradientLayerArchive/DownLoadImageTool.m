//
//  DownLoadImageTool.m
//  CAGradientLayerArchive
//
//  Created by 余伟 on 16/11/21.
//  Copyright © 2016年 yuwei. All rights reserved.
//

#import "DownLoadImageTool.h"

@implementation DownLoadImageTool


+(instancetype)share
{
    
    static DownLoadImageTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tool = [[DownLoadImageTool alloc]init];
       
    });
    return tool;
}

-(void)downLoadImageWithUrl:(NSArray *)urls
{
    NSMutableArray * images = [NSMutableArray arrayWithCapacity:10];
    
    NSURLSession * session      = [NSURLSession sharedSession];
 
    for (int i = 0; i<urls.count; i++) {

        NSURL * URL                 = [NSURL URLWithString:urls[i]];
        
        NSURLSessionDataTask * task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            UIImage * image = [UIImage imageWithData:data];
            
            [images addObject:image];
            
            __weak typeof(self)wself = self;
            
            if (i == urls.count-1) {
                
                wself.loadImage(images);
                
            }
            
            
            
            NSLog(@"%ld", images.count);
            
            

        }];
        [task resume];
    }
    
    
}



@end
