//
//  IPAddress.h
//  mamachat
//
//  Created by bourbon on 14-1-8.
//  Copyright (c) 2014年 Bourbon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPAddress : NSObject

- (NSString *)getIPAddress:(BOOL)preferIPv4;
- (NSDictionary *)getIPAddresses;

//获取外网IP
-(NSString*)getIPWithHostName:(const NSString*)hostName;
@end
