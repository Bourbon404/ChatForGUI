//
//  PublishCell.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "PublishCell.h"

@implementation PublishCell
@synthesize headImg,nameLabel,messageLabel,fromLabel,dateLabel,likeImg,imgArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //定制开始
        headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 10.0f;
        headImg.layer.masksToBounds = YES;
        [self addSubview:headImg];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        [self addSubview:nameLabel];
        
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:messageLabel];
        
        fromLabel = [[UILabel alloc] init];
        [fromLabel setBackgroundColor:[UIColor clearColor]];
        [fromLabel setTextColor:[UIColor whiteColor]];
        [fromLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [fromLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:fromLabel];
        
        dateLabel = [[UILabel alloc] init];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor lightGrayColor]];
        [dateLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self addSubview:dateLabel];
        
        likeImg = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *norImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"默认喜欢" ofType:@"png"]];
        UIImage *selectImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"喜欢" ofType:@"png"]];
        [likeImg setImage:norImg forState:(UIControlStateNormal)];
        [likeImg setImage:selectImg forState:(UIControlStateSelected)];
        [likeImg addTarget:self action:@selector(clickLikeImg:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:likeImg];
    
    }
    return self;
}
-(void)clickLikeImg:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.selected == YES)
    {
        [button setSelected:NO];
    }
    else
    {
        [button setSelected:YES];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 15, 55, 55)];
    [nameLabel setFrame:CGRectMake(70, 15, 160, 15)];
    [messageLabel setFrame:CGRectMake(70, 10+15+10+10, 160, 15)];
    [fromLabel setFrame:CGRectMake(240, 10, 60, 15)];
    [dateLabel setFrame:CGRectMake(70, self.frame.size.height-10-25+5, 100, 15)];
    [likeImg setFrame:CGRectMake(280, self.frame.size.height-10-25+5, 22.5f, 18)];

    for (int i = 0; i < [imgArray count]; i++)
    {
        UIImage *tmp = [imgArray objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:tmp];
        if (i < 3)
        {
            [imgView setFrame:CGRectMake(70+5+80*i+4*(i-1), 60+5+5+5, 80, 80)];
        }
        else if (i >=3 && i <= 5)
        {
            [imgView setFrame:CGRectMake(70+5+80*(i-3)+4*(i-4), 60+80+5+5+5+5, 80, 80)];
        }
        else if (i >= 6)
        {
            [imgView setFrame:CGRectMake(70+5+80*(i-6)+4*(i-7), 60+80+80+5+5+5+5+5, 80, 80)];
        }
        [self addSubview:imgView];
    }
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
