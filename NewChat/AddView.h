//
//  AddView.h
//  mamachat
//
//  Created by bourbon on 13-12-31.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePicker;
}
@property (nonatomic,strong) UIButton *picSelected;
@property (nonatomic,strong) UIButton *picTake;
@property (nonatomic,strong) UIButton *vedioSelected;
@property (nonatomic,strong) UIButton *vedioTake;

@end
