#include <a_samp>

#define DISTANCE 600.0
#define MAX_ICONS 100
#define INVALID_ICON_ID -1
#define ICON 1
#define MAX_PLAYER_UPDATES 45

new Float:IconPos[MAX_ICONS][3];
new IconModel[MAX_ICONS];
new IconColor[MAX_ICONS];
new IconActive[MAX_ICONS];
new Slot[MAX_PLAYERS][MAX_ICONS];
new SlotUsed[MAX_PLAYERS][128];
new IconCount[MAX_PLAYERS];
new PlayerUpdates[MAX_PLAYERS];

forward CreateMapIcon(modelid,color,Float:x,Float:y,Float:z);
public CreateMapIcon(modelid,color,Float:x,Float:y,Float:z)
{
        for(new i=0;i<MAX_ICONS;i++)
        {
                if(!IconActive[i])
                {
                        IconPos[i][0]=x;
                        IconPos[i][1]=y;
                        IconPos[i][2]=z;
                        IconModel[i]=modelid;
                        IconColor[i]=color;
                        IconActive[i]=true;
                        return i;
                }
        }
        print("[mapicon] Erstellen von Mapicon fehlgeschlagen!");
        return INVALID_ICON_ID;
}

forward DestroyMapIcon(id);
public DestroyMapIcon(id)
{
        if(!IconActive[id]) return 0;

        IconActive[id]=false;
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(IsPlayerConnected(i) && Slot[i][id]!=INVALID_ICON_ID)
            {
                RemovePlayerMapIcon(i,Slot[i][id]);
                SlotUsed[i][Slot[i][id]]=false;
                Slot[i][id]=INVALID_ICON_ID;
                IconCount[i]--;
            }
        }
        return 1;
}

forward StreamIcons(playerid);
public StreamIcons(playerid)
{
    new s;
    if(IsPlayerConnected(playerid))
    {
        for(new i=0;i<MAX_ICONS;i++)
        {
            if(IconActive[i])
            {
                if(IsPlayerInRangeOfPoint(playerid,DISTANCE,IconPos[i][0],IconPos[i][1],IconPos[i][2]))
                {
                    if(Slot[playerid][i]==INVALID_ICON_ID)
                    {
                        s=GetFreeSlot(playerid);
                        if(IconCount[playerid]<128 && s!=INVALID_ICON_ID)
                        {
                            SetPlayerMapIcon(playerid,s,IconPos[i][0],IconPos[i][1],IconPos[i][2],IconModel[i],IconColor[i]);
                            SlotUsed[playerid][s]=true;
							Slot[playerid][i]=s;
                            IconCount[playerid]++;
                        }
                    }
                }
                else
                {
                    if(Slot[playerid][i]!=INVALID_ICON_ID)
                    {
                        RemovePlayerMapIcon(playerid,Slot[playerid][i]);
                        SlotUsed[playerid][Slot[playerid][i]]=false;
                        Slot[playerid][i]=INVALID_ICON_ID;
                        IconCount[playerid]--;
                    }
                }
            }
        }
		return 1;
    }
  	return 0;
}

stock GetFreeSlot(playerid)
{
	for(new i=0;i<128;i++)
	    if(!SlotUsed[playerid][i])
	        return i;
	return INVALID_ICON_ID;
}

DOI_OnPlayerUpdate(playerid)
{
	PlayerUpdates[playerid]++;
	if(PlayerUpdates[playerid]>=MAX_PLAYER_UPDATES)
	{
		PlayerUpdates[playerid]=0;
		StreamIcons(playerid);
	}
}

DOI_OnPlayerConnect(playerid)
{
        for(new i=0;i<MAX_ICONS;i++)
            Slot[playerid][i]=INVALID_ICON_ID;
		for(new i=0;i<128;i++)
		    SlotUsed[playerid][i]=false;
        IconCount[playerid]=0;
}