//
//  ChatDefine.h
//  ChatCore
//
//  Created by bourbon on 14-1-6.
//  Copyright (c) 2014年 bourbon. All rights reserved.
//

#ifndef _ChatDefine_H_
#define _ChatDefine_H_

typedef enum EntityType : NSUInteger
{
    USER_ENT = 1,    
    FRIEND_ENT,
    GROUP_ENT,
    
    VISTOR_ENT,    
 
    INQUIRY_ENT,
    INQUIRYMSG_ENT,
    INQUIRYORDERDETAIL_ENT,
    
    ORDER_ENT,
    ORDERDETAIL_ENT,

    MESSAGE_ENT,
    
    RECENT_ENT,
} EntityType;

#define MSGTYPE "type"
#define MSGSIZE "size"
#define MSGDATA "buf"

#define MSGCENTERNAME "chatcore"

#define DATA_MSG    0
#define ACTION_MSG  1

#define EXIT_ACT    0x100
#define LOGIN_ACT   0x101
#define FRIEND_ACT  0x102

#define SENDMSG_ACT   0x108
#define RECVMSG_ACT   0x109
#define RECVFILE_ACT  0x120

//////////////////////////////
#define DATA_NEWUPD 0
#define DATA_DELETE 1

//////////////////////////////
#define DATA_NEWUPD 0
#define DATA_DELETE 1

#endif
