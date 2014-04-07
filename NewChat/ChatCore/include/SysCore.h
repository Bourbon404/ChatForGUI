#ifndef _SYSCORE_H_
#define _SYSCORE_H_

#define ROWID_LENGTH 19

///////////////////////////////////
typedef enum
{
	USER_TASK,
	FRIEND_TASK,
	GROUP_TASK,
	TEXTMSG_TASK,
	FILEMSG_TASK,

	ENTFILE_TASK,

	VISPRODFILE_TASK,
	VISUSERFILE_TASK,
	VISUSERENT_TASK,

	INQDETAIL_TASK,
	INQPRODFILE_TASK,
	INQPRICEMSG_TASK,
	INQPRODPRI_TASK,

} TaskType;

typedef struct _PushTask
{
	UINT     bufNo;
	TaskType type;
	void*    taskData;
	BOOL     isPush;
} PushTask, *PPushTask;

/////////////////////////////////////////////////////////
//′?·??-?3?è????
typedef struct _XPoint 
{
	double Lng;
	double Lat;
}XPoint, *PXPoint;

//存放基站信息
typedef struct _BaseStaion
{
    XPoint center;  
    double r; 
	string RSSI;    //信号强度
	string Cid;
	string Lac;
}BaseStaion, *PBaseStaion;

typedef struct _PosUserInfo
{
	XPoint pt;
	int size;
	BaseStaion lbs[3];
}PosUserInfo, *PPosUserInfo;

#define PosUserInfoSize sizeof(PosUserInfo)

//////////////////////////////////////////////////////
typedef struct _UserInfo
{
	UINT   nUserId;
	string strUserName;
	
	
	string strNickName;
	
	CTime  tmLastTime;	
	string strSignature;

	string strFileName;
	string strFilePath;
} UserInfo, *PUserInfo;

typedef struct _UserNet
{
	UINT nSeqNum;

	UINT nInetAddr;  //主机字节序
	UINT nInetPort;  //主机字节序
	
	UINT nLocalAddr;
	UINT nLocalMask;
	UINT nLocalPort;

	BOOL bOnline;
	BOOL bPushTask;
	CTime lastSend;

	BOOL bNatOk;
} UserNet, *PUserNet;

typedef struct _UserCtrl
{
	UserInfo userInfo;
	
	UserNet  netStatus;

 	PosUserInfo stPosInfo;
	
} UserCtrl, *PUserCtrl;


typedef struct _FriendCtrl
{
	string strRowid;

	UINT nFriendId;
	UINT nUserId;  
	UINT nFriendUserId;
	UINT nGroupId;
	string strNoteName;
} FriendCtrl, *PFriendCtrl;


typedef struct _FriendGroupCtrl
{
	string strRowid;
	
	UINT nGroupId;
	UINT nUserId;
	string strGroupName;
} FriendGroupCtrl, *PFriendGroupCtrl;

typedef struct _ChatTextMsg
{
	UINT senderId;
	UINT recverId;
	CTime sendTime;
	string strMsg;
} ChatTextMsg, *PChatTextMsg;

typedef struct _ChatFileMsg
{
	UINT senderId;
	UINT recverId;
	CTime sendTime;
	string strFileName;
	string strFilePath;
} ChatFileMsg, *PChatFileMsg;

/////////////////////////////////////////
typedef struct _VisitorCtrl
{
	UINT nVisitorId;

	UINT nSelfId;   
	UINT nUserId; 

	string userName;
	UINT   nGender;

	string browseTime;
	
	string userPlace;
	
	BOOL   bIsCheck;
	string fileName;
	string filePath;  
} VisitorCtrl, *PVisitorCtrl;

typedef struct _VisitorDetailCtrl
{
	UINT nVisitorId;
	UINT nProductId;
	
	string fileName;
	string filePath;  
} VisitorDetailCtrl, *PVisitorDetailCtrl;

typedef struct _InquiryCtrl
{
	UINT inquiryId;
	
	UINT selfId;
	UINT userId;
	UINT shopId;
	
	string orderCode;
	string userName;	
	string userPlace;
	
	string fileName;
	string filePath;  
} InquiryCtrl, *PInquiryCtrl;

typedef struct _InquiryMsgCtrl
{
	UINT nInquiryId;
	string msg;
	BOOL bIsSelf;
	string inquiryTime;
} InquiryMsgCtrl, *PInquiryMsgCtrl;

typedef struct _InqOrderDeatilCtrl
{
	UINT nInquiryId;

	UINT nOrderId;
	UINT nProductId;
	
	UINT nBuyerId;
	string productName;
	float nProdSellPrice;

	UINT nProdQty;
	float prodSumPrice;
	string fileName;
	string filePath;  
} InqOrderDeatilCtrl, *PInqOrderDeatilCtrl;

typedef struct _OrderCtrl
{
	string strRowid;

	UINT   nOrderId;
	UINT   nBuyerId;
	string userName;
	string orderTime;
	string userPlace;
	string orderCode;
	UINT   nGoodsSum;
	UINT   nTotalPrice;
	UINT   nIsPay;

	string fileName;
	string filePath;  
} OrderCtrl, *POrderCtrl;

typedef struct _OrderDetailCtrl
{
	UINT inquiryId;
	UINT orderprdid;  //key

	UINT productId;
	UINT buyerId;
	UINT userId;

	string productName;
	string prodSellPrice;
	UINT prodQty;
	string fileName;
	string filePath;  
} OrderDetailCtrl, *POrderDetailCtrl;

typedef struct _PublishCtrl
{
	UINT nPublishId;
	UINT nSelfId;
	UINT nUserId;
	string userName;
	string userPlace;
	UINT   nShopId;
	string shopName;
	string fileName;
	string filePath;  
} PublishCtrl, *PPublishCtrl;

typedef struct _PubProdDetailCtrl
{
	UINT nPublishId;
	UINT nProductId;
	string publishProdTime;

	string fileName;
	string filePath;  
} PubProdDetailCtrl, *PPubProdDetailCtrl; 

typedef struct _PublishShopCtrl
{
	UINT nPublishId;
	UINT nSelfId;
	UINT nUserId;
	string userName;
	string userPlace;
	UINT   nShopId;
	string shopName;

	string fileName;
	string filePath;  
	string shopFileName;
	string shopFilePath;
} PublishShopCtrl, *PPublishShopCtrl;

#endif
