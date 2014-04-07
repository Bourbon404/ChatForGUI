//
//  VisitorCell.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "VisitorCell.h"

@implementation VisitorCell
@synthesize headImg,bubbleImg,numLabel,nameLabel,dateLabel,fromLabel,sexImg,sexString;

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
        bubbleImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        [self addSubview:bubbleImg];
        
        numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        numLabel.textColor = [UIColor whiteColor];
        [numLabel setFont:[UIFont systemFontOfSize:7.0f]];
        [numLabel setText:@"new"];
        [bubbleImg addSubview:numLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc] init];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [dateLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:dateLabel];
        
        fromLabel = [[UILabel alloc] init];
        [fromLabel setBackgroundColor:[UIColor clearColor]];
        [fromLabel setTextColor:[UIColor whiteColor]];
        [fromLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [fromLabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:fromLabel];
        
        sexImg = [[UIImageView alloc] init];
        [self addSubview:sexImg];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [headImg setFrame:CGRectMake(6.75f, 6.75f, 55, 55)];
    [bubbleImg setFrame:CGRectMake(50, 1, 18, 18)];
    [numLabel setFrame:CGRectMake(3, 2, 15,15)];
    [nameLabel setFrame:CGRectMake(6.75f*2+55, 21.75f, 80, 25)];
    [dateLabel setFrame:CGRectMake(190, 14.25f,120, 20)];
    [fromLabel setFrame:CGRectMake(240, 14.25f+10+15, 70, 20)];
    
    UIImage *man = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"男人" ofType:@"png"]];
    UIImage *woman = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"女人" ofType:@"png"]];
    
    if ([sexString isEqualToString:@"man"])
    {
        sexImg.image = man;
        
    }
    else
    {
        sexImg.image = woman;
    }
    
    [sexImg setFrame:CGRectMake(6.75f*2+55+70, 21.25f,10, 16.5f)];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
