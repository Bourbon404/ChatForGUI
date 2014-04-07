#ifndef _SYSCMD_H_
#define _SYSCMD_H_

//base
#define CMD_ACK					0x0101  
#define CMD_HEARBET				0x0102  

//login
#define CMD_LOGIN				0x0103
#define CMD_LOGRES				0x0104

//chat
#define CMD_TXTMSG				0x0105 
#define CMD_FILEMSG				0x0106

//nat hole
#define CMD_NAT_CHAT			0x0107
#define CMD_NAT_NOTY			0x0108
#define CMD_NAT_TRAN			0x0109

#define CMD_NAT_HOLE			0x0110
#define CMD_NAT_DONE			0x0111

#define CMD_NAT_CALL			0x0112
#define CMD_NAT_CAOK			0x0113

#define CMD_BASEPOS				0x0130
#define CMD_LALGPOS				0x0131

//Lookaround
#define CMD_LOOKUSER			0x0132
#define CMD_LOOKBACK		    0x0133
#define CMD_LOOKDATA		    0x0133
#define CMD_LOOKRESULT			0x0134

//get friend
#define CMD_GETFRIEND			0x0140  
#define CMD_PUSHFRIEND		    0x0141
#define CMD_FRIENDFINISH        0x0142

//push ent
#define CMD_PUSHENTDATA	        0x0155

//client update
#define CMD_UPDATEENT    	    0x0150

//send ent file
#define CMD_ENTFILESEND		    0x0160
#define CMD_ENTFILEBEGIN		0x0161
#define CMD_ENTFILEREADY		0x0162
#define CMD_ENTFILEDATA		    0x0163
#define CMD_ENTFILEFINISH		0x0164

//send chat file
#define CMD_CHATFILESEND		0x0165
#define CMD_CHATFILEBEGIN		0x0166
#define CMD_CHATFILEREADY		0x0167
#define CMD_CHATFILEDATA		0x0168
#define CMD_CHATFILEFINISH		0x0169

#endif