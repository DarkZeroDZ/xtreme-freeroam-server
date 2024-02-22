/*
								Seifalk - Chatbox by Seif
								
				 いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい
					ADD THIS IN YOUR GAMEMODE IF YOU WANT TO FORBID PLAYERS USING COLORS
			い                                                     	 							い
		い                                                              							い
	い                                                                      							い
い                                                                              							い

public OnPlayerText(playerid, text[])
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	new color = GetPlayerColor(playerid);
	if (!IsPlayerAdmin(playerid))
	{
		for(new i = 0; i < strlen(text); i++)
		{
		    if (text[i] == '~')
		    {
		        if (text[i+1] == 'r' || text[i+1] == 'g' || text[i+1] == 'w' || text[i+1] == 'l' || text[i+1] == 'b' || text[i+1] == 'p' || text[i+1] == 'y' || text[i+1] == '>' || text[i+1] == '<')
				{
				    if (text[i+2] == '~') return SendClientText(playerid, 0xFFFFFFFF, "SERVER: You can not color your text."), 0;
				}
			}
		}
	}
	format(text, 256, "%s: ~w~%s", name, text);
	SendClientTextToAll(color, text);
	return 0;
}
*/
/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
//**PRAGMAS**//

//**MISC**//
//native SendClientText(playerid, color, text[]);
//native SendClientTextToAll(color, text[]);
//native Seifalk_OnPlayerConnect(playerid);
//native Seifalk_OnPlayerDisconnect(playerid, reason);
//native Seifalk_OnInit();
//native Seifalk_OnExit();
//native Seifalk_ClearSAMPChat()
/*x---------------------------------Defining-------------------------------------x*/
//**COLORS*//
/*#define GREEN 			0x21DD00FF
#define RED 			0xE60000FF
#define ADMIN_RED 		0xFB0000FF
#define YELLOW 			0xFFFF00FF
#define ORANGE 			0xF97804FF
#define LIGHTRED 		0xFF8080FF
#define LIGHTBLUE 		0x00C2ECFF
#define PURPLE 			0xB360FDFF
#define PLAYER_COLOR 	0xFFFFFFFF
#define BLUE 			0x1229FAFF
#define LIGHTGREEN 		0x38FF06FF
#define DARKPINK 		0xE100E1FF
#define DARKGREEN 		0x008040FF
#define ANNOUNCEMENT 	0x6AF7E1FF
#define COLOR_SYSTEM 	0xEFEFF7AA
#define GREY 			0xCECECEFF
#define PINK 			0xD52DFFFF
#define DARKGREY    	0x626262FF
#define AQUAGREEN   	0x03D687FF
#define NICESKY 		0x99FFFFAA
#define WHITE 			0xFFFFFFFF*/
//**MISC**//
#define MAX_TEXTS       			20
#define MAX_ERASED_SAMPMESSAGES     10
//**VARIABLES**//
new TextInBox[MAX_PLAYERS][MAX_TEXTS][256];
new TextColor[MAX_TEXTS];
new Text:TextdrawInBox[MAX_PLAYERS][MAX_TEXTS];
new Float:ChatBoxX = 16.000000;
new Float:ChatBoxY = 120.000000;
// **FORWARDS** //
forward Seifalk_ClearSAMPChat();
forward Seifalk_MakeChatBox(id, Float:x, Float:y);
forward Seifalk_OnInit();
forward Seifalk_OnExit();
forward Seifalk_OnPlayerConnect(playerid);
forward Seifalk_OnPlayerDisconnect(playerid, reason);
/*x---------------------------------CallBacks-------------------------------------x*/
public Seifalk_OnPlayerConnect(playerid)
{
    Seifalk_ClearSAMPChat();
	for(new i = 0; i < MAX_TEXTS; i++) SendClientText(playerid, 0xFFFFFFFF, " ");
	for(new i = 0; i < MAX_TEXTS; i++) TextDrawShowForPlayer(playerid, TextdrawInBox[playerid][i]);
	return 1;
}

public Seifalk_OnPlayerDisconnect(playerid, reason)
{
    for(new i = 0; i < MAX_TEXTS; i++) TextDrawHideForPlayer(playerid, TextdrawInBox[playerid][i]);
	return 1;
}

public Seifalk_OnInit()
{
    for(new i = 0; i < MAX_TEXTS; i++)
	{
	    Seifalk_MakeChatBox(i, ChatBoxX, ChatBoxY);
	    ChatBoxY -= 6.000000;
	    //printf("%f",ChatBoxY);
	}
	
	SetTimer("Seifalk_ClearSAMPChat",60000, 1);
}

public Seifalk_OnExit()
{
    for(new p = 0; p < MAX_PLAYERS; p++)
	{
		for(new i = 0; i < MAX_TEXTS; i++) TextDrawDestroy(TextdrawInBox[p][i]);
	}
}

public Seifalk_ClearSAMPChat()
{
    for(new i = 0; i < MAX_ERASED_SAMPMESSAGES; i++) SendClientMessageToAll(0xFFFFFFFF, " ");
}

public Seifalk_MakeChatBox(id, Float:x, Float:y)
{
    for(new playerid = 0; playerid < GetMaxPlayers(); playerid++)
	{
	    TextdrawInBox[playerid][id] = TextDrawCreate(x, y, " ");
		TextDrawUseBox(TextdrawInBox[playerid][id],0);
		TextDrawBoxColor(TextdrawInBox[playerid][id],0x000000ff);
		TextDrawTextSize(TextdrawInBox[playerid][id],612.000000,-150.000000);
		TextDrawAlignment(TextdrawInBox[playerid][id],0);
		TextDrawBackgroundColor(TextdrawInBox[playerid][id],0x000000ff);
		TextDrawFont(TextdrawInBox[playerid][id],1);
		TextDrawLetterSize(TextdrawInBox[playerid][id],0.250000,0.750000);
		TextDrawColor(TextdrawInBox[playerid][id],0xFFFFFFFF);
		TextDrawSetOutline(TextdrawInBox[playerid][id],1);
		TextDrawSetProportional(TextdrawInBox[playerid][id],1);
		TextDrawSetShadow(TextdrawInBox[playerid][id],1);

		TextColor[id] = 0xFFFFFFFF;
		strmid(TextInBox[playerid][id], " ", 0, strlen(" "), 128);
	}
}

stock SendClientText(playerid, color, text[])
{
	for(new t = MAX_TEXTS-1; t > 0; t--)
	{
	    TextDrawSetString(TextdrawInBox[playerid][t], TextInBox[playerid][t-1]);
    	strmid(TextInBox[playerid][t], TextInBox[playerid][t-1], 0, strlen(TextInBox[playerid][t-1]), 128);
    	TextColor[t] = TextColor[t-1];
    	TextDrawColor(TextdrawInBox[playerid][t], TextColor[t]);
    	TextDrawShowForPlayer(playerid, TextdrawInBox[playerid][t]);
	}
	TextDrawColor(TextdrawInBox[playerid][0], color);
	TextDrawSetString(TextdrawInBox[playerid][0], text);
    strmid(TextInBox[playerid][0], text, 0, strlen(text), 128);
    TextColor[0] = color;
    TextDrawShowForPlayer(playerid, TextdrawInBox[playerid][0]);
    return 1;
}

stock SendClientTextToAll(color, text[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i)) SendClientText(i, color, text);
	}
}
