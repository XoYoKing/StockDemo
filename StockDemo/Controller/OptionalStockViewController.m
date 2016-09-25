//
//  OptionalStockViewController.m
//  StockDemo
//
//  Created by student on 13-12-25.
//  Copyright (c) 2013年 lly. All rights reserved.
//

#import "OptionalStockViewController.h"
#define kStockNameTag 1
#define kStockIDTag 2
#define kRecentPriceTag 3
#define kStockIncreaseScopeTag 4 //涨幅
#define kStockRiseAndDropTag 5  //涨跌
#define kPercentage @"%"

@interface OptionalStockViewController (){
    BOOL SortingBOOL;
    BOOL Judgment;
    NSTimer *timer;
    
    BOOL RecentPrice;
    BOOL IncreaseScope;
    BOOL RiseAndDrop;
}
@property (nonatomic,strong)NSString *String;


@end

@implementation OptionalStockViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.databaseManager=[[StocksSQLManager alloc]init];
    self.manager=[[StockDownloadManager alloc]init];

    timer=[NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(TimerOfMethod) userInfo:nil repeats:YES];
    SortingBOOL=NO;
    self.String=[[NSString alloc]init];
    RecentPrice=NO;
    IncreaseScope=NO;
    RiseAndDrop=NO;
    
}

-(void)TimerOfMethod
{
    NSLog(@"11111");

    for (int i=0; i<[self.databaseManager numberOfStockpeople]; i++) {
        Stock *aStock=[[Stock alloc]init];
        aStock=[self.databaseManager StockOfIndex:i];
        [self.manager FindStockObject:aStock];
        [self.databaseManager UpdateOfStock:aStock];
    }
    [self.tableView reloadData];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}
- (IBAction)ReloadButton:(UIBarButtonItem *)sender {
    [self TimerOfMethod];

}

- (IBAction)IncreaseScopeButton:(UIBarButtonItem *)sender {
    SortingBOOL=YES;
    self.String=@"IncreaseScope";
    if (IncreaseScope==NO) {
        Judgment=YES;
        IncreaseScope=YES;
    }else{
        Judgment=NO;
        IncreaseScope=NO;
    }
    [self.tableView reloadData];
}

- (IBAction)RecentPriceButton:(UIBarButtonItem *)sender {
    SortingBOOL=YES;
    self.String=@"RecentPrice";
    if (RecentPrice==NO) {
        Judgment=YES;
        RecentPrice=YES;
    }else{
        Judgment=NO;
        RecentPrice=NO;
    }
    [self.tableView reloadData];
}

- (IBAction)RiseAndDropButton:(UIBarButtonItem *)sender {
    SortingBOOL=YES;
    self.String=@"RiseAndDrop";
    if (RiseAndDrop==NO) {
        Judgment=YES;
        RiseAndDrop=YES;
    }else{
        Judgment=NO;
        RiseAndDrop=NO;
    }
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
        return [self.databaseManager numberOfStockpeople];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    int row =indexPath.row;
    Stock *aStocks;
    if (SortingBOOL==YES) {

            aStocks=[self.databaseManager SortStockByStockPrice:self.String AndIndex:row andAscending_order:Judgment];
    }else{
    aStocks=[self.databaseManager StockOfIndex:row];
    }
    UILabel *NameLabel=(UILabel*)[cell viewWithTag:kStockNameTag];
    NameLabel.text=aStocks.StockName;
    
    UILabel *IDLabel=(UILabel*)[cell viewWithTag:kStockIDTag];
    IDLabel.text=aStocks.StockID;
    
    UILabel *RecentPriceLabel=(UILabel*)[cell viewWithTag:kRecentPriceTag];
    NSString *string=[NSString stringWithFormat:@"%.2f",aStocks.RecentPrice.floatValue];
    RecentPriceLabel.text=string;

    UILabel *increaseLabel=(UILabel*)[cell viewWithTag:kStockIncreaseScopeTag];
    NSString *string1=[NSString stringWithFormat:@"%.2f %@",aStocks.IncreaseScope.floatValue,kPercentage];
    increaseLabel.text=string1;
    
    UILabel *riseAndDropLabel=(UILabel*)[cell viewWithTag:kStockRiseAndDropTag];
    NSString *string2=[NSString stringWithFormat:@"%.2f",aStocks.RiseAndDrop.floatValue];
    riseAndDropLabel.text=string2;
    

    
    if (aStocks.RiseAndDrop.floatValue>0) {
        NameLabel.textColor=[UIColor redColor];
        IDLabel.textColor=[UIColor redColor];
        RecentPriceLabel.textColor=[UIColor redColor];
        increaseLabel.textColor=[UIColor redColor];
        riseAndDropLabel.textColor=[UIColor redColor];
    }
    else if(aStocks.RiseAndDrop.floatValue<0){
        NameLabel.textColor=[UIColor greenColor];
        IDLabel.textColor=[UIColor greenColor];
        RecentPriceLabel.textColor=[UIColor greenColor];
        increaseLabel.textColor=[UIColor greenColor];
        riseAndDropLabel.textColor=[UIColor greenColor];
    }
    else{
        NameLabel.textColor=[UIColor whiteColor];
        IDLabel.textColor=[UIColor whiteColor];
        RecentPriceLabel.textColor=[UIColor whiteColor];
        increaseLabel.textColor=[UIColor whiteColor];
        riseAndDropLabel.textColor=[UIColor whiteColor];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=indexPath.row;
    Stock *theStocks=[self.databaseManager StockOfIndex:row];

    [self.databaseManager removeStockpeople:theStocks];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *nextVC=segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"AllToTime"]) {
       
    NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
    int row = indexPath.row;
    Stock * SendStock=[self.databaseManager StockOfIndex:row];
    [nextVC setValue:SendStock forKey:@"GetStock"];
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
