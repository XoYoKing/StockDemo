//
//  TimeSharingLineViewController.h
//  StockDemo
//
//  Created by FsWan on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"
@interface TimeSharingLineViewController : UIViewController{
    int _bey;
    int _dataSize;
}

@property(strong,nonatomic)NSMutableData *imgData;
@property(strong,nonatomic) Stock *GetStock;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
