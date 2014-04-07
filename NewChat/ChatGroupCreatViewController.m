//
//  ChatGroupCreatViewController.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatGroupCreatViewController.h"
#import "ChatGroupCreatCell.h"
@interface ChatGroupCreatViewController ()

@end

@implementation ChatGroupCreatViewController

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
    self.navigationItem.title = @"选择联系人";
    contactTable.delegate = self;
    contactTable.dataSource = self;
    contactPerson = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contactPerson count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    ChatGroupCreatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil)
    {
        cell = [[ChatGroupCreatCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentify];
    }
    cell.headImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
    cell.nameLabel.text = @"taby";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end
