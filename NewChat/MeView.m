//
//  MeView.m
//  NewChat
//
//  Created by bourbon on 13-12-24.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "MeView.h"

@implementation MeView
@synthesize headButton,headImg;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    
    headImg = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"png"]]];
    headImg.frame = CGRectMake(120, 50+30, 80, 80);
    headImg.layer.cornerRadius = 40.0f;
    headImg.layer.masksToBounds = YES;
    [self addSubview:headImg];
    
    
    headButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:headButton];
    [headButton setFrame:CGRectMake(85, 125+30, 150, 50)];
    [headButton setTitle:@"......" forState:(UIControlStateNormal)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    CGContextRef contexty = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(contexty, 0, 200);
    CGContextAddLineToPoint(contexty, 320, 200);
    CGContextSetLineWidth(contexty, 1);
    CGContextStrokePath(contexty);
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
