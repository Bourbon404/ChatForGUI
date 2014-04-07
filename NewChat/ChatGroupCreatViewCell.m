//
//  ChatGroupCreatViewCell.m
//  NewChat
//
//  Created by bourbon on 13-12-23.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatGroupCreatViewCell.h"

@implementation ChatGroupCreatViewCell
@synthesize headImage,messageLabel,nextButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImage = [[UIImageView alloc] init];
        messageLabel = [[UILabel alloc] init];
        [messageLabel setBackgroundColor:[UIColor clearColor]];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont systemFontOfSize:20.0f];
        nextButton = [[UIImageView alloc] init];
                
        [self addSubview:headImage];
        [self addSubview:messageLabel];
        [self addSubview:nextButton];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImage setFrame:CGRectMake(12.75f, 21.75f, 25, 25)];
    [messageLabel setFrame:CGRectMake(49, 25, 150, 18.5)];
    [nextButton setFrame:CGRectMake(300, 28.25f, 7, 12)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
