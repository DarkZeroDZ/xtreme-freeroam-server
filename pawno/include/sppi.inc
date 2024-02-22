#include <a_samp>

/* SetPlayerPosI by Markus
   Wie funktioniert SetPlayerPosI?
   Ganz einfach:
   SetPlayerPosI(playerid,Float:x,Float:y,Float:z,Float:angle,interior);
*/
   
//Funktion:
   
forward SetPlayerPosI(playerid,Float:x,Float:y,Float:z,Float:angle,interior);
public SetPlayerPosI(playerid,Float:x,Float:y,Float:z,Float:angle,interior)
{
 	if(IsPlayerConnected(playerid))
 	{
	SetPlayerPos(playerid,x,y,z);
  	SetPlayerFacingAngle(playerid,angle);
  	SetPlayerInterior(playerid,interior);
  	return 1;
 	}
 	return 0;
}
