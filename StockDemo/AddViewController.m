//
//  AddViewController.m
//  StockDemo
//
//  Created by student on 13-12-30.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import "AddViewController.h"
#define kPercentage @"%"
@interface AddViewController ()

@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.SQLmanager=[[StocksSQLManager alloc]init];
    self.manager=[[StockDownloadManager alloc]init];
    [self.ShowTextView setHidden:YES];
    [self.AddButton setHidden:YES];
    self.aStock=[[Stock alloc]init];
    self.aStock.StockType=[NSNumber numberWithInt:0];
    
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FindButton:(UIButton *)sender {
    NSString *string=self.StockIDField.text;
    if (string.length>6) {
        self.ShowTextView.text=@"股票代码长度超过！！！";
        [self.ShowTextView setHidden:NO];
        self.StockIDField.text=@"";
    }
    else{
    self.aStock.StockID=string;
 
    [self.manager FindStockObject:self.aStock];
    
    if (self.aStock.StockName==nil) {
        [self.ShowTextView setHidden:NO];
    }else{
        [self.ShowTextView setHidden:NO];
        [self.AddButton setHidden:NO];
        
        if (self.aStock.RiseAndDrop.floatValue>0) {
            self.ShowTextView.textColor=[UIColor redColor];
        }
        else{
            self.ShowTextView.textColor=[UIColor greenColor];
        }
        
        self.ShowTextView.text=[NSString stringWithFormat:@"股票名字：%@  股票代码：%@  昨日价：%@  最新价：%@  涨幅：%.2f %@   涨跌：%.2f   ",self.aStock.StockName,self.aStock.StockID,self.aStock.YesterdayClosePrice,self.aStock.RecentPrice,self.aStock.IncreaseScope.floatValue,kPercentage,self.aStock.RiseAndDrop.floatValue];
    }
    }
    [self.StockIDField resignFirstResponder];
}

- (IBAction)AddButton:(UIButton *)sender {
    [self.SQLmanager addStockpeople:self.aStock];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Background:(UIControl *)sender {
    [self.StockIDField resignFirstResponder];
}
- (IBAction)StockTypeSegment:(UISegmentedControl *)sender {
    self.aStock.StockType=@(sender.selectedSegmentIndex);
}
@end
