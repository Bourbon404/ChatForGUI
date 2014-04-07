//
//  OrderDetailView.m
//  NewChat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView
@synthesize dateLabel,fromLabel,totalPriceLabel,totaNumLabel,stateLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
    label1.text = @"下单时间:";
    label1.font = [UIFont systemFontOfSize:10.0f];
    label1.textColor = [UIColor whiteColor];
    [self addSubview:label1];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 100, 20)];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:dateLabel];
    
    fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 100, 20)];
    [fromLabel setTextColor:[UIColor whiteColor]];
    [fromLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:fromLabel];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 50, 20)];
    label2.text = @"商品总数:";
    label2.font = [UIFont systemFontOfSize:10.0f];
    label2.textColor = [UIColor whiteColor];
    [self addSubview:label2];
    
    totaNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, 100, 20)];
    [totaNumLabel setTextColor:[UIColor yellowColor]];
    [totaNumLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:totaNumLabel];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(250, 70, 50, 20)];
    label3.text = @"总价格:";
    label3.font = [UIFont systemFontOfSize:10.0f];
    label3.textColor = [UIColor whiteColor];
    [self addSubview:label3];
    
    totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 70, 50, 20)];
    [totalPriceLabel setTextColor:[UIColor yellowColor]];
    [totalPriceLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:totalPriceLabel];
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 50, 20)];
    [stateLabel setTextColor:[UIColor yellowColor]];
    [stateLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [self addSubview:stateLabel];
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
