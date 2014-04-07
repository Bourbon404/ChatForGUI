//
//  GroupButtonView.m
//  mamachat
//
//  Created by bourbon on 13-12-30.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "GroupButtonView.h"

@implementation GroupButtonView
@synthesize headImg,headLabel,isOpen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        headImg = [[UIImageView alloc] init];
        [self addSubview:headImg];
        
        headLabel = [[UILabel alloc] init];
        [headLabel setBackgroundColor:[UIColor clearColor]];
        headLabel.font = [UIFont systemFontOfSize:10.0f];
        headLabel.textColor = [UIColor whiteColor];
        headLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:headLabel];
        
        isOpen = YES;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    headImg.frame = CGRectMake(5, 5, 20, 20);
    headLabel.frame = CGRectMake(40, 5, 200, 30);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
