#ifndef _SYSSTRUCT_H
#define _SYSSTRUCT_H

struct Msgbuf
{
	UINT   len;   //数据长度
	UINT   ptr;   //当前数据指针
	DWORD  time;  //发送时间
	UINT   times; //发送次数
	void*  task;
	
	void*  payload;
	
	sockaddr_in peer;
};
typedef Msgbuf *PMsgbuf;

typedef struct _PackHeader
{
	UINT ack : 4;        //是否需要ACK
	UINT arrive : 4;     //必须到达
	UINT datadesc : 8;   
	UINT len : 16;       //数据包长度
	UINT seqnum;         //用来唯一标识同一个数据源发出的每个数据包
	UINT senderId;       //发送用户Id
	UINT recverId;       //接收用户Id
	UINT cmdId : 16;     //数据包的指令
	UINT checkSum : 16;  //数据包的CheckSum
} PackHeader, *PPackHeader;

#define PackHeaderSize sizeof(PackHeader)


// Entity
typedef enum
{
	E_USERINFO = 1,
	E_USERFRIEND,
	E_FRIENDGROUP,

	E_VISTORENT,

	E_INQPRICE,
	E_INQPRICEMSG,
	E_INQDETAIL,
} EntType;


#endif
