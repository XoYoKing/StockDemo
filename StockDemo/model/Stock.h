//
//  Stock.h
//  StockDemo
//
//  Created by student on 13-12-24.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stock : NSObject
@property (nonatomic,strong)NSNumber *SQLID;//数据库中的ID
@property (nonatomic,copy) NSString *StockID;//股票代码
@property (nonatomic,copy) NSString *StockName;//股票名
@property (nonatomic,strong) NSNumber *StockType;//股票类型SH：上海 0，SZ：深圳 1
@property (nonatomic,strong) NSNumber *YesterdayClosePrice;//昨日收盘价
@property (nonatomic,strong) NSNumber *RecentPrice;//最新价格
@property (nonatomic,copy) NSData *ImageData;

@property (nonatomic,strong) NSNumber *IncreaseScope;//涨幅=(现价-上一个交易日收盘价）/上一个交易日收盘价*100%
@property (nonatomic,strong) NSNumber *RiseAndDrop;//涨跌=今收盘-昨收盘


@end
