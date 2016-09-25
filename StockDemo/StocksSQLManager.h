//
//  StocksManager.h
//  Stocks
//
//  Created by student on 13-12-27.
//  Copyright (c) 2013年 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stock.h"
#import "FMDatabase.h"


@interface StocksSQLManager : NSObject

@property (nonatomic,strong)FMDatabase *db;



-(NSString *)DBPath;//数据库路径
-(instancetype)init;//初始化，打开数据库
-(void)addStockpeople:(Stock *)aFinalTSpeople;//增加数据
-(void)removeStockpeople:(Stock *)aFinalTSpeople;//根据。。删除数据
-(Stock *)StockOfIndex:(int)index;//查找

-(int)numberOfStockpeople;//根据ID查找出共有多少股票

-(Stock *)SortStockByStockPrice:(NSString *)aStr AndIndex:(int)index andAscending_order:(BOOL)order;//排序
-(int)UpdateOfStock:(Stock *)aUpdateStock; //修改
@end
