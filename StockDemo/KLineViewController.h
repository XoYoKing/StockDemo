//
//  KLineViewController.h
//  StockDemo
//
//  Created by FsWan on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"
@interface KLineViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) Stock *GetStock;
- (IBAction)dayKButton:(id)sender;
- (IBAction)weakKbutton:(id)sender;
- (IBAction)monthKButton:(id)sender;
@end
