//
//  AddView.m
//  mamachat
//
//  Created by bourbon on 13-12-31.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import "AddView.h"

@implementation AddView
@synthesize picSelected,picTake,vedioSelected,vedioTake;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        picSelected = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [picSelected setBackgroundColor:[UIColor clearColor]];
        [picSelected setTitle:@"相片" forState:(UIControlStateNormal)];
        [picSelected setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [picSelected addTarget:self action:@selector(clickPicSelected:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:picSelected];
        
        picTake = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [picTake setBackgroundColor:[UIColor clearColor]];
        [picTake setTitle:@"照相" forState:(UIControlStateNormal)];
        [picTake setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [picTake addTarget:self action:@selector(clickPicTake:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:picTake];
        
        vedioSelected = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [vedioSelected setBackgroundColor:[UIColor clearColor]];
        [vedioSelected setTitle:@"视频选择" forState:(UIControlStateNormal)];
        [vedioSelected setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:vedioSelected];
        
        vedioTake = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [vedioTake setBackgroundColor:[UIColor clearColor]];
        [vedioTake setTitle:@"视频录像" forState:(UIControlStateNormal)];
        [vedioTake setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:vedioTake];
        
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [picTake setFrame:CGRectMake(5, 5, 60, 60)];
    [picSelected setFrame:CGRectMake(70, 5, 60, 60)];
    [vedioTake setFrame:CGRectMake(135, 5, 60, 60)];
    [vedioSelected setFrame:CGRectMake(210, 5, 60, 60)];
    //设置背景
    UIImage *backImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"表情背景" ofType:@"png"]];
    self.backgroundColor = [UIColor colorWithPatternImage:backImg];
}
-(void)clickPicTake:(id)sender
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TakePic" object:imagePicker];
}
-(void)clickPicSelected:(id)sender
{
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedPic" object:imagePicker];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage *original = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImageWriteToSavedPhotosAlbum(original, self, nil, nil);
    }
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PicSelected" object:image];
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
