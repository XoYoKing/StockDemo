//
//  ImageDownloadManager.m
//  StockDemo
//
//  Created by FsWan on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import "ImageDownloadManager.h"

@implementation ImageDownloadManager
-(void)GetImageString:(NSString *)string AndImageView:(UIImageView *)ImageView AndStcok:(Stock *)Stock
{
    NSString *address;
    if (Stock.StockType.intValue==0) {
        address=[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/%@/n/sh%@.gif",string,Stock.StockID];
    }else{
        address=[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/%@/n/sz%@.gif",string,Stock.StockID];
    }
    NSURL *url=[NSURL URLWithString:address];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error ) {
        if (data) {
            ImageView.image=[UIImage imageWithData:data];

        }
    }];

}
@end
