//
//  InquiryCell.m
//  NewChat
//
//  Created by bourbon on 13-12-25.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "InquiryCell.h"

@implementation InquiryCell
@synthesize headImg,bubbleImg,numLabel,nameLabel,styleImg,messageLabel,dateLabel,fromLabel;
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
        numLabel.font = [UIFont systemFontOfSize:10.0f];
        [bubbleImg addSubview:numLabel];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:17.0f];
        [self addSubview:nameLabel];

        styleImg = [[UIImageView alloc] init];
        [self addSubview:styleImg];
        
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:messageLabel];
        
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
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [headImg setFrame:CGRectMake(6.75f, 6.75f, 55, 55)];
    [bubbleImg setFrame:CGRectMake(50, 1, 18, 18)];
    [numLabel setFrame:CGRectMake(3, 3, 12,12)];
    [nameLabel setFrame:CGRectMake(6.75f*2+55, 6.75f, 100, 25)];
    [styleImg setFrame:CGRectMake(10+40+10, 14.25f+10+15, 15, 15)];
    [messageLabel setFrame:CGRectMake(6.75f*2+55, 12.25f+25+5,150, 20)];
    [dateLabel setFrame:CGRectMake(190, 14.25f,120, 20)];
    [fromLabel setFrame:CGRectMake(240, 14.25f+10+15, 70, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
