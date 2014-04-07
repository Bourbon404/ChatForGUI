//
//  ManagementCell.m
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "ManagementCell.h"

@implementation ManagementCell
@synthesize headImg,messageLebel,nextImg;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        messageLebel = [[UILabel alloc] init];
        [messageLebel setBackgroundColor:[UIColor clearColor]];
        messageLebel.textAlignment = NSTextAlignmentLeft;
        messageLebel.textColor = [UIColor whiteColor];
        messageLebel.font = [UIFont systemFontOfSize:20.0f];
        [self addSubview:messageLebel];
        
        UIImage *next = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back" ofType:@"png"]];
        nextImg = [[UIImageView alloc] initWithImage:next];
        [self addSubview:nextImg];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [headImg setFrame:CGRectMake(12.75f, 21.75f, 25, 25)];
    [messageLebel setFrame:CGRectMake(49, 10, 150, 48.5f)];
    [nextImg setFrame:CGRectMake(300, 30, 7, 12)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
