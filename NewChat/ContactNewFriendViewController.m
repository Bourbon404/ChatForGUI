//
//  ContactNewFriendViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ContactNewFriendViewController.h"
#import "ContactListCell.h"

@interface ContactNewFriendViewController ()

@end

@implementation ContactNewFriendViewController

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
    // Do any additional setup after loading the view from its nib.
    listTable.dataSource = self;
    listTable.delegate = self;
    listArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 按钮事件
-(void)clickButton:(id)sender
{
    
}
#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    ContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
    if (cell == nil)
    {
        cell = [[ContactListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
    }
    cell.headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.nameLabel.text = @"taby";
    cell.messageLabel.text = @"I am taby";
    
    return cell;
}

@end

