#ifndef _SYSNETENT_H_
#define _SYSNETENT_H_

typedef struct _UserEnt
{
	UINT userId;
	char userName[41];
	
	char nickName[101];
	
	char signature[101];
} UserEnt, *PUserEnt;
#define UserEntSize sizeof(UserEnt)

typedef struct _FriendEnt
{
	UINT nFriendId;
	UINT nUserId;
	UINT nFriendUserId;
	UINT nGroupId;
	char noteName[51];
} FriendEnt, *PFriendEnt;
#define FriendEntSize sizeof(FriendEnt)

typedef struct _FriendGroupEnt
{
	UINT groupId;
	UINT userId;
	char groupName[51];
} FriendGroupEnt, *PFriendGroupEnt;
#define FriendGroupEntSize sizeof(FriendGroupEnt)

typedef struct _VisitorEnt
{
	UINT visitorId;
	
	UINT selfId;
	UINT userId;

	char userName[41];
	UINT gender;

	UINT productId;

	char browseTime[15];
	char userPlace[101];
	
	BOOL isCheck;
} VisitorEnt, *PVisitorEnt;
#define VisitorEnttSize sizeof(VisitorEnt)

// typedef struct _VisitorDetailEnt
// {
// 		UINT visitorId;
// 		UINT productId;
// } VisitorDetailEnt, *PVisitorDetailEnt;
// #define VisitorDetailEntSize sizeof(VisitorDetailEnt)

/////////////////////////////////////////////////////////
typedef struct _InquiryEnt
{
	UINT inquiryId;
	
	UINT selfId;
	UINT userId;
	
	char orderCode[23];
	char userName[41];
	
	char userPlace[101];
} InquiryEnt, *PInquiryEnt;
#define InquiryEntSize sizeof(InquiryEnt)

typedef struct _InquiryMsgEnt
{
	UINT inquiryId;
	char msg[201];
	BOOL isSelf;
	char inquiryTime[15];

} InquiryMsgEnt, *PInquiryMsgEnt;
#define InquiryMsgEntSize sizeof(InquiryMsgEnt)

typedef struct _InqOrderDetailEnt
{
	UINT orderprdid;

	UINT inquiryId;
	UINT productId;
	
	UINT buyerId;
	UINT userId;
	char productName[101];
	char prodSellPrice[52];

	UINT prodQty;
} InqOrderDetailEnt, *PInqOrderDetailEnt;
#define InqOrderDetailEntSize sizeof(InqOrderDetailEnt)

// typedef struct _OrderEnt
// {
// 	UINT OrderId;
// 	UINT BuyerId;
// 	UINT nUserId;
// 	char userName[41];
// 
// 	char orderTime[15];
// 	char userPlace[101];
// 	char orderCode[61];
// 	UINT goodsSum;
// 	UINT totalPrice;
// 	UINT isPay;
// } OrderEnt, *POrderEnt;
// #define OrderEntSize sizeof(OrderEnt)
// 
// /////////////////////////////////////////////
// typedef struct _OrderDetailEnt
// {
// 	UINT orderId;
// 	UINT productId;
// 	UINT buyerId;
// 	UINT userId;
// 	char productName[101];
// 	char prodSellPrice[52];
// 	UINT prodQty;
// } OrderDetailEnt, *POrderDetailEnt;
// #define OrderDetailEntSize sizeof(OrderDetailEnt)
// 
// typedef struct _PublishEnt
// {
// 	UINT publishId;
// 	UINT selfId;
// 	UINT userId;
// 	char userName[41];
// 	char userPlace[201];
// 	UINT shopId;
// 	char shopName[101];
// } PublishEnt, *PPublishEnt;
// #define PublishEntSize sizeof(PublishEnt)
// 
// typedef struct _PublishProdEnt
// {
// 	UINT publishId;
// 	UINT productId;
// 	char publishTime[15];
// } PublishProdEnt, *PPublishProdEnt; 
// #define PublishProdEntSize sizeof(PublishProdEnt)
// 
// typedef struct _PublishShopEnt
// {
// 	UINT publishId;
// 	UINT selfId;
// 	UINT userId;
// 	char userName[41];
// 	char userPlace[101];
// 
// 	UINT shopId;
// 	char shopName[101];
// } PublishShopEnt, *PPublishShopEnt;
// #define PublishShopEntSize sizeof(PublishShopEnt)

#endif
