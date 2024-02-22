/*---------------------------------------

/--------\  /--------\     /\
|        |  |        |    /  \
|        |  |        |   /    \    |-----
|        |  |--------/  /      \   |
|        |  |          |--------|  \----\
|        |  |          |        |       |
\--------/  |          |        |  -----/

          OBJECTSTREAMER & MAPEDITOR
                VERSION 5.1.1
                 OCMD MODULE

---------------------------------------*/

/*
	OCMD 2.0.0
	by kleinerOpa
	best command-solution for sa:mp
	supports samp 0.2X, 0.3a without OCMD_CHECK_UPDATE function
	supports samp 0.3b, 0.3c
	WEB: www.kleiner-opa.de
	ICQ: 611064955
*/

#include <a_samp>
#if defined OCMD_CHECK_UPDATE
	#tryinclude <a_http>
	#if !defined HTTP
	    #error OCMD_CHECK_UPDATE only works with a_http.inc
	    #undef OCMD_CHECK_UPDATE
	#endif
#endif

forward ocmdOnPlayerCommandText(playerid,cmdtext[]);
#if defined OCMD_BEFORE_CALLBACK
	forward BeforePlayerCommandText(playerid,cmdtext[]);
#endif
#if defined OCMD_CHECK_UPDATE
	forward ocmdCheckUpdate();
	forward ocmdCheckUpdate2(index,response_code,data[]);
#endif

#if defined OCMD_BEFORE_CALLBACK
	new bool:ocmdBeforeCallback;
#endif
#if defined OCMD_BEFORE_CALLBACK || defined OCMD_CHECK_UPDATE
	new bool:ocmdInit;
#endif

#define ocmd:%1(%2) forward ocmd_%1(%2);\
public ocmd_%1(%2)

#define OCMD_VERSION "2.0.0"

public OnPlayerCommandText(playerid,cmdtext[])
{
    #if defined OCMD_BEFORE_CALLBACK || defined OCMD_CHECK_UPDATE
        if(!ocmdInit)
        {
            #if defined OCMD_BEFORE_CALLBACK
                if(funcidx("BeforePlayerCommandText")!=-1)ocmdBeforeCallback=true;
            #endif
            #if defined OCMD_CHECK_UPDATE
				SetTimer("ocmdCheckUpdate",(60*1000),false);
				SetTimer("ocmdCheckUpdate",(60*60*1000),true);
            #endif
            ocmdInit=true;
        }
    #endif
    new ocmdStr[32]="ocmd_",
		i=1,
		#if defined OCMD_COMMAND_LOG
		ocmdName[MAX_PLAYER_NAME],
		#endif
		bool:ocmdNoParams;
	#if defined OCMD_COMMAND_LOG
		GetPlayerName(playerid,ocmdName,sizeof ocmdName);
	    printf("[cmd] [%s]: %s",ocmdName,cmdtext);
	#endif
	#if defined OCMD_BEFORE_CALLBACK
	    if(ocmdBeforeCallback&&!CallLocalFunction("BeforePlayerCommandText","ds",playerid,cmdtext))return 1;
	#endif
	for(;i<128;i++)
	{
	    if(!cmdtext[i]||cmdtext[i]==' ')
	    {
	        if(!cmdtext[i]||!cmdtext[i+1])ocmdNoParams=true;
	        break;
	    }
	    ocmdStr[i+4]=tolower(cmdtext[i]);
	}
	if(!ocmdNoParams&&CallLocalFunction(ocmdStr,"ds",playerid,cmdtext[i+1]))return 1;
	if(ocmdNoParams&&CallLocalFunction(ocmdStr,"ds",playerid," "))return 1;
	return CallLocalFunction("ocmdOnPlayerCommandText","ds",playerid,cmdtext);
}

#if defined OCMD_CHECK_UPDATE
public ocmdCheckUpdate()
{
	HTTP(1,HTTP_GET,"www.kleiner-opa.de/sc/ocmd.txt","","ocmdCheckUpdate2");
}
public ocmdCheckUpdate2(index,response_code,data[])
{
	if(strlen(data)&&strcmp(OCMD_VERSION,data)!=0)
	{
	    new ocmdStr[128];
	    format(ocmdStr,sizeof ocmdStr,"An update for OCMD is available (version %s) - www.kleiner-opa.de",data);
	    print(ocmdStr);
	    for(new i;i<MAX_PLAYERS;i++)if(IsPlayerAdmin(i))SendClientMessage(i,0xD3D3FFFF,ocmdStr);
	}
}
#endif

#define OnPlayerCommandText ocmdOnPlayerCommandText
