//
//  OptionalStockViewController.h
//  StockDemo
//
//  Created by student on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"
#import "StockDownloadManager.h"
#import "StocksSQLManager.h"
@interface OptionalStockViewController : UITableViewController<UIAlertViewDelegate>

@property(strong,nonatomic)NSMutableArray *stockList;

@property(strong,nonatomic)StocksSQLManager *databaseManager;
@property (nonatomic,strong)StockDownloadManager *manager;

- (IBAction)ReloadButton:(UIBarButtonItem *)sender;
- (IBAction)RecentPriceButton:(UIBarButtonItem *)sender;
- (IBAction)IncreaseScopeButton:(UIBarButtonItem *)sender;
- (IBAction)RiseAndDropButton:(UIBarButtonItem *)sender;


@end
