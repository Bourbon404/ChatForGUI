//
//  ManagementViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ManagementViewController.h"
#import "NewProductViewController.h"
#import "BuyLeadViewController.h"
#import "SupplierViewController.h"
#import "ClientViewController.h"
#import "AdverViewController.h"
#import "JobViewController.h"
#import "ManagementCell.h"
#import "GamesViewController.h"
@interface ManagementViewController ()
{
    NSMutableArray *imageMenuArray;
}
@end

@implementation ManagementViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    listArray = [[NSMutableArray alloc] initWithObjects:@"games",@"client",@"new product",@"buying leads",@"supplier",@"advertisement",@"job", nil];
    imageMenuArray = [[NSMutableArray alloc] initWithObjects:@"game",@"client",@"product",@"leads",@"supplier",@"ad",@"job", nil];

    //更改navi上的字体颜色和一些背景颜色
    if (iOS7)
    {
        NSDictionary *naviDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
        [self.navigationController.navigationBar setTitleTextAttributes:naviDic];
    }
    self.navigationItem.title = @"Smart management";
    
    UIImage *naviImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"导航栏" ofType:@"png"]];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    if (iOS7) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    } else {
        naviImg = [self scaleToSize:naviImg size:self.navigationController.navigationBar.bounds.size];
    }
    [self.navigationController.navigationBar setBackgroundImage:naviImg forBarMetrics:(UIBarMetricsDefault)];
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    self.tableView.separatorColor = [UIColor blackColor];
}
-(UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
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
    return [listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[ManagementCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.messageLebel.text = [listArray objectAtIndex:indexPath.row];
    cell.headImg.image = [self menuImgWith:[imageMenuArray objectAtIndex:indexPath.row]];
    return cell;
}
-(UIImage *)menuImgWith:(NSString *)name
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
    return image;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.5f;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.

     // ...
     // Pass the selected object to the new view controller.
    if (indexPath.row == 0)
    {
        GamesViewController *nextView = [[GamesViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 1)
    {
        NewProductViewController *nextView = [[NewProductViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 2)
    {
        BuyLeadViewController *nextView = [[BuyLeadViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 3)
    {
        SupplierViewController *nextView = [[SupplierViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 4)
    {
        ClientViewController *nextView = [[ClientViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 5)
    {
        AdverViewController *nextView = [[AdverViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    else if (indexPath.row == 6)
    {
        JobViewController *nextView = [[JobViewController alloc] init];
        nextView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextView animated:YES];
    }
    
}

@end
