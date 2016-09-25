//
//  AddViewController.h
//  StockDemo
//
//  Created by student on 13-12-30.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"
#import "StockDownloadManager.h"
#import "StocksSQLManager.h"
@interface AddViewController : UIViewController
@property(strong,nonatomic) Stock *aStock;
@property(strong,nonatomic) StockDownloadManager *manager;
@property(strong,nonatomic) StocksSQLManager *SQLmanager;

- (IBAction)StockTypeSegment:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITextField *StockIDField;

@property (weak, nonatomic) IBOutlet UITextView *ShowTextView;
@property (weak, nonatomic) IBOutlet UIButton *AddButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *StockTypeSegment;

- (IBAction)FindButton:(UIButton *)sender;
- (IBAction)AddButton:(UIButton *)sender;
- (IBAction)Background:(UIControl *)sender;
@end
