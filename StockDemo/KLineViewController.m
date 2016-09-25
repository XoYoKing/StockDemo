//
//  KLineViewController.m
//  StockDemo
//
//  Created by FsWan on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import "KLineViewController.h"
#import "ImageDownloadManager.h"
static int MotionlessValue=0;
@interface KLineViewController ()

@property(nonatomic,strong)ImageDownloadManager *manager;

@end

@implementation KLineViewController

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
    self.manager=[[ImageDownloadManager alloc]init];
    if (MotionlessValue==0) {
        self.title=@"日K线";
        [self.manager GetImageString:@"daily" AndImageView:self.imageView AndStcok:self.GetStock];
    }else if (MotionlessValue==1){
        self.title=@"周K线";
        [self.manager GetImageString:@"weekly" AndImageView:self.imageView AndStcok:self.GetStock];
    }else if (MotionlessValue==2){
        self.title=@"月K线";
        [self.manager GetImageString:@"monthly" AndImageView:self.imageView AndStcok:self.GetStock];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//daily,weekly,monthly
- (IBAction)dayKButton:(id)sender {
    self.title=@"日K线";
    [self.manager GetImageString:@"daily" AndImageView:self.imageView AndStcok:self.GetStock];
    MotionlessValue=0;
}

- (IBAction)weakKbutton:(id)sender {
    self.title=@"周K线";
    [self.manager GetImageString:@"weekly" AndImageView:self.imageView AndStcok:self.GetStock];
    MotionlessValue=1;
}

- (IBAction)monthKButton:(id)sender {
    self.title=@"月K线";
    [self.manager GetImageString:@"monthly" AndImageView:self.imageView AndStcok:self.GetStock];
    MotionlessValue=2;
}
@end
