#ifndef _SYSUTILS_H_
#define _SYSUTILS_H_

#include "../include/SysInc.h"

#define PACKACK(p, ackb, arr) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->ack = ackb; \
		header->arrive = arr; \
	}

#define PACKLEN(p, len) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->len = len; \
	}

#define PACKSUM(p, sum) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->checkSum = sum; \
	}

#define PACKCMD(p, cmd) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->cmdId = cmd; \
	} 

#define PACKUSER(p, sender, recver) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->senderId = sender;  \
		header->recverId = recver; \
	} 
	
#define PACKSEQSUM(p, num) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->seqnum = num; \
	}

#define PACKDATADESC(p, data) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->datadesc = data;  \
	}

#define PACKCMDUSER(p, cmd, sender, recver) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		header->cmdId = cmd; \
		header->senderId = sender;  \
		header->recverId = recver; \
	}

#define PACKADDR(p, addr, port) \
	{ \
		p->peer.sin_family = AF_INET; \
		p->peer.sin_port = htons(port);  \
		p->peer.sin_addr.s_addr = htonl(addr);  \
	}

#define PACKBUFADDR(p, pa) 	(p->peer = pa->peer)

//////////////////////////////////////////////////
#define PARSESENDER(p, sender) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		sender = header->senderId;  \
	} 

#define PARSECMD(p, cmd) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		cmd = header->cmdId;  \
	}

#define PARSELEN(p, nLen) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		nLen = header->len;  \
	}

#define PARSEACK(p, flag) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		flag = (header->ack == 1);  \
	}

#define PARSESEQSUM(p, num) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		num = header->seqnum;  \
	}

#define PARSEUSER(p, sender, recver) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		sender = header->senderId;  \
		recver = header->recverId; \
	}

#define PARSEDATADESC(p, data) \
	{ \
		PBYTE buf = (PBYTE)p->payload; \
		PPackHeader header = (PPackHeader)buf; \
		data = header->datadesc;  \
	}

//////////////////////////////////////////////////
void WriteLog(const char* format, ...);

void CalcBufLen(PMsgbuf pBuf);
SBOOL DoCheckSum(PMsgbuf pBuf);
void CheckSumVal(PMsgbuf pBuf);
USHORT Checksum(USHORT* buf, int size);


//int CreateServSocket();
void InitUserCtrl(PUserCtrl user);
void InitFriendCtrl(PFriendCtrl pFriend);
void InitFriendGroupCtrl(PFriendGroupCtrl pFriendGroup);

#endif
