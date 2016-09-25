//
//  StockManager.m
//  StockDemo
//
//  Created by student on 13-12-24.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import "StockDownloadManager.h"
#define kStockURL @"http://hq.sinajs.cn/list="
#define kStockName 0
#define kYesterdayClosePrice 2
#define kRecentPrice 3

@implementation StockDownloadManager
-(void)FindStockObject:(Stock *)Stock
{
    NSStringEncoding myEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *URLstring;
    if (Stock.StockType.intValue==0) {
        URLstring=[NSString stringWithFormat:@"%@sh%@",kStockURL,Stock.StockID];
    }else{
        URLstring=[NSString stringWithFormat:@"%@sz%@",kStockURL,Stock.StockID];
    }

    NSURL *url=[NSURL URLWithString:URLstring];
    NSString *string = [NSString stringWithContentsOfURL:url encoding:myEncoding error:Nil];
    NSArray * array1= [string componentsSeparatedByString:@"\"" ];
    NSString * string2 = [NSString stringWithFormat:@"%@",array1[1]];

    
    NSArray *array2=[string2 componentsSeparatedByString:@","];
    
    if (array2.count==1) {
        Stock.StockName=nil;
        
        Stock.YesterdayClosePrice=0;
        
        Stock.RecentPrice=0;
        
        [self GetIncreaseScope:Stock];
        
        [self GetRiseAndDrop:Stock];
    } else {
    
    Stock.StockName=array2[kStockName];

    Stock.YesterdayClosePrice=array2[kYesterdayClosePrice];

    Stock.RecentPrice=array2[kRecentPrice];

    [self GetIncreaseScope:Stock];

    [self GetRiseAndDrop:Stock];

    }
}

-(void)GetIncreaseScope:(Stock *)Stock//涨幅=(现价-上一个交易日收盘价）/上一个交易日收盘价*100%
{
    float RecentPrice=Stock.RecentPrice.floatValue;
    float YesterdayClosePrice=Stock.YesterdayClosePrice.floatValue;
    Stock.IncreaseScope=@((RecentPrice-YesterdayClosePrice)/YesterdayClosePrice*100);
}
-(void)GetRiseAndDrop:(Stock *)Stock//涨跌
{
    float RecentPrice=Stock.RecentPrice.floatValue;
    float YesterdayClosePrice=Stock.YesterdayClosePrice.floatValue;
    Stock.RiseAndDrop=@(RecentPrice-YesterdayClosePrice);
}
-(void)ReloadOfArray:(NSArray *)StockOfArray AndTableView:(UITableView *)tableView
{
    self.manager=[[StocksSQLManager alloc]init];
    for (int i=0; i<StockOfArray.count; i++) {
        Stock *aStock=[[Stock alloc]init];
        aStock=StockOfArray[i];
        [self FindStockObject:aStock];
        [self.manager UpdateOfStock:aStock];
    }
    [tableView reloadData];
}
@end
