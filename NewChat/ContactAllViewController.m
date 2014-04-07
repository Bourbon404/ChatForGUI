//
//  ContactAllViewController.m
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ContactAllViewController.h"
#import "ChatGroupCreatViewCell.h"
#import "ContactCell.h"
#import "FriendEntity.h"
#import "SearchVIew.h"


#import "ChineseString.h"
#import "pinyin.h"

@interface ContactAllViewController ()

@end

@implementation ContactAllViewController
@synthesize userID;
//@synthesize allFriendsTable,newFriendTable,allFriendsArray;

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
	// Do any additional setup after loading the view.
    //搜索框
    SearchVIew *search = [[SearchVIew alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.backgroundColor = [UIColor clearColor];
    
    //点击进入新朋友
    newFriendTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 68.5f) style:(UITableViewStylePlain)];
    newFriendTable.backgroundColor = [UIColor clearColor];
    newFriendTable.delegate = self;
    newFriendTable.dataSource = self;
    newFriendTable.separatorColor = [UIColor blackColor];
    //全部朋友
    if (iOS7)
    {
        allFriendsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-64-49) style:(UITableViewStylePlain)];
        [newFriendTable setSeparatorInset:UIEdgeInsetsZero];
        [allFriendsTable setSeparatorInset:UIEdgeInsetsZero];
    }
    else
    {
        allFriendsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44-49) style:(UITableViewStylePlain)];
    }
    newFriendTable.backgroundColor = [UIColor clearColor];
    newFriendTable.scrollEnabled = NO;
    allFriendsTable.delegate = self;
    allFriendsTable.dataSource = self;
    allFriendsTable.separatorColor = [UIColor blackColor];
    [allFriendsTable setBackgroundColor:[UIColor clearColor]];
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表格" ofType:@"png"]];
    [allFriendsTable setBackgroundView:[[UIImageView alloc] initWithImage:backImg]];
    
    
    //添加
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44+68.5f)];
    headView.backgroundColor = [UIColor clearColor];
    [headView addSubview:search];
    [headView addSubview:newFriendTable];
    
    allFriendsTable.tableHeaderView = headView;
    [self.view addSubview:allFriendsTable];
    
    //准备数据
    
    
//    NSMutableArray *allArray = [[UserAndMessageManager defaultManager] selectAllFriendsByUserID:userID];
    [[UserAndMessageManager defaultManager] selectAllFriendsByUserID:userID];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;;
    BaseStore *store = [app.store getStore:FRIEND_ENT];
    NSMutableArray *allArray =[store getEntArray];
                         
                         
                         
                         
    allDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    keyArray = [[NSMutableArray alloc] initWithCapacity:0];
    allFriendsArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *allName = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [allArray count]; i++)
    {
        ChineseString *chineseString = [[ChineseString alloc] init];
        FriendEntity *tmp = [allArray objectAtIndex:i];
        chineseString.string = [NSString stringWithString:tmp.noteName];
        
        if (chineseString.string == nil)
        {
            chineseString.string  = @"";
        }
        
        if (![chineseString.string isEqualToString:@""])
        {
            NSString *singlePinyinletter = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:0])] uppercaseString];
            chineseString.pinYin = singlePinyinletter;
            
            int flag = 0;
            for (NSString *tmp in keyArray)
            {
                if ([tmp isEqualToString:chineseString.pinYin])
                {
                    flag ++;
                }
            }
            if (flag == 0)
            {
                [keyArray addObject:chineseString.pinYin];
            }
        }
        else
        {
            chineseString.pinYin = @"";
        }
        [allName addObject:chineseString];
    }
    
    //数组排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [allName sortUsingDescriptors:sortDescriptors];
    

    for (int i = 0; i < [allArray count]; i++)
    {
        ChineseString *name = [allName objectAtIndex:i];
        for (FriendEntity *tmp in allArray)
        {
            if ([name.string isEqualToString:tmp.noteName])
            {
                [allFriendsArray addObject:tmp];
            }
        }
    } 
  
    
}
#pragma mark UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == newFriendTable)
    {
        return 1;
    }
    else
    {
        return [allFriendsArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentify = @"cell";
    if (tableView == newFriendTable)
    {
        ChatGroupCreatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        if (cell == nil)
        {
            cell = [[ChatGroupCreatViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
        }
        cell.headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newfriend" ofType:@"png"]];
        cell.messageLabel.text = @"new friends";
        cell.nextButton.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentify];
        if (cell == nil)
        {
            cell = [[ContactCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CellIdentify];
        }
        FriendEntity *_friend = [allFriendsArray objectAtIndex:indexPath.row];
        
        cell.headImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]];
        cell.fromLabel.text = @"中国 深圳";

        if ([_friend.noteName isEqualToString:@""] || _friend.noteName == nil)
        {
            cell.nameLabel.text = [NSString stringWithFormat:@"%i",_friend.friendUserId];
        }
        else
        {
            cell.nameLabel.text = _friend.noteName;
        }
        cell.stateLabel.text = @"[在线]";
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == newFriendTable)
    {
        return 68.5f;
    }
    else
    {
        return 68.5f;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return [keyArray sortedArrayUsingSelector:@selector(compare:)];
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == allFriendsTable)
    {
        FriendEntity *_friend = [allFriendsArray objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chat" object:_friend];
    }
    else if (tableView == newFriendTable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"string" delegate:self cancelButtonTitle:@"string" otherButtonTitles:@"string", nil];
        [alert show];
    }
}
@end
