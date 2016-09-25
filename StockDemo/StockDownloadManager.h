//
//  StockManager.h
//  StockDemo
//
//  Created by student on 13-12-24.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stock.h"
#import "StocksSQLManager.h"
@interface StockDownloadManager : NSObject
@property (nonatomic,strong)Stock *GetStock;
@property (nonatomic,strong)StocksSQLManager *manager;

-(void) FindStockObject:(Stock *)Stock;//下载

@end
