//
//  StocksManager.m
//  Stocks
//
//  Created by student on 13-12-27.
//  Copyright (c) 2013年 student. All rights reserved.
//

#import "StocksSQLManager.h"
#import "FMDatabaseAdditions.h"
#define kDBName @"Stocks.db"

@implementation StocksSQLManager : NSObject

-(NSString *)DBPath{
    NSArray *dirList=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[dirList firstObject];
    NSLog(@"数据库路径：%@",path);
    
    return [path stringByAppendingPathComponent:kDBName];
}

-(instancetype)init{
    
    self.db=[FMDatabase databaseWithPath:[self DBPath]];
    if ([self.db open]) {
        NSLog(@"打开数据库");
    }
    
    [self.db executeUpdate:@"create table if not exists Stock (ID integer primary key autoincrement, StockID text,StockName text,StockType integer,IncreaseScope float,RiseAndDrop float, RecentPrice float)"];
    
    return self;
}

-(void)addStockpeople:(Stock *)aFinalTSpeople
{
    NSString *string=[NSString stringWithFormat:@"insert into Stock (StockID,StockName,StockType,IncreaseScope,RiseAndDrop,RecentPrice) values('%@','%@',%@,%@,%@,%@)",aFinalTSpeople.StockID,aFinalTSpeople.StockName,aFinalTSpeople.StockType,aFinalTSpeople.IncreaseScope,aFinalTSpeople.RiseAndDrop,aFinalTSpeople.RecentPrice];
    [self.db executeUpdate:string];
}

-(void)removeStockpeople:(Stock *)aFinalTSpeople
{
    [self.db executeUpdate:@"delete from Stock where ID=?",aFinalTSpeople.SQLID];
}

-(Stock *)StockOfIndex:(int)index
{
    FMResultSet *rs=[self.db executeQuery:@"select * from Stock limit 1 offset ?",@(index)];
    Stock *theStock;
    while ([rs next]) {
        theStock=[[Stock alloc]init];
        theStock.SQLID=@([rs intForColumn:@"ID"]);
        theStock.StockID=[rs stringForColumn:@"StockID"];
        theStock.StockName=[rs stringForColumn:@"StockName"];
        theStock.StockType=@([rs intForColumn:@"StockType"]);
        theStock.IncreaseScope=@([rs doubleForColumn:@"IncreaseScope"]);
        theStock.RiseAndDrop=@([rs doubleForColumn:@"RiseAndDrop"]);
        theStock.RecentPrice=@([rs doubleForColumn:@"RecentPrice"]);
    }
    return theStock;
}

-(int)numberOfStockpeople
{
    NSString *rs=@"select count(StockID) from Stock";
    return [self.db intForQuery:rs];
}

-(Stock *)SortStockByStockPrice:(NSString *)aStr AndIndex:(int)index andAscending_order:(BOOL)order
{
    NSString *orderStr = order==YES?@"asc":@"desc";
    NSString  *selectSQL = [NSString stringWithFormat: @"select * from Stock order by %@ %@ limit 1 offset %d",aStr,orderStr,index];
    FMResultSet *rs = [self.db executeQuery:selectSQL];
    
    Stock *theStock;
    while ([rs next]) {
        theStock=[[Stock alloc]init];
        theStock.SQLID=@([rs intForColumn:@"ID"]);
        theStock.StockID=[rs stringForColumn:@"StockID"];
        theStock.StockName=[rs stringForColumn:@"StockName"];
        theStock.StockType=@([rs intForColumn:@"StockType"]);
        theStock.IncreaseScope=@([rs doubleForColumn:@"IncreaseScope"]);
        theStock.RiseAndDrop=@([rs doubleForColumn:@"RiseAndDrop"]);
        theStock.RecentPrice=@([rs doubleForColumn:@"RecentPrice"]);
    }
    return theStock;

}


-(int)UpdateOfStock:(Stock *)aUpdateStock
{
    NSString *rs=[NSString stringWithFormat:@"update Stock set IncreaseScope=%@,RiseAndDrop=%@,RecentPrice=%@ where ID=%@",aUpdateStock.IncreaseScope,aUpdateStock.RiseAndDrop,aUpdateStock.RecentPrice,aUpdateStock.SQLID];
    return [self.db executeUpdate:rs];
}

@end
