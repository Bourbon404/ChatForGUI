//
//  SearchVIew.m
//  NewChat
//
//  Created by bourbon on 13-12-23.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "SearchVIew.h"

@implementation SearchVIew
@synthesize backImg,searchButton,searchText;

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
    backImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6.5f, 300, 31)];
    backImg.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"搜索框" ofType:@"png"]];
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(12, 8, 258, 31)];
    searchText.borderStyle = UITextBorderStyleNone;
    searchText.placeholder = @"输入内容";
    searchText.backgroundColor = [UIColor clearColor];
    [searchText addTarget:self action:@selector(didEndOnExit:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
    
    searchButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"搜索" ofType:@"png"]];
    [searchButton setImage:image forState:(UIControlStateNormal)];
    [searchButton setFrame:CGRectMake(271.5f, 6.5f, 38.5f, 31)];
    
    self.backgroundColor = [UIColor clearColor];
    
    CGContextRef contexty = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(contexty, 0, 44);
    CGContextAddLineToPoint(contexty, 320, 44);
    CGContextSetLineWidth(contexty, 1);
    CGContextStrokePath(contexty);

    [self addSubview:backImg];
    [self addSubview:searchButton];
    [self addSubview:searchText];
}
-(void)didEndOnExit:(id)sender
{
    [sender resignFirstResponder];
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
