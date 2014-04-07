#ifndef _SYSNETUSE_H_
#define _SYSNETUSE_H_

typedef struct _UserLogin
{
	UINT nUserId;
	char userName[41];
	char password[36];
	UINT localAddr;     //¿Í»§¶ËµØÖ· Ö÷»ú×Ö½ÚÐò
	UINT localMask;     //¿Í»§¶ËÑÚÂë Ö÷»ú×Ö½ÚÐò
	UINT localPort;     //¿Í»§¶Ë¶Ë¿Ú Ö÷»ú×Ö½ÚÐò
	BOOL bGetFriend;
} UserLogin, *PUserLogin;
#define UserLoginSize sizeof(UserLogin)


typedef struct _LoginRes
{
	UINT nUserId;
	int  loginRes;  
	char userName[41];
	BOOL bGetFriend;
} LoginRes, *PLoginRes;
#define LoginResSize sizeof(LoginRes)


typedef struct _StaionInfo
{
	char RSSI[6];    //ÐÅºÅÇ¿¶È
	char Cid[15];
	char Lac[15];
} StaionInfo, *PStaionInfo;
#define StaionInfoSize sizeof(StaionInfo)

typedef struct _UserStaion
{
	UINT nUserId;
	int size;
	StaionInfo lbs[3];
}UserStaion, *PUserStaion;
#define UserStaionSize sizeof(UserStaion)


typedef struct _UserPostion
{
	UINT nUserId;
	XPoint pt;	
} UserPostion, *PUserPostion;
#define UserPosSize sizeof(UserPostion)


///////////////////////////////////////////////////

typedef struct _TextMsg
{
	int len;     //max len 520
	char msg[1];
} TextMsg, *PTextMsg;
#define TextMsgSize sizeof(TextMsg)


///////////////////////////////////////////////////
typedef struct _ChatFileData
{
	UINT toUserId;
	char fileName[51];
	UINT  size;
	PBYTE data;
} ChatFileData, *PChatFileData;
#define ChatFileDataSize sizeof(ChatFileData)

typedef struct _ChatBeginFile
{
	UINT fromUserId;
	UINT toUserId;
	UINT fileNo;
	UINT totSize;
	char fileName[51];
} ChatBeginFile, *PChatBeginFile;
#define ChatBeginFileSize sizeof(ChatBeginFile)

typedef struct _FileFlagData
{
	UINT fromUserId;
	UINT toUserId;
	UINT fileNo;
} FileFlagData, *PFileFlagData;
#define FileFlagDataSize sizeof(FileFlagData)

typedef struct _ChatFileHeader
{
	UINT fromUserId;
	UINT toUserId;
	UINT fileNo;
	UINT begin;
	UINT size;
} ChatFileHeader, *PChatFileHeader;
#define ChatFileHeaderSize sizeof(ChatFileHeader)


///////////////////////////////////////////////////
typedef struct _EntFileData
{
	UINT toUserId;
	UINT entId;
	UINT fileType;
	UINT fileNo;
	UINT totSize;
	EntType type;
	char fileName[51];
	char filePath[301];
} EntFileData, *PEntFileData;
#define EntFileDataSize sizeof(EntFileData)

typedef struct _EntBeginFile
{
	UINT toUserId;
	UINT entId;
	UINT fileType;
	EntType entType;
	UINT fileNo;
	UINT totSize;
	char fileName[51];
} EntBeginFile, *PEntBeginFile;
#define EntBeginFileSize sizeof(EntBeginFile)

typedef struct _EntFileFlag
{
	UINT toUserId;
	UINT fileNo;
} EntFileFlag, *PEntFileFlag;
#define EntFileFlagSize sizeof(EntFileFlag)

typedef struct _EntFileHeader
{
	UINT toUserId;
	UINT fileNo;
	UINT begin;
	UINT size;
} EntFileHeader, *PEntFileHeader;
#define EntFileHeaderSize sizeof(EntFileHeader)



///////////////////////////////////////////////////

typedef struct _LookUserBegin
{
	int totSize;
} LookUserBegin, *PLookUserBegin;
#define LookUserBeginSize sizeof(LookUserBegin)

///////////////////////////////////////////////////

#endif
