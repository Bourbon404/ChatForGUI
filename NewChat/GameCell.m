//
//  GameCell.m
//  NewChat
//
//  Created by bourbon on 13-12-26.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell
@synthesize headImg,bubbleImg,flagLabel,nameLabel,nextImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        headImg.layer.cornerRadius = 10.0f;
        headImg.layer.masksToBounds = YES;
        [self addSubview:headImg];
        
        bubbleImg = [[UIImageView alloc] init];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImg.image = img;
        [self addSubview:bubbleImg];
        
        flagLabel = [[UILabel alloc] init];
        [flagLabel setBackgroundColor:[UIColor clearColor]];
        flagLabel.text = @"new";
        flagLabel.textColor = [UIColor whiteColor];
        [flagLabel setBackgroundColor:[UIColor clearColor]];
        [bubbleImg addSubview:flagLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:nameLabel];
        
        nextImg = [[UIImageView alloc] init];
        UIImage *next = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
        nextImg.image = next;
        [self addSubview:nextImg];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(10, 10, 50, 50)];
    [bubbleImg setFrame:CGRectMake(50, 5, 20, 20)];
    [nameLabel setFrame:CGRectMake(80, 25, 200, 20)];
    [nextImg setFrame:CGRectMake(290, 25, 7 , 12)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
