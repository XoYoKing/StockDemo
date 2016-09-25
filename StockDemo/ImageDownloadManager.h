//
//  ImageDownloadManager.h
//  StockDemo
//
//  Created by FsWan on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stock.h"

@interface ImageDownloadManager : NSObject

-(void)GetImageString:(NSString *)string AndImageView:(UIImageView *)ImageView AndStcok:(Stock *)Stock;//图片下载

@end
