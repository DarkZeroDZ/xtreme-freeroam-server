/*  Object Streamer
 *
 *  (c) Copyright 2009, Einstein
 *  Thx here also to Trivial
 */

#define MAX_STREAM_OBJECTS 10000
#define MAX_STREAM_AT_SAME_TIME 142
#define MAXUPDATES 13

forward ObjectCheck(playerid);

new ObjectCount[MAX_PLAYERS];
new haveobject[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new ID;
new modelid2[MAX_STREAM_OBJECTS];
new Float:x2[MAX_STREAM_OBJECTS];
new Float:y2[MAX_STREAM_OBJECTS];
new Float:z2[MAX_STREAM_OBJECTS];
new Float:rX2[MAX_STREAM_OBJECTS];
new Float:rY2[MAX_STREAM_OBJECTS];
new Float:rZ2[MAX_STREAM_OBJECTS];
new ViewDistance2[MAX_STREAM_OBJECTS];
new Float:MoveX2[MAX_STREAM_OBJECTS];
new Float:MoveY2[MAX_STREAM_OBJECTS];
new Float:MoveZ2[MAX_STREAM_OBJECTS];
new Float:MoveSpeed2[MAX_STREAM_OBJECTS];
new moved[MAX_STREAM_OBJECTS];
new objectres[MAX_PLAYERS][MAX_STREAM_OBJECTS];
new Float:playerpos2[MAX_PLAYERS][3];
new updatespassed[MAX_PLAYERS] = 0;

//From the Samp Forums: Usual Functions

stock IsPlayerInBall(playerid,Float:x,Float:y,Float:z,radius)
	{
	if(GetPlayerDistanceToPoint(playerid,x,y,z) < radius)
		{
		return 1;
		}
	return 0;
}

stock GetPlayerDistanceToPoint(playerid,Float:x,Float:y,Float:z)
	{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(Float:x,x1)),2)+floatpower(floatabs(floatsub(Float:y,y1)),2)+floatpower(floatabs(floatsub(Float:z,z1)),2));
	return floatround(tmpdis);
	}		

//ObjectStreamer Functions
stock CreateObjectToStream(modelid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ)
	{
	modelid2[ID] = modelid;
	x2[ID] = Float:x;
	y2[ID] = Float:y;
	z2[ID] = Float:z;
	rX2[ID] = Float:rX;
	rY2[ID] = Float:rY;
	rZ2[ID] = Float:rZ;
	ViewDistance2[ID] = 142;
	ID++;
	return ID-1;
	}

stock CreatePlayerObjectToStream(playerid ,modelid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ) //untested
	{
	modelid2[ID] = modelid;
	x2[ID] = Float:x;
	y2[ID] = Float:y;
	z2[ID] = z;
	rX2[ID] = rX;
	rY2[ID] = rY;
	rZ2[ID] = rZ;
	ViewDistance2[ID] = 142;
	ID++;
	for(new i=0; i<YOUPLAYERSLOTS; i++)
		{
		haveobject[i][ID] = -1;
		}
	haveobject[playerid][ID] = 0;	
	return ID-1;
	}

stock DestroyObjectToStream(streamobjectid)
	{
	modelid2[streamobjectid] = 0;
	x2[streamobjectid] = 0;
	y2[streamobjectid] = 0;
	z2[streamobjectid] = -1000;
	rX2[streamobjectid] = 0;
	rY2[streamobjectid] = 0;
	rZ2[streamobjectid] = 0;
	ViewDistance2[streamobjectid] = 0;
	for(new i=0; i<YOUPLAYERSLOTS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			DestroyPlayerObject(i, objectres[i][streamobjectid]);
			}
		haveobject[i][streamobjectid] = -1;
		}
	}

stock DestroyPlayerObjectToStream(playerid, streamobjectid) //untested
	{
	modelid2[streamobjectid] = 0;
	x2[streamobjectid] = 0;
	y2[streamobjectid] = 0;
	z2[streamobjectid] = -1000;
	rX2[streamobjectid] = 0;
	rY2[streamobjectid] = 0;
	rZ2[streamobjectid] = 0;
	ViewDistance2[streamobjectid] = 0;
	if(haveobject[playerid][streamobjectid] == 1)
		{
		DestroyPlayerObject(playerid, objectres[playerid][streamobjectid]);
		}
	haveobject[playerid][streamobjectid] = -1;
	}
			
stock MoveObjectToStream(streamobjectid, Float:Movex, Float:Movey, Float:Movez, Float:Speed)
	{
	MoveX2[streamobjectid] = Movex;
	MoveY2[streamobjectid] = Movey;
	MoveZ2[streamobjectid] = Movez;
	MoveSpeed2[streamobjectid] = Speed;
	moved[streamobjectid] = 1;
	for(new i=0; i<YOUPLAYERSLOTS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			MovePlayerObject(i, objectres[i][streamobjectid], MoveX2[streamobjectid], MoveY2[streamobjectid], MoveZ2[streamobjectid], MoveSpeed2[streamobjectid]);
			}
		}	
	}
	
stock StopObjectToStream(streamobjectid)
	{
	for(new i=0; i<YOUPLAYERSLOTS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			StopPlayerObject(i, objectres[i][streamobjectid]);
			}
		}	
	}	

stock GetBasePosObjectToStream(streamobjectid, &Float:x, &Float:y, &Float:z) //untested
	{
	x = x2[streamobjectid];
	y = y2[streamobjectid];
	z = z2[streamobjectid];
	}

stock GetMovePosObjectToStream(stramobjectid, &Float:x, &Float:y, &Float:z) //untested
	{
	x = MoveX2[streamobjectid];
	y = MoveY2[streamobjectid];
	z = MoveZ2[streamobjectid];
	}

stock GetCurrentPosObjectToStream(streamobjectid, &Float:x, &Float:y, &Float:z) //untested
	{
	if(moved[streamobjectid] == 0)
		{
		x = x2[streamobjectid];
		y = y2[streamobjectid];
		z = z2[streamobjectid];	
		}
	else if(moved[streamobjectid] == 1)
		{
		x = MoveX2[streamobjectid];
		y = MoveY2[streamobjectid];
		z = MoveZ2[streamobjectid];
		}
	}

stock GetCurrentRotObjectToStream(streamobjectid, &Float:Rx, &Float:Ry, &Float:Rz) //untested
	{
	Rx = rX2[streamobjectid];
	Ry = rY2[streamobjectid];
	Rz = rZ2[streamobjectid];
	}	
	
stock SetObjectPosToStream(streamobjectid, Float:x, Float:y, Float:z)
	{
	for(new i=0; i<YOUPLAYERSLOTS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			SetPlayerObjectPos(i, objectres[i][streamobjectid], x, y, z);
			}
		}
	x2[streamobjectid] = x;
	y2[streamobjectid] = y;
	z2[streamobjectid] = z;
	}

stock SetObjectRotToStream(streamobjectid, Float:rX, Float:rY, Float:rZ)
	{
	for(new i=0; i<YOUPLAYERSLOTS; i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{							
			SetPlayerObjectRot(i, objectres[i][streamobjectid], rX, rY, rZ);
			}
		}
	rX2[streamobjectid] = Float:rX;
	rY2[streamobjectid] = Float:rY;
	rZ2[streamobjectid] = Float:rZ;
	}

stock SetObjectViewDistanceToStream(streamobjectid, Viewdistance)
	{
	ViewDistance2[streamobjectid] = Viewdistance;
	}
	
stock SetGloabalViewDistanceToStream(Viewdistance)
	{
	for(new Objects=0; Objects<ID; Objects++)
		{
		ViewDistance2[Objects] = Viewdistance;
		}
	}

stock SetObjectViewDistanceToStreamEx(streamobjectidMIN, streamobjectidMAX, Viewdistance)
	{
	for(new Objects=streamobjectidMIN; Objects<streamobjectidMAX; Objects++)
		{
		ViewDistance2[Objects] = Viewdistance;
		}
	}

stock HavePlayerObjectToStream(playerid,streamobjectid)
	{
	if(haveobject[playerid][streamgateid] == 1)
		{
		return 0;
		}
	else if(haveobject[playerid][streamobjectid] == 0)
		{
		return 1;
		}
	}
	
stock HavePlayerAnyObjectToStream(playerid)
	{
	for(new object=0; object<ID; object++)
		{
		if(haveobject[playerid][object] == 1)
			{
			return 0;
			}
		}
	return 1;
	}					

stock HaveObjectAnyPlayerToStream(streamobjectid) //untested
	{
	for(new i=0; i<YOUPLAYERSLOTS< i++)
		{
		if(haveobject[i][streamobjectid] == 1)
			{
			return 0;
			}
		}
	return 1;
	}		
						
					
stock StreamObject_OnPlayerUpdate(playerid)
	{
           updatespassed++;
	if( updatespassed == MAXUPDATES)
	{
		ObjectCheck(playerid);
		updatespassed = 0;
	}
	}
	
stock StreamObject_OnPlayerDisconnect(playerid)
	{
	for(new k=0; k<ID; k++)
		{
		haveobject[playerid][k] = 0; 
		objectres[playerid][k] = -1;
		
		}
	ObjectCount[playerid] = 0; //untested
	}

public ObjectCheck(playerid)
	{
	new Float:playerx, Float:playery, Float:playerz;
	GetPlayerPos(playerid, playerx, playery, playerz);
	if(playerpos2[playerid][0] != playerx || playerpos2[playerid][1] != playery || playerpos2[playerid][2] != playerz)
		{
		playerpos2[playerid][0] = playerx;
		playerpos2[playerid][1] = playery;
		playerpos2[playerid][2] = playerz;		
		for(new objects=0; objects<ID; objects++)
			{
			if(IsPlayerInBall(playerid,x2[objects], y2[objects], z2[objects], ViewDistance2[objects]))
				{
				if(ObjectCount[playerid] < MAX_STREAM_AT_SAME_TIME)
					{
					if(haveobject[playerid][objects] == 0)
						{
						if(moved[objects] == 0)
							{
							objectres[playerid][objects] = CreatePlayerObject(playerid, modelid2[objects], x2[objects], y2[objects], z2[objects], rX2[objects], rY2[objects], rZ2[objects]);
							ObjectCount[playerid]++;
							haveobject[playerid][objects] = 1;
							}
						else if(moved[objects] == 1)
							{
							objectres[playerid][objects] = CreatePlayerObject(playerid, modelid2[objects], MoveX2[objects], MoveY2[objects], MoveZ2[objects], rX2[objects], rY2[objects], rZ2[objects]);
							ObjectCount[playerid]++;
							haveobject[playerid][objects] = 1;
							}
						}
					}
				} 
			else
				{
				if(haveobject[playerid][objects] == 1)
					{
					DestroyPlayerObject(playerid, objectres[playerid][objects]);
					ObjectCount[playerid]--;
					haveobject[playerid][objects] = 0;
					}
				}
			}
		}	
	return 1;
	}