//
//  BubbleView.m
//  WorldTchChat
//
//  Created by Bourbon on 13-12-11.
//  Copyright (c) 2013年 mamarow. All rights reserved.
//

#import "BubbleView.h"
#import "UIImage+UIImageExt.h"
#define biaoqiSizeWidth 18
#define biaoqinSizeHeight 18
#define MAX_width 150
#define begin_flag @"[/"
#define end_flag @"]"

@implementation BubbleView

#pragma mark 发送图片
-(UIView *)bubbleVIew: (UIImage *)image from: (NSString *)aMessageFrom
{
    image = [image imageByScalingAndCroppingForSize:CGSizeMake(50, 50)];
    UIImageView *returnView = [[UIImageView alloc] initWithImage:image];
    returnView.backgroundColor = [UIColor clearColor];
    
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor clearColor];
    
    BOOL fromSelf;
    NSUserDefaults  *userDefault = [NSUserDefaults standardUserDefaults];
    fromSelf = [aMessageFrom isEqualToString:[userDefault objectForKey:@"username"]] ? YES : NO;
    
    UIImage *bubble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fromSelf?@"wo":@"对象" ofType:@"png"]];
    
    UIImageView *bubleView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:22 topCapHeight:18]];
    bubleView.backgroundColor = [UIColor clearColor];
    
    UIImageView  *headImageView = [[UIImageView alloc]init];
    
    
    
    if (fromSelf)
    {
        NSString *defaultString = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"];
        UIImage *defaultImage = [UIImage imageWithContentsOfFile:defaultString];
        headImageView.image = defaultImage;
        
        [returnView setFrame:CGRectMake(9.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height)];
        bubleView.frame =CGRectMake(0, 14, returnView.frame.size.width+24, returnView.frame.size.height+24);
        cellView.frame = CGRectMake(265-bubleView.frame.size.width, 0, bubleView.frame.size.width+50, bubleView.frame.size.height+30);
        headImageView.frame =CGRectMake(bubleView.frame.size.width+1, cellView.frame.size.height-55.0f, 50, 50);
        
    }
    else
    {
        NSString *string = @"01";
        NSString *imageName = [[NSBundle mainBundle] pathForResource:string ofType:@"png"];
        
        headImageView.image = [UIImage imageWithContentsOfFile:imageName];
        returnView.frame =CGRectMake(65, 15.0, returnView.frame.size.width, returnView.frame.size.height);
        bubleView.frame = CGRectMake(54, 15, returnView.frame.size.width+25, returnView.frame.size.height+25);
        cellView.frame = CGRectMake(0, 0, bubleView.frame.size.width +30, bubleView.frame.size.height +30);
        headImageView.frame =CGRectMake(0, cellView.frame.size.height -50, 50, 50);
    }
    
    
    [cellView addSubview:bubleView];
    [cellView addSubview:headImageView];
    [cellView addSubview:returnView];
    
    cellView.userInteractionEnabled = YES;
    
    return cellView ;
}






#pragma mark 发送文字
//第三步
//生成起泡聊天
#pragma  mark ------ bubbleView   methods 冒泡聊天------
-(UIView *)bubbleView: (NSString *) text from: (NSString *)aMessageFrom
{
    UIView *returnView = [self messageAtInder:text from:aMessageFrom];
    returnView.backgroundColor = [UIColor clearColor];
    
    //tableViewCell 的 view
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectZero];
    cellView.backgroundColor = [UIColor clearColor];
    
    //判断是否消息来自自己,aMessageFrom是当前发送的信息，chatPerson.userName是当前聊天对象
    BOOL fromSelf;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    fromSelf = [aMessageFrom isEqualToString:[userDefault objectForKey:@"username"]]?YES:NO;

    
    UIImage *buble = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fromSelf?@"wo":@"对象" ofType:@"png" ]];
    
    //图像拉伸(ios 5  ios 6 几种方法) 泡泡图像拉伸
    UIImageView  *bubleView = [[UIImageView alloc]initWithImage:[buble stretchableImageWithLeftCapWidth:22 topCapHeight:18]];
    bubleView.backgroundColor = [UIColor clearColor];
    //用户头像
    UIImageView  *headImageView = [[UIImageView alloc]init];
    

    
    if (fromSelf)
    {
        NSString *defaultString = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"];
        UIImage *defaultImage = [UIImage imageWithContentsOfFile:defaultString];
        headImageView.image = defaultImage;
        
        [returnView setFrame:CGRectMake(9.0f, 15.0f, returnView.frame.size.width, returnView.frame.size.height)];
        bubleView.frame =CGRectMake(0, 14, returnView.frame.size.width+24, returnView.frame.size.height+24);
        cellView.frame = CGRectMake(265-bubleView.frame.size.width, 0, bubleView.frame.size.width+50, bubleView.frame.size.height+30);
        headImageView.frame =CGRectMake(bubleView.frame.size.width+1, cellView.frame.size.height-55.0f, 50, 50);
        
    }
    else
    {
        NSString *string = @"01";
        NSString *imageName = [[NSBundle mainBundle] pathForResource:string ofType:@"png"];
        
        headImageView.image = [UIImage imageWithContentsOfFile:imageName];
        returnView.frame =CGRectMake(65, 15.0, returnView.frame.size.width, returnView.frame.size.height);
        bubleView.frame = CGRectMake(54, 15, returnView.frame.size.width+25, returnView.frame.size.height+25);
        cellView.frame = CGRectMake(0, 0, bubleView.frame.size.width +30, bubleView.frame.size.height +30);
        headImageView.frame =CGRectMake(0, cellView.frame.size.height -50, 50, 50);
    }
    
    
    [cellView addSubview:bubleView];
    [cellView addSubview:headImageView];
    [cellView addSubview:returnView];
    
    cellView.userInteractionEnabled = YES;
    
    return cellView ;
}


//第二步
//获取反回的  uiview
-(UIView *)messageAtInder :(NSString *)message from: (NSString *)fromSelf
{
    NSMutableArray  *array = [[NSMutableArray alloc]init];
    
    [self getImage:message :array];
    
    UIView *returnView = [[UIView alloc]initWithFrame:CGRectZero];
    NSArray * data = array;
    
    CGFloat zuobiaoX = 0;
    CGFloat zuobiaoY=  0;
    CGFloat X = 0;
    CGFloat Y = 0;
    
    
    
    if (data)
    {
        for (int i = 0; i < [data count]; i++)
        {
            NSString  * str = [data objectAtIndex:i];
            if ([str hasPrefix: begin_flag] && [str hasSuffix: end_flag])
            {
                if (zuobiaoX >= MAX_width)
                {
                    zuobiaoY = zuobiaoY + biaoqinSizeHeight;
                    zuobiaoX = 0;
                    X = 150;
                    Y = zuobiaoY;
                }
                
                NSString *imageName=[str substringWithRange:NSMakeRange(2, str.length - 3)];
                NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
                UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
                UIImageView *img=[[UIImageView alloc]initWithImage:image];
                img.frame = CGRectMake(zuobiaoX, zuobiaoY, biaoqiSizeWidth, biaoqinSizeHeight);
                [returnView addSubview:img];
                zuobiaoX=biaoqiSizeWidth+zuobiaoX;
                
                if (X<150)
                {
                    X = zuobiaoX;
                }
            }
            else
            {
                for (int j = 0; j < [str length]; j++)
                {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    if (zuobiaoX  >= MAX_width)
                    {
                        zuobiaoY = zuobiaoY + biaoqinSizeHeight;
                        zuobiaoX = 0;
                        X = 150;
                        Y =zuobiaoY;
                    }
                    CGSize size=[temp sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(150, 40)];
                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(zuobiaoX,zuobiaoY,size.width,size.height)];
                    la.font = [UIFont systemFontOfSize:15];
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:la];
                    zuobiaoX = zuobiaoX +size.width;
                    if (X<150)
                    {
                        X = zuobiaoX;
                    }
                    
                }
            }
        }
    }
    returnView.frame = CGRectMake(15.0f,1.0f, X, Y); //@ 需要将该view的尺寸记下，方便以后使用
    return returnView;
}

//第一步
//获取表情图片和文字信息并排效果，若没表情图片则获取纯文字信息
-(void)getImage:(NSString *)message :(NSMutableArray *) array
{
    //获取指定短字符串在长字符串中的开始，结尾索引值；
    NSRange range = [message rangeOfString:begin_flag];
    NSRange rangeRight =[message rangeOfString:end_flag];
    
    
    if (range.length > 0 && rangeRight.length >0)
    {
        if (range.location>0)
        {
            [array addObject:[message substringToIndex:range.location]];//反回从0到I的字符串
            [array addObject:[message substringWithRange:NSMakeRange(range.location, rangeRight.location-range.location+1)]];//截取范围内的字符串
            NSString *string = [message substringFromIndex:rangeRight.location+1];
            [self getImage:string :array];
        }
        else
        {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, rangeRight.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""])
            {
                [array addObject:nextstr];
                NSString *string=[message substringFromIndex:rangeRight.location+1];
                [self getImage:string :array];
            }
            else
            {
                return;
            }
        }
    }
    else if (message != nil)
    {
        [array addObject:message];
    }
}

@end
