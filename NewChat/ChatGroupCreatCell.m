//
//  ChatGroupCreatCell.m
//  NewChat
//
//  Created by Bourbon on 13-12-20.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ChatGroupCreatCell.h"

@implementation ChatGroupCreatCell
@synthesize headImageView,nameLabel,checkButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImageView = [[UIImageView alloc] init];
        nameLabel = [[UILabel alloc] init];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        checkButton = [[UIButton alloc] init];
        
        [self addSubview:headImageView];
        [self addSubview:nameLabel];
        [self addSubview:checkButton];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImageView setFrame:CGRectMake(5, 5, 40, 40)];
    [nameLabel setFrame:CGRectMake(55, 15, 100, 20)];
    [checkButton setFrame:CGRectMake(200, 15, 30, 20)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
