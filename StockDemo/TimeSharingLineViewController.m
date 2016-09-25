//
//  TimeSharingLineViewController.m
//  StockDemo
//
//  Created by FsWan on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import "TimeSharingLineViewController.h"

@interface TimeSharingLineViewController ()
@property (strong,nonatomic)Stock *SendStock;
@end

@implementation TimeSharingLineViewController

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
    self.SendStock=self.GetStock;
    NSString *address;
    if (self.GetStock.StockType.intValue==0) {
    address=[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/min/n/sh%@.gif",self.GetStock.StockID];
    }else{
    address=[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/min/n/sz%@.gif",self.GetStock.StockID];
    }
    NSURL *url=[NSURL URLWithString:address];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error ) {
        if (data) {
            UIImage *image=[UIImage imageWithData:data];
            self.imageView.image=image;
            }
    }];
       NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(ReladImager) userInfo:nil repeats:YES];
//    NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:self];

	// Do any additional setup after loading the view.
}

-(void)ReladImager
{
    NSLog(@"22222");
    NSString *address;
    if (self.GetStock.StockType.intValue==0) {
        address=[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/min/n/sh%@.gif",self.GetStock.StockID];
    }else{
        address=[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/min/n/sz%@.gif",self.GetStock.StockID];
    }
    NSURL *url=[NSURL URLWithString:address];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error ) {
        if (data) {
            UIImage *image=[UIImage imageWithData:data];
            self.imageView.image=image;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *nextVC=segue.destinationViewController;

        [nextVC setValue:self.SendStock forKey:@"GetStock"];
    
}

@end
