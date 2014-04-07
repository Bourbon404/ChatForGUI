#ifndef _SYSDEFINE_H_
#define _SYSDEFINE_H_

#define TRUE  1
#define FALSE 0

#define BUF_SIZE   1024

#define MAX_TRY 3

#define SEND_CHECK 3 //3000
#define RECV_CHECK 30000

#define SERVER_UDP_PORT  4080
#define CLIENT_UDP_PORT  5080
#define SERVER_NAT_PORT  6080

#define MAX_PATH 256
/////////////////////////////////////////////

#define SERVCMD    "servthread"
#define RECVCTRL   "recvthread"
#define SENDCTRL   "sendthread"
#define NAPTCTRL   "naptthread"
#define DISPATCH   "dispaththread"
#define SENDENTFILE	    "sendentfilethread"
#define RECVENTFILE	    "recventfilethread"
#define SENDCHATFILE	"sendchatfilethread"
#define RECVCHATFILE	"recvchatfilethread"


class CSysCenter;
extern CSysCenter g_sysCenter;

#define bufUser   g_sysCenter.GetBufUser() 
#define buftask   g_sysCenter.GetBufTask()
#define bufcache  g_sysCenter.GetBufCache()
#define checkrecv g_sysCenter.GetCheckRecv() 
#define checksend g_sysCenter.GetCheckSend() 


#define servcmd				g_sysCenter.GetWorkerThread(SERVCMD)
#define sendctrl			g_sysCenter.GetWorkerThread(SENDCTRL)
#define dispatch			g_sysCenter.GetWorkerThread(DISPATCH)
#define naptctrl			g_sysCenter.GetWorkerThread(NAPTCTRL)
#define sendentfile			g_sysCenter.GetWorkerThread(SENDENTFILE)
#define recventfile			g_sysCenter.GetWorkerThread(RECVENTFILE)
#define sendchatfile		g_sysCenter.GetWorkerThread(SENDCHATFILE)
#define recvchatfile	    g_sysCenter.GetWorkerThread(RECVCHATFILE)

#endif
