#include <a_samp>

/*
native TelePlayer(playerid, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerInt(playerid, InteriorID, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerWorld(playerid, Virtualworld, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerIntWorld(playerid, Virtualworld, InteriorID, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerCar(playerid, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerCarInt(playerid, InteriorID, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerCarWorld(playerid, Virtualworld, Float:X, Float:Y, Float:Z, Float:A);
native TelePlayerCarIntWorld(playerid, Virtualworld, InteriorID, Float:X, Float:Y, Float:Z, Float:A);
*/

stock TelePlayer(playerid, Float:X, Float:Y, Float:Z, Float:A)
{
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, A);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	return 1;
}

stock TelePlayerWorld(playerid, Virtualworld, Float:X, Float:Y, Float:Z, Float:A)
{
	SetPlayerVirtualWorld(playerid, Virtualworld);
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, A);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	return 1;
}

stock TelePlayerInt(playerid, InteriorID, Float:X, Float:Y, Float:Z, Float:A)
{
	SetPlayerInterior(playerid, InteriorID);
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, A);
	SetCameraBehindPlayer(playerid);
	return 1;
}

stock TelePlayerIntWorld(playerid, Virtualworld, InteriorID, Float:X, Float:Y, Float:Z, Float:A)
{
	SetPlayerVirtualWorld(playerid, Virtualworld);
	SetPlayerInterior(playerid, InteriorID);
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, A);
	SetCameraBehindPlayer(playerid);
	return 1;
}

stock TelePlayerCar(playerid, Float:X, Float:Y, Float:Z, Float:A)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), A);
	SetCameraBehindPlayer(playerid);
	}
	else
	{
	TelePlayer(playerid, X, Y, Z, A);
	}
	return 1;
}

stock TelePlayerCarWorld(playerid, Virtualworld, Float:X, Float:Y, Float:Z, Float:A)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	SetPlayerVirtualWorld(playerid, Virtualworld);
	SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), A);
	SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), Virtualworld);
	SetCameraBehindPlayer(playerid);
	}
	else
	{
	TelePlayerWorld(playerid, Virtualworld, Float:X, Float:Y, Float:Z, Float:A);
	}
	return 1;
}

stock TelePlayerCarInt(playerid, InteriorID, Float:X, Float:Y, Float:Z, Float:A)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	SetPlayerInterior(playerid, InteriorID);
	SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), A);
	LinkVehicleToInterior(GetPlayerVehicleID(playerid), InteriorID);
	SetCameraBehindPlayer(playerid);
	}
	else
	{
	TelePlayerInt(playerid, InteriorID, X, Y, Z, A);
	}
	return 1;
}

stock TelePlayerCarIntWorld(playerid, Virtualworld, InteriorID, Float:X, Float:Y, Float:Z, Float:A)
{
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	SetPlayerInterior(playerid, InteriorID);
	SetPlayerVirtualWorld(playerid, Virtualworld);
	SetVehiclePos(GetPlayerVehicleID(playerid), X, Y, Z);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), A);
	LinkVehicleToInterior(GetPlayerVehicleID(playerid), InteriorID);
	SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), Virtualworld);
	SetCameraBehindPlayer(playerid);
	}
	else
	{
	TelePlayerIntWorld(playerid, Virtualworld, InteriorID, Float:X, Float:Y, Float:Z, Float:A);
	}
	return 1;
}