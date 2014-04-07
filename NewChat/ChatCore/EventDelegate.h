//
//  EventDelegate.h
//  ChatCore
//
//  Created by Bourbon on 13-12-13.
//  Copyright (c) 2013年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventDelegate <NSObject>
-(void)DoEventData: (NSMutableData*)buf bufsize: (int)nSize;
-(void)DoEventAction: (NSMutableData*)buf bufsize: (int)nSize;
@end
