//
//  ChatCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell
@synthesize headImageView,nameLabel,messageLabel,dateLabel,bubbleImage,numLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImageView = [[UIImageView alloc] init];
        headImageView.layer.cornerRadius = 10;
        headImageView.layer.masksToBounds = YES;
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:20.0f];
        
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.font = [UIFont systemFontOfSize:15.0f];
        
        dateLabel = [[UILabel alloc] init];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.font = [UIFont systemFontOfSize:12.0f];
        
        numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.font = [UIFont systemFontOfSize:12.0f];
        
        bubbleImage = [[UIImageView alloc] init];
        UIImage *bubbleImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"消息提醒" ofType:@"png"]];
        bubbleImage.image = bubbleImg;
        
        [bubbleImage addSubview:numLabel];
                
        [self addSubview:headImageView];
        [self addSubview:nameLabel];
        [self addSubview:messageLabel];
        [self addSubview:dateLabel];
        [self addSubview:bubbleImage];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImageView setFrame:CGRectMake(6.75f, 6.75f, 55, 55)];
    [nameLabel setFrame:CGRectMake(6.75f*2+55, 6.75f, 100, 25)];
    [messageLabel setFrame:CGRectMake(6.75f*2+55, 12.25f+25+5, 200, 20)];
    [dateLabel setFrame:CGRectMake(250, 14.25f, 70, 20)];
    [bubbleImage setFrame:CGRectMake(50, 1, 18, 18)];
    [numLabel setFrame:CGRectMake(6, 3, 11,11)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
