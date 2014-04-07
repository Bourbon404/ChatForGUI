//
//  FaceView.m
//  mamachat
//
//  Created by bourbon on 13-12-27.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "FaceView.h"

#define deviceWhdth   [[UIScreen mainScreen] bounds ].size.width
#define deviceHeight   [[UIScreen mainScreen] bounds ].size.height

@implementation FaceView
@synthesize faceArry,faceScrollView,pageControl,faceSendBtn,button_face;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = 3;
        pageControl.currentPage = 0;
        pageControl.backgroundColor = [UIColor clearColor];
        [pageControl addTarget:self action:@selector(pageControlChange:) forControlEvents:(UIControlEventValueChanged)];
        [self addSubview:pageControl];
        
        faceSendBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [faceSendBtn setTitle:@"发送" forState:UIControlStateNormal];
        faceSendBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"发送按钮" ofType:@"png"]];
        [faceSendBtn setBackgroundImage:image forState:(UIControlStateNormal)];
        [self addSubview:faceSendBtn];
        
        faceScrollView = [[UIScrollView alloc]init];
        faceScrollView.scrollEnabled = YES;
        faceScrollView.pagingEnabled = YES;
        faceScrollView.showsHorizontalScrollIndicator = NO;  //水平划条显示
        faceScrollView.showsVerticalScrollIndicator =NO;    //垂直划条显示
        faceScrollView.contentSize=CGSizeMake(312*3, 156);
        faceScrollView.delegate = self;
        [self addSubview:faceScrollView];
        
        //增加表情    初始化表情。。。
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (int i= 0;i<= 104;i++)
        {
            NSString *head = [NSString stringWithFormat:@"%d",i];
            NSString *string = [[NSBundle mainBundle] pathForResource:head ofType:@"png"];
            UIImage *faceImage = [UIImage imageWithContentsOfFile:string];
            
            NSMutableDictionary * facedic = [NSMutableDictionary dictionaryWithCapacity:100];
            [facedic setValue:faceImage forKey:[NSString stringWithFormat:@"[/%d]",i]];
            [temp addObject:facedic];
        }
        self.faceArry = temp;
        
        
        //添加表情视图
        UIView *faceButtonView1 = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 312, 186)];
        int k = 1;
        for (int i=1; i<=4; i++)
        {
            for (int j=1; j<=8; j++)
            {
                button_face = [UIButton buttonWithType:UIButtonTypeCustom];
                button_face.frame = CGRectMake((j-1)*40, (i-1)*40, 32, 32);
                NSMutableDictionary *muDict = [self.faceArry objectAtIndex:k];
                UIImage *image_face = [muDict objectForKey:[NSString stringWithFormat:@"[/%i]",k]];
                button_face.tag = k+1000;
                
                [button_face setImage:image_face forState:UIControlStateNormal];
                [button_face addTarget:self action:@selector(selectFace:) forControlEvents:UIControlEventTouchUpInside];
                [faceButtonView1 addSubview:button_face];
                k++;
            }
        }
        [faceScrollView addSubview:faceButtonView1];
        
        UIView *faceButtonView2 = [[UIView alloc] initWithFrame:CGRectMake(1*312.f, 0.0f, 312, 186)];
        int l=33;
        for (int i=1; i<=4; i++)
        {
            for (int j=1; j<=8; j++)
            {
                button_face = [UIButton buttonWithType:UIButtonTypeCustom];
                button_face.frame = CGRectMake((j-1)*40, (i-1)*40, 32, 32);
                NSMutableDictionary *muDict = [self.faceArry objectAtIndex:l];
                UIImage *image_face = [muDict objectForKey:[NSString stringWithFormat:@"[/%i]",l]];
                button_face.tag = l+1000;
                
                [button_face setImage:image_face forState:UIControlStateNormal];
                [button_face addTarget:self action:@selector(selectFace:) forControlEvents:UIControlEventTouchUpInside];
                [faceButtonView2 addSubview:button_face];
                l++;
            }
        }
        [faceScrollView addSubview:faceButtonView2];
        
        UIView *faceButtonView3 = [[UIView alloc] initWithFrame:CGRectMake(2*312.f, 0.0f, 312, 186)];
        int m=65;
        for (int i=1; i<=4; i++)
        {
            for (int j=1; j<=8; j++)
            {
                button_face = [UIButton buttonWithType:UIButtonTypeCustom];
                button_face.frame = CGRectMake((j-1)*40, (i-1)*40, 32, 32);
                NSMutableDictionary *muDict = [self.faceArry objectAtIndex:m];
                UIImage *image_face = [muDict objectForKey:[NSString stringWithFormat:@"[/%i]",m]];
                button_face.tag = m+1000;
                
                [button_face setImage:image_face forState:UIControlStateNormal];
                [button_face addTarget:self action:@selector(selectFace:) forControlEvents:UIControlEventTouchUpInside];
                [faceButtonView3 addSubview:button_face];
                m++;
            }
        }
        [faceScrollView addSubview:faceButtonView3];
    }
    return self;
}
-(void)pageControlChange:(id)sender
{
    NSInteger num = pageControl.currentPage;
    CGPoint offset = CGPointMake(num * 312.0f, 0.0f);
    [faceScrollView setContentOffset:offset animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = faceScrollView.contentOffset;
    NSInteger num = offset.x / 312;
    pageControl.currentPage = num;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [pageControl setFrame:CGRectMake(120, 190, 100, 20)];
    faceSendBtn.frame = CGRectMake(240, 180, 70, 30);
    [faceScrollView setFrame:CGRectMake(0, 5, 312, 216-30)];
    
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表情背景" ofType:@"png"]];
    self.backgroundColor = [UIColor colorWithPatternImage:backImg];
}
-(void)selectFace:(id)sender
{
    UIButton * butonSelect =(UIButton *)sender;
    NSMutableDictionary *dic = [self.faceArry objectAtIndex:butonSelect.tag-1000];
    NSArray *array =[dic allKeys];
    NSString *face_String = [NSString stringWithString:[NSString stringWithFormat:@"%@",[array objectAtIndex:0]]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectFace" object:face_String];
}

@end
