

					/*XXXXXXXX        XXXXXXX       FFFFFFFFFFFFFFFFFFFFFFFFFFFF          SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
					   XXXXXXXX      XXXXXXX        FFFFFFFFFFFFFFFFFFFFFFFFFFFF        SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
						XXXXXXXX    XXXXXXX         FFFFFFFFFFFFFFFFFFFFFFFFFFFF       SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
						 XXXXXXXX  XXXXXXX          FFFFFFFF                           SSSSSSS
						  XXXXXXXXXXXXXXX           FFFFFFFF                           SSSSSSS
						   XXXXXXXXXXXXX            FFFFFFFF                           SSSSSSS
							XXXXXXXXXXX             FFFFFFFFFFFFFFFFFFFFFF             SSSSSSS
							XXXXXXXXXX              FFFFFFFFFFFFFFFFFFFFFF             SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
					       XXXXXXXXXXX              FFFFFFFFFFFFFFFFFFFFFF              SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
						  XXXXXXXXXXXXX             FFFFFFFF                              SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
						 XXXXXXXXXXXXXXX            FFFFFFFF                                                       SSSSSSS
						XXXXXXXX XXXXXXXX           FFFFFFFF                                                       SSSSSSS
					   XXXXXXXX	  XXXXXXXX          FFFFFFFF                                                       SSSSSSS
					  XXXXXXXX	   XXXXXXXX         FFFFFFFF                            SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
					 XXXXXXXX		XXXXXXXX        FFFFFFFF                           SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
					XXXXXXXX		 XXXXXXXX       FFFFFFFF                            SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
					
			======================================================================================================================
			=========================================                           ==================================================
			=========================================    SCRIPTVERSION: v0.3    ==================================================
			=========================================  LAST UPDATE: 14.08.2012  ==================================================
			=========================================                           ==================================================
			======================================================================================================================
			======================================================================================================================
			=========================================                           ==================================================
			=========================================  SCRIPTCREATOR: DARKZERO  ==================================================
			=========================================                           ==================================================
			======================================================================================================================
			
 
============= DO NOT REMOVE THE CREDITS!!! ==============
-DarkZero   				Scripting
-Adler      				Ideas and tests
-CraZy      				Script assisting
-InternetInk aka Benjamin   Bankinterior
-Double-O-Seven             Anticheat
=========================================================

==================== FEATURES ===========================
-Dynamic Racesystem     	    Create new races ingame! (You have to add dem in the script anyways)
-7 Deathmatch-Zones         	Enjoy to kill people in the deathmatch zones /DM1-7!
								DM1: Drug Facrory 	Deathmatch
								DM2: Walkies 		Deathmatch
								DM3: Runnies 		Deathmatch
								DM4: Rocketthrower 	Deathmatch
								DM5: Minigun 		Deathmatch
								DM6: Bloodbowl 		Deathmatch
								DM7: Underwater 	Deathmatch
-Duel System 	              	Get in a 1vs1 fight to win score and money! (You can select the used weapons
								and the arena by yourself)
-Accountsystem in DINI      	Due to the fact that I never used MySQL back then, I used this classic file system! :)
-Administrationsystem      		Help players and troll cheaters with our administration system!
-Falloutsystem              	Join the Fallout and try to stay on the objects as long as you can!
-Banksystem                 	Safe your money by using the bank!
-Derbysystem                	Feel free to ram other players till they die. (2 maps included, have to get added manually)
-Tikkisystem                	Collect all tikkis and get rewarded!
-Dynamic house system 		    If you got enough score and money, buy your own house that only you can enter!
								(Use /Createhouse to create houses by yourself)
-Carsellersystem             	If you got enough score and money, buy your own car that only you can drive!
========================================================
Have fun with this gamemode! :)


========================================== THE SCRIPT ==========================================*/


//Includes
#include <a_samp>
#include <dini>
#include <a_zones>
#include <Easy-Teleports>
#include <streamer>
#include <foreach>
#include <Anticheat>
#include <zcmd>

//Defines
#undef MAX_PLAYERS
#define MAX_PLAYERS 50 //Replace this by the amount of max players set on your server config
#define MAX_HAUS 100
#define MIN_SCORE_WANG 1500 
#define MIN_SCORE_COUTT 750
//-------------------
#define Owner "Eagles-Clan" //Replace this by the server owner
#define Version "v0.3" //Current script version
#define Homepage "www.Eagles-Clan.com" //Replace this by your homepage
//-------------------
#define Registerdialog 1
#define Logindialog 2
#define Bankmenu 3
#define Einzahlung 4
#define Auszahlung 5
#define Ueberweisung 6
#define Kontostand 7
#define EinzahlungText 8
#define AuszahlungText 9
#define UeberweisungText1 10
#define Ueberweisung2 11
#define Duelltext 16
#define Derbyvote 17
#define Creditsdialog 18
#define Regeldialog 19
#define Commandsdialog 20
#define Teleportdialog 21
#define Newsdialog 22
#define Haustypdialog 23
#define Gelddialog 24
#define Scoredialog 25
#define Hausmenudialog 26
#define Hauscardialog 27
//-------------------
#define TEAM_GROVE 1
#define TEAM_COPS 2
#define TEAM_BALLAS 3
#define TEAM_VAGOS 4
#define TEAM_AZTECAS 5
#define TEAM_MAFIA 6
#define TEAM_FRAUEN 7
//-------------------
#define Error_FARBE 0xFF000000
#define ADMIN_FARBE 0xFFFF00FF
#define TELEPORT_FARBE 0xFFC800FF
#define WEISS 0xFFFFFFFF
#define RENN_FARBE 0x0073FFFF
#define DM_FARBE 0xA000FFFF
#define FALLOUT_FARBE 0xDB881AAA
#define DERBY_FARBE 0xADDEFFFF
#define TIKKI_FARBE 0x009C00FF
#define msg 0x99FF66FF
#define AUTO_FARBE 0x663300FF
#define REAKTIONSTEST_FARBE 0xC06CFFFF
//-------------------
#define RACESTART 0
#define RACECP2 1
#define RACECP3 2
#define RACECP4 3
#define RACECP5 4
#define RACECP6 5
#define RACECP7 6
#define RACECP8 7
#define RACECP9 8
#define RACECP10 9
#define RACECP11 10
#define RACECP12 11
#define RACECP13 12
#define RACECP14 13
#define RACECP15 14
#define RACECP16 15
#define RACECP17 16
#define RACECP18 17
#define RACECP19 18
#define RACEFINISH 19
#define RACEWAIT 20
//-------------------
#define SNAME1 "[ENG] xTreme Freeroam Server by "#Owner"" 
#define SNAME2 "[ENG] XFS - Last Update: 14.08.2012"
#define SNAME3 "[ENG] XFS - Join us: "#Homepage""
//-------------------
#define DMLEISTENTEXT "Players online: ~g~~h~%d ~w~] DM: ~g~~h~%d ~w~] Race: ~g~~h~%d ~w~] Derby: ~g~~h~%d ~w~] Fallout: ~g~~h~%d"
//-------------------
#define MoneyForKill 5000
#define GiveAllPlayerMoney 2
#define Rampage_3Killes     3000
#define Rampage_7Killes     7000
#define Rampage_10Killes    10000
#define Rampage_15Killes    15000
#define Rampage_20Killes    20000
#define Rampage_25Killes    25000
#define Rampage_30Killes    30000
#define Rampage_40Killes    40000
#define Rampage_50Killes    50000
//-------------------
#define DerbyMin 2
#define DerbyTime 5
#define Derby_Reward 20000


#if defined Owner
//Statics
static gTeam[MAX_PLAYERS];

//Variablen
new stringtu[128];
//-------------------
new Text:HomepageTD[MAX_PLAYERS];
new Text:zonentext[MAX_PLAYERS];
new Text:ServernameTD1[MAX_PLAYERS];
new Text:ServernameTD2[MAX_PLAYERS];
new Text:ServernameTD3[MAX_PLAYERS];
new Text:ServernameTD4[MAX_PLAYERS];
new Text:ScoreLine[MAX_PLAYERS];
new Text:SpeedoTD[MAX_PLAYERS];
new Text:SpeedoTD2[MAX_PLAYERS];
new Text:SpeedoTD3[MAX_PLAYERS];
new Text:leiste;
new Text:BoxOben;
new Text:BoxUnten;
new Text:FPS[MAX_PLAYERS];
//-------------------
new DLlast[MAX_PLAYERS] = 0;
new FPS2[MAX_PLAYERS] = 0;
//-------------------
new reactionstr[9];
new reactioninprog;
new reacendtimer;
//-------------------
new Zonetimer[MAX_PLAYERS];
//-------------------
new Ueberweiser[MAX_PLAYERS] ={-1,...};
//-------------------
new Bankeingang;
new Bankausgang;
//-------------------
new pTHausID[MAX_PLAYERS];
new vw1,vw2,vw3,vw4,vw5,vw6;
new currHaus;
new pTestID[MAX_PLAYERS];
//-------------------
new hostname = 0;
//-------------------
new Menu:WangCars;
new Menu:CouttBikes;
new hausauto[MAX_PLAYERS];
new VehicleOwner[MAX_VEHICLES]={INVALID_PLAYER_ID,...};
//-------------------
new Tikki1;
new Tikki2;
new Tikki3;
new Tikki4;
new Tikki5;
new Tikki6;
new Tikki7;
new Tikki8;
new Tikki9;
new Tikki10;
//-------------------
new wangpick;
new couttpick;
//-------------------
new Messages1[][] =
{
	{"[Info]: {FFFFFF}Use /Cmds to see all available server commands."},
	{"[Info]: {FFFFFF}Use /Derby to join the derby."},
	{"[Info]: {FFFFFF}To report a cheater, use /Report."},
	{"[Info]: {FFFFFF}To see the credits of the server, use /Credits."},
	{"[Info]: {FFFFFF}Use /News to see the latest updates."},
	{"[Info]: {FFFFFF}This gamemode has been created by DarkZero!"}
};
//-------------------
new onlineplayers = 0;
//-------------------
new FalloutPlayers = 0;
new JoinedFallout[MAX_PLAYERS];
new bool:Falloutr_[MAX_PLAYERS char];
new bool:VIEW_FROM_ABOVE;
new inProgress, uTimer;
new Objects_[2][54];
new pWeaponData[MAX_PLAYERS][13];
new pSavedAmmo[MAX_PLAYERS][13];
new Float:pCoords[MAX_PLAYERS][3];
new pInterior[MAX_PLAYERS];
new Iterator:_Falloutr	<54>;
new Iterator:_Objects	<54>;
new pReadyText[1][64] =
{
	"_"
};
new pFellOffText[1][28] =
{
	"_"
};
new Float:gCoords[54][3] = {

	{ -5309.198120,-199.052383,22.593704 },
	{ -5309.198120,-195.786071,22.593704 },
	{ -5309.198120,-192.510620,22.593704 },
	{ -5309.198120,-189.250564,22.593704 },
	{ -5309.198120,-185.987960,22.593704 },
	{ -5309.198120,-182.727081,22.593704 },
	{ -5309.198120,-179.463394,22.593704 },
	{ -5309.198120,-176.205261,22.593704 },
	{ -5304.841796,-176.205261,22.593704 },
	{ -5304.841796,-179.468795,22.593704 },
	{ -5304.841796,-182.737884,22.593704 },
	{ -5304.841796,-185.989654,22.593704 },
	{ -5304.841796,-189.259185,22.593704 },
	{ -5304.841796,-192.518615,22.593704 },
	{ -5304.841796,-195.785491,22.593704 },
	{ -5304.841796,-199.054733,22.593704 },
	{ -5300.489990,-199.054733,22.593704 },
	{ -5300.489990,-195.782165,22.593704 },
	{ -5300.489990,-192.531250,22.593704 },
	{ -5300.489990,-189.274765,22.593704 },
	{ -5300.489990,-186.003005,22.593704 },
	{ -5300.489990,-182.735229,22.593704 },
	{ -5300.489990,-179.471069,22.593704 },
	{ -5300.489990,-176.208007,22.593704 },
	{ -5296.138061,-176.208007,22.593704 },
	{ -5296.138061,-179.479248,22.593704 },
	{ -5296.138061,-182.744735,22.593704 },
	{ -5296.138061,-186.002944,22.593704 },
	{ -5296.138061,-189.274505,22.593704 },
	{ -5296.138061,-192.533691,22.593704 },
	{ -5296.138061,-195.788970,22.593704 },
	{ -5296.138061,-199.048782,22.593704 },
	{ -5291.776000,-199.050140,22.593704 },
	{ -5291.776000,-195.790634,22.593704 },
	{ -5291.776000,-192.542922,22.593704 },
	{ -5291.776000,-189.277542,22.593704 },
	{ -5291.776000,-186.013275,22.593704 },
	{ -5291.776000,-182.742355,22.593704 },
	{ -5291.776000,-179.475021,22.593704 },
	{ -5291.776000,-176.215805,22.593704 },
	{ -5287.432250,-176.215805,22.593704 },
	{ -5287.432250,-179.485168,22.593704 },
	{ -5287.432250,-182.739608,22.593704 },
	{ -5287.432250,-186.016723,22.593704 },
	{ -5287.432250,-189.277816,22.593704 },
	{ -5287.432250,-192.539001,22.593704 },
	{ -5287.432250,-195.796325,22.593704 },
	{ -5287.432250,-199.053771,22.593704 },
	{ -5287.431274,-202.320648,22.593704 },
	{ -5291.781616,-202.320648,22.593704 },
	{ -5296.136718,-202.320648,22.593704 },
	{ -5300.493652,-202.320648,22.593704 },
	{ -5304.848876,-202.320648,22.593704 },
	{ -5309.201660,-202.320648,22.593704 }
};
//-------------------
new RaceVehicleID[MAX_PLAYERS];
new RacePosition1,RacePosition2,RacePosition3;
new RacePlayers = 0;
new racelist = 1;
new NextRace = -1;
new RaceStatus[MAX_PLAYERS];
new StartTime[MAX_PLAYERS];
new Motocountdown[MAX_PLAYERS] =-1;
new MotoGP[MAX_PLAYERS] = 0;
new MotoGate[MAX_PLAYERS]=1;
new JoinedRace[MAX_PLAYERS];
new RaceTime[MAX_PLAYERS];
new pos1time;
new pos4time;
new Gtickcount;
new cmins,csecs,cmils;
new winnings = 15000;
new rennengestartet = 0;
new Rennen;
new CurrentRace[128];
//-------------------
new Speedotimer[MAX_PLAYERS];
//-------------------
new Iterator:InDerby<MAX_PLAYERS>;
new bool:InDerby[MAX_PLAYERS];
new DerbyPlayerNum[MAX_PLAYERS],
    DerbyMap,
    DerbyVote[2] =0,
    DerbyCar[MAX_PLAYERS],
    DerbyMapName[128];
new DerbyState;
new Msec[MAX_PLAYERS], Mmin[MAX_PLAYERS];
new Out[MAX_PLAYERS];
new DerbyPlayers = 0;
//-------------------
new GmxAktiv;
new Geist[MAX_PLAYERS];
new GMXtimer;
//-------------------
new pWeapons[MAX_PLAYERS][13],pAmmo[MAX_PLAYERS][13];
new phour[MAX_PLAYERS],pminutes[MAX_PLAYERS];
new timer3[MAX_PLAYERS],DCount[MAX_PLAYERS] = 6,CountDown[MAX_PLAYERS];
new Killestreak[MAX_PLAYERS];
new DmId[MAX_PLAYERS];
new IteratorArray :Dm [18] <MAX_PLAYERS>;
new bool:InDm[MAX_PLAYERS];
new rand;
new bool:Dueler[MAX_PLAYERS];
new Iterator:InDuel<MAX_PLAYERS>;
new DuelInfo = 0;
new Duelp, DuelWeapon;
new DuelWeaponName[128];
new DuelBet;
new DMPlayers = 0;
new Float:Dm1SP[ 3 ][ 4 ] =
{
	{-2187.7495, -236.3353, 37.9595, 278.1712},
	{-2183.4138, -207.8275,36.5156, 163.6990},
	{-2144.0620, -233.9885,36.5156, 93.0938}
};
new Float:Dm2SP[ 3 ][ 4 ] =
{
	{1268.3138, 2842.7417, 10.8125, 169.4573},
	{1214.2262, 2787.3616, 10.8203, 266.8004},
	{1321.8940, 2801.5938, 10.8126, 91.3320}
};
new Float:Dm3SP[ 3 ][ 4 ] =
{
	{1306.1936,2109.8308,11.0156,320.0303},
	{1309.4669,2187.0706,11.0234,224.9848},
	{1387.1461,2188.2690,11.0234,136.4570}
};
new Float:Dm4SP[ 3 ][ 4 ] =
{
	{-2358.0461,94.6873,35.3125,290.7809},
	{-2297.2285,137.4780,35.3125,133.3634},
	{-2292.5383,82.2072,35.3125,61.1290}
};
new Float:Dm5SP[ 3 ][ 4 ] =
{
	{-975.975708, 1060.983032, 1345.671875, 90.0000},
	{-1043.557983, 1061.900878, 1346.020629, 90.0000},
	{-1066.534790, 1056.252319, 1344.286743, 00.0000}
};
new Float:Dm6SP[ 3 ][ 4 ] =
{
	{-2502.1531, -714.9811, 139.3203, 356.1828},
	{-2511.3630, -661.7205, 139.3203, 275.5510},
	{-2500.1497, -621.2712, 132.6944, 177.3724}
};

new Float:Dm7SP[ 3 ][ 4 ] =
{
	{-596.0815, -3756.7095, 7.4455, 10.4507},
	{-510.5476, -3545.3325, 17.6705, 150.0264},
	{-588.3386, -3682.2703, 57.9123, 21.6475}
};
new Float:Dm8SP[ 3 ][ 4 ] =
{
	{291.6334, -8.0505, 1001.5156, 182.6771},
	{292.1754, -25.3630, 1001.5156, 358.2221},
	{285.3199, -21.5402, 1001.5229, 317.2971}
};
new Float:Dm9SP[ 3 ][ 4 ] =
{
	{-1396.5200, 1275.2949, 1039.8672, 180.0000},
	{-1397.5731, 1208.6052, 1039.8672, 359.6333},
	{-1362.3287, 1233.9620, 1039.8672, 72.3273}
};

new Float:Dm15SP[ 3 ][ 4 ] =
{
	{441.7771,-2600.3967,-33.1172,174.4654},
	{435.5923,-2731.9790,-37.7500,19.2987},
	{404.5169,-2688.9531,-37.7500,327.3684}
};

//-------------------

//Forwards
forward Clock();
forward ClockSync(playerid);
forward Zonencheck(playerid);
forward StartRace(playerid);
forward GPRaceCountdown(count);
forward RaceUpdate();
forward SaveTimes(name[]);
forward SaveRace(name[]);
forward ConvertTicks(ticks);
forward LoadRace(playerid,name[]);
forward UpdateList(playerid,TimeRec);
forward RaceEnd(playerid);
forward GameTicks(ticks);
forward LoadNextRace();
forward Minigame(playerid);
forward Scorebar(playerid);
forward Speedo(playerid);
forward OnPlayerMiniGameSpawn(i);
forward PlayerCountDown(p);
forward Remove_From_Dm(playerid);
forward MiniGameUpdate(i);
forward SendClientMessageToAdmins(color,string[],alevel);
forward Restart();
forward FalloutWinner(player);
forward FalloutCountdown();
forward FalloutUpdate();
forward EndFallout();
forward SpeedUp(object,Float:x,Float:y,Float:z);
forward RespawnPlayer(player);
forward StartDerby();
forward Werbung();
forward ShowStats(playerid);
forward HostName();
forward ZeitTimer();
forward Speichern();
forward Laden();
forward FPSUP();
forward AUP(playerid);
forward ReactionTest();
forward ReactionEnd();
forward ReactionWin(playerid);
forward SetBack();

//Accountdatas
enum Accountinfo
{
	Adminlevel,
	Passwort[128],
	Geld,
	Bankgeld,
	Score,
	Language,
	Tiki1,
	Tiki2,
	Tiki3,
	Tiki4,
	Tiki5,
	Tiki6,
	Tiki7,
	Tiki8,
	Tiki9,
	Tiki10,
	pHausID,
	Hausauto,
	Farbe1,
	Farbe2,
	Nos,
	Hydraulik,
	Felgen,
	Stereo,
	Paintjob,
	Motorhaube,
	Spoiler,
	Dach,
	Lampen,
	SeitenschwellerR,
	SeitenschwellerL,
	Auspuff,
    Heckstossstange,
	Frontstossstange,
	OvalLuftR,
	OvalLuftL,
	EckLuftR,
	EckLuftL,
	Kills,
	Tode
}
new PlayerInfo[MAX_PLAYERS][Accountinfo];

//Housedatas
enum haus
{
	Float:TuerX,
	Float:TuerY,
	Float:TuerZ,
	Float:AusgangX,
	Float:AusgangY,
	Float:AusgangZ,
	HausInterior,
	Hauskosten,
	HausVw,
	HausScore,
	HausBesitzer[16],
	HausID,
	Pickup,
	Verkauft
}
new Haus[MAX_HAUS][haus];

//Racedatas
enum rInfo
{
	Float:r1[3],
	Float:r2[3],
	Float:r3[3],
	Float:r4[3],
	Float:r5[3],
	Float:r6[3],
	Float:r7[3],
	Float:r8[3],
	Float:r9[3],
	Float:r10[3],
	Float:r11[3],
	Float:r12[3],
	Float:r13[3],
	Float:r14[3],
	Float:r15[3],
	Float:r16[3],
	Float:r17[3],
	Float:r18[3],
	Float:r19[3],
	Float:r20[3],
	rName1[MAX_PLAYER_NAME],
	rName2[MAX_PLAYER_NAME],
	rName3[MAX_PLAYER_NAME],
	Float:rAngle,
	rBestms1,
	rBestms2,
	rBestms3,
};
new RaceInfo[rInfo];
enum CreateInfo
{
	Float:rCP1[3],
	Float:rCP2[3],
	Float:rCP3[3],
	Float:rCP4[3],
	Float:rCP5[3],
	Float:rCP6[3],
	Float:rCP7[3],
	Float:rCP8[3],
	Float:rCP9[3],
	Float:rCP10[3],
	Float:rCP11[3],
	Float:rCP12[3],
	Float:rCP13[3],
	Float:rCP14[3],
	Float:rCP15[3],
	Float:rCP16[3],
	Float:rCP17[3],
	Float:rCP18[3],
	Float:rCP19[3],
	Float:rCP20[3],
	rName1[MAX_PLAYER_NAME],
	rName2[MAX_PLAYER_NAME],
	rName3[MAX_PLAYER_NAME],
	Float:rAngle,
	rBestms1,
	rBestms2,
	rBestms3,
};
new CheckPoint = 1;
new CreateRace[CreateInfo];

main()
{
	print("\n----------------------------------");
	print(" XFS by "#Owner" wurde erfolgreich gestartet.");
	print("----------------------------------\n");
}

public PnP_OnGameModeInit()
{
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	print("Gamemode will get loaded...");
	print("Loading accounts...");
	if(!fexist("/Accounts"))
	{
		print("The folder 'Accounts' is missing!");
	}
	print("Loading races...");
	if(!fexist("/Rennen"))
	{
	    print("The folder 'Rennen' is missing!");
	}
	if(!fexist("/RennEditor"))
	{
	    print("The folder 'RennEditor' is missing!");
	}
	print("Loading anticheat...");
	if(!fexist("/Anticheat"))
	{
	    print("The folder 'Anticheat' is missing!");
	}
	print("Loading houses...");
	if(!fexist("hauser.txt"))
	{
	    print("The file 'hauser.txt' is missing!");
	}
	format(stringtu,sizeof(stringtu),"hostname %s",SNAME1);
	SendRconCommand("mapname XFS v"#Version"");
	SendRconCommand("weburl "#Homepage"");
	SetGameModeText("DM|Race|Derby v"#Version"");
	
	//Haeuser
	Laden();
	currHaus = dini_Int("hauser.txt","currHaus");
	vw1 = dini_Int("hauser.txt","vw1");
	vw2 = dini_Int("hauser.txt","vw2");
	vw3 = dini_Int("hauser.txt","vw3");
	vw4 = dini_Int("hauser.txt","vw4");
	vw5 = dini_Int("hauser.txt","vw5");
	vw6 = dini_Int("hauser.txt","vw6");
	for(new i;i<MAX_PLAYERS;i++)
	{
		PlayerInfo[i][pHausID] = -1;
	}
	
	//Textdraws
	leiste = TextDrawCreate(304.000000,1.000000,"Players online: ~g~~h~1 ~w~] DM: ~g~~h~0 ~w~] Race: ~g~~h~0 ~w~] Derby: ~g~~h~0 ~w~] Fallout: ~g~~h~0");
	TextDrawUseBox(leiste,1);
	TextDrawBoxColor(leiste,0x00000066);
	TextDrawTextSize(leiste,102.000000,304.000000);
	TextDrawAlignment(leiste,2);
	TextDrawBackgroundColor(leiste,0x000000ff);
	TextDrawFont(leiste,2);
	TextDrawLetterSize(leiste,0.200000,1.000000);
	TextDrawColor(leiste,0xffffffff);
	TextDrawSetOutline(leiste,1);
	TextDrawSetProportional(leiste,1);
	TextDrawSetShadow(leiste,1);
	
	BoxOben = TextDrawCreate(645.000000,101.000000,"___");
	BoxUnten = TextDrawCreate(1.000000,328.000000,"____");
	TextDrawUseBox(BoxOben,1);
	TextDrawBoxColor(BoxOben,0x000000ff);
	TextDrawTextSize(BoxOben,-260.000000,17.000000);
	TextDrawUseBox(BoxUnten,1);
	TextDrawBoxColor(BoxUnten,0x000000ff);
	TextDrawTextSize(BoxUnten,680.000000,0.000000);
	TextDrawAlignment(BoxOben,0);
	TextDrawAlignment(BoxUnten,0);
	TextDrawBackgroundColor(BoxOben,0x000000ff);
	TextDrawBackgroundColor(BoxUnten,0x000000ff);
	TextDrawFont(BoxOben,3);
	TextDrawLetterSize(BoxOben,1.000000,-14.000000);
	TextDrawFont(BoxUnten,3);
	TextDrawLetterSize(BoxUnten,1.000000,20.000000);
	TextDrawColor(BoxOben,0xffffffff);
	TextDrawColor(BoxUnten,0xffffffff);
	TextDrawSetShadow(BoxOben,1);
	TextDrawSetShadow(BoxUnten,1);

	//Menus
	WangCars = CreateMenu("Vehicles", 0, 23.000000,119.000000, 150.0, 150.0);
	SetMenuColumnHeader(WangCars, 0, "Vehicle:     Price:");
	AddMenuItem(WangCars, 0, "Sultan     3000000$");
	AddMenuItem(WangCars, 0, "Uranus     2500000$");
	AddMenuItem(WangCars, 0, "Jester     2600000$");
	AddMenuItem(WangCars, 0, "Stratum     2900000$");
	AddMenuItem(WangCars, 0, "Elegy     2800000$");
	AddMenuItem(WangCars, 0, "Flash     2300000$");
	AddMenuItem(WangCars, 0, "Leave menu");

	CouttBikes = CreateMenu("Bikes", 0, 23.000000,119.000000, 150.0, 150.0);
	SetMenuColumnHeader(CouttBikes, 0, "Bike:     Price:");
	AddMenuItem(CouttBikes, 0, "NRG-500     3000000$");
	AddMenuItem(CouttBikes, 0, "FCR-900     2000000$");
	AddMenuItem(CouttBikes, 0, "Freeway     1000000$");
	AddMenuItem(CouttBikes, 0, "Sanchez     1900000$");
	AddMenuItem(CouttBikes, 0, "Wayfarer     940000$");
	AddMenuItem(CouttBikes, 0, "PCJ-600     1700000$");
	AddMenuItem(CouttBikes, 0, "Leave menu");
	
	//Pickups
	Bankeingang = CreatePickup(1559,1,592.7961,-1250.3898,18.2159);
	Bankausgang = CreatePickup(1559,1,1415.6256,-988.5735,1639.7843);
   	couttpick = CreatePickup(1274,23,2131.9202,-1149.4294,24.2693);
   	wangpick = CreatePickup(1274,23,-1951.9543,264.2843,41.0471);
	Tikki1 = CreatePickup(1276,1,2528.4614,-1679.4567,19.9302);
	Tikki2 = CreatePickup(1276,1,2505.2991,-1694.7522,25.7682);
	Tikki3 = CreatePickup(1276,1,2244.5981,-1346.5085,41.3252);
	Tikki4 = CreatePickup(1276,1,1823.5339,-1429.4283,35.4831);
	Tikki5 = CreatePickup(1276,1,1857.1145,-1455.0167,28.7969);
	Tikki6 = CreatePickup(1276,1,1785.6917,-1304.3364,13.1524);
	Tikki7 = CreatePickup(1276,1,3889,-1353.5826,329.4736);
	Tikki8 = CreatePickup(1276,1,1415.2643,-813.0600,74.0405);
	Tikki9 = CreatePickup(1276,1,1189.8684,-921.6595,43.5525);
	Tikki10 = CreatePickup(1276,1,811.5095,-1098.2948,25.9063);

	//3D Labels
	Create3DTextLabel("Enter bank",0x00FFFFFF,592.7961,-1250.3898,18.2159,10,0);
	Create3DTextLabel("Exit bank",0x00FFFFFF,1415.6256,-988.5735,1639.7843,10,0);
	Create3DTextLabel("ATM\nUse /ATM!",0x00FFFFFF,1417.6970,-981.2289,1639.7843,10,0);
	Create3DTextLabel("ATM\nUse /ATM!",0x00FFFFFF,1421.1302,-981.2379,1639.7843,10,0);
	Create3DTextLabel("ATM\nUse /ATM!",0x00FFFFFF,1424.6023,-981.5164,1639.7843,10,0);
	
	//Spielerskins
    AddPlayerClass(0,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(105,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(106,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(107,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(269,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(270,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(271,2517.3142,-1678.6617,14.3770,60.8737,24,200,30,200,32,200); //Grove
	AddPlayerClass(280,1584.8950,-1691.8157,6.2188,278.2299,27,200,22,200,29,200);//Cop
	AddPlayerClass(281,1584.8950,-1691.8157,6.2188,278.2299,27,200,22,200,29,200);//Cop
	AddPlayerClass(282,1584.8950,-1691.8157,6.2188,278.2299,27,200,22,200,29,200);//Cop
	AddPlayerClass(283,1584.8950,-1691.8157,6.2188,278.2299,27,200,22,200,29,200);//Cop
	AddPlayerClass(284,1584.8950,-1691.8157,6.2188,278.2299,27,200,22,200,29,200);//Cop
	AddPlayerClass(285,1584.8950,-1691.8157,6.2188,278.2299,27,200,22,200,29,200);//Cop
	AddPlayerClass(102,1909.5679,-1120.4241,25.8779,172.9802,31,200,27,300,6,1);//Ballas
	AddPlayerClass(103,1909.5679,-1120.4241,25.8779,172.9802,31,200,27,300,6,1);//Ballas
	AddPlayerClass(104,1909.5679,-1120.4241,25.8779,172.9802,31,200,27,300,6,1);//Ballas
	AddPlayerClass(108,2154.1604,-1207.9894,23.6303,1.9498,27,200,16,100,8,1);//Los Granatos
	AddPlayerClass(109,2154.1604,-1207.9894,23.6303,1.9498,27,200,16,100,8,1);//Los Granatos
	AddPlayerClass(110,2154.1604,-1207.9894,23.6303,1.9498,27,200,16,100,8,1);//Los Granatos
	AddPlayerClass(114,1766.2480,-1896.0956,13.2676,261.2370,28,200,33,100,4,1);//Aztecas
	AddPlayerClass(115,1766.2480,-1896.0956,13.2676,261.2370,28,200,33,100,4,1);//Aztecas
	AddPlayerClass(116,1766.2480,-1896.0956,13.2676,261.2370,28,200,33,100,4,1);//Aztecas
	AddPlayerClass(111,-2181.7998,640.9501,49.4375,80.6177,16,100,31,200,34,200);//Mafia
	AddPlayerClass(112,-2181.7998,640.9501,49.4375,80.6177,16,100,31,200,34,200);//Mafia
	AddPlayerClass(113,-2181.7998,640.9501,49.4375,80.6177,16,100,31,200,34,200);//Mafia
	AddPlayerClass(12,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
	AddPlayerClass(13,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(55,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(56,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(93,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(169,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(192,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(193,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(195,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(214,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen
    AddPlayerClass(226,-2622.1233,1405.1744,7.1016,212.4782,12,1,23,200,32,200); //Frauen

	//Fahrzeuge
	AddStaticVehicle(536,2428.0955,-1642.9897,13.2298,179.5407,86,86);
	AddStaticVehicle(536,2501.0332,-1655.8900,13.1737,248.2757,86,86);
	AddStaticVehicle(567,2509.8733,-1672.1565,13.2770,356.8286,86,86);
	AddStaticVehicle(534,2473.0662,-1700.3829,13.2444,0.1961,86,86);
	AddStaticVehicle(536,2443.4197,-1663.9293,13.1294,89.4885,86,86);
	AddStaticVehicle(567,1929.3104,-1140.7001,24.9972,268.8697,157,157);
	AddStaticVehicle(567,1891.5977,-1141.2896,24.0494,270.2093,157,157);
	AddStaticVehicle(567,1881.7700,-1130.5884,23.8042,267.6906,157,157);
	AddStaticVehicle(534,1935.3846,-1131.2510,25.1474,268.9189,157,157);
	AddStaticVehicle(596,1536.9392,-1671.3644,13.1835,359.9496,0,1);
	AddStaticVehicle(523,1601.4506,-1699.7570,5.4605,93.9745,0,1);
	AddStaticVehicle(523,1578.2488,-1710.1154,5.4610,2.8470,0,1);
	AddStaticVehicle(596,1529.9669,-1683.6982,5.6124,268.9698,0,1);
	AddStaticVehicle(596,1558.9694,-1710.7615,5.6128,359.9520,0,1);
	AddStaticVehicle(534,1777.0436,-1913.4524,13.1047,268.7440,7,7);
	AddStaticVehicle(451,1803.4063,-1921.8640,13.0982,88.5677,7,7);
	AddStaticVehicle(522,1804.1414,-1926.9576,12.9609,88.6231,7,7);
	AddStaticVehicle(534,1803.1338,-1905.8027,13.1251,89.9405,7,7);
	AddStaticVehicle(522,1776.1571,-1929.2666,12.9561,266.6964,7,7);
	AddStaticVehicle(522,2148.2202,-1171.0334,23.6861,269.2616,6,6);
	AddStaticVehicle(567,2161.6299,-1187.7034,23.6860,89.5134,6,6);
	AddStaticVehicle(534,2148.1675,-1199.0227,23.7554,270.0404,6,6);
	AddStaticVehicle(567,2161.5425,-1144.0933,24.6774,86.6499,6,6);
	AddStaticVehicle(482,-2628.4944,1376.7595,7.2523,178.4243,199826,199826);
	AddStaticVehicle(482,-2635.5078,1335.0621,7.3156,0.2058,199826,199826);
	AddStaticVehicle(482,-2620.0952,1350.3398,7.2844,93.1794,199826,199826);
	AddStaticVehicle(409,-2620.3442,1371.4646,6.8836,92.2990,199826,199826);
	AddStaticVehicle(415,-2207.6177,631.5872,49.2100,3.1010,0,0);
	AddStaticVehicle(451,-2207.0706,652.9000,49.1426,183.3781,0,0);
	AddStaticVehicle(518,-2212.8008,638.6640,49.1175,63.2109,0,0);
	AddStaticVehicle(410,-2124.5781,-866.1370,31.6730,89.3731,10,1);
	AddStaticVehicle(415,-2124.3369,-905.0008,31.7942,88.8208,25,1);
	AddStaticVehicle(401,-2148.6755,-888.8345,31.8029,88.8845,47,47);
	AddStaticVehicle(421,-2134.0020,-844.0114,31.9059,269.8933,30,1);
	AddStaticVehicle(418,-2134.1855,-929.1196,32.1162,270.2047,117,227);
	AddStaticVehicle(426,-2124.8125,-962.1194,31.7665,88.8624,7,7);
	AddStaticVehicle(429,-2148.7505,-950.2186,31.7031,89.5702,13,13);
	AddStaticVehicle(431,-2145.8342,-814.9313,32.1209,89.2167,75,59);
	AddStaticVehicle(434,-2124.3259,-784.7522,31.9947,268.3008,2,2);
	AddStaticVehicle(436,-2148.9790,-766.5967,31.7899,89.8786,87,1);
	AddStaticVehicle(593,-1440.1454,-526.2789,14.6337,208.8007,60,1);
	AddStaticVehicle(513,-1379.1272,-483.0100,14.7378,225.9074,21,34);
	AddStaticVehicle(513,-1360.9581,-474.8956,14.7165,186.6064,30,34);
	AddStaticVehicle(512,-1426.1222,-593.9229,14.4381,302.2944,15,123);
	AddStaticVehicle(463,1772.4773,-2129.1648,13.0872,3.7641,84,84);
	AddStaticVehicle(466,1724.7827,-2090.9773,13.2887,180.5543,78,76);
	AddStaticVehicle(468,1724.6223,-2133.0288,13.2234,356.6785,46,46);
	AddStaticVehicle(475,1772.9988,-2093.7275,13.3527,178.6393,9,39);
	AddStaticVehicle(479,1885.9299,-2022.2517,13.1841,178.3271,59,36);
	AddStaticVehicle(482,1878.0094,-2038.5869,13.5831,0.6079,52,52);
	AddStaticVehicle(491,1938.7609,-2086.4846,13.3192,270.4355,71,72);
	AddStaticVehicle(499,2299.2791,-1937.9620,13.5627,271.7709,109,32);
	AddStaticVehicle(508,2451.1008,-2023.5681,13.9218,359.9777,1,1);
	AddStaticVehicle(526,2474.3726,-1990.0908,13.3135,178.8289,17,1);
	AddStaticVehicle(529,2502.0115,-1952.4810,13.0673,0.5338,10,10);
	AddStaticVehicle(533,2486.0837,-1952.5502,13.1422,0.0450,75,1);
	AddStaticVehicle(536,1188.2478,-1085.4056,28.9155,90.4102,30,96);
	AddStaticVehicle(540,1108.2456,-1025.1974,31.7826,180.2584,42,42);
	AddStaticVehicle(524,971.6852,-1259.4022,17.4711,179.2768,65,31);
	AddStaticVehicle(527,853.6683,-1512.2797,12.7352,270.6258,66,1);
	AddStaticVehicle(529,894.0306,-1517.8302,12.6069,180.0332,15,15);
	AddStaticVehicle(549,1098.3512,-1760.8237,13.0490,270.0245,75,39);
	AddStaticVehicle(550,1083.8539,-1775.3861,13.1619,269.6745,42,42);
	AddStaticVehicle(554,1078.0844,-1754.8723,13.4795,89.9617,15,32);
	AddStaticVehicle(424,901.3791,-1842.3174,10.1829,195.0920,3,6);
	AddStaticVehicle(514,1363.4846,479.8463,20.7468,159.2780,40,1);
	AddStaticVehicle(531,-91.2616,-40.1765,3.0831,336.4311,40,35);
	AddStaticVehicle(515,249.3238,1396.6383,11.6044,270.8098,39,78);
	AddStaticVehicle(514,249.8753,1371.4633,11.1703,270.0392,54,1);
	AddStaticVehicle(578,248.7841,1420.8024,11.1891,268.4417,1,1);
	AddStaticVehicle(573,250.9330,1445.7805,11.2363,269.6436,79,7);
	AddStaticVehicle(575,-85.1418,1339.7498,10.3897,187.2595,66,96);
	AddStaticVehicle(579,-94.6707,1338.3828,10.3800,187.3709,42,42);
	AddStaticVehicle(585,-102.7220,1367.8901,9.8602,9.6308,53,53);
	AddStaticVehicle(528,220.6042,1918.6620,17.6843,181.2994,0,0);
	AddStaticVehicle(528,211.5214,1920.1097,17.6818,180.5540,0,0);
	AddStaticVehicle(490,193.7932,1919.0475,17.7693,181.0586,0,0);
	AddStaticVehicle(490,202.8501,1919.0427,17.7693,180.5332,0,0);
	AddStaticVehicle(601,200.4091,1892.4022,17.4049,359.5934,1,1);
	AddStaticVehicle(602,1448.9889,1999.0741,10.6258,179.4398,69,1);
	AddStaticVehicle(603,1519.8259,2000.1200,10.6588,179.4707,18,1);
	AddStaticVehicle(605,1446.6323,1951.4150,11.2760,178.5111,43,8);
	AddStaticVehicle(423,1495.6357,2257.7471,10.8440,0.7718,1,16);
	AddStaticVehicle(437,1532.5940,2278.3701,10.9480,359.5557,123,20);
	AddStaticVehicle(582,1522.3906,2257.3384,10.8736,179.0288,56,123);
	AddStaticVehicle(488,1447.2448,2271.2510,11.2032,276.1574,2,29);
	AddStaticVehicle(468,2479.5276,-1750.0995,13.2119,7.6165,46,46);
	AddStaticVehicle(566,2502.3713,-1755.0593,12.6671,357.4185,72,8);
	AddStaticVehicle(445,2492.2949,-1755.3577,13.2423,2.4913,35,35);
	AddStaticVehicle(410,2599.5549,-1737.8967,12.7073,272.6349,25,1);
	AddStaticVehicle(434,2658.5286,-1635.2771,10.8165,89.0818,2,2);
	AddStaticVehicle(576,2637.7466,-1542.8746,22.0491,182.4828,79,1);
	AddStaticVehicle(412,2647.8960,-1444.4802,30.2153,358.2473,27,1);
	AddStaticVehicle(522,2584.9475,-1455.6437,34.2161,359.5717,36,105);
	AddStaticVehicle(461,2599.4871,-1455.6631,33.2128,0.5131,53,1);
	AddStaticVehicle(521,2613.3381,-1455.8961,32.1325,2.2981,75,13);
	AddStaticVehicle(567,2575.6548,-1359.5139,34.1376,0.3096,99,81);
	AddStaticVehicle(467,2506.4058,-1366.0760,28.1794,178.1461,60,1);
	AddStaticVehicle(517,2456.3130,-1389.8872,23.7614,180.1867,36,36);
	AddStaticVehicle(536,2409.7727,-1449.2896,23.6550,273.7559,30,96);
	AddStaticVehicle(466,2391.9224,-1487.6578,23.5699,268.9249,68,76);
	AddStaticVehicle(491,2391.7253,-1497.1715,23.5911,268.3101,52,66);
	AddStaticVehicle(506,2391.4382,-1507.0160,23.3551,268.7529,6,6);
	AddStaticVehicle(541,2415.7346,-1538.8087,23.7284,358.8717,68,8);
	AddStaticVehicle(541,2408.6077,-1538.9550,23.7283,1.5563,2,1);
	AddStaticVehicle(509,2337.5913,-1539.4005,23.3290,181.7824,74,1);
	AddStaticVehicle(517,2337.4434,-1616.2424,19.9679,178.3311,40,36);
	AddStaticVehicle(566,2262.1306,-1478.7106,22.1663,88.5553,95,1);
	AddStaticVehicle(412,2207.7288,-1531.9718,23.7446,177.3930,29,8);
	AddStaticVehicle(536,2200.2412,-1453.9589,24.3301,270.7949,32,1);
	AddStaticVehicle(426,2217.6772,-1430.2889,23.6542,359.1011,42,42);
	AddStaticVehicle(534,2266.8494,-1433.9316,23.6338,357.1046,42,42);
	AddStaticVehicle(442,2228.7012,-1365.9402,23.8166,90.4700,36,0);
	AddStaticVehicle(442,2229.7041,-1327.3463,23.8088,90.8664,40,36);
	AddStaticVehicle(566,2229.6467,-1342.2701,23.2417,93.2184,72,8);
	AddStaticVehicle(468,2161.8586,-1367.5662,23.6533,179.4929,3,3);
	AddStaticVehicle(445,2137.7444,-1368.8391,24.4424,179.7440,39,39);
	AddStaticVehicle(426,2106.4336,-1363.9841,23.7293,180.5882,53,53);
	AddStaticVehicle(400,2031.3563,-1325.7827,23.6281,180.0303,123,1);
	AddStaticVehicle(407,1748.0942,-1456.9514,13.7750,270.5117,3,1);
	AddStaticVehicle(451,1719.8125,-1315.9056,13.1670,357.2494,16,16);
	AddStaticVehicle(478,1599.0344,-1331.7666,17.3550,178.1613,66,1);
	//AddStaticVehicle(522,1544.2523,-1361.4221,329.0371,358.8506,3,8);
	AddStaticVehicle(522,1547.6052,-1361.4109,329.0315,359.8624,8,82);
	AddStaticVehicle(426,1379.4064,-1245.9169,13.2043,92.2119,62,62);
	AddStaticVehicle(567,1362.6223,-1284.3108,13.3378,359.7848,97,96);
	AddStaticVehicle(567,1326.7445,-1275.6484,13.3320,90.3467,99,81);
	AddStaticVehicle(522,1364.2317,-1383.5945,13.2414,178.6118,3,8);
	AddStaticVehicle(527,1419.8622,-1446.2150,13.0788,269.2766,76,1);
	AddStaticVehicle(471,1461.1527,-1506.1143,13.0312,89.8903,120,117);
	AddStaticVehicle(427,1530.5841,-1646.0176,6.0225,179.2018,0,1);
	AddStaticVehicle(596,1538.7211,-1645.8385,5.6123,180.4580,0,1);
	AddStaticVehicle(528,1545.0261,-1667.6467,5.9341,90.9890,0,0);
	AddStaticVehicle(427,1600.3859,-1629.1858,13.6035,91.1682,0,1);
	AddStaticVehicle(523,1602.4486,-1621.3541,13.0622,87.4423,0,0);
	AddStaticVehicle(596,1601.2792,-1610.8031,13.2007,90.8496,0,1);
	AddStaticVehicle(497,1554.2573,-1608.6780,13.5587,246.0142,0,1);
	AddStaticVehicle(431,1483.9261,-1737.1431,13.5613,268.3948,71,59);
	AddStaticVehicle(565,1434.5592,-1649.9429,13.0872,357.4501,42,42);
	AddStaticVehicle(565,1411.6921,-1648.5232,13.0062,268.3765,53,53);
	AddStaticVehicle(561,1394.3085,-1780.9795,13.2749,181.0255,8,17);
	AddStaticVehicle(522,1374.0613,-1885.0767,13.0749,2.1159,7,79);
	AddStaticVehicle(500,1434.5951,-1993.7521,50.3211,19.6443,40,84);
	AddStaticVehicle(506,1417.7404,-871.9294,47.8901,260.3945,6,6);
	AddStaticVehicle(426,1429.3740,-882.1603,50.5648,26.1352,7,7);
	AddStaticVehicle(429,1463.7998,-902.1751,54.5156,355.2695,1,2);
	AddStaticVehicle(409,1518.8521,-875.8375,61.7881,44.0916,1,1);
	AddStaticVehicle(451,1537.2317,-842.0255,64.3198,88.8596,75,75);
	AddStaticVehicle(533,1503.5793,-837.1879,66.5801,151.6590,79,1);
	AddStaticVehicle(555,1531.2872,-813.4913,71.7056,89.5942,60,1);
	AddStaticVehicle(411,1515.2018,-766.4016,79.9192,137.4257,106,1);
	AddStaticVehicle(405,1483.9529,-692.9626,94.6250,242.6120,40,1);
	AddStaticVehicle(563,1466.8839,-669.7328,95.4540,184.4857,1,6);
	AddStaticVehicle(400,1451.1544,-717.9449,91.5874,202.4195,123,1);
	AddStaticVehicle(572,1432.7108,-643.6116,95.0483,57.7768,101,1);
	AddStaticVehicle(429,1460.2197,-634.3720,95.5032,180.2286,2,1);
	AddStaticVehicle(533,1372.3969,-576.9318,84.2693,266.0419,83,1);
	AddStaticVehicle(477,1362.7343,-620.8109,108.8572,285.2046,94,1);
	AddStaticVehicle(409,1242.8285,-806.8474,83.9408,179.7454,1,1);
	AddStaticVehicle(580,1254.6884,-805.4654,83.9368,357.9958,81,81);
	AddStaticVehicle(555,1248.5564,-805.5460,83.8251,178.3247,2,1);
	AddStaticVehicle(422,1272.3119,-830.9995,83.1292,299.5435,97,25);
	AddStaticVehicle(422,1291.3143,-830.5469,83.1276,47.3964,101,25);
	AddStaticVehicle(571,1305.6517,-797.6143,83.4246,197.8333,11,22);
	AddStaticVehicle(487,1290.8433,-790.1866,96.6353,6.3663,3,29);
	AddStaticVehicle(400,1089.0465,-635.2951,112.9034,268.8359,113,1);
	AddStaticVehicle(439,1088.9109,-640.9133,113.0148,271.9739,43,21);
	AddStaticVehicle(429,1052.2688,-639.5970,119.7969,91.5240,10,10);
	AddStaticVehicle(409,1011.1945,-658.3325,120.9421,33.2528,1,1);
	AddStaticVehicle(411,1006.6672,-662.9801,120.8734,30.0074,80,1);
	AddStaticVehicle(522,945.2007,-716.3558,121.7817,29.8445,3,8);
	AddStaticVehicle(477,864.6086,-712.3176,105.4079,332.9925,121,1);
	AddStaticVehicle(542,813.4797,-768.4810,76.0160,285.8720,24,118);
	AddStaticVehicle(475,789.5916,-821.4273,69.2429,12.1027,9,39);
	AddStaticVehicle(429,979.9902,-831.0175,95.3019,31.6829,13,13);
	AddStaticVehicle(555,1024.3285,-778.6536,102.7314,175.3497,36,1);
	AddStaticVehicle(580,1028.4117,-810.5958,101.6477,21.6466,61,61);
	AddStaticVehicle(411,1082.6403,-761.2158,107.4038,181.5630,75,1);
	AddStaticVehicle(461,870.1513,-847.8548,77.0143,169.1815,43,1);
	AddStaticVehicle(409,872.4217,-872.5833,77.4275,20.6548,1,1);
	AddStaticVehicle(522,829.7703,-886.5394,68.3421,240.3028,6,25);
	AddStaticVehicle(497,-1679.6797,707.6371,30.7845,88.1793,0,1);
	AddStaticVehicle(489,753.5113,-582.1860,17.4744,87.6277,120,123);
	AddStaticVehicle(508,771.9379,-551.5790,17.5746,3.0268,1,1);
	AddStaticVehicle(410,696.4998,-470.1266,15.9888,269.0383,84,1);
	AddStaticVehicle(599,613.7797,-602.0450,17.4209,271.6757,0,1);
	AddStaticVehicle(596,614.6026,-597.0176,16.9557,270.4748,0,1);
	AddStaticVehicle(553,306.9088,2063.9912,18.9922,181.7204,61,74);
	AddStaticVehicle(470,277.4086,1994.0979,17.6330,271.7856,43,0);
	AddStaticVehicle(470,280.6309,1985.1162,17.6343,267.9067,43,0);
	AddStaticVehicle(470,276.9229,1958.5323,17.6392,273.5289,43,0);
	AddStaticVehicle(433,281.2407,1953.2352,18.0769,274.8674,43,0);
	AddStaticVehicle(433,276.2394,2023.0872,18.0777,268.4416,43,0);
	AddStaticVehicle(423,1118.8361,1602.9048,12.5717,56.3379,1,53);
	AddStaticVehicle(588,1080.2139,1608.8333,12.4499,283.0216,1,1);
	AddStaticVehicle(507,315.7447,1152.2910,8.4117,89.1702,42,42);
	AddStaticVehicle(411,-1869.4142,857.6966,34.8101,92.9129,116,1);
	AddStaticVehicle(411,-1838.9938,833.1534,32.4945,267.3946,116,1);
	AddStaticVehicle(487,-1877.2249,784.1362,113.4645,353.7531,29,42);
	AddStaticVehicle(487,-1826.7954,902.6821,87.3719,266.2777,29,42);
	AddStaticVehicle(538,1738.3094,-1955.6108,13.2560,87.3638,-1,-1);
	AddStaticVehicle(449,-2006.5000,135.3289,27.9973,180.0000,-1,-1);
	AddStaticVehicle(467,2290.5852,-1676.9460,14.1029,6.1207,58,8);
	AddStaticVehicle(442,2255.2488,-1319.2679,23.8074,273.2591,11,105);
	AddStaticVehicle(576,2315.8213,-1278.4633,23.5435,89.7178,68,96);
	AddStaticVehicle(589,2470.2410,-1261.9911,26.0467,89.7582,31,31);
	AddStaticVehicle(600,2564.5300,-1266.5769,45.8566,181.6457,32,8);
	AddStaticVehicle(603,2427.1145,-1223.6403,25.1846,174.9334,18,1);
	AddStaticVehicle(605,2411.3064,-1237.1873,23.6615,270.2426,32,8);
	AddStaticVehicle(410,2424.7539,-1104.6060,41.2286,353.7196,25,1);
	AddStaticVehicle(419,2568.6213,-1099.7614,66.0282,45.6616,33,75);
	AddStaticVehicle(422,2486.6716,-1013.4405,65.3481,150.3296,101,25);
	AddStaticVehicle(436,2031.6680,-966.7542,40.8303,190.2201,92,1);
	AddStaticVehicle(439,1514.4991,-694.8356,94.6456,91.9354,54,38);
	AddStaticVehicle(458,944.7879,-840.8605,94.0654,34.4436,109,1);
	AddStaticVehicle(451,834.8312,-760.0735,84.8988,242.9383,18,18);
	AddStaticVehicle(471,1016.8055,-640.4919,120.2865,22.8124,74,91);
	AddStaticVehicle(474,910.6050,-664.0602,116.6983,237.9870,110,1);
	AddStaticVehicle(477,831.4391,-856.6163,69.6767,199.4115,94,1);
	AddStaticVehicle(479,687.8637,-1073.7809,49.2720,61.7845,59,36);
	AddStaticVehicle(483,346.7135,-1198.2335,76.5081,41.7442,1,20);
	AddStaticVehicle(492,253.4381,-1357.9250,52.8912,304.8589,81,27);
	AddStaticVehicle(495,541.4001,-1202.5719,44.9041,21.7688,119,122);
	AddStaticVehicle(500,680.8981,-1264.8258,13.6862,76.0390,40,84);
	AddStaticVehicle(473,719.2662,-1637.8140,-0.3253,359.9156,56,15);
	AddStaticVehicle(472,719.6095,-1702.1432,0.1004,189.5365,56,15);
	AddStaticVehicle(434,680.1243,-1829.8282,6.0126,261.0049,2,2);
	AddStaticVehicle(544,-2605.9827,348.0260,4.4184,83.5956,3,1);
	AddStaticVehicle(409,-2757.5269,375.2547,4.1410,176.6718,1,1);
	AddStaticVehicle(414,-2744.6746,973.8952,54.5533,3.8043,43,1);
	AddStaticVehicle(418,-2718.9600,981.4011,54.5557,5.5232,114,114);
	AddStaticVehicle(424,-2590.3108,899.4644,64.7659,0.8111,24,53);
	AddStaticVehicle(402,1882.1761,954.0123,10.6520,269.6830,39,39);
	AddStaticVehicle(411,1882.0510,960.4860,10.5474,271.4763,116,1);
	AddStaticVehicle(415,1881.9669,967.0225,10.5907,269.8757,36,1);
	AddStaticVehicle(429,2039.1671,999.2255,10.3516,178.3837,14,14);
	AddStaticVehicle(439,2129.0012,888.1301,10.7087,177.4140,8,17);
	AddStaticVehicle(451,2132.5991,1029.3433,10.5269,268.3974,36,36);
	AddStaticVehicle(451,2039.7676,1047.6312,10.3782,358.5389,36,36);
	AddStaticVehicle(451,2110.0938,1398.0092,10.5275,358.5416,36,36);
	AddStaticVehicle(477,2136.0415,1409.0038,10.5599,178.8837,94,1);
	AddStaticVehicle(477,2073.9607,1609.7820,10.4271,359.5528,94,1);
	AddStaticVehicle(506,2191.3025,1809.9684,10.5247,180.9512,6,6);
	AddStaticVehicle(521,2145.9282,1806.4209,10.3868,69.7910,75,13);
	AddStaticVehicle(522,2233.5361,1788.1121,10.3924,358.7466,36,105);
	AddStaticVehicle(535,2173.1863,1787.3798,10.5830,180.5368,66,1);
	AddStaticVehicle(541,2202.6157,1878.9254,10.4454,358.8321,58,8);
	AddStaticVehicle(541,2187.0181,2000.4918,10.4452,268.3104,58,8);
	AddStaticVehicle(451,2171.8254,1977.4331,10.5271,271.5660,46,46);
	AddStaticVehicle(411,2171.9736,1993.0500,10.5474,89.0826,106,1);
	AddStaticVehicle(411,2155.8806,2118.3806,10.3989,357.1316,106,1);
	AddStaticVehicle(411,2209.9241,2491.3066,10.5474,0.7505,106,1);
	AddStaticVehicle(506,2192.0637,2502.5715,10.5246,179.6127,76,76);
	AddStaticVehicle(598,2273.4568,2476.9617,10.5651,359.2619,0,1);
	AddStaticVehicle(598,2290.8213,2443.4663,10.5639,0.7513,0,1);
	AddStaticVehicle(598,2256.0911,2443.4539,10.5649,358.4428,0,1);
	AddStaticVehicle(598,2314.2966,2495.2759,3.0190,268.5978,0,1);
	AddStaticVehicle(598,2297.9507,2456.1570,3.0209,269.6137,0,1);
	AddStaticVehicle(598,2272.8394,2430.7886,3.0187,179.1313,0,1);
	AddStaticVehicle(598,2239.8132,2438.0820,3.0164,86.4948,0,1);
	AddStaticVehicle(402,2040.1128,1559.9341,10.5035,359.9707,13,13);
	AddStaticVehicle(521,2075.3313,2226.2896,10.3925,353.1345,75,13);
	AddStaticVehicle(521,2119.2336,1988.8817,10.2385,20.5787,75,13);
	AddStaticVehicle(409,2033.0109,1909.4553,12.0418,1.7639,1,1);
	AddStaticVehicle(409,2033.6027,1927.7786,12.0432,354.3028,1,1);
	AddStaticVehicle(409,2218.3711,1837.9954,10.6204,359.5183,1,1);
	AddStaticVehicle(409,2161.2544,1675.8177,10.5532,167.1293,1,1);
	AddStaticVehicle(409,2232.9058,1286.2864,10.5425,178.4740,1,1);
	AddStaticVehicle(415,2039.6688,1348.5322,10.4440,180.6409,20,1);
	AddStaticVehicle(415,2172.5552,1988.8611,10.5924,270.0703,20,1);
	AddStaticVehicle(415,2103.0676,2207.0649,10.5911,356.4005,20,1);
	AddStaticVehicle(415,2370.9861,2578.8425,10.5931,2.1535,20,1);
	AddStaticVehicle(451,2327.5078,2575.8103,10.5244,183.9150,46,46);
	AddStaticVehicle(506,2348.6646,2578.4822,10.5183,0.5199,76,76);
	AddStaticVehicle(506,2508.9048,2512.2939,10.5248,268.9881,76,76);
	AddStaticVehicle(506,2454.5403,2496.0815,21.5792,1.1583,76,76);
	AddStaticVehicle(451,2506.9705,2493.9063,21.5840,269.4263,75,75);
	AddStaticVehicle(522,2529.4746,2516.0884,21.4344,67.6782,7,79);
	AddStaticVehicle(522,2511.0935,2355.4475,10.3849,266.6987,7,79);
	AddStaticVehicle(451,2510.4124,2379.4268,10.5267,87.5835,125,125);
	AddStaticVehicle(451,2514.2822,2377.0471,3.9170,273.3658,125,125);
	AddStaticVehicle(451,2565.4661,2258.1277,10.5275,89.3742,125,125);
	AddStaticVehicle(506,2581.9695,2271.3857,10.5249,90.3656,3,3);
	AddStaticVehicle(541,2610.7024,2271.2053,10.4452,268.7214,68,8);
	AddStaticVehicle(409,2637.9912,2347.8828,10.4719,267.7343,1,1);
	AddStaticVehicle(506,2623.9175,2206.2439,10.5244,178.5255,6,6);
	AddStaticVehicle(506,2006.2783,2312.6086,10.5247,0.4430,6,6);
	AddStaticVehicle(451,1861.6022,2243.2703,10.5272,177.6018,36,36);
	AddStaticVehicle(455,1724.1365,2344.3298,11.2579,212.1348,32,74);
	AddStaticVehicle(451,1702.1085,2243.4651,10.5268,352.7067,36,36);
	AddStaticVehicle(456,1747.1049,2236.0615,10.9937,267.0810,12,95);
	AddStaticVehicle(498,1747.3081,2210.1519,10.8899,90.5724,11,123);
	AddStaticVehicle(499,1747.5114,2192.6729,10.8147,88.0630,30,44);
	AddStaticVehicle(515,1746.9943,2220.0962,11.8302,89.7674,42,76);
	AddStaticVehicle(541,1612.5308,2210.2856,10.4453,89.0040,2,1);
	AddStaticVehicle(506,1613.3693,2200.5212,10.5247,267.4624,76,76);
	AddStaticVehicle(451,1593.8029,2189.3835,10.5259,89.9404,16,16);
	AddStaticVehicle(412,1837.8177,-1869.9449,13.2269,0.2290,11,1);
	AddStaticVehicle(421,2055.8550,-1904.9235,13.4294,0.6250,30,1);
	AddStaticVehicle(421,1928.6410,-2142.0146,13.4440,0.6307,30,1);
	AddStaticVehicle(423,1948.1849,-2133.2405,13.5670,270.3376,1,53);
	AddStaticVehicle(485,1874.0948,-2297.1113,13.2065,271.0407,1,75);
	AddStaticVehicle(485,1992.5037,-2308.5859,13.2034,183.4787,1,75);
	AddStaticVehicle(487,1829.3319,-2421.3125,13.7298,213.8274,3,29);
	AddStaticVehicle(511,2117.2219,-2476.6731,14.9203,93.6505,12,60);
	AddStaticVehicle(519,2002.0490,-2620.6682,14.4688,359.3576,1,1);
	AddStaticVehicle(563,1475.1953,-2431.9106,14.7289,173.2142,1,6);
	AddStaticVehicle(566,1063.3035,-1754.8824,13.2105,271.8399,95,1);
	AddStaticVehicle(413,2348.6191,-1997.7170,13.4504,179.0335,105,1);
	AddStaticVehicle(414,2748.0964,-2445.2803,13.7429,91.9314,67,1);
	AddStaticVehicle(414,2748.0007,-2468.3755,13.7423,268.3236,25,1);
	AddStaticVehicle(431,1828.9916,-1395.9996,13.5204,91.1773,47,74);
	AddStaticVehicle(463,1865.3689,-1403.2109,13.0217,268.8262,11,11);
	AddStaticVehicle(463,1865.4507,-1401.1575,13.0274,264.3066,19,19);
	AddStaticVehicle(463,1865.4010,-1398.7721,13.0282,269.0854,22,22);
	AddStaticVehicle(463,1865.5385,-1396.8900,13.0298,268.6366,36,36);
	AddStaticVehicle(463,1865.1497,-1395.1691,13.0296,271.6035,53,53);
	AddStaticVehicle(462,1883.0397,-1402.7933,13.1685,321.6162,1,2);
	AddStaticVehicle(461,1865.2985,-1409.8779,13.0826,267.3351,43,1);
	AddStaticVehicle(461,1865.1888,-1406.2632,13.0625,273.7295,53,1);
	AddStaticVehicle(522,1910.5208,-1414.8583,13.1390,2.7341,36,105);
	AddStaticVehicle(522,1915.3735,-1414.9282,13.1407,4.2695,39,106);
	AddStaticVehicle(522,1926.5260,-1413.9901,13.1402,9.7083,51,118);
	AddStaticVehicle(522,1924.7205,-1414.1868,13.1410,6.7691,3,3);
	AddStaticVehicle(522,1922.2194,-1414.0645,13.1323,1.7873,3,8);
	AddStaticVehicle(481,1907.5153,-1438.5917,13.0646,184.0349,6,6);
	AddStaticVehicle(481,1911.6127,-1438.5548,13.0661,180.3133,46,46);
	AddStaticVehicle(510,1913.6503,-1438.4033,13.1584,183.5292,39,39);
	AddStaticVehicle(471,1917.7300,-1438.0747,13.0339,181.0119,120,114);
	AddStaticVehicle(471,1920.8787,-1438.2892,13.0313,175.0454,74,91);
	AddStaticVehicle(416,1179.8257,-1338.4535,13.9367,270.3495,1,3);
	AddStaticVehicle(416,1179.2936,-1308.8552,13.9205,271.3345,1,3);
	AddStaticVehicle(422,1010.5247,-1367.5598,13.3397,0.3258,111,31);
	AddStaticVehicle(488,772.4777,-1348.1410,13.7064,45.1116,2,26);
	AddStaticVehicle(492,524.2675,-1483.1439,14.2773,175.8079,24,55);
	AddStaticVehicle(424,491.0125,-1819.9658,5.3286,184.9281,3,2);
	AddStaticVehicle(424,327.8460,-1789.2728,4.6120,359.6221,3,2);
	AddStaticVehicle(457,318.0788,-1807.9807,4.1318,181.8893,63,1);
	AddStaticVehicle(457,337.3136,-1809.1741,4.1387,0.2485,45,1);
	AddStaticVehicle(467,547.5541,-1286.3242,16.9882,343.3277,60,1);
	AddStaticVehicle(468,1904.6671,-1353.7904,13.1437,178.8215,6,6);
	AddStaticVehicle(468,1898.1074,-1353.6400,13.1496,177.2491,46,46);
	AddStaticVehicle(468,1878.1576,-1364.2582,14.3098,181.0864,53,53);
	AddStaticVehicle(468,1954.1672,-1372.8142,19.3177,269.3129,53,53);
	AddStaticVehicle(416,1999.9729,-1416.3391,17.1421,178.7646,1,3);
	AddStaticVehicle(416,2033.0020,-1446.6805,17.3751,91.7940,1,3);
	AddStaticVehicle(444,1535.9631,-1364.3883,329.8347,340.7065,32,32);
	AddStaticVehicle(444,1554.2153,-1363.6304,329.8316,31.3378,32,32);
	AddStaticVehicle(474,2393.0313,-1926.4108,13.1454,1.3092,110,1);
	AddStaticVehicle(474,2533.3462,-2008.7177,13.3078,107.7556,110,1);
	AddStaticVehicle(478,1199.4252,-884.1469,42.9888,92.5699,45,1);
	AddStaticVehicle(442,922.3729,-1083.4695,24.1181,358.9449,75,36);
	AddStaticVehicle(442,930.5671,-1067.5444,24.1216,181.4083,75,36);
	AddStaticVehicle(445,1567.3541,-1012.2565,23.7851,359.2173,43,43);
	AddStaticVehicle(448,1684.9083,-1035.5687,23.5057,181.6496,3,6);
	AddStaticVehicle(475,1695.8376,-1006.7072,23.7068,16.4063,2,39);
	AddStaticVehicle(483,1756.6492,-1035.4084,23.9533,181.0603,3,6);
	AddStaticVehicle(499,1803.2363,-1084.8929,23.9524,181.0723,84,66);
	AddStaticVehicle(404,1118.4491,-1495.6190,15.5325,178.9188,123,92);
	AddStaticVehicle(404,1141.2595,-1497.0906,15.5302,0.2908,123,92);
	AddStaticVehicle(574,-2351.8037,-1635.7314,483.4283,266.3210,26,26);
	AddStaticVehicle(522,-2351.5837,-1632.0994,483.2554,271.5515,36,105);
	AddStaticVehicle(423,-2353.6289,-1628.7333,483.7032,273.5668,1,17);
	AddStaticVehicle(429,-2353.1082,-1622.4164,483.3421,256.1650,1,2);
	AddStaticVehicle(436,-2352.9287,-1616.2721,483.4117,262.8937,95,1);
	AddStaticVehicle(451,2074.1838,1272.5265,10.3788,0.7266,61,61);
	AddStaticVehicle(480,1920.6165,953.6292,10.5862,92.4785,12,12);
	AddStaticVehicle(541,1920.9280,960.9136,10.4434,91.2964,13,8);
	AddStaticVehicle(522,1901.8279,946.9430,10.3841,178.2387,36,105);
	AddStaticVehicle(521,1897.9597,947.0371,10.3781,181.6115,115,118);
	AddStaticVehicle(522,1671.7450,987.8455,10.3745,24.4674,36,105);
	AddStaticVehicle(506,1680.8236,987.4741,10.5248,179.4031,52,52);
	AddStaticVehicle(506,1814.0461,1356.2902,6.4973,358.1068,52,52);
	AddStaticVehicle(420,1726.9836,1518.9500,10.5222,171.2969,6,1);
	AddStaticVehicle(420,1721.8710,1495.5359,10.5168,162.6962,6,1);
	AddStaticVehicle(420,1715.3396,1473.3627,10.5214,162.8368,6,1);
	AddStaticVehicle(420,1708.0063,1446.5009,10.5299,160.4660,6,1);
	AddStaticVehicle(420,1706.7908,1428.6458,10.3512,184.0946,6,1);
	AddStaticVehicle(416,1592.9238,1849.8015,10.9702,359.7261,1,3);
	AddStaticVehicle(416,1605.2347,1849.2566,10.9677,176.2567,1,3);
	AddStaticVehicle(416,1608.2552,1831.5017,10.9690,175.1553,1,3);
	AddStaticVehicle(603,1920.4119,957.2501,10.6507,269.1129,75,77);
	AddStaticVehicle(603,2394.3320,987.5118,10.6585,357.9387,75,77);
	AddStaticVehicle(603,2628.0364,1167.5146,10.6583,355.5161,75,77);
	AddStaticVehicle(506,2624.0845,1238.8961,10.5248,90.0268,3,3);
	AddStaticVehicle(506,2258.4600,1198.9313,10.4474,87.3344,3,3);
	AddStaticVehicle(506,1952.6752,1325.7380,8.8845,2.2469,3,3);
	AddStaticVehicle(506,1673.1630,1297.8597,10.5246,1.3236,3,3);
	AddStaticVehicle(522,1654.0508,1614.9730,10.3911,89.9927,3,3);
	AddStaticVehicle(522,1653.3939,1631.1367,10.3903,273.5416,3,3);
	AddStaticVehicle(522,1653.3153,1640.0421,10.3907,85.6532,3,3);
	AddStaticVehicle(506,1709.7206,1574.6658,10.5019,79.0680,6,6);
	AddStaticVehicle(451,1710.5714,1580.9457,10.3863,88.8871,16,16);
	AddStaticVehicle(411,1712.8234,1588.0392,10.1468,83.2691,12,1);
	AddStaticVehicle(541,1709.8379,1564.2114,10.3793,279.7047,36,8);
	AddStaticVehicle(603,1709.0184,1569.2386,10.6171,81.9562,18,1);
	AddStaticVehicle(593,1353.1289,1698.8951,11.2804,303.5530,68,8);
	AddStaticVehicle(469,1356.3201,1720.1597,10.8328,84.5665,1,3);
	AddStaticVehicle(476,1342.1444,1734.6641,11.5336,272.2384,7,6);
	AddStaticVehicle(487,1353.1433,1749.9968,10.9978,58.9344,26,3);
	AddStaticVehicle(487,1354.8773,1767.5679,11.0137,176.5491,26,3);
	AddStaticVehicle(420,-1987.1251,107.2585,27.3863,179.5096,6,1);
	AddStaticVehicle(420,-1987.1217,118.2273,27.3898,180.0185,6,1);
	AddStaticVehicle(420,-1987.1500,134.6486,27.3894,180.0259,6,1);
	AddStaticVehicle(420,-1987.1802,149.6286,27.3894,180.0776,6,1);
	AddStaticVehicle(420,-1987.2130,163.3889,27.3894,180.1264,6,1);
	AddStaticVehicle(420,-1987.2411,181.7285,27.3853,179.9982,6,1);
	AddStaticVehicle(560,-2033.8055,179.1840,28.5489,270.7278,9,39);
	AddStaticVehicle(561,-2033.8508,170.9949,28.6497,272.1378,8,17);
	AddStaticVehicle(561,-1958.8131,302.7149,35.2853,179.6627,8,17);
	AddStaticVehicle(565,-1948.7212,259.6898,35.0933,31.2393,53,53);
	AddStaticVehicle(568,-1944.8381,268.4719,35.3408,85.0980,17,1);
	AddStaticVehicle(580,-1945.8995,273.1898,35.2701,91.2441,67,67);
	AddStaticVehicle(585,-1950.9474,268.8344,40.6348,41.9786,53,53);
	AddStaticVehicle(587,-1975.5262,898.4756,44.9288,180.7182,72,1);
	AddStaticVehicle(587,-1985.2399,898.0829,44.9307,179.5413,75,1);
	AddStaticVehicle(442,-2041.2239,1116.1007,53.1204,84.6825,36,0);
	AddStaticVehicle(442,-2040.5057,1108.5195,53.1246,89.7474,36,0);
	AddStaticVehicle(589,-1985.0587,1341.2925,6.8422,182.3013,7,7);
	AddStaticVehicle(411,-1656.6176,1213.9949,6.9769,289.9662,123,1);
	AddStaticVehicle(418,-1657.4347,1212.6448,13.7676,124.9584,108,108);
	AddStaticVehicle(597,-1573.9816,743.1966,-5.4744,268.6024,0,1);
	AddStaticVehicle(597,-1600.0872,676.5780,-5.4740,180.1876,0,1);
	AddStaticVehicle(597,-1638.7655,682.5631,-5.4738,89.4294,0,1);
	AddStaticVehicle(597,-1608.5128,691.5226,-5.4733,179.0019,0,1);
	AddStaticVehicle(425,370.8374,1982.7158,18.2119,176.5680,43,0);
	AddStaticVehicle(425,372.0126,1938.5544,18.2100,229.8271,43,0);
	AddStaticVehicle(520,275.2755,2048.7795,18.3633,181.7498,0,0);
	AddStaticVehicle(432,278.6241,1933.5564,17.6515,343.0715,43,0);
	AddStaticVehicle(432,359.6037,1913.9871,17.6456,316.0831,43,0);
	AddStaticVehicle(470,115.8998,1900.4111,18.5452,5.0724,43,0);
	AddStaticVehicle(470,123.5806,1904.2921,18.6305,3.5569,43,0);
	AddStaticVehicle(433,180.1651,1930.0607,18.4241,179.3683,43,0);
	AddStaticVehicle(433,160.5292,1905.0585,19.1472,1.4859,43,0);
	AddStaticVehicle(597,-1593.9238,652.1296,6.9562,0.2590,0,1);
	AddStaticVehicle(597,-1605.3199,650.8818,6.9552,356.8932,0,1);
	AddStaticVehicle(523,-1600.1761,748.4938,-5.6722,183.6882,0,0);
	AddStaticVehicle(523,-1588.9227,748.3679,-5.6704,179.9672,0,0);
	AddStaticVehicle(472,-1476.7904,694.5764,0.0150,183.8784,56,53);
	AddStaticVehicle(493,-1476.5304,687.7230,-0.0625,1.7208,36,13);
	AddStaticVehicle(519,-1379.6605,-228.5971,15.0705,315.4794,1,1);
	AddStaticVehicle(487,-1186.1956,26.4966,14.3255,211.5488,74,35);
	AddStaticVehicle(488,-1231.9817,-8.5000,14.3259,44.9000,2,29);
	AddStaticVehicle(417,1344.7661,1382.7399,10.9096,244.4116,0,0);
	AddStaticVehicle(513,1284.9008,1361.7461,11.3712,273.2211,54,34);
	AddStaticVehicle(513,1285.3335,1325.0874,11.3733,272.9690,54,34);
	AddStaticVehicle(513,1296.9412,1377.2367,11.3760,221.4396,54,34);
	AddStaticVehicle(593,1366.8563,1493.3700,11.2805,210.3932,68,8);
	AddStaticVehicle(553,1477.8314,1274.6060,10.7372,0.8493,8,7);
	AddStaticVehicle(602,-2480.1831,1071.2307,55.5932,1.8060,69,1);
	AddStaticVehicle(603,-2472.6523,1069.2368,55.6125,3.0823,13,1);
	AddStaticVehicle(605,-2360.0881,1021.0844,50.5167,291.0907,67,8);
	AddStaticVehicle(563,-2227.6787,2323.5820,8.2339,6.1247,1,6);
	AddStaticVehicle(473,-2218.7727,2395.9268,-0.2887,46.3572,56,53);
	AddStaticVehicle(473,-2227.2131,2403.5825,-0.3304,50.3428,56,15);
	AddStaticVehicle(473,-2235.1072,2396.9438,-0.2718,45.4929,56,15);
	AddStaticVehicle(473,-2229.2598,2392.1467,-0.1760,46.3962,56,53);
	AddStaticVehicle(539,-2257.0322,2430.6726,0.3304,222.1085,86,70);
	AddStaticVehicle(549,-2193.0286,293.7254,34.8141,0.5224,72,39);
	AddStaticVehicle(400,-2217.5325,307.0669,35.2095,355.6835,123,1);
	AddStaticVehicle(419,-2235.5986,293.5063,34.9144,1.8155,47,76);
	AddStaticVehicle(424,-2266.5518,133.1931,34.9535,89.0396,3,6);
	AddStaticVehicle(508,-2269.4131,81.6356,35.5435,90.0610,1,1);
	AddStaticVehicle(491,-2318.7168,-126.0670,35.0686,182.1095,71,72);
	AddStaticVehicle(468,-2326.0000,-124.8521,34.9815,182.5400,46,46);
	AddStaticVehicle(571,-2344.8049,-126.6489,34.5963,359.6448,2,35);
	AddStaticVehicle(402,-2672.8689,-34.9518,4.1674,1.3846,110,110);
	AddStaticVehicle(429,-2683.3755,-22.2932,4.0156,178.7405,2,1);
	AddStaticVehicle(410,-2676.5879,-54.2795,3.9888,179.8918,9,1);
	AddStaticVehicle(415,-2770.1621,-295.4528,6.8120,178.7402,92,1);
	AddStaticVehicle(557,-2752.3884,-295.8544,7.4159,356.8052,1,1);
	AddStaticVehicle(422,-2796.1794,135.5030,7.1799,90.4847,101,25);
	AddStaticVehicle(472,-2953.2971,500.4120,0.3825,174.2858,56,53);
	AddStaticVehicle(416,-2544.2502,610.5790,14.6021,273.1309,1,3);
	AddStaticVehicle(416,-2573.0222,628.2946,14.6034,86.1379,1,3);
	AddStaticVehicle(416,-2582.2434,659.3068,14.6029,357.9334,1,3);
	AddStaticVehicle(486,-2469.8918,740.7175,35.2351,0.4309,1,1);
	AddStaticVehicle(552,-2494.5212,740.5241,34.7122,179.8260,49,49);
	AddStaticVehicle(443,-1947.4006,582.1632,35.7523,358.8390,20,1);
	AddStaticVehicle(410,-1959.3347,585.2523,34.7741,180.0034,10,1);
	AddStaticVehicle(429,1929.1346,697.4724,10.5072,180.2551,1,3);
	AddStaticVehicle(522,1923.0559,697.6785,10.3911,173.5855,7,7);
	AddStaticVehicle(451,1935.5146,709.7194,10.5268,0.1359,75,75);
	AddStaticVehicle(411,1916.5685,709.1528,10.5474,359.6668,64,1);
	AddStaticVehicle(407,1763.4819,2075.6494,11.0555,182.9893,3,1);
	AddStaticVehicle(407,1757.1030,2075.7246,11.0549,180.4046,3,1);
	AddStaticVehicle(525,1644.1111,2196.3069,10.6981,180.3533,17,20);
	AddStaticVehicle(525,1632.4647,2196.1550,10.6985,181.1443,18,20);
	AddStaticVehicle(409,2597.7344,1690.7073,10.6203,91.3475,1,1);
	AddStaticVehicle(418,2611.5566,1694.2747,10.9131,270.4373,95,95);
	AddStaticVehicle(566,2604.2744,1792.8124,10.6002,270.1129,84,8);
	AddStaticVehicle(588,1537.8708,2215.0393,10.7263,359.5805,1,1);
	AddStaticVehicle(490,2276.9431,2475.0476,3.4019,1.3256,0,0);
	AddStaticVehicle(490,2239.9507,2461.3250,3.4019,91.0709,0,0);
	AddStaticVehicle(404,2161.7500,-1794.7538,13.0963,180.1745,109,100);
	AddStaticVehicle(566,2165.5925,-1794.4922,13.1420,181.6179,84,8);
	AddStaticVehicle(567,2170.0979,-1794.2892,13.2336,180.0801,97,96);
	AddStaticVehicle(508,2682.0120,-1673.1191,9.7991,177.9372,1,1);
	AddStaticVehicle(491,2696.6240,-1673.1011,9.2413,359.5916,52,66);
	AddStaticVehicle(429,2831.0444,-1689.2819,9.6686,257.8022,1,3);
	AddStaticVehicle(488,2785.5208,-1865.5787,9.9966,170.0859,2,29);
	AddStaticVehicle(531,2281.1953,-47.9510,26.9780,177.6954,36,2);
	AddStaticVehicle(400,2298.6658,-119.8532,27.4693,2.7231,113,1);
	AddStaticVehicle(415,2201.3611,-66.0823,27.1809,271.2696,20,1);
	AddStaticVehicle(485,2238.3247,-13.6707,26.4952,175.9621,1,76);
	AddStaticVehicle(456,2469.4524,75.6340,26.5792,0.2262,102,65);
	AddStaticVehicle(418,1352.6860,255.1298,19.5696,333.8116,108,108);
	AddStaticVehicle(448,1360.9049,248.5348,19.1657,48.2342,3,6);
	AddStaticVehicle(456,1350.4504,356.4907,20.0513,65.7283,110,93);
	AddStaticVehicle(583,1280.1830,380.4268,19.0949,245.8823,1,1);
	AddStaticVehicle(448,206.1462,-205.7276,1.1765,175.7484,3,6);
	AddStaticVehicle(455,221.7484,24.5014,3.0142,269.6370,32,74);
	AddStaticVehicle(468,91.3439,-164.1712,2.2629,276.3611,53,53);
	AddStaticVehicle(573,65.7817,-282.0732,2.2283,181.6544,86,24);
	AddStaticVehicle(407,-2019.6420,84.2114,28.1188,269.3656,3,1);
	AddStaticVehicle(407,-2022.1603,92.2716,28.3101,269.7193,3,1);
	AddStaticVehicle(409,-1755.5055,952.7491,24.5413,93.3441,1,1);
	AddStaticVehicle(415,-1737.0625,1024.4463,17.3579,88.3876,0,1);
	AddStaticVehicle(419,-1687.4375,1032.7346,17.3834,269.7573,33,75);
	AddStaticVehicle(421,-1693.2766,977.5120,17.4684,179.4667,95,1);
	AddStaticVehicle(429,-2129.0261,1187.6202,55.4083,182.1625,2,1);
	AddStaticVehicle(496,-1786.4386,1205.8181,24.8413,182.5069,66,72);
	AddStaticVehicle(527,-1842.2102,1092.8308,45.1608,87.1436,53,1);
	AddStaticVehicle(529,-2636.5168,932.6116,71.4718,180.1981,42,42);
	AddStaticVehicle(533,-2651.6069,855.2545,63.7188,329.0188,74,1);
	AddStaticVehicle(535,-2695.9761,826.0124,49.7514,181.1090,28,1);
	AddStaticVehicle(540,-2155.9697,835.2351,69.4157,271.8333,42,42);
	AddStaticVehicle(409,-2413.8376,328.5027,34.7702,150.2072,1,1);
	AddStaticVehicle(483,-2528.1685,-33.2180,25.6091,291.3264,1,5);
	AddStaticVehicle(489,-2797.2883,-136.7519,7.3303,88.1056,14,123);
	AddStaticVehicle(457,-2505.1147,-305.6113,38.9177,258.1051,2,1);
	AddStaticVehicle(457,-2311.3601,-262.5432,42.7317,9.2773,2,1);
	AddStaticVehicle(422,-2152.8813,-166.4486,35.3116,264.6697,67,59);
	AddStaticVehicle(422,-2107.4170,-271.2023,35.3250,355.9126,67,59);
	AddStaticVehicle(544,-2020.5365,74.5346,28.3576,272.0969,3,1);
	AddStaticVehicle(547,-2141.6951,-429.5009,35.0715,158.9814,123,1);
	AddStaticVehicle(550,-2122.7061,-483.0810,35.2520,204.0050,42,42);
	AddStaticVehicle(551,-2052.0112,-501.1217,35.1364,270.1396,72,1);
	AddStaticVehicle(554,-2008.7917,-500.3151,35.4250,271.2854,15,32);
	AddStaticVehicle(451,2221.7620,736.2302,11.1679,179.8096,125,125);
	AddStaticVehicle(451,2308.4170,694.5885,11.1201,4.2688,125,125);
	AddStaticVehicle(409,2354.5557,736.2498,11.2683,179.8335,1,1);
	AddStaticVehicle(560,2451.6016,697.8967,11.1658,89.0457,52,39);
	AddStaticVehicle(561,2556.2712,747.2149,10.6337,182.7173,54,38);
	AddStaticVehicle(565,2626.4668,748.2969,10.4457,182.2970,10,10);
	AddStaticVehicle(531,2683.5994,846.8790,8.7169,88.3647,51,53);
	AddStaticVehicle(543,2625.0217,814.3141,5.1367,358.8951,32,8);
	AddStaticVehicle(543,2606.4194,836.2809,5.0235,268.0660,32,8);
	AddStaticVehicle(567,2664.7275,-1999.1934,13.3331,270.9636,102,114);
	AddStaticVehicle(576,2684.9136,-1984.6302,13.1604,358.3811,72,1);
	AddStaticVehicle(536,2684.3440,-2024.5045,13.2520,359.2501,26,96);
	AddStaticVehicle(412,2651.8494,-2041.4044,13.3878,1.0336,10,8);
	AddStaticVehicle(534,2659.6794,-2036.6785,13.2731,89.3725,10,10);
	AddStaticVehicle(535,2642.6682,-2005.0203,13.2329,181.3551,66,1);
	AddStaticVehicle(437,2810.5869,1342.1926,10.8833,90.1766,79,7);
	AddStaticVehicle(541,2832.1470,1278.4384,10.4005,84.6853,22,1);
	AddStaticVehicle(543,2828.2451,2010.2964,10.6412,177.9908,43,8);
	AddStaticVehicle(546,2821.2942,2230.7983,10.5442,92.7330,2,62);
	AddStaticVehicle(547,2792.9785,2180.0063,10.5473,309.9872,10,1);
	AddStaticVehicle(549,2879.5081,2342.2522,10.5174,87.7677,84,36);
	AddStaticVehicle(555,2840.9656,2360.4492,10.4980,91.2130,58,1);
	AddStaticVehicle(558,2815.1152,2360.8926,10.4504,90.1832,116,1);
	AddStaticVehicle(562,2815.0713,2338.2432,10.4730,90.6439,35,1);
	AddStaticVehicle(575,2810.2813,2591.2000,9.9934,43.9830,19,96);
	AddStaticVehicle(573,2822.6272,2603.7356,11.4710,43.2390,85,6);
	AddStaticVehicle(578,2143.5337,2802.6719,11.4462,89.2507,1,1);
	AddStaticVehicle(579,2166.9260,2750.8633,10.7485,269.6641,42,42);
	AddStaticVehicle(516,1961.5433,2732.2888,10.6543,359.7515,119,1);
	AddStaticVehicle(516,1918.5258,2760.0166,10.6536,88.9786,119,1);
	AddStaticVehicle(518,1976.1675,2657.0713,10.4981,181.0966,37,0);
	AddStaticVehicle(524,2200.3406,2788.2622,11.7519,180.0415,61,27);
	AddStaticVehicle(527,2027.4601,2731.9160,10.5359,3.9644,75,1);
	AddStaticVehicle(527,1870.8438,2591.5154,10.5358,0.9877,75,1);
	AddStaticVehicle(534,1867.9719,2626.1719,10.5430,359.8385,11,11);
	AddStaticVehicle(540,1817.7302,2639.3237,10.6796,183.9044,62,62);
	AddStaticVehicle(542,1626.7671,2602.7095,10.5704,180.9128,31,93);
	AddStaticVehicle(546,1353.2643,2599.7087,10.5451,182.3614,2,78);
	AddStaticVehicle(550,1272.5564,2603.7021,10.6440,179.8936,7,7);
	AddStaticVehicle(457,1275.7573,2827.5259,10.4468,324.1442,63,1);
	AddStaticVehicle(457,1357.6268,2775.1362,10.4458,243.3050,63,1);
	AddStaticVehicle(462,1423.7108,2860.1746,10.4164,87.4953,2,1);
	AddStaticVehicle(467,1464.3319,2877.7041,10.5604,357.2351,2,1);
	AddStaticVehicle(474,1492.1610,2877.6313,10.5831,359.5744,97,1);
	AddStaticVehicle(477,1529.8492,2827.4319,10.5745,268.4694,121,1);
	AddStaticVehicle(479,646.7964,1703.7297,6.7888,128.9424,59,36);
	AddStaticVehicle(482,653.4738,1695.3479,7.1119,133.4062,71,71);
	AddStaticVehicle(485,649.9169,1713.6934,6.6534,220.7768,1,76);
	AddStaticVehicle(409,711.8459,1946.4647,5.3391,2.1466,1,1);
	AddStaticVehicle(413,685.9656,1945.8607,5.6313,179.7174,105,1);
	AddStaticVehicle(418,726.4732,1947.4772,5.6322,180.1127,41,41);
	AddStaticVehicle(423,923.5570,2011.9662,11.3786,88.4600,1,5);
	AddStaticVehicle(429,1040.2190,2315.3726,11.1482,180.5029,1,3);
	AddStaticVehicle(436,1385.2469,2283.3167,10.5897,89.2144,95,1);
	AddStaticVehicle(517,1369.4264,2249.3345,10.6752,89.5137,36,36);
	AddStaticVehicle(521,1338.2552,2249.6672,10.3871,91.1326,25,118);
	AddStaticVehicle(526,1686.7671,2086.6204,11.2258,273.4098,9,39);
	AddStaticVehicle(533,1656.5085,1916.7396,10.5294,1.0359,79,1);
	AddStaticVehicle(527,1606.6709,1970.8319,10.5356,186.6481,81,1);
	AddStaticVehicle(545,1731.4089,1897.5214,10.6314,90.2163,39,1);
	AddStaticVehicle(539,1742.6149,1944.6404,10.1803,272.3510,70,86);
	AddStaticVehicle(546,1743.9423,1994.2346,10.5446,89.8117,78,38);
	AddStaticVehicle(550,1742.8629,2015.2640,10.6397,88.4918,10,10);
	AddStaticVehicle(554,1600.8595,2046.1823,11.4614,272.3599,14,32);
	AddStaticVehicle(558,1644.0264,2132.2295,10.8310,88.2603,24,1);
	AddStaticVehicle(559,1595.8378,2140.5386,11.1173,272.3750,58,8);
	AddStaticVehicle(544,1700.4879,2190.6245,11.0568,31.3358,3,1);
	AddStaticVehicle(403,1687.3871,2197.6362,11.4274,90.3561,37,1);
	AddStaticVehicle(519,1389.5282,1291.3912,11.7413,3.9789,1,1);
	AddStaticVehicle(525,1322.3698,1278.2693,10.6962,181.3949,22,30);
	AddStaticVehicle(529,1282.4486,1294.2015,10.4524,270.2072,10,10);
	AddStaticVehicle(411,298.1414,2257.1589,79.1856,3.4631,12,1);
	AddStaticVehicle(522,295.1747,2256.8528,79.0313,2.4226,39,106);
	AddStaticVehicle(522,289.2234,2257.4199,79.0312,2.5444,39,106);
	AddStaticVehicle(522,283.5193,2256.3870,79.0252,357.9383,39,106);
	AddStaticVehicle(463,311.7048,2255.0786,78.9992,355.7463,84,84);
	AddStaticVehicle(463,318.1136,2255.0659,78.9977,8.3752,84,84);
	AddStaticVehicle(553,403.5253,2450.2732,17.8365,0.9174,102,119);
	AddStaticVehicle(455,-217.9229,2731.4971,63.1250,270.6873,32,74);
	AddStaticVehicle(522,-223.0802,2596.2004,62.2572,182.2533,51,118);
	AddStaticVehicle(461,-213.8152,2595.6284,62.2795,7.3623,37,1);
	AddStaticVehicle(400,-237.2677,2608.3826,62.7955,357.7208,62,1);
	AddStaticVehicle(485,-508.3430,2618.1951,53.0709,87.1178,1,77);
	AddStaticVehicle(417,-514.5479,2604.7351,53.5238,267.5091,0,0);
	AddStaticVehicle(400,-527.4479,2617.0930,53.5053,269.2497,40,1);
	AddStaticVehicle(486,2490.7573,1215.7017,11.0401,180.4235,1,1);
	AddStaticVehicle(491,2490.1526,1408.2457,10.5767,178.1604,64,72);
	AddStaticVehicle(492,2470.3208,1427.7280,10.6022,180.7492,81,27);
	AddStaticVehicle(494,2476.2026,1657.3116,10.7156,180.5848,75,79);
	AddStaticVehicle(496,2482.6326,1677.5767,10.5372,177.3915,37,19);
	AddStaticVehicle(455,-19.1958,-2505.5203,37.0915,123.1488,84,58);
	AddStaticVehicle(400,-32.9281,-2496.4541,36.7408,214.6823,123,1);
	AddStaticVehicle(483,28.4315,-2640.8943,40.4270,92.4743,1,31);
	AddStaticVehicle(483,-1108.7068,-1621.8759,76.3614,267.8538,1,5);
	AddStaticVehicle(489,-1427.1552,-1524.6484,101.8918,15.3141,14,123);
	AddStaticVehicle(489,-1424.2979,-1495.3447,103.7877,357.5428,14,123);
	AddStaticVehicle(455,-1858.7666,-1615.8866,22.2675,186.5272,84,31);
	AddStaticVehicle(486,-1818.6582,-1619.1652,23.2353,182.6284,1,1);
	AddStaticVehicle(531,-1832.6295,-1694.6039,21.7144,40.5223,36,2);
	AddStaticVehicle(534,-2147.0852,-2444.3333,30.3487,141.0836,62,62);
	AddStaticVehicle(543,-2151.0076,-2546.3962,30.4396,321.3198,32,8);
	AddStaticVehicle(546,-2235.1733,-2478.9258,30.8960,321.5607,78,38);
	AddStaticVehicle(549,-2230.2131,-2425.3635,30.7670,231.0381,72,39);
	AddStaticVehicle(514,-1578.2002,-2731.6755,49.1302,144.2565,25,1);
	AddStaticVehicle(516,-1567.8202,-2736.5186,48.3757,145.6190,119,1);
	AddStaticVehicle(524,-267.9393,-2157.9619,29.7329,18.4003,61,27);
	AddStaticVehicle(588,365.8058,-1996.5623,7.6603,0.7425,1,1);
	AddStaticVehicle(423,374.4974,-1933.2324,7.7773,358.6991,1,56);
	AddStaticVehicle(531,2793.5012,-2416.9016,13.5968,95.2036,91,2);
	AddStaticVehicle(455,2663.3303,-2399.5557,13.9594,89.5516,43,31);
	AddStaticVehicle(571,2364.7190,-70.6361,26.7604,279.7453,91,2);
	AddStaticVehicle(572,2496.7668,7.0273,26.9253,185.9343,101,1);
	AddStaticVehicle(575,2552.7097,14.1840,26.6343,88.9140,19,96);
	AddStaticVehicle(576,1518.1572,11.7624,23.7496,281.3857,68,96);
	AddStaticVehicle(579,1544.4406,17.1919,24.0707,278.5261,42,42);
	AddStaticVehicle(572,1569.5369,31.3990,23.7589,84.9840,116,1);
	AddStaticVehicle(560,861.4890,-14.8971,62.9763,165.5495,17,1);
	AddStaticVehicle(483,1045.2408,-297.7158,73.9855,181.7000,3,6);
	AddStaticVehicle(489,1044.9423,-299.7287,74.1365,177.1206,120,123);
	AddStaticVehicle(451,-865.2075,1544.6162,22.6870,270.0740,36,36);
	AddStaticVehicle(437,-819.4144,1459.2821,14.3037,93.3488,79,7);
	AddStaticVehicle(411,-683.8646,966.4230,11.8599,91.7786,106,1);
	AddStaticVehicle(446,-646.6898,865.2881,-0.5904,224.3059,1,22);
	AddStaticVehicle(552,-111.0833,1130.8082,19.4412,359.0728,49,49);
	AddStaticVehicle(423,-176.4377,1219.6744,19.7608,268.8809,1,56);
	AddStaticVehicle(410,-304.0071,1024.4451,19.2503,90.5229,10,1);
	AddStaticVehicle(459,-176.3457,1015.2915,19.7930,272.3287,28,28);
	AddStaticVehicle(411,-277.0600,1555.5293,75.0865,134.2058,80,1);
	AddStaticVehicle(403,-294.8612,1572.5062,75.9749,136.3599,37,1);
	AddStaticVehicle(404,-339.5506,1516.0974,75.0956,181.2865,119,50);
	AddStaticVehicle(508,-1506.8732,1977.2676,48.6782,179.0459,1,1);
	AddStaticVehicle(400,-1924.9563,2358.5342,49.0465,110.5240,123,1);
	AddStaticVehicle(583,-1473.9502,2641.6008,55.3765,185.0394,1,1);
	AddStaticVehicle(416,-1503.6654,2524.9941,55.8371,177.9675,1,3);
	AddStaticVehicle(544,-1522.5780,2527.2556,55.9472,182.1869,3,1);
	AddStaticVehicle(404,-1303.8619,2706.8298,49.7952,7.0669,123,92);
	AddStaticVehicle(451,-2467.5815,2225.2227,4.5528,181.8412,16,16);
	AddStaticVehicle(451,-2482.4077,2241.8181,4.5495,1.0279,16,16);
	AddStaticVehicle(558,-2443.8604,2242.5586,4.4463,0.8262,116,1);
	AddStaticVehicle(517,-2435.4399,2449.4827,13.6408,268.4816,40,36);
	AddStaticVehicle(456,-575.5142,-547.7195,25.7003,183.3488,91,63);
	AddStaticVehicle(455,-535.9458,-547.2222,25.9211,182.9189,84,58);
	AddStaticVehicle(400,-999.5934,-674.1949,32.1002,89.8846,113,1);
	AddStaticVehicle(402,-983.6152,-661.1803,31.8394,270.9778,13,13);
	AddStaticVehicle(429,-1030.4137,-673.8923,31.6875,91.9187,1,3);
	AddStaticVehicle(424,-1065.2045,-1230.5377,129.0009,275.5749,2,2);
	AddStaticVehicle(409,-2520.4497,-604.0573,132.3625,2.3753,1,1);
	AddStaticVehicle(507,-2497.9722,-602.3024,132.3874,0.6016,42,42);
	AddStaticVehicle(568,-2398.0256,-592.6183,132.5159,122.3831,9,39);
	AddStaticVehicle(485,-2397.7456,-610.4223,132.3029,212.8871,1,74);
	AddStaticVehicle(414,818.8205,871.7081,12.5629,116.2488,28,1);
	AddStaticVehicle(456,853.7126,844.1563,13.5246,285.8787,102,65);
	AddStaticVehicle(524,577.5634,901.2927,-42.5601,70.1865,61,27);
	AddStaticVehicle(471,596.9218,880.6252,-43.9820,209.7197,103,111);
	AddStaticVehicle(486,602.6954,855.6363,-42.7917,269.2891,1,1);
	AddStaticVehicle(455,624.2741,822.2102,-42.5242,3.0048,84,31);
	AddStaticVehicle(420,821.1712,-1331.7725,13.2565,274.6331,6,1);
	AddStaticVehicle(485,881.8751,-1254.1548,14.7113,9.8339,1,74);
	AddStaticVehicle(583,885.4150,-1185.7859,16.5170,190.3050,1,1);
	AddStaticVehicle(494,2658.0535,-1691.9567,9.2603,270.5791,36,13);
	AddStaticVehicle(504,2658.0342,-1697.1824,9.1109,271.3967,45,29);
	AddStaticVehicle(423,2658.1846,-1711.8254,9.3427,267.9392,1,56);
	AddStaticVehicle(503,2658.2319,-1701.9846,9.2148,269.9647,87,74);
	AddStaticVehicle(434,2691.7139,-1672.9165,9.4423,180.0944,12,12);
	AddStaticVehicle(498,2767.1575,-2008.9965,13.6258,2.3546,13,120);
	AddStaticVehicle(405,2755.3713,-1943.3928,13.4217,268.1127,36,1);
	AddStaticVehicle(405,2784.3398,-1943.3828,13.4227,90.1827,40,1);
	AddStaticVehicle(576,2657.7058,-2048.0701,13.2152,359.3799,75,96);
	AddStaticVehicle(534,2654.7964,-2032.2474,13.2735,90.3258,11,11);
	AddStaticVehicle(566,2645.1729,-1984.2659,12.8067,180.5337,84,8);
	AddStaticVehicle(487,1837.8007,-2416.6992,13.7093,209.7634,12,39);
	AddStaticVehicle(487,1837.1262,-2425.7561,13.7319,212.0214,74,35);
	AddStaticVehicle(583,1874.2147,-2285.5525,13.0873,269.7783,1,1);
	AddStaticVehicle(485,1874.0574,-2289.2341,13.1869,269.9383,1,74);
	AddStaticVehicle(583,1873.9362,-2293.2444,13.1027,270.8120,1,1);
	AddStaticVehicle(485,1874.0955,-2297.1106,13.2119,271.0415,1,75);
	AddStaticVehicle(593,1907.5023,-2241.3794,14.0108,181.0453,60,1);
	AddStaticVehicle(593,1920.0702,-2240.9688,14.0095,180.8980,68,8);
	AddStaticVehicle(593,1932.4424,-2241.0393,14.0051,176.6493,2,1);
	AddStaticVehicle(417,1433.2589,-2639.3823,13.6532,352.2072,0,0);
	AddStaticVehicle(519,1491.0181,-2641.6895,14.4658,3.9881,1,1);
	AddStaticVehicle(519,1511.9976,-2642.4946,14.4663,350.6630,1,1);
	AddStaticVehicle(519,1535.1614,-2646.4490,14.4675,348.5858,1,1);
	AddStaticVehicle(417,1584.9148,-2647.2661,13.5587,359.7520,0,0);
	AddStaticVehicle(487,1569.7688,-2644.8257,13.6989,351.2698,3,29);
	AddStaticVehicle(417,1559.1777,-2641.5632,13.6366,358.1480,0,0);
	AddStaticVehicle(513,1655.0291,-2636.1873,14.0969,346.8781,21,34);
	AddStaticVehicle(593,1643.3081,-2635.0261,14.0096,10.0309,22,1);
	AddStaticVehicle(519,1718.2079,-2647.8118,14.4726,0.3490,1,1);
	AddStaticVehicle(583,1751.3793,-2636.7720,13.0884,359.8139,1,1);
	AddStaticVehicle(485,1755.7607,-2636.7603,13.2093,358.1984,1,77);
	AddStaticVehicle(563,1788.0725,-2642.2002,14.4090,1.9452,1,6);
	AddStaticVehicle(583,1818.6649,-2637.3853,13.0873,353.4655,1,1);
	AddStaticVehicle(485,1822.5498,-2637.4348,13.2061,356.4081,1,78);
	AddStaticVehicle(513,1848.1143,-2636.0022,14.0959,13.9255,30,34);
	AddStaticVehicle(593,1864.3198,-2635.8188,14.0080,331.6854,36,8);
	AddStaticVehicle(583,1927.5038,-2661.6194,13.0933,56.6389,1,1);
	AddStaticVehicle(485,1927.5682,-2666.2832,13.2130,52.9081,1,79);
	AddStaticVehicle(445,1927.3066,-2672.4746,13.2971,50.5951,35,35);
	AddStaticVehicle(461,1927.3708,-2677.5139,13.1379,50.3752,88,1);
	AddStaticVehicle(487,1941.1954,-2650.1755,13.7246,1.7819,26,57);
	AddStaticVehicle(593,1951.8199,-2648.4546,14.0058,357.7411,51,1);
	AddStaticVehicle(583,2080.7766,-2453.9868,13.0868,150.2326,1,1);
	AddStaticVehicle(492,2516.7046,-1672.2085,13.7355,68.1567,77,26);
	AddStaticVehicle(481,2495.3015,-1645.6272,13.1079,179.8264,3,3);
	AddStaticVehicle(545,2416.7686,-1715.8696,13.5681,359.2425,47,1);
	AddStaticVehicle(588,2383.1272,-1754.1299,13.3663,271.3994,1,1);
	AddStaticVehicle(522,2358.5977,-1701.2755,13.1706,96.4484,51,118);
	AddStaticVehicle(482,2299.1589,-1645.3439,14.8474,269.6949,48,48);
	AddStaticVehicle(566,2302.1138,-1634.5439,13.8610,181.3483,84,8);
	AddStaticVehicle(522,2271.1055,-1644.9208,14.9421,179.3563,3,8);
	AddStaticVehicle(462,2232.2559,-1689.8866,13.5942,82.7626,14,14);
	AddStaticVehicle(600,2184.5898,-1673.1071,14.0695,163.7413,11,11);
	AddStaticVehicle(587,2182.8452,-1680.7313,13.6460,169.6601,101,1);
	AddStaticVehicle(411,2180.2556,-1740.8082,13.1454,182.8411,12,1);
	AddStaticVehicle(466,2069.4783,-1695.3640,13.2863,268.9285,68,76);
	AddStaticVehicle(575,1929.1121,-1795.5098,12.9877,268.5541,19,96);
	AddStaticVehicle(575,1918.0098,-1795.5577,12.9860,270.7969,31,64);
	AddStaticVehicle(420,1692.8943,-2259.3389,13.1986,265.5694,6,1);
	AddStaticVehicle(420,1691.5587,-2248.6113,13.2395,88.2783,6,1);
	AddStaticVehicle(438,1693.1730,-2314.5310,13.4647,88.1359,6,76);
	AddStaticVehicle(438,1693.1503,-2323.9661,13.4607,270.7873,6,76);
	AddStaticVehicle(466,1673.7712,-2324.0659,13.2003,270.7038,16,76);
	AddStaticVehicle(405,1674.0696,-2248.6870,13.3485,87.3893,24,1);
	AddStaticVehicle(481,1687.7379,-2264.8538,12.9925,359.3042,3,3);
	AddStaticVehicle(510,1677.9158,-2264.7512,13.1462,359.9904,28,28);
	AddStaticVehicle(462,1687.4503,-2307.7830,13.1391,180.5448,10,10);
	AddStaticVehicle(522,1678.1338,-2307.6814,13.1020,178.9979,36,105);
	AddStaticVehicle(409,1791.3058,-2324.1404,13.2515,268.2218,1,1);
	AddStaticVehicle(533,1792.9003,-2249.0728,5.9938,91.3965,74,1);
	AddStaticVehicle(437,1673.6298,-2259.2241,-2.6812,91.5579,79,7);
	AddStaticVehicle(431,1694.4751,-2323.5498,-2.6645,268.2501,59,83);
	AddStaticVehicle(403,-1702.8567,379.8232,7.7875,224.5616,25,1);
	AddStaticVehicle(584,-1711.2061,388.2976,7.7872,224.5178,25,1);
	AddStaticVehicle(490,-1651.3030,1206.3916,21.2773,253.7301,0,0);
	AddStaticVehicle(429,-1658.1780,1215.3739,20.8359,314.3866,14,14);
	AddStaticVehicle(522,-1792.3538,1400.5447,6.7539,183.5485,7,79);
	AddStaticVehicle(445,-2251.7815,2288.1033,4.6914,90.6125,41,41);
	AddStaticVehicle(439,-2251.9119,2302.9697,4.7084,89.4183,8,17);
	AddStaticVehicle(411,-2251.8560,2314.9153,4.5396,89.9993,123,1);
	AddStaticVehicle(451,-2252.1553,2332.9937,4.5198,90.7130,125,125);
	AddStaticVehicle(436,-2271.5737,2336.2200,4.5795,270.2275,109,1);
	AddStaticVehicle(458,-2271.1487,2327.2720,4.6949,270.2254,30,1);
	AddStaticVehicle(429,-2271.2681,2318.3232,4.4999,269.4370,2,1);
	AddStaticVehicle(462,-2271.0920,2312.2754,4.4198,271.9762,1,3);
	AddStaticVehicle(466,-2271.3418,2297.4053,4.5620,270.9309,67,76);
	AddStaticVehicle(477,-2271.4829,2291.4626,4.5743,269.5077,94,1);
	AddStaticVehicle(452,-2255.3416,2417.3025,-0.5207,224.0582,1,5);
	AddStaticVehicle(452,-2249.4031,2423.6646,-0.3845,229.2866,1,16);
	AddStaticVehicle(493,-2237.0330,2438.2710,-0.2144,224.1001,36,13);
	AddStaticVehicle(493,-2230.0271,2445.8120,-0.2775,224.9153,36,13);
	AddStaticVehicle(539,-2210.0342,2427.3438,0.3664,46.0593,79,74);
	AddStaticVehicle(539,-2218.3347,2419.1543,0.5869,43.8741,61,98);
	AddStaticVehicle(525,-1482.7141,1877.2502,32.5086,183.8396,17,20);
	AddStaticVehicle(543,-1488.9436,1876.2725,32.4520,183.4537,32,8);
	AddStaticVehicle(483,-1196.7529,1820.4163,41.7111,44.9522,1,31);
	AddStaticVehicle(483,-1199.0428,1817.6910,41.7113,43.8489,1,20);
	AddStaticVehicle(483,-1201.4602,1815.3767,41.7110,44.7265,0,6);
	AddStaticVehicle(452,-1374.8685,2114.7292,40.1366,227.5950,1,57);
	AddStaticVehicle(515,-1299.5004,2705.6169,51.0806,184.8666,24,77);
	AddStaticVehicle(515,-1287.7910,2713.0984,51.0806,183.5724,63,78);
	AddStaticVehicle(584,-1291.7407,2711.3955,51.0793,186.3791,63,78);
	AddStaticVehicle(403,-82.6642,-1148.1742,2.3372,64.5803,101,1);
	AddStaticVehicle(584,-67.5211,-1155.4136,2.3551,64.4331,101,1);
	AddStaticVehicle(522,391.7628,2546.1362,16.1100,356.9254,36,105);
	AddStaticVehicle(522,389.1868,2546.3586,16.1131,2.3236,36,105);
	AddStaticVehicle(522,386.5970,2546.5112,16.0995,3.2324,36,105);
	AddStaticVehicle(522,384.2728,2546.7739,16.1064,2.4641,36,105);
	AddStaticVehicle(522,381.4831,2547.0862,16.0988,3.9186,36,105);
	AddStaticVehicle(522,379.1186,2546.7544,16.1129,1.7072,36,105);
	AddStaticVehicle(425,1689.7753,-2940.3313,3.5608,92.7963,43,0); 
	AddStaticVehicle(473,1024.9177,-2595.4043,-0.4884,93.0160,56,53);
	AddStaticVehicle(454,1035.3751,-2604.4878,-0.1157,88.7293,26,26);
	AddStaticVehicle(417,1113.8494,-2610.8301,2.9727,359.0287,0,0);
	AddStaticVehicle(571,1186.0670,-2582.1340,1.1608,0.9438,51,53);
	AddStaticVehicle(571,1189.5220,-2582.3030,1.1609,2.3064,51,53);
	AddStaticVehicle(571,1193.2290,-2583.1167,1.1609,3.0000,51,53);
	AddStaticVehicle(571,1182.5961,-2582.4836,1.1606,2.4451,51,53);
	AddStaticVehicle(415,1173.7146,-2595.8833,1.6402,181.1533,36,1);
	AddStaticVehicle(424,1089.6128,-2588.5400,1.6304,181.4441,2,2);
	AddStaticVehicle(589,1095.2401,-2589.0171,1.5063,180.2255,31,31);
	AddStaticVehicle(460,1034.1298,-2591.7405,1.2528,88.4991,1,9);

	//DarkZero's Haus
	CreateObject(10766, 1089.020386, -2599.312988, -1.466685, 0.000000, 0.000000, -89.999981276);
	CreateDynamicObject(6450, 1191.856323, -2592.188477, -7.598844, 0.000000, 0.000000, -270.000001124, 0, 0, -1, 200);
	CreateObject(10766, 1155.295044, -2599.024414, -1.490140, 0.000000, 0.000000, -269.999943828);
	CreateDynamicObject(3605, 1064.624268, -2597.968018, 6.959222, 0.000000, 0.000000, 89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(13697, 1166.972778, -2582.643799, -4.035466, 0.000000, 0.000000, -179.999962552, 0, 0, -1, 200);
	CreateObject(9241, 1114.217529, -2612.002197, 1.055262, 0.000000, 0.000000, -89.999981276);
	CreateDynamicObject(17068, 1032.455444, -2599.757568, -0.019451, 0.000000, 0.000000, -89.9999239803, 0, 0, -1, 200);
	CreateDynamicObject(17068, 1032.454102, -2597.990723, -0.021220, 0.000000, 0.000000, -629.999811636, 0, 0, -1, 200);
	CreateDynamicObject(3749, 1198.699219, -2601.536133, 6.337042, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(8147, 1116.542969, -2570.618652, 0.829650, 0.000000, 0.000000, -270.000001124, 0, 0, -1, 200);
	CreateDynamicObject(8147, 1116.491089, -2627.737305, 0.854650, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1043.627075, -2616.196777, 0.455172, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1043.603271, -2570.327148, 0.455172, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1043.609375, -2582.288574, 0.455172, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1043.632446, -2585.612549, 0.455172, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1043.668335, -2604.300537, 0.455172, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1043.678223, -2600.341797, 0.463768, 0.000000, 0.000000, -89.999981276, 0, 0, -1, 200);
	CreateDynamicObject(987, 1200.814575, -2570.426758, 0.478628, 0.000000, 0.000000, -179.999962552, 0, 0, -1, 200);
	CreateDynamicObject(987, 1200.695435, -2582.335449, 0.478628, 0.000000, 0.000000, -269.999943828, 0, 0, -1, 200);
	CreateDynamicObject(987, 1200.568115, -2591.980713, 0.478628, 0.000000, 0.000000, -269.999943828, 0, 0, -1, 200);
	CreateDynamicObject(987, 1188.978271, -2627.857666, 0.478628, 0.000000, 0.000000, -359.9999824, 0, 0, -1, 200);
	CreateDynamicObject(987, 1200.701294, -2627.970703, 0.478629, 0.000000, 0.000000, -269.999943828, 0, 0, -1, 200);
	CreateDynamicObject(987, 1200.566772, -2621.974365, 0.478628, 0.000000, 0.000000, -269.999943828, 0, 0, -1, 200);
	CreateDynamicObject(3604, 1092.041748, -2580.011719, 3.423190, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(1243, 1038.155029, -2567.569824, -3.343327, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(1243, 1039.571533, -2630.864502, -3.349257, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(1243, 1203.731934, -2632.569580, -3.485052, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(1243, 1204.762207, -2566.670410, -3.356059, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3472, 1177.241821, -2617.521729, 1.238985, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3472, 1121.382568, -2575.993652, 1.246226, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3472, 1140.334106, -2615.744873, 1.238985, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3472, 1051.389526, -2574.001221, 1.089589, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3472, 1087.850830, -2618.609619, 1.222768, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3472, 1083.437378, -2577.973633, 1.246225, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(6965, 1131.770020, -2585.301270, 3.233821, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(7388, 1155.570923, -2584.880859, 5.156404, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3461, 1258.673584, -2594.216797, 2.235208, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3461, 1258.651978, -2609.022217, 2.207679, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);
	CreateDynamicObject(3337, 1258.697266, -2589.806152, -0.363058, 0.000000, 0.000000, 0.000000, 0, 0, -1, 200);

    
	// Drift1
	CreateDynamicObject(2773, -296.10000610, 1508.19995117, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2773, -296.10000610, 1508.19995117, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2773, -302.20001221, 1508.50000000, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2773, -308.50000000, 1508.40002441, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2773, -305.39999390, 1508.59997559, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2773, -299.29998779, 1508.40002441, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3526, -295.89999390, 1430.50000000, 71.90000153, 0.00000000, 0.00000000, 276.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3526, -302.29980469, 1505.69921875, 74.50000000, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -301.89941406, 1500.50000000, 74.69999695, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -301.29980469, 1494.69921875, 74.69999695, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -300.89941406, 1489.50000000, 74.69999695, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -300.39941406, 1483.29980469, 74.59999847, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -299.89941406, 1478.00000000, 74.30000305, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -299.39941406, 1471.59960938, 73.90000153, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -298.69921875, 1464.89941406, 73.59999847, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -298.09960938, 1457.19921875, 73.19999695, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -297.39941406, 1448.19921875, 72.69999695, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -296.59960938, 1439.59960938, 72.30000305, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -295.39999390, 1423.00000000, 71.59999847, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -295.00000000, 1414.50000000, 71.40000153, 0.00000000, 0.00000000, 275.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -295.29998779, 1406.50000000, 71.40000153, 0.00000000, 0.00000000, 271.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3526, -298.00000000, 1400.09997559, 71.40000153, 0.00000000, 0.00000000, 235.99401855, -1, 0, -1, 250);
	CreateDynamicObject(3526, -301.89999390, 1396.40002441, 71.40000153, 0.00000000, 0.00000000, 213.99401855, -1, 0, -1, 250);
	CreateDynamicObject(3526, -308.79998779, 1394.80004883, 71.40000153, 0.00000000, 0.00000000, 185.99169922, -1, 0, -1, 250);
	CreateDynamicObject(3526, -314.50000000, 1397.00000000, 71.09999847, 0.00000000, 0.00000000, 147.98754883, -1, 0, -1, 250);
	CreateDynamicObject(3526, -319.00000000, 1401.90002441, 70.50000000, 0.00000000, 0.00000000, 127.98583984, -1, 0, -1, 250);
	CreateDynamicObject(3526, -323.29998779, 1408.90002441, 69.69999695, 0.00000000, 0.00000000, 127.98526001, -1, 0, -1, 250);
	CreateDynamicObject(3526, -327.60000610, 1417.19995117, 68.69999695, 0.00000000, 0.00000000, 121.98522949, -1, 0, -1, 250);
	CreateDynamicObject(3526, -331.50000000, 1424.80004883, 67.80000305, 0.00000000, 0.00000000, 121.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3526, -335.60000610, 1433.69995117, 66.80000305, 0.00000000, 0.00000000, 121.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3526, -340.79998779, 1444.09997559, 65.59999847, 0.00000000, 0.00000000, 121.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3526, -355.29998779, 1464.19995117, 63.20000076, 0.00000000, 0.00000000, 155.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3526, -348.00000000, 1457.00000000, 64.09999847, 0.00000000, 0.00000000, 121.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3526, -372.60000610, 1462.59997559, 61.50000000, 0.00000000, 0.00000000, 215.97839355, -1, 0, -1, 250);
	CreateDynamicObject(3526, -320.39999390, 1322.59997559, 52.59999847, 0.00000000, 0.00000000, 243.97473145, -1, 0, -1, 250);
	CreateDynamicObject(3526, -379.89941406, 1450.69921875, 60.50000000, 0.00000000, 0.00000000, 281.96960449, -1, 0, -1, 250);
	CreateDynamicObject(3526, -374.89941406, 1434.89941406, 59.79999924, 0.00000000, 0.00000000, 281.96960449, -1, 0, -1, 250);
	CreateDynamicObject(3526, -367.19921875, 1419.59960938, 58.79999924, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -360.29980469, 1406.69921875, 57.90000153, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -353.29980469, 1394.09960938, 57.09999847, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -345.00000000, 1379.39941406, 56.00000000, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -337.10000610, 1366.09997559, 55.09999847, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -331.09960938, 1355.19921875, 54.40000153, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -325.29980469, 1344.39941406, 53.79999924, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -320.50000000, 1332.89941406, 53.29999924, 0.00000000, 0.00000000, 299.97070312, -1, 0, -1, 250);
	CreateDynamicObject(3526, -331.79980469, 1315.79980469, 51.20000076, 0.00000000, 0.00000000, 177.97302246, -1, 0, -1, 250);
	CreateDynamicObject(3526, -345.10000610, 1323.69995117, 50.09999847, 0.00000000, 0.00000000, 135.97302246, -1, 0, -1, 250);
	CreateDynamicObject(3526, -354.00000000, 1337.00000000, 48.70000076, 0.00000000, 0.00000000, 121.97229004, -1, 0, -1, 250);
	CreateDynamicObject(3526, -361.60000610, 1350.09997559, 47.20000076, 0.00000000, 0.00000000, 117.97232056, -1, 0, -1, 250);
	CreateDynamicObject(3526, -370.89999390, 1367.50000000, 44.90000153, 0.00000000, 0.00000000, 123.97235107, -1, 0, -1, 250);
	CreateDynamicObject(3526, -377.29998779, 1379.90002441, 43.29999924, 0.00000000, 0.00000000, 123.96972656, -1, 0, -1, 250);
	CreateDynamicObject(3526, -384.29998779, 1393.59997559, 41.50000000, 0.00000000, 0.00000000, 123.96972656, -1, 0, -1, 250);
	CreateDynamicObject(3526, -400.00000000, 1425.69995117, 37.29999924, 0.00000000, 0.00000000, 123.96972656, -1, 0, -1, 250);
	CreateDynamicObject(3526, -394.09960938, 1413.29980469, 38.90000153, 0.00000000, 0.00000000, 123.96972656, -1, 0, -1, 250);
	CreateDynamicObject(3526, -405.39999390, 1437.00000000, 36.09999847, 0.00000000, 0.00000000, 123.96972656, -1, 0, -1, 250);
	CreateDynamicObject(3526, -428.89999390, 1445.69995117, 33.70000076, 0.00000000, 0.00000000, 203.96740723, -1, 0, -1, 250);
	CreateDynamicObject(3666, -309.60000610, 1507.30004883, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -313.10000610, 1507.30004883, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -316.10000610, 1507.40002441, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -319.29998779, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -322.60000610, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -329.00000000, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -325.59960938, 1507.39941406, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -332.29998779, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -335.70001221, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -338.39999390, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -345.10000610, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -341.19921875, 1507.39941406, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -347.70001221, 1507.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -282.00000000, 1521.50000000, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -292.59960938, 1511.89941406, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -292.59960938, 1511.89941406, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -288.50000000, 1515.59960938, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -285.00000000, 1518.69921875, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -278.60000610, 1524.50000000, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -263.39999390, 1538.50000000, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -275.29980469, 1527.59960938, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -272.59960938, 1530.39941406, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -269.89941406, 1532.69921875, 74.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -266.69921875, 1535.69921875, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, -259.39999390, 1542.09997559, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(9192, -300.29998779, 1539.50000000, 79.40000153, 0.00000000, 0.00000000, 76.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7313, -317.79980469, 1515.29980469, 77.09999847, 0.00000000, 0.00000000, 177.99499512, -1, 0, -1, 250);
	CreateDynamicObject(7301, -338.89999390, 1539.40002441, 81.59999847, 0.00000000, 0.00000000, 170.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1260, -278.39999390, 1419.00000000, 87.19999695, 0.00000000, 0.00000000, 330.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7301, -277.70001221, 1418.40002441, 92.09999847, 0.00000000, 0.00000000, 16.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2790, -333.60000610, 1537.40002441, 76.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(10281, -321.00000000, 1536.40002441, 76.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(11395, -286.79998779, 1496.40002441, 83.00000000, 0.00000000, 358.00000000, 316.00000000, -1, 0, -1, 250);
	CreateDynamicObject(13831, -471.29998779, 1626.09997559, 60.90000153, 0.00000000, 356.00000000, 66.00000000, -1, 0, -1, 250);
	CreateDynamicObject(14467, -313.29998779, 1536.00000000, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3458, -331.50000000, 1513.19995117, 75.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7313, -267.79998779, 1538.90002441, 79.69999695, 0.00000000, 0.00000000, 313.99450684, -1, 0, -1, 250);
	CreateDynamicObject(7313, -338.10000610, 1515.40002441, 77.09999847, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(7313, -344.89999390, 1515.40002441, 77.09999847, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(16362, -292.09960938, 1572.39941406, 77.50000000, 0.00000000, 0.00000000, 43.98925781, -1, 0, -1, 250);
	CreateDynamicObject(11095, -302.89941406, 1504.50000000, 79.80000305, 0.00000000, 0.00000000, 273.99353027, -1, 0, -1, 250);
	CreateDynamicObject(1251, -298.79998779, 1507.50000000, 74.50000000, 0.00000000, 0.00000000, 272.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1251, -305.50000000, 1507.19995117, 74.50000000, 0.00000000, 0.00000000, 271.99951172, -1, 0, -1, 250);
	CreateDynamicObject(10357, -258.89999390, 1407.09997559, 94.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8620, -319.00000000, 1472.90002441, 96.90000153, 0.00000000, 0.00000000, 318.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -267.79998779, 1535.69995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -269.10000610, 1534.19995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -270.60000610, 1533.19995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -271.70001221, 1531.90002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -273.10000610, 1531.09997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -274.20001221, 1529.40002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -275.39999390, 1528.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -275.39941406, 1528.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -276.50000000, 1527.40002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -278.00000000, 1526.19995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -278.00000000, 1526.19921875, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -279.39999390, 1525.00000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -280.60000610, 1523.80004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -281.79998779, 1522.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -283.20001221, 1521.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -284.50000000, 1520.30004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -285.79998779, 1519.09997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -287.10000610, 1517.90002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -288.39999390, 1516.59997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -289.79998779, 1515.09997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -291.39999390, 1513.90002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(870, -292.79998779, 1512.80004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -309.50000000, 1490.09997559, 74.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -290.79980469, 1491.69921875, 75.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -308.00000000, 1469.69995117, 74.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -289.89941406, 1473.69921875, 74.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -288.29998779, 1457.09997559, 73.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -306.70001221, 1457.40002441, 73.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -305.50000000, 1444.30004883, 72.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -287.60000610, 1445.00000000, 72.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -304.39999390, 1429.30004883, 71.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -288.10000610, 1430.09997559, 72.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -287.79998779, 1418.69995117, 71.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -307.70001221, 1404.50000000, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -288.60000610, 1400.80004883, 71.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -293.70001221, 1392.40002441, 71.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -301.50000000, 1388.90002441, 71.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -313.50000000, 1388.30004883, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -328.79998779, 1404.40002441, 69.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -322.69921875, 1394.59960938, 70.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -337.79998779, 1424.19995117, 67.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -334.19921875, 1415.69921875, 68.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -303.89941406, 1417.59960938, 71.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -302.89941406, 1408.39941406, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -313.79998779, 1408.50000000, 70.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -344.20001221, 1433.40002441, 66.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -318.79980469, 1419.29980469, 69.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -309.50000000, 1507.40002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -295.29998779, 1507.90002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -268.60000610, 1533.40002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -273.10000610, 1529.40002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -277.20001221, 1525.69995117, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -283.79998779, 1520.09997559, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -280.59960938, 1522.89941406, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -287.20001221, 1517.09997559, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -290.70001221, 1513.90002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -309.00000000, 1503.40002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -308.50000000, 1499.19995117, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -308.20001221, 1495.19995117, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -308.20001221, 1491.40002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -295.29998779, 1504.59997559, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -295.10000610, 1501.90002441, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -294.00000000, 1493.19995117, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1231, -294.39941406, 1497.59960938, 77.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1283, -293.70001221, 1480.50000000, 77.50000000, 0.00000000, 0.00000000, 4.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1283, -294.29998779, 1485.69995117, 77.50000000, 0.00000000, 0.00000000, 3.99902344, -1, 0, -1, 250);
	CreateDynamicObject(1283, -293.10000610, 1475.30004883, 77.50000000, 0.00000000, 0.00000000, 3.99902344, -1, 0, -1, 250);
	CreateDynamicObject(1350, -308.50000000, 1502.80004883, 74.59999847, 0.00000000, 0.00000000, 181.99996948, -1, 0, -1, 250);
	CreateDynamicObject(3855, -307.79998779, 1487.40002441, 74.40000153, 0.00000000, 0.00000000, 189.99996948, -1, 0, -1, 250);
	CreateDynamicObject(1302, -326.00000000, 1536.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1302, -324.79998779, 1536.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -280.79998779, 1478.19995117, 74.69999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -314.10000610, 1477.00000000, 75.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -339.29998779, 1533.40002441, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -330.10000610, 1534.00000000, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -320.60000610, 1534.09997559, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -312.60000610, 1533.69995117, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -304.29998779, 1533.90002441, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -295.79998779, 1533.40002441, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -289.89999390, 1533.90002441, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -291.20001221, 1539.90002441, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -297.60000610, 1546.09997559, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -305.70001221, 1554.00000000, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -312.10000610, 1560.09997559, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -324.69921875, 1430.29980469, 67.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -330.09960938, 1441.29980469, 66.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -350.10000610, 1445.80004883, 65.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -336.00000000, 1452.39941406, 65.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -343.29998779, 1465.00000000, 63.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -361.39999390, 1456.00000000, 63.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -356.09960938, 1453.79980469, 64.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -371.79998779, 1450.19995117, 60.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -367.50000000, 1454.89941406, 61.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -358.00000000, 1474.00000000, 63.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -350.69921875, 1471.09960938, 63.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -374.00000000, 1470.50000000, 61.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -365.19921875, 1473.29980469, 62.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -388.10000610, 1449.50000000, 60.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -381.29980469, 1465.19921875, 61.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -385.79980469, 1457.59960938, 60.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -385.10000610, 1439.59997559, 60.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -370.10000610, 1443.80004883, 60.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -366.50000000, 1436.09997559, 59.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -381.39941406, 1431.69921875, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -377.39999390, 1422.69995117, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -362.29998779, 1427.30004883, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -373.10000610, 1414.30004883, 58.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -358.39999390, 1420.09997559, 58.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -353.79998779, 1411.19995117, 58.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -370.29998779, 1406.40002441, 58.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -364.79998779, 1398.09997559, 57.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -348.39999390, 1403.30004883, 57.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -343.70001221, 1394.30004883, 57.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -358.29998779, 1387.69995117, 56.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -353.10000610, 1378.90002441, 56.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -338.00000000, 1383.90002441, 56.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -332.50000000, 1375.80004883, 55.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -347.39999390, 1370.09997559, 55.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -327.79998779, 1365.50000000, 55.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -341.39999390, 1358.69995117, 54.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -312.89999390, 1338.09997559, 53.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -322.09960938, 1355.89941406, 54.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -335.69921875, 1348.39941406, 53.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -317.19921875, 1345.89941406, 53.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -311.79998779, 1329.00000000, 53.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -312.60000610, 1320.30004883, 52.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -346.29998779, 1314.69995117, 50.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -317.39999390, 1313.50000000, 52.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -324.39941406, 1309.50000000, 51.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -332.19921875, 1309.09960938, 51.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -338.70001221, 1310.69995117, 51.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -352.79998779, 1321.00000000, 50.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -359.29998779, 1331.40002441, 49.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -364.29998779, 1340.09997559, 48.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -380.29998779, 1368.90002441, 44.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -373.59960938, 1356.69921875, 46.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -384.89999390, 1379.69995117, 43.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -390.79998779, 1391.19995117, 41.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -406.69921875, 1420.39941406, 37.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -356.60000610, 1325.40002441, 49.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -402.89999390, 1413.00000000, 38.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, -377.00000000, 1467.90002441, 62.20000076, 0.00000000, 4.00000000, 217.99977112, -1, 0, -1, 250);
	CreateDynamicObject(979, -443.39999390, 1430.19995117, 33.00000000, 0.00000000, 0.00000000, 13.99975586, -1, 0, -1, 250);
	CreateDynamicObject(979, -386.60000610, 1454.09997559, 61.29999924, 0.00000000, 1.99902344, 253.98901367, -1, 0, -1, 250);
	CreateDynamicObject(978, -312.79998779, 1333.80004883, 54.20000076, 0.00000000, 0.00000000, 95.99853516, -1, 0, -1, 250);
	CreateDynamicObject(978, -312.39999390, 1324.90002441, 53.90000153, 0.00000000, 357.99499512, 81.99841309, -1, 0, -1, 250);
	CreateDynamicObject(978, -315.20001221, 1317.09997559, 53.20000076, 0.00000000, 357.99499512, 53.99328613, -1, 0, -1, 250);
	CreateDynamicObject(978, -321.00000000, 1311.90002441, 52.90000153, 0.00000000, 357.98950195, 25.98962402, -1, 0, -1, 250);
	CreateDynamicObject(978, -328.10000610, 1309.80004883, 52.09999847, 0.00000000, 357.98950195, 3.98693848, -1, 0, -1, 250);
	CreateDynamicObject(978, -334.60000610, 1310.00000000, 51.79999924, 0.00000000, 357.98950195, 343.98535156, -1, 0, -1, 250);
	CreateDynamicObject(979, -385.89999390, 1444.40002441, 61.20000076, 0.00000000, 1.99951172, 283.99108887, -1, 0, -1, 250);
	CreateDynamicObject(979, -382.70001221, 1435.50000000, 60.70000076, 0.00000000, 3.99902344, 289.98559570, -1, 0, -1, 250);
	CreateDynamicObject(978, -342.39999390, 1313.30004883, 51.40000153, 0.00000000, 355.98449707, 329.98278809, -1, 0, -1, 250);
	CreateDynamicObject(979, -383.00000000, 1461.30004883, 61.50000000, 0.00000000, 1.99353027, 239.97985840, -1, 0, -1, 250);
	CreateDynamicObject(979, -435.60000610, 1432.09997559, 33.00000000, 0.00000000, 0.00000000, 13.99658203, -1, 0, -1, 250);
	CreateDynamicObject(979, -431.20001221, 1433.19995117, 33.00000000, 0.00000000, 0.00000000, 13.99658203, -1, 0, -1, 250);
	CreateDynamicObject(3526, -413.00000000, 1445.69921875, 34.79999924, 0.00000000, 0.00000000, 155.96740723, -1, 0, -1, 250);
	CreateDynamicObject(3526, -420.50000000, 1447.80004883, 33.79999924, 0.00000000, 0.00000000, 155.96740723, -1, 0, -1, 250);
	CreateDynamicObject(3526, -434.29998779, 1442.30004883, 32.79999924, 0.00000000, 0.00000000, 203.96667480, -1, 0, -1, 250);
	CreateDynamicObject(3526, -442.20001221, 1448.40002441, 32.70000076, 0.00000000, 0.00000000, 107.96667480, -1, 0, -1, 250);
	CreateDynamicObject(3526, -440.20001221, 1440.30004883, 32.40000153, 0.00000000, 0.00000000, 107.96264648, -1, 0, -1, 250);
	CreateDynamicObject(3526, -443.70001221, 1458.00000000, 33.09999847, 0.00000000, 0.00000000, 107.96264648, -1, 0, -1, 250);
	CreateDynamicObject(3526, -445.50000000, 1471.09997559, 33.29999924, 0.00000000, 0.00000000, 95.96264648, -1, 0, -1, 250);
	CreateDynamicObject(3526, -446.29998779, 1483.00000000, 33.40000153, 0.00000000, 0.00000000, 95.96008301, -1, 0, -1, 250);
	CreateDynamicObject(3526, -447.20001221, 1496.00000000, 33.90000153, 0.00000000, 0.00000000, 95.96008301, -1, 0, -1, 250);
	CreateDynamicObject(3526, -448.50000000, 1514.59997559, 34.59999847, 0.00000000, 0.00000000, 95.96008301, -1, 0, -1, 250);
	CreateDynamicObject(3526, -449.79998779, 1525.59997559, 35.09999847, 0.00000000, 0.00000000, 95.96008301, -1, 0, -1, 250);
	CreateDynamicObject(3526, -451.39999390, 1540.69995117, 35.70000076, 0.00000000, 0.00000000, 97.96008301, -1, 0, -1, 250);
	CreateDynamicObject(3526, -453.89999390, 1555.00000000, 36.00000000, 0.00000000, 358.00000000, 93.95959473, -1, 0, -1, 250);
	CreateDynamicObject(3526, -455.89999390, 1567.09997559, 35.79999924, 0.00000000, 0.00000000, 97.95959473, -1, 0, -1, 250);
	CreateDynamicObject(3526, -450.50000000, 1607.00000000, 34.79999924, 0.00000000, 0.00000000, 83.95959473, -1, 0, -1, 250);
	CreateDynamicObject(3526, -455.19921875, 1583.50000000, 35.40000153, 0.00000000, 0.00000000, 83.95751953, -1, 0, -1, 250);
	CreateDynamicObject(3526, -453.29980469, 1596.00000000, 35.09999847, 0.00000000, 0.00000000, 83.95751953, -1, 0, -1, 250);
	CreateDynamicObject(3526, -446.89999390, 1619.09997559, 34.59999847, 0.00000000, 0.00000000, 83.95751953, -1, 0, -1, 250);
	CreateDynamicObject(3526, -437.29998779, 1641.09997559, 34.70000076, 0.00000000, 0.00000000, 59.95751953, -1, 0, -1, 250);
	CreateDynamicObject(3526, -442.39941406, 1630.39941406, 34.59999847, 0.00000000, 0.00000000, 83.95751953, -1, 0, -1, 250);
	CreateDynamicObject(3526, -432.20001221, 1650.40002441, 35.00000000, 0.00000000, 0.00000000, 59.95239258, -1, 0, -1, 250);
	CreateDynamicObject(3526, -427.20001221, 1658.80004883, 35.50000000, 0.00000000, 0.00000000, 59.95239258, -1, 0, -1, 250);
	CreateDynamicObject(3526, -422.39999390, 1666.69995117, 36.09999847, 0.00000000, 0.00000000, 59.95239258, -1, 0, -1, 250);
	CreateDynamicObject(3526, -417.79998779, 1675.09997559, 36.90000153, 0.00000000, 0.00000000, 59.95239258, -1, 0, -1, 250);
	CreateDynamicObject(3526, -413.39999390, 1684.09997559, 37.70000076, 0.00000000, 0.00000000, 59.95239258, -1, 0, -1, 250);
	CreateDynamicObject(3526, -410.00000000, 1693.59997559, 38.40000153, 0.00000000, 0.00000000, 73.95239258, -1, 0, -1, 250);
	CreateDynamicObject(3526, -405.29998779, 1713.00000000, 39.70000076, 0.00000000, 0.00000000, 73.94897461, -1, 0, -1, 250);
	CreateDynamicObject(3526, -407.19921875, 1702.89941406, 39.09999847, 0.00000000, 0.00000000, 73.94897461, -1, 0, -1, 250);
	CreateDynamicObject(3526, -404.60000610, 1721.30004883, 40.09999847, 0.00000000, 0.00000000, 83.94897461, -1, 0, -1, 250);
	CreateDynamicObject(3526, -404.60000610, 1729.00000000, 40.29999924, 0.00000000, 0.00000000, 83.94653320, -1, 0, -1, 250);
	CreateDynamicObject(3526, -404.00000000, 1736.69995117, 40.59999847, 0.00000000, 0.00000000, 83.94653320, -1, 0, -1, 250);
	CreateDynamicObject(3526, -392.50000000, 1761.90002441, 43.20000076, 0.00000000, 0.00000000, 75.94653320, -1, 0, -1, 250);
	CreateDynamicObject(3526, -401.00000000, 1746.39941406, 41.29999924, 0.00000000, 0.00000000, 75.94299316, -1, 0, -1, 250);
	CreateDynamicObject(3526, -382.70001221, 1778.30004883, 45.40000153, 0.00000000, 0.00000000, 75.94299316, -1, 0, -1, 250);
	CreateDynamicObject(3526, -376.89999390, 1793.90002441, 47.00000000, 0.00000000, 0.00000000, 75.94299316, -1, 0, -1, 250);
	CreateDynamicObject(3526, -377.00000000, 1810.80004883, 48.40000153, 0.00000000, 0.00000000, 101.94299316, -1, 0, -1, 250);
	CreateDynamicObject(3526, -381.10000610, 1829.40002441, 49.79999924, 0.00000000, 0.00000000, 101.94213867, -1, 0, -1, 250);
	CreateDynamicObject(3526, -385.50000000, 1848.30004883, 51.29999924, 0.00000000, 0.00000000, 101.94213867, -1, 0, -1, 250);
	CreateDynamicObject(3526, -390.20001221, 1872.19995117, 53.50000000, 0.00000000, 0.00000000, 101.94213867, -1, 0, -1, 250);
	CreateDynamicObject(3526, -391.10000610, 1892.59997559, 55.70000076, 0.00000000, 0.00000000, 101.94213867, -1, 0, -1, 250);
	CreateDynamicObject(3526, -398.29998779, 1913.00000000, 57.20000076, 0.00000000, 0.00000000, 127.94213867, -1, 0, -1, 250);
	CreateDynamicObject(3526, -432.00000000, 1907.30004883, 57.00000000, 0.00000000, 0.00000000, 233.94128418, -1, 0, -1, 250);
	CreateDynamicObject(3526, -417.00000000, 1918.59960938, 56.50000000, 0.00000000, 0.00000000, 181.93908691, -1, 0, -1, 250);
	CreateDynamicObject(3526, -427.60000610, 1824.90002441, 66.30000305, 0.00000000, 0.00000000, 281.93737793, -1, 0, -1, 250);
	CreateDynamicObject(3526, -434.00000000, 1890.19921875, 59.09999847, 0.00000000, 0.00000000, 265.93505859, -1, 0, -1, 250);
	CreateDynamicObject(3526, -433.09960938, 1871.19921875, 61.50000000, 0.00000000, 0.00000000, 265.93505859, -1, 0, -1, 250);
	CreateDynamicObject(3526, -430.59960938, 1847.79980469, 64.00000000, 0.00000000, 0.00000000, 265.93505859, -1, 0, -1, 250);
	CreateDynamicObject(3526, -425.29998779, 1807.30004883, 68.00000000, 0.00000000, 0.00000000, 277.93505859, -1, 0, -1, 250);
	CreateDynamicObject(3526, -427.00000000, 1770.00000000, 71.00000000, 0.00000000, 0.00000000, 229.93212891, -1, 0, -1, 250);
	CreateDynamicObject(3526, -423.29980469, 1791.19921875, 69.50000000, 0.00000000, 0.00000000, 277.93212891, -1, 0, -1, 250);
	CreateDynamicObject(3526, -458.79998779, 1761.40002441, 71.40000153, 0.00000000, 0.00000000, 151.92736816, -1, 0, -1, 250);
	CreateDynamicObject(3526, -441.50000000, 1759.69921875, 71.09999847, 0.00000000, 0.00000000, 221.92382812, -1, 0, -1, 250);
	CreateDynamicObject(3526, -467.89999390, 1798.00000000, 74.80000305, 0.00000000, 0.00000000, 101.92437744, -1, 0, -1, 250);
	CreateDynamicObject(3526, -467.59960938, 1776.59960938, 72.69999695, 0.00000000, 0.00000000, 95.92370605, -1, 0, -1, 250);
	CreateDynamicObject(3526, -467.20001221, 1820.00000000, 77.00000000, 0.00000000, 0.00000000, 101.92016602, -1, 0, -1, 250);
	CreateDynamicObject(3526, -471.60000610, 1871.09997559, 81.59999847, 0.00000000, 0.00000000, 101.92016602, -1, 0, -1, 250);
	CreateDynamicObject(3526, -468.79980469, 1844.69921875, 79.30000305, 0.00000000, 0.00000000, 101.92016602, -1, 0, -1, 250);
	CreateDynamicObject(3526, -477.10000610, 1907.40002441, 84.19999695, 0.00000000, 0.00000000, 101.92016602, -1, 0, -1, 250);
	CreateDynamicObject(3526, -480.29998779, 1932.69995117, 85.50000000, 0.00000000, 0.00000000, 79.92016602, -1, 0, -1, 250);
	CreateDynamicObject(3526, -474.39999390, 1954.80004883, 84.00000000, 0.00000000, 0.00000000, 61.92004395, -1, 0, -1, 250);
	CreateDynamicObject(3526, -461.70001221, 1973.00000000, 80.40000153, 0.00000000, 0.00000000, 51.91894531, -1, 0, -1, 250);
	CreateDynamicObject(3526, -440.00000000, 1995.40002441, 74.90000153, 0.00000000, 0.00000000, 51.91589355, -1, 0, -1, 250);
	CreateDynamicObject(3526, -381.79998779, 2054.30004883, 60.70000076, 0.00000000, 0.00000000, 51.91589355, -1, 0, -1, 250);
	CreateDynamicObject(3526, -424.00000000, 2012.09997559, 70.50000000, 0.00000000, 0.00000000, 51.91589355, -1, 0, -1, 250);
	CreateDynamicObject(3526, -402.09960938, 2032.79980469, 64.90000153, 0.00000000, 0.00000000, 51.91589355, -1, 0, -1, 250);
	CreateDynamicObject(3461, -309.00000000, 1504.09997559, 76.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -309.10000610, 1504.80004883, 76.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -309.39999390, 1505.30004883, 76.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -309.29998779, 1505.90002441, 76.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -295.20001221, 1506.69995117, 76.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -295.39999390, 1506.19995117, 76.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -295.20001221, 1505.50000000, 76.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3461, -295.00000000, 1504.69995117, 76.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7073, -478.70001221, 1577.69995117, 53.90000153, 0.00000000, 0.00000000, 10.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7392, -452.89999390, 1657.50000000, 58.50000000, 0.00000000, 0.00000000, 140.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1649, -261.79998779, 1546.59997559, 76.09999847, 0.00000000, 0.00000000, 316.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1649, -273.79998779, 1558.90002441, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -264.59960938, 1549.79980469, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -267.69921875, 1552.79980469, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -270.89941406, 1555.79980469, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -276.60000610, 1561.69995117, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -279.70001221, 1564.69995117, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -285.79998779, 1570.59997559, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -282.69921875, 1567.79980469, 76.09999847, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(16362, -274.89999390, 1554.59997559, 77.50000000, 0.00000000, 0.00000000, 43.98925781, -1, 0, -1, 250);
	CreateDynamicObject(1649, -291.60000610, 1576.19995117, 76.19999695, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -288.89941406, 1573.50000000, 76.19999695, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -294.79998779, 1579.19995117, 76.19999695, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -298.00000000, 1582.19995117, 76.19999695, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(1649, -301.10000610, 1585.19995117, 76.19999695, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(7313, -317.79980469, 1515.29980469, 77.09999847, 0.00000000, 0.00000000, 177.99499512, -1, 0, -1, 250);
	CreateDynamicObject(7313, -272.50000000, 1543.50000000, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -277.19921875, 1548.50000000, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -281.79998779, 1553.09997559, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -286.39999390, 1558.09997559, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -291.20001221, 1562.90002441, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -295.89941406, 1567.79980469, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -300.60000610, 1572.69995117, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -305.29998779, 1577.59997559, 79.69999695, 0.00000000, 0.00000000, 313.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7313, -331.29998779, 1515.30004883, 77.09999847, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(7313, -324.79998779, 1515.19995117, 77.09999847, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(1491, -344.60000610, 1534.80004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1491, -341.60000610, 1534.80004883, 74.59999847, 0.00000000, 0.00000000, 182.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3964, -347.00000000, 1536.80004883, 76.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3921, -346.29998779, 1539.19995117, 75.19999695, 0.00000000, 0.00000000, 176.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2571, -342.50000000, 1548.80004883, 74.59999847, 0.00000000, 0.00000000, 320.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2239, -346.00000000, 1549.00000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1536.30004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1537.50000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1538.59997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1539.80004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1541.00000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1542.19995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1543.40002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1544.59997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1545.80004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1547.00000000, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1548.19995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2187, -346.50000000, 1535.09997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2898, -341.20001221, 1546.59997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2898, -341.39999390, 1541.19995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2898, -341.50000000, 1537.80004883, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2898, -345.10000610, 1537.59997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2898, -345.20001221, 1542.40002441, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2898, -344.89999390, 1546.59997559, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(16151, -340.20001221, 1542.69995117, 74.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1561, -345.50000000, 1549.30004883, 74.59999847, 0.00000000, 0.00000000, 182.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1561, -344.00000000, 1549.39941406, 74.59999847, 0.00000000, 0.00000000, 181.99951172, -1, 0, -1, 250);
	CreateDynamicObject(8620, -349.39999390, 1530.30004883, 97.50000000, 0.00000000, 0.00000000, 83.99597168, -1, 0, -1, 250);
	CreateDynamicObject(8167, -351.29998779, 1517.19995117, 75.69999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8167, -351.29998779, 1509.80004883, 75.69999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8167, -356.00000000, 1507.40002441, 75.69999695, 0.00000000, 0.00000000, 269.99499512, -1, 0, -1, 250);
	CreateDynamicObject(8167, -363.79998779, 1507.50000000, 75.69999695, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(8167, -370.70001221, 1507.50000000, 75.69999695, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(8167, -375.00000000, 1507.40002441, 75.69999695, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(8167, -377.10000610, 1512.00000000, 75.69999695, 0.00000000, 0.00000000, 177.99450684, -1, 0, -1, 250);
	CreateDynamicObject(8167, -376.89999390, 1519.50000000, 75.69999695, 0.00000000, 0.00000000, 177.98950195, -1, 0, -1, 250);
	CreateDynamicObject(8167, -376.79998779, 1526.80004883, 75.69999695, 0.00000000, 0.00000000, 179.98950195, -1, 0, -1, 250);
	CreateDynamicObject(8167, -376.79998779, 1534.19995117, 75.69999695, 0.00000000, 0.00000000, 179.98901367, -1, 0, -1, 250);
	CreateDynamicObject(8167, -376.79998779, 1541.40002441, 75.69999695, 0.00000000, 0.00000000, 179.98901367, -1, 0, -1, 250);
	CreateDynamicObject(8167, -372.20001221, 1543.09997559, 75.69999695, 0.00000000, 0.00000000, 81.98898315, -1, 0, -1, 250);
	CreateDynamicObject(8167, -364.89999390, 1542.00000000, 75.69999695, 0.00000000, 0.00000000, 81.98547363, -1, 0, -1, 250);
	CreateDynamicObject(8167, -357.70001221, 1541.00000000, 75.69999695, 0.00000000, 0.00000000, 81.98547363, -1, 0, -1, 250);
	CreateDynamicObject(1340, -374.89999390, 1538.50000000, 75.50000000, 0.00000000, 0.00000000, 354.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1341, -375.50000000, 1534.00000000, 75.40000153, 0.00000000, 0.00000000, 354.00000000, -1, 0, -1, 250);
	CreateDynamicObject(642, -370.00000000, 1540.19995117, 76.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(642, -365.10000610, 1539.19995117, 76.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(642, -356.79998779, 1537.50000000, 76.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(642, -360.50000000, 1538.19995117, 76.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -450.20001221, 1440.40002441, 37.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -452.79998779, 1453.09997559, 37.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -455.50000000, 1468.19995117, 37.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -457.79998779, 1502.40002441, 39.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -456.39941406, 1480.39941406, 38.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -457.09960938, 1490.79980469, 39.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -458.29998779, 1512.30004883, 40.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -459.00000000, 1520.50000000, 40.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -459.89999390, 1528.09997559, 40.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -461.89941406, 1543.79980469, 41.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -460.89941406, 1535.89941406, 41.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, -442.10000610, 1426.09997559, 33.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, -432.19921875, 1429.39941406, 34.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, -435.29980469, 1428.09960938, 33.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, -438.79980469, 1427.09960938, 33.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8661, -328.29980469, 1524.69921875, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8661, -282.79998779, 1544.00000000, 74.40000153, 0.00000000, 0.00000000, 313.99475098, -1, 0, -1, 250);
	CreateDynamicObject(8661, -288.39941406, 1524.59960938, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8661, -300.20001221, 1562.09997559, 74.40000153, 0.00000000, 0.00000000, 313.99475098, -1, 0, -1, 250);
	CreateDynamicObject(1237, -332.79998779, 1344.09997559, 53.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -331.70001221, 1341.40002441, 53.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -330.10000610, 1338.19995117, 53.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -328.89999390, 1335.40002441, 53.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -327.89999390, 1332.59997559, 53.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -334.10000610, 1324.90002441, 51.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -327.00000000, 1329.89941406, 53.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -326.89941406, 1327.39941406, 52.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -328.59960938, 1325.09960938, 52.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -331.29980469, 1323.79980469, 51.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -336.60000610, 1326.80004883, 50.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -338.50000000, 1328.80004883, 51.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -340.60000610, 1331.40002441, 50.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -342.89999390, 1334.30004883, 50.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -345.29998779, 1338.09997559, 50.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(6973, -248.00000000, 1458.00000000, 79.00000000, 0.00000000, 0.00000000, 6.00000000, -1, 0, -1, 250);
	CreateDynamicObject(10236, -444.79998779, 1425.00000000, 43.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(16113, -428.39999390, 1399.30004883, 30.50000000, 0.00000000, 0.00000000, 56.00000000, -1, 0, -1, 250);
	CreateDynamicObject(974, -542.40002441, 2006.59997559, 62.00000000, 0.00000000, 0.00000000, 56.00000000, -1, 0, -1, 250);
	CreateDynamicObject(974, -549.09997559, 1997.69995117, 62.00000000, 0.00000000, 0.00000000, 51.99829102, -1, 0, -1, 250);
	CreateDynamicObject(974, -539.20001221, 2011.40002441, 62.00000000, 0.00000000, 0.00000000, 55.99731445, -1, 0, -1, 250);
	CreateDynamicObject(974, -551.90002441, 1994.09997559, 62.00000000, 0.00000000, 0.00000000, 51.99829102, -1, 0, -1, 250);
	CreateDynamicObject(981, -546.40002441, 2002.59997559, 59.40000153, 0.00000000, 0.00000000, 54.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -530.90002441, 1988.40002441, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -531.09997559, 1989.40002441, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -529.09997559, 1990.00000000, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -530.59960938, 1990.29980469, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -529.59960938, 1990.69921875, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -529.20001221, 1989.09997559, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -529.70001221, 1988.30004883, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -538.29980469, 2011.50000000, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -552.79998779, 1991.09997559, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -549.09997559, 1997.09997559, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -542.59997559, 2006.00000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -538.79998779, 1978.59997559, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -522.59997559, 2001.50000000, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -525.90002441, 1972.30004883, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -514.40002441, 1996.50000000, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -512.70001221, 1971.59997559, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -479.00000000, 1988.30004883, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -501.79998779, 1996.80004883, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -481.60000610, 2012.90002441, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -501.50000000, 1975.19921875, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -487.69921875, 1981.19921875, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -491.50000000, 2004.19921875, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -469.60000610, 1998.59997559, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -475.79998779, 2018.69995117, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -462.19921875, 2006.59960938, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -469.79998779, 2025.09997559, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, -457.50000000, 2012.00000000, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -381.20001221, 1873.30004883, 53.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -403.10000610, 1926.19995117, 57.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -382.29980469, 1881.29980469, 54.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -389.50000000, 1917.19921875, 57.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -382.79980469, 1900.09960938, 56.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -385.89941406, 1910.19921875, 57.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -393.39941406, 1920.59960938, 57.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -397.79998779, 1923.19995117, 57.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -410.79998779, 1927.80004883, 56.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -417.89999390, 1927.30004883, 56.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -383.20001221, 1891.09997559, 55.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -424.39999390, 1925.69995117, 56.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -430.89999390, 1921.50000000, 57.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -383.89999390, 1905.19995117, 56.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -436.70001221, 1916.40002441, 56.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -442.00000000, 1901.50000000, 58.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -440.00000000, 1908.59997559, 57.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -443.29998779, 1894.40002441, 58.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -443.39999390, 1887.09997559, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -442.79998779, 1876.40002441, 61.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -414.50000000, 1794.50000000, 69.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -415.10000610, 1801.30004883, 68.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -414.00000000, 1789.00000000, 70.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -414.60000610, 1778.59997559, 70.69999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -413.79998779, 1783.50000000, 70.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -425.29998779, 1759.19995117, 71.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -415.39941406, 1773.79980469, 70.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -417.39941406, 1768.69921875, 71.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -421.10000610, 1763.80004883, 71.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -461.70001221, 1753.69995117, 71.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -429.59960938, 1756.29980469, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -434.50000000, 1753.29980469, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -439.69921875, 1751.19921875, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -439.69921875, 1751.19921875, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -445.00000000, 1750.29980469, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -450.29980469, 1749.89941406, 71.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -456.19921875, 1750.69921875, 71.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -471.60000610, 1762.00000000, 72.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -467.00000000, 1756.79980469, 71.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -476.70001221, 1780.00000000, 73.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -474.10000610, 1767.00000000, 72.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -476.20001221, 1773.80004883, 72.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -476.39999390, 1786.90002441, 73.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -476.39999390, 1793.30004883, 74.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -476.10000610, 1800.50000000, 75.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -475.69921875, 1807.79980469, 75.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -406.00000000, 2018.00000000, 67.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -385.00000000, 2037.09997559, 62.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -400.79980469, 2022.19921875, 66.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -396.09960938, 2026.69921875, 65.30000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -390.39941406, 2032.09960938, 64.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -379.50000000, 2042.90002441, 61.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -370.50000000, 2072.00000000, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -374.59960938, 2048.69921875, 61.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -371.79980469, 2054.89941406, 61.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -369.69921875, 2063.89941406, 59.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -390.10000610, 2089.69995117, 60.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -373.89941406, 2077.79980469, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -377.79980469, 2082.29980469, 59.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -383.59960938, 2086.89941406, 60.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -397.29998779, 2091.19995117, 60.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -404.50000000, 2089.30004883, 60.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -411.70001221, 2086.50000000, 61.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -416.50000000, 2082.80004883, 61.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -421.10000610, 2078.30004883, 60.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -426.10000610, 2073.80004883, 60.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3509, -430.50000000, 2069.00000000, 60.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, -382.50000000, 1895.19995117, 57.00000000, 0.00000000, 353.99597168, 95.98205566, -1, 0, -1, 250);
	CreateDynamicObject(979, -380.39999390, 1868.50000000, 54.00000000, 0.00000000, 353.99597168, 105.98107910, -1, 0, -1, 250);
	CreateDynamicObject(979, -382.29998779, 1877.30004883, 55.29999924, 0.00000000, 353.99597168, 99.97656250, -1, 0, -1, 250);
	CreateDynamicObject(979, -383.29998779, 1886.00000000, 56.20000076, 0.00000000, 353.99597168, 93.97705078, -1, 0, -1, 250);
	CreateDynamicObject(979, -384.29998779, 1905.40002441, 57.59999847, 0.00000000, 357.99499512, 105.97961426, -1, 0, -1, 250);
	CreateDynamicObject(979, -393.39999390, 1919.80004883, 58.00000000, 0.00000000, 357.98950195, 145.97485352, -1, 0, -1, 250);
	CreateDynamicObject(979, -387.79998779, 1913.40002441, 57.90000153, 0.00000000, 359.98950195, 123.97473145, -1, 0, -1, 250);
	CreateDynamicObject(979, -400.79998779, 1924.69995117, 57.79999924, 0.00000000, 1.98852539, 151.97192383, -1, 0, -1, 250);
	CreateDynamicObject(979, -406.70001221, 1927.19995117, 57.50000000, 0.00000000, 1.98303223, 171.96899414, -1, 0, -1, 250);
	CreateDynamicObject(979, -414.00000000, 1927.19995117, 57.59999847, 0.00000000, 1.97753906, 179.96459961, -1, 0, -1, 250);
	CreateDynamicObject(979, -427.50000000, 1923.50000000, 57.09999847, 0.00000000, 353.97399902, 209.96388245, -1, 0, -1, 250);
	CreateDynamicObject(979, -420.70001221, 1926.19995117, 57.09999847, 0.00000000, 1.96655273, 193.95373535, -1, 0, -1, 250);
	CreateDynamicObject(979, -433.70001221, 1918.90002441, 57.29999924, 0.00000000, 355.97351074, 227.95996094, -1, 0, -1, 250);
	CreateDynamicObject(979, -438.00000000, 1912.30004883, 57.70000076, 0.00000000, 355.97351074, 245.95446777, -1, 0, -1, 250);
	CreateDynamicObject(979, -440.39999390, 1905.09997559, 58.40000153, 0.00000000, 353.96850586, 253.95599365, -1, 0, -1, 250);
	CreateDynamicObject(979, -442.70001221, 1881.00000000, 61.29999924, 0.00000000, 353.96301270, 269.95056152, -1, 0, -1, 250);
	CreateDynamicObject(979, -442.00000000, 1898.00000000, 59.09999847, 0.00000000, 353.96301270, 259.95056152, -1, 0, -1, 250);
	CreateDynamicObject(979, -442.60000610, 1890.80004883, 60.09999847, 0.00000000, 353.96301270, 265.95056152, -1, 0, -1, 250);
	CreateDynamicObject(978, -414.79998779, 1799.09997559, 69.90000153, 0.00000000, 1.98303223, 103.98107910, -1, 0, -1, 250);
	CreateDynamicObject(978, -413.89999390, 1790.90002441, 70.69999695, 0.00000000, 3.98254395, 93.97949219, -1, 0, -1, 250);
	CreateDynamicObject(978, -414.39999390, 1782.09997559, 71.19999695, 0.00000000, 359.97753906, 83.97741699, -1, 0, -1, 250);
	CreateDynamicObject(978, -416.20001221, 1773.59997559, 71.50000000, 0.00000000, 1.97204590, 69.97229004, -1, 0, -1, 250);
	CreateDynamicObject(978, -420.00000000, 1766.09997559, 72.00000000, 0.00000000, 357.96752930, 55.96826172, -1, 0, -1, 250);
	CreateDynamicObject(978, -425.89999390, 1759.19995117, 72.00000000, 0.00000000, 3.96606445, 31.96813965, -1, 0, -1, 250);
	CreateDynamicObject(978, -431.29998779, 1755.59997559, 72.00000000, 0.00000000, 357.96203613, 29.96508789, -1, 0, -1, 250);
	CreateDynamicObject(978, -439.79998779, 1752.09997559, 72.00000000, 0.00000000, 3.96057129, 9.96447754, -1, 0, -1, 250);
	CreateDynamicObject(978, -462.29998779, 1754.69995117, 72.00000000, 0.00000000, 3.96057129, 321.96447754, -1, 0, -1, 250);
	CreateDynamicObject(978, -468.89999390, 1759.40002441, 72.00000000, 0.00000000, 3.96057129, 307.95983887, -1, 0, -1, 250);
	CreateDynamicObject(978, -472.89999390, 1766.40002441, 73.09999847, 0.00000000, 9.96057129, 291.95776367, -1, 0, -1, 250);
	CreateDynamicObject(978, -475.20001221, 1775.00000000, 74.30000305, 0.00000000, 3.95910645, 279.95617676, -1, 0, -1, 250);
	CreateDynamicObject(978, -476.20001221, 1784.80004883, 74.50000000, 0.00000000, 3.95507812, 269.95361328, -1, 0, -1, 250);
	CreateDynamicObject(978, -475.89999390, 1792.19995117, 75.19999695, 0.00000000, 3.95507812, 269.95056152, -1, 0, -1, 250);
	CreateDynamicObject(978, -475.29998779, 1799.69995117, 76.00000000, 0.00000000, 3.95507812, 269.95056152, -1, 0, -1, 250);
	CreateDynamicObject(978, -475.20001221, 1806.09997559, 76.50000000, 0.00000000, 3.95507812, 269.95056152, -1, 0, -1, 250);
	CreateDynamicObject(979, -397.50000000, 2025.50000000, 66.40000153, 0.00000000, 7.97399902, 43.96386719, -1, 0, -1, 250);
	CreateDynamicObject(979, -404.39941406, 2019.09960938, 68.09999847, 0.00000000, 5.97106934, 43.96179199, -1, 0, -1, 250);
	CreateDynamicObject(979, -375.59960938, 2047.69921875, 62.00000000, 0.00000000, 3.97058105, 57.95980835, -1, 0, -1, 250);
	CreateDynamicObject(979, -391.59960938, 2031.00000000, 65.09999847, 0.00000000, 7.97058105, 43.96179199, -1, 0, -1, 250);
	CreateDynamicObject(979, -386.19921875, 2036.29980469, 64.00000000, 0.00000000, 7.97058105, 43.96179199, -1, 0, -1, 250);
	CreateDynamicObject(979, -380.69921875, 2041.79980469, 62.90000153, 0.00000000, 7.97058105, 43.96179199, -1, 0, -1, 250);
	CreateDynamicObject(979, -371.00000000, 2055.30004883, 61.20000076, 0.00000000, 3.97058105, 69.95544434, -1, 0, -1, 250);
	CreateDynamicObject(979, -370.10000610, 2063.39990234, 61.20000076, 0.00000000, 1.96752930, 87.95104980, -1, 0, -1, 250);
	CreateDynamicObject(979, -371.89999390, 2071.30004883, 61.20000076, 0.00000000, 357.96752930, 113.95108032, -1, 0, -1, 250);
	CreateDynamicObject(979, -376.50000000, 2078.69921875, 61.20000076, 0.00000000, 1.96752930, 133.94531250, -1, 0, -1, 250);
	CreateDynamicObject(979, -383.09960938, 2084.50000000, 61.20000076, 0.00000000, 359.96752930, 147.94192505, -1, 0, -1, 250);
	CreateDynamicObject(979, -390.20001221, 2088.00000000, 61.20000076, 0.00000000, 357.96752930, 161.94189453, -1, 0, -1, 250);
	CreateDynamicObject(979, -399.29980469, 2089.39941406, 61.50000000, 0.00000000, 357.96752930, 183.92761230, -1, 0, -1, 250);
	CreateDynamicObject(979, -408.20001221, 2086.89990234, 61.70000076, 0.00000000, 1.96752930, 207.93310547, -1, 0, -1, 250);
	CreateDynamicObject(979, -415.39999390, 2082.00000000, 61.70000076, 0.00000000, 359.96752930, 221.92382812, -1, 0, -1, 250);
	CreateDynamicObject(979, -420.69921875, 2077.29980469, 61.70000076, 0.00000000, 359.96752930, 223.92333984, -1, 0, -1, 250);
	CreateDynamicObject(979, -425.50000000, 2072.60009766, 61.70000076, 0.00000000, 357.96752930, 227.92138672, -1, 0, -1, 250);
	CreateDynamicObject(1237, -430.39999390, 2055.60009766, 60.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -423.69921875, 2062.59960938, 60.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -426.00000000, 2060.30004883, 60.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -428.19921875, 2058.00000000, 60.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -432.79998779, 2053.10009766, 60.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -437.10000610, 2048.39990234, 60.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -434.79998779, 2050.89990234, 60.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -439.20001221, 2046.30004883, 60.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -441.20001221, 2044.09997559, 59.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -443.29998779, 2041.69995117, 59.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -449.00000000, 2035.40002441, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -445.29980469, 2039.50000000, 59.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -447.29980469, 2037.39941406, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -454.10000610, 2029.90002441, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -450.59960938, 2033.69921875, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -452.29980469, 2031.79980469, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -455.89999390, 2027.80004883, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -457.70001221, 2026.00000000, 59.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -464.70001221, 2018.09997559, 59.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -459.29980469, 2024.19921875, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -460.89941406, 2022.29980469, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -462.79998779, 2020.19995117, 59.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -466.79998779, 2016.09997559, 59.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -468.70001221, 2013.90002441, 59.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -478.20001221, 2003.90002441, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -470.60000610, 2011.69995117, 59.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -473.20001221, 2009.09997559, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -475.69921875, 2006.39941406, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -482.89999390, 1999.30004883, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -480.39941406, 2001.59960938, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -490.10000610, 1992.80004883, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -485.09960938, 1997.19921875, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -487.59960938, 1994.89941406, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -495.70001221, 1988.90002441, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -492.79980469, 1990.50000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -499.20001221, 1987.00000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -504.60000610, 1985.50000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -502.79980469, 1985.69921875, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -510.79998779, 1984.80004883, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -506.39941406, 1985.19921875, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -508.29998779, 1985.00000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -512.79998779, 1984.80004883, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -514.79998779, 1985.19995117, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -516.90002441, 1985.90002441, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -518.90002441, 1986.69995117, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -522.29998779, 1988.50000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -520.50000000, 1987.59960938, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -524.29998779, 1989.40002441, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -526.40002441, 1990.69995117, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -504.39999390, 1984.59997559, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -507.60000610, 1983.50000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -505.79980469, 1983.89941406, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -516.40002441, 1982.00000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -510.00000000, 1982.79980469, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -512.09960938, 1982.39941406, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -514.19921875, 1981.89941406, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -518.59997559, 1981.90002441, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -525.20001221, 1983.30004883, 59.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -520.69921875, 1982.09960938, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -522.89941406, 1982.39941406, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -527.40002441, 1983.90002441, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, -530.00000000, 1985.00000000, 59.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1696, -475.89941406, 2011.50000000, 60.20000076, 0.00000000, 0.00000000, 315.99975586, -1, 0, -1, 250);
	CreateDynamicObject(3460, -462.89999390, 1549.19995117, 41.40000153, 0.00000000, 0.00000000, 6.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -463.89999390, 1555.09997559, 41.40000153, 0.00000000, 0.00000000, 5.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3460, -465.10000610, 1559.90002441, 41.50000000, 0.00000000, 0.00000000, 5.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3460, -465.79998779, 1564.40002441, 41.40000153, 0.00000000, 0.00000000, 5.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3460, -465.89999390, 1570.30004883, 41.29999924, 0.00000000, 0.00000000, 5.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3460, -466.10000610, 1576.40002441, 41.09999847, 0.00000000, 0.00000000, 5.99853516, -1, 0, -1, 250);
	CreateDynamicObject(3460, -465.50000000, 1582.29980469, 41.00000000, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -465.10000610, 1587.40002441, 40.79999924, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -464.50000000, 1592.59997559, 40.70000076, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -463.70001221, 1597.50000000, 40.59999847, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -462.60000610, 1602.59997559, 40.50000000, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -461.29998779, 1607.59997559, 40.40000153, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -459.89999390, 1612.30004883, 40.29999924, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -458.60000610, 1616.09997559, 40.20000076, 0.00000000, 0.00000000, 349.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -457.20001221, 1620.59997559, 40.20000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -455.60000610, 1625.00000000, 40.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -453.69921875, 1630.50000000, 40.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(2780, -451.89999390, 2043.50000000, 60.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -442.89999390, 2052.80004883, 60.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -464.79998779, 2028.50000000, 59.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -457.79998779, 2036.40002441, 59.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -424.60000610, 2070.89990234, 60.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2780, -433.39941406, 2062.09960938, 60.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -451.60000610, 1636.30004883, 40.09999847, 0.00000000, 0.00000000, 355.99548340, -1, 0, -1, 250);
	CreateDynamicObject(3460, -445.20001221, 1648.59997559, 40.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -448.70001221, 1642.09997559, 40.20000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -442.29998779, 1654.40002441, 40.50000000, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -439.29998779, 1659.50000000, 40.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -436.29998779, 1664.19995117, 41.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -433.89999390, 1668.00000000, 41.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -430.60000610, 1673.80004883, 41.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -427.89999390, 1678.90002441, 42.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -425.29998779, 1683.80004883, 42.70000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -422.70001221, 1688.50000000, 43.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -420.89999390, 1693.40002441, 43.59999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -419.00000000, 1698.30004883, 43.90000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -417.60000610, 1703.40002441, 44.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -415.50000000, 1713.09997559, 44.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -416.70001221, 1708.00000000, 44.59999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -414.70001221, 1724.90002441, 45.20000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -414.89999390, 1718.59997559, 45.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -415.50000000, 1713.09960938, 44.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -414.00000000, 1732.80004883, 45.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -413.10000610, 1738.40002441, 45.40000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -412.20001221, 1744.59997559, 45.59999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -410.00000000, 1749.90002441, 45.90000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -407.89999390, 1754.69995117, 46.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -405.79998779, 1759.30004883, 46.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -403.29998779, 1764.30004883, 47.40000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -400.29998779, 1768.59997559, 47.90000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -397.70001221, 1773.09997559, 48.50000000, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -395.10000610, 1777.09997559, 49.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -392.70001221, 1780.69995117, 49.59999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -390.39999390, 1785.69995117, 50.20000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -387.70001221, 1790.40002441, 50.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -386.79998779, 1794.69995117, 51.40000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -385.10000610, 1804.00000000, 52.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -385.70001221, 1808.19995117, 52.70000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -385.50000000, 1799.50000000, 51.90000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -386.29998779, 1812.40002441, 53.00000000, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -387.50000000, 1817.69995117, 53.50000000, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -388.89999390, 1824.30004883, 54.00000000, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -391.00000000, 1831.09997559, 54.59999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -392.39999390, 1838.09997559, 55.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -393.60000610, 1843.30004883, 55.50000000, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -394.60000610, 1847.80004883, 55.90000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -395.60000610, 1852.80004883, 56.29999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -396.60000610, 1857.09997559, 56.70000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -397.70001221, 1862.50000000, 57.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3509, -379.29998779, 1863.30004883, 52.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -403.60000610, 1906.50000000, 61.50000000, 0.00000000, 0.00000000, 9.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -399.00000000, 1873.00000000, 58.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -399.60000610, 1878.50000000, 58.59999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -399.50000000, 1883.40002441, 59.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -400.10000610, 1891.00000000, 59.90000153, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -399.00000000, 1873.00000000, 58.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -400.09960938, 1897.69921875, 60.70000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3509, -382.79980469, 1900.09960938, 56.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -416.29998779, 1909.59997559, 61.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -408.00000000, 1909.80004883, 61.29999924, 0.00000000, 0.00000000, 9.98657227, -1, 0, -1, 250);
	CreateDynamicObject(3460, -403.59960938, 1906.50000000, 61.50000000, 0.00000000, 0.00000000, 9.98657227, -1, 0, -1, 250);
	CreateDynamicObject(3460, -420.29998779, 1906.90002441, 61.09999847, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -412.39941406, 1910.59960938, 61.20000076, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -399.60000610, 1868.69995117, 57.79999924, 0.00000000, 0.00000000, 349.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -425.20001221, 1898.90002441, 62.29999924, 0.00000000, 0.00000000, 65.99145508, -1, 0, -1, 250);
	CreateDynamicObject(3460, -425.79998779, 1890.00000000, 63.59999847, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -424.29980469, 1902.19921875, 61.70000076, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -421.79998779, 1833.00000000, 69.80000305, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -426.09960938, 1895.19921875, 62.90000153, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -426.20001221, 1876.90002441, 65.19999695, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -426.19921875, 1885.39941406, 64.19999695, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -426.09960938, 1880.89941406, 64.80000305, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -425.50000000, 1862.09997559, 66.80000305, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -426.39941406, 1873.00000000, 65.59999847, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -425.69921875, 1867.09960938, 66.30000305, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -424.29980469, 1855.59960938, 67.59999847, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -423.59960938, 1849.00000000, 68.19999695, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -423.29980469, 1843.89941406, 68.69999695, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -417.79998779, 1808.00000000, 72.30000305, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -418.70001221, 1814.40002441, 71.69999695, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -421.79980469, 1833.00000000, 69.80000305, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -473.39999390, 1818.40002441, 81.00000000, 0.00000000, 0.00000000, 271.98937988, -1, 0, -1, 250);
	CreateDynamicObject(978, -348.79998779, 1318.30004883, 51.09999847, 0.00000000, 355.98449707, 315.97985840, -1, 0, -1, 250);
	CreateDynamicObject(978, -450.00000000, 1750.80004883, 72.00000000, 0.00000000, 3.96057129, 349.95910645, -1, 0, -1, 250);
	CreateDynamicObject(978, -456.70001221, 1751.59997559, 72.00000000, 0.00000000, 3.96057129, 333.95849609, -1, 0, -1, 250);
	CreateDynamicObject(3509, -368.89999390, 1347.19995117, 47.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3460, -419.79980469, 1820.39941406, 71.09999847, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -419.79980469, 1820.39941406, 71.09999847, 0.00000000, 0.00000000, 65.98937988, -1, 0, -1, 250);
	CreateDynamicObject(3460, -473.59960938, 1823.29980469, 81.00000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -473.89999390, 1828.30004883, 82.00000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -474.29998779, 1833.50000000, 82.50000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -474.70001221, 1838.40002441, 83.00000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -475.10000610, 1843.19995117, 83.40000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -475.29998779, 1847.40002441, 83.80000305, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -475.79998779, 1851.19995117, 84.09999847, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -476.10000610, 1855.30004883, 84.50000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -476.79998779, 1859.90002441, 84.90000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -477.10000610, 1864.80004883, 85.30000305, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -477.39999390, 1868.90002441, 85.69999695, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -478.00000000, 1873.09997559, 86.00000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -478.70001221, 1877.59997559, 86.40000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -480.20001221, 1886.50000000, 87.09999847, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -479.19921875, 1881.59960938, 86.69999695, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -480.60000610, 1891.40002441, 87.50000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -481.60000610, 1896.09997559, 87.90000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -482.50000000, 1900.69995117, 88.19999695, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -483.39999390, 1905.19995117, 88.50000000, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -484.10000610, 1910.30004883, 88.80000305, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -484.89999390, 1915.00000000, 89.09999847, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -485.70001221, 1920.90002441, 89.40000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -486.10000610, 1926.40002441, 89.59999847, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -486.20001221, 1932.09997559, 89.90000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -485.89999390, 1938.30004883, 89.90000153, 0.00000000, 0.00000000, 271.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -485.10000610, 1943.40002441, 89.80000305, 0.00000000, 0.00000000, 257.98852539, -1, 0, -1, 250);
	CreateDynamicObject(3460, -483.89999390, 1949.09997559, 89.59999847, 0.00000000, 0.00000000, 257.98645020, -1, 0, -1, 250);
	CreateDynamicObject(3460, -481.50000000, 1954.40002441, 88.80000305, 0.00000000, 0.00000000, 233.98645020, -1, 0, -1, 250);
	CreateDynamicObject(3460, -478.89999390, 1959.80004883, 88.00000000, 0.00000000, 0.00000000, 233.98132324, -1, 0, -1, 250);
	CreateDynamicObject(3460, -476.60000610, 1964.50000000, 87.19999695, 0.00000000, 0.00000000, 225.98132324, -1, 0, -1, 250);
	CreateDynamicObject(3460, -473.29998779, 1969.30004883, 86.30000305, 0.00000000, 0.00000000, 221.98132324, -1, 0, -1, 250);
	CreateDynamicObject(3460, -469.79998779, 1974.00000000, 85.40000153, 0.00000000, 0.00000000, 211.98132324, -1, 0, -1, 250);
	CreateDynamicObject(3460, -466.70001221, 1978.00000000, 84.59999847, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -463.60000610, 1981.50000000, 83.80000305, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -458.00000000, 1987.69995117, 82.30000305, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -460.59960938, 1984.79980469, 83.00000000, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -454.70001221, 1991.30004883, 81.50000000, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -451.39999390, 1994.69995117, 80.59999847, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -447.79998779, 1998.00000000, 79.69999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -440.39999390, 2005.90002441, 77.69999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -444.00000000, 2002.00000000, 78.69999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -433.89999390, 2012.50000000, 75.90000153, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -437.00000000, 2009.29980469, 76.80000305, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -430.60000610, 2015.40002441, 75.00000000, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -427.70001221, 2018.00000000, 74.19999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -425.20001221, 2021.00000000, 73.50000000, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -422.60000610, 2023.59997559, 72.80000305, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -420.20001221, 2026.19995117, 72.19999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -417.10000610, 2029.50000000, 71.30000305, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -413.79998779, 2032.19995117, 70.50000000, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -410.20001221, 2035.00000000, 69.69999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -402.79998779, 2042.90002441, 67.90000153, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -406.69921875, 2038.50000000, 68.90000153, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -391.20001221, 2054.30004883, 65.59999847, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -399.19921875, 2046.00000000, 67.19999695, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -395.19921875, 2050.09960938, 66.40000153, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -386.39999390, 2063.19995117, 64.69999695, 0.00000000, 0.00000000, 241.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -388.00000000, 2057.89941406, 65.09999847, 0.00000000, 0.00000000, 211.98120117, -1, 0, -1, 250);
	CreateDynamicObject(3460, -389.50000000, 2071.10009766, 64.59999847, 0.00000000, 0.00000000, 299.97937012, -1, 0, -1, 250);
	CreateDynamicObject(3460, -386.79980469, 2067.50000000, 64.50000000, 0.00000000, 0.00000000, 271.97753906, -1, 0, -1, 250);
	CreateDynamicObject(3460, -401.70001221, 2073.80004883, 65.00000000, 0.00000000, 0.00000000, 21.97619629, -1, 0, -1, 250);
	CreateDynamicObject(3460, -393.50000000, 2073.79980469, 64.80000305, 0.00000000, 0.00000000, 317.97180176, -1, 0, -1, 250);
	CreateDynamicObject(3460, -397.39941406, 2075.00000000, 64.90000153, 0.00000000, 0.00000000, 1.97204590, -1, 0, -1, 250);
	CreateDynamicObject(3460, -406.00000000, 2070.60009766, 65.00000000, 0.00000000, 0.00000000, 39.97265625, -1, 0, -1, 250);
	CreateDynamicObject(3460, -413.70001221, 2063.19995117, 64.80000305, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -410.29980469, 2067.59960938, 65.00000000, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -423.29998779, 2052.80004883, 64.59999847, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -417.29980469, 2059.89941406, 64.69999695, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -420.29980469, 2056.39941406, 64.69999695, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -453.50000000, 2021.09997559, 63.70000076, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -426.00000000, 2050.09960938, 64.50000000, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -436.70001221, 2038.90002441, 64.19999695, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -429.50000000, 2046.19921875, 64.40000153, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -433.09960938, 2042.89941406, 64.30000305, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -440.39941406, 2034.69921875, 64.09999847, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -450.29998779, 2023.90002441, 63.90000153, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -444.19921875, 2030.50000000, 64.00000000, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	CreateDynamicObject(3460, -447.39941406, 2027.19921875, 63.90000153, 0.00000000, 0.00000000, 39.96826172, -1, 0, -1, 250);
	
	// Drift2
	CreateDynamicObject(979, 1421.59997559, -1760.00000000, 0.80000001, 0.00000000, 0.00000000, 222.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1418.19995117, -1773.40002441, 34.09999847, 0.00000000, 0.00000000, 318.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1430.40002441, -1756.40002441, 33.29999924, 0.00000000, 0.00000000, 179.99523926, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1435.50000000, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 1.99951172, -1, 0, -1, 250);
	CreateDynamicObject(979, 1449.30004883, -1756.40002441, 33.29999924, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1445.30004883, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 1.99951172, -1, 0, -1, 250);
	CreateDynamicObject(979, 1440.29980469, -1756.39941406, 33.29999924, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 1462.69995117, -1754.00000000, 33.29999924, 0.00000000, 0.00000000, 213.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1454.19995117, -1756.40002441, 34.09999847, 0.00000000, 0.00000000, 1.99951172, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1425.50000000, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 1.99951172, -1, 0, -1, 250);
	CreateDynamicObject(979, 1421.59960938, -1759.59960938, 33.29999924, 0.00000000, 0.00000000, 221.99523926, -1, 0, -1, 250);
	CreateDynamicObject(979, 1418.09997559, -1768.19995117, 33.29999924, 0.00000000, 0.00000000, 269.99523926, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1418.19921875, -1763.19921875, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1415.00000000, -1777.09997559, 33.29999924, 0.00000000, 0.00000000, 229.99523926, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1418.19995117, -1816.90002441, 34.09999847, 0.00000000, 0.00000000, 24.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1411.80004883, -1785.90002441, 33.29999924, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1411.79980469, -1781.00000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1414.69995117, -1803.69995117, 33.29999924, 0.00000000, 0.00000000, 315.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1418.09997559, -1807.19995117, 34.09999847, 0.00000000, 0.00000000, 28.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1411.79980469, -1795.50000000, 33.29999924, 0.00000000, 0.00000000, 269.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1411.89941406, -1800.59960938, 34.09999847, 0.00000000, 0.00000000, 27.99865723, -1, 0, -1, 250);
	CreateDynamicObject(979, 1421.19995117, -1820.50000000, 33.29999924, 0.00000000, 0.00000000, 309.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1411.69921875, -1790.89941406, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1418.09960938, -1811.89941406, 33.29999924, 0.00000000, 0.00000000, 269.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1424.50000000, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1429.30004883, -1824.09997559, 33.29999924, 0.00000000, 0.00000000, 359.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1434.30004883, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1448.40002441, -1824.09997559, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 1438.80004883, -1824.09997559, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1443.90002441, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1453.30004883, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1476.50000000, -1824.09997559, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1462.80004883, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1457.79980469, -1824.09960938, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1472.30004883, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1467.39941406, -1824.09960938, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1481.50000000, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1486.00000000, -1824.09997559, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 1495.50000000, -1824.00000000, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1491.00000000, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1500.40002441, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1504.80004883, -1824.00000000, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1509.80004883, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1514.09997559, -1824.00000000, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1519.09997559, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1523.80004883, -1824.00000000, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1528.69995117, -1823.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1532.69995117, -1824.00000000, 33.29999924, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1537.59997559, -1823.80004883, 34.09999847, 0.00000000, 0.00000000, 22.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1540.90002441, -1820.40002441, 33.29999924, 0.00000000, 0.00000000, 47.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1544.09997559, -1816.59997559, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1544.09997559, -1811.59997559, 33.29999924, 0.00000000, 0.00000000, 89.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1544.19995117, -1806.69995117, 34.09999847, 0.00000000, 0.00000000, 328.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1550.80004883, -1794.09997559, 33.29999924, 0.00000000, 0.00000000, 89.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 1547.40002441, -1803.09997559, 33.29999924, 0.00000000, 0.00000000, 49.98278809, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1550.59997559, -1799.19995117, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1550.59997559, -1789.09997559, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1550.80004883, -1784.09997559, 33.29999924, 0.00000000, 0.00000000, 89.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1550.40002441, -1779.19995117, 34.09999847, 0.00000000, 0.00000000, 28.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1546.80004883, -1775.80004883, 33.29999924, 0.00000000, 0.00000000, 139.98348999, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1536.09997559, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1531.50000000, -1756.30004883, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1542.80004883, -1763.00000000, 34.09999847, 0.00000000, 0.00000000, 37.99865723, -1, 0, -1, 250);
	CreateDynamicObject(979, 1539.69995117, -1759.69995117, 33.29999924, 0.00000000, 0.00000000, 135.98229980, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1543.19921875, -1772.59960938, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1543.29980469, -1767.89941406, 33.29999924, 0.00000000, 0.00000000, 89.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1526.59997559, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1521.69995117, -1756.30004883, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1516.69995117, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1499.30004883, -1753.69995117, 33.29999924, 0.00000000, 0.00000000, 149.98355103, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1508.00000000, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7301, 1481.30004883, -1772.69995117, 43.40000153, 0.00000000, 0.00000000, 313.99475098, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1503.40002441, -1756.19995117, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1494.90002441, -1751.30004883, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3663, 1505.50000000, -1753.69995117, 33.59999847, 0.00000000, 0.00000000, 272.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1513.00000000, -1756.29980469, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 1490.30004883, -1751.09997559, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 1481.30004883, -1751.09997559, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1485.40002441, -1751.30004883, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1466.80004883, -1751.30004883, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1476.40002441, -1751.30004883, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1471.80004883, -1751.09997559, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1458.69995117, -1756.50000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 1454.59997559, -1756.30004883, 33.29999924, 0.00000000, 0.00000000, 179.98352051, -1, 0, -1, 250);
	CreateDynamicObject(978, 1490.00000000, -1760.50000000, 33.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1485.09997559, -1760.40002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1481.19995117, -1760.50000000, 33.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1495.19995117, -1770.19995117, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1476.40002441, -1760.40002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1472.09997559, -1760.50000000, 33.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1467.80004883, -1760.40002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1491.90002441, -1772.69995117, 43.70000076, 0.00000000, 0.00000000, 88.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1471.50000000, -1772.69995117, 43.29999924, 0.00000000, 0.00000000, 87.99499512, -1, 0, -1, 250);
	CreateDynamicObject(978, 1529.00000000, -1798.80004883, 33.29999924, 0.00000000, 0.00000000, 224.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1494.59960938, -1760.39941406, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1497.90002441, -1774.09997559, 33.29999924, 0.00000000, 0.00000000, 306.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1500.69995117, -1777.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1494.79980469, -1765.19921875, 33.29999924, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1532.40002441, -1786.40002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1525.89941406, -1801.79980469, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1529.19995117, -1782.50000000, 33.29999924, 0.00000000, 0.00000000, 311.99475098, -1, 0, -1, 250);
	CreateDynamicObject(978, 1532.40002441, -1790.90002441, 33.29999924, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1525.89941406, -1778.59960938, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1532.30004883, -1795.40002441, 34.20000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1467.59997559, -1765.09997559, 33.29999924, 0.00000000, 0.00000000, 90.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1467.19995117, -1770.09997559, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1464.80004883, -1774.09997559, 33.29999924, 0.00000000, 0.00000000, 58.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1462.00000000, -1777.90002441, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1437.80004883, -1778.59997559, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1437.80004883, -1801.80004883, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1434.19995117, -1781.80004883, 33.29999924, 0.00000000, 0.00000000, 43.99682617, -1, 0, -1, 250);
	CreateDynamicObject(978, 1434.40002441, -1798.09997559, 33.29999924, 0.00000000, 0.00000000, 131.99517822, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1430.80004883, -1785.19995117, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 1431.09997559, -1794.50000000, 34.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 1431.00000000, -1789.80004883, 33.29999924, 0.00000000, 0.00000000, 90.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7301, 1438.40002441, -1790.30004883, 40.50000000, 0.00000000, 0.00000000, 43.99475098, -1, 0, -1, 250);
	CreateDynamicObject(7301, 1525.40002441, -1790.00000000, 40.79999924, 0.00000000, 0.00000000, 223.98925781, -1, 0, -1, 250);
	CreateDynamicObject(7301, 1481.40002441, -1750.90002441, 28.89999962, 0.00000000, 0.00000000, 313.99475098, -1, 0, -1, 250);
	CreateDynamicObject(8615, 1573.40002441, -1633.80004883, 15.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1491.40002441, -1772.69995117, 25.79999924, 0.00000000, 0.00000000, 87.99499512, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1486.30004883, -1772.69995117, 25.79999924, 0.00000000, 0.00000000, 87.99499512, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1481.19995117, -1772.69995117, 25.79999924, 0.00000000, 0.00000000, 87.99499512, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1475.59997559, -1772.69995117, 25.89999962, 0.00000000, 0.00000000, 87.99499512, -1, 0, -1, 250);
	CreateDynamicObject(3528, 1470.40002441, -1772.69995117, 25.89999962, 0.00000000, 0.00000000, 87.99499512, -1, 0, -1, 250);
	
	// drift3
	CreateDynamicObject(979, 2176.10009766, 1039.40002441, 10.69999981, 0.00000000, 0.00000000, 140.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2179.69995117, 1036.09997559, 11.50000000, 0.00000000, 0.00000000, 22.00000000, -1, 0, -1, 250);
	CreateDynamicObject(979, 2180.00000000, 1031.50000000, 10.69999981, 0.00000000, 0.00000000, 89.99877930, -1, 0, -1, 250);
	CreateDynamicObject(979, 2180.00000000, 1022.20001221, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2180.00000000, 1012.90002441, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2180.00000000, 1003.59997559, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2180.00000000, 998.50000000, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2149.39990234, 1030.69995117, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2179.80004883, 985.20001221, 11.50000000, 0.00000000, 0.00000000, 359.99462891, -1, 0, -1, 250);
	CreateDynamicObject(979, 2167.19995117, 1042.80004883, 10.69999981, 0.00000000, 0.00000000, 177.99877930, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2172.30004883, 1042.40002441, 11.50000000, 0.00000000, 0.00000000, 357.99462891, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2162.50000000, 1042.89941406, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2158.60009766, 1039.59997559, 10.69999981, 0.00000000, 0.00000000, 221.99877930, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2155.30004883, 1036.19995117, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2155.10009766, 1031.50000000, 10.69999981, 0.00000000, 0.00000000, 269.99523926, -1, 0, -1, 250);
	CreateDynamicObject(979, 2155.10009766, 1022.50000000, 10.69999981, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2155.10009766, 1013.29998779, 10.69999981, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2155.10009766, 1006.79998779, 10.69999981, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2155.19995117, 1001.90002441, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2168.30004883, 1009.40002441, 10.80000019, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 2168.30004883, 1018.79998779, 10.80000019, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2166.60009766, 1026.40002441, 10.80000019, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2168.29980469, 1026.39941406, 10.80000019, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2166.60009766, 1017.59997559, 10.80000019, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2166.60009766, 1009.29998779, 10.80000019, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2167.39990234, 1032.09997559, 11.60000038, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2167.39941406, 1003.50000000, 11.60000038, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2180.00000000, 990.00000000, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2149.39990234, 1021.50000000, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2149.30004883, 1035.80004883, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2149.39990234, 1014.50000000, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2150.69995117, 1001.90002441, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2149.39990234, 1006.70001221, 10.69999981, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2145.59960938, 1039.19921875, 10.69999981, 0.00000000, 0.00000000, 139.99877930, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2141.60009766, 1042.09997559, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2136.80004883, 1042.19995117, 10.69999981, 0.00000000, 0.00000000, 179.99499512, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2131.80004883, 1042.09997559, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2128.00000000, 1038.90002441, 10.69999981, 0.00000000, 0.00000000, 221.99523926, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2124.60009766, 1035.50000000, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2124.39990234, 1030.90002441, 10.69999981, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2124.39990234, 1023.90002441, 10.69999981, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2124.50000000, 1019.09997559, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2119.60009766, 1019.20001221, 10.69999981, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2132.39990234, 1011.70001221, 10.69999981, 0.00000000, 0.00000000, 35.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2115.19995117, 1009.00000000, 10.69999981, 0.00000000, 0.00000000, 359.98974609, -1, 0, -1, 250);
	CreateDynamicObject(978, 2108.19995117, 1009.00000000, 10.69999981, 0.00000000, 0.00000000, 359.98901367, -1, 0, -1, 250);
	CreateDynamicObject(978, 2124.00000000, 1009.00000000, 10.69999981, 0.00000000, 0.00000000, 359.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2096.80004883, 1009.09997559, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(978, 2101.19995117, 1009.00000000, 10.69999981, 0.00000000, 0.00000000, 359.98901367, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2136.30004883, 1014.29998779, 11.60000038, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(978, 2136.39990234, 1019.29998779, 10.80000019, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2136.39990234, 1026.40002441, 10.80000019, 0.00000000, 0.00000000, 89.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2137.39990234, 1031.90002441, 11.60000038, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(978, 2138.30004883, 1026.40002441, 10.80000019, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2138.30004883, 1017.50000000, 10.80000019, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2138.30004883, 1009.09997559, 10.80000019, 0.00000000, 0.00000000, 269.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2137.39990234, 1003.59997559, 11.60000038, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2113.10009766, 1019.20001221, 10.69999981, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2106.00000000, 1019.20001221, 10.69999981, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2101.19995117, 1019.20001221, 10.69999981, 0.00000000, 0.00000000, 179.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 2088.69995117, 1009.40002441, 10.69999981, 0.00000000, 0.00000000, 267.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2088.89990234, 1013.40002441, 11.80000019, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2092.89941406, 1016.39941406, 10.69999981, 0.00000000, 0.00000000, 217.99072266, -1, 0, -1, 250);
	CreateDynamicObject(979, 2092.00000000, 992.00000000, 10.69999981, 0.00000000, 0.00000000, 315.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2088.39990234, 1000.29998779, 10.69999981, 0.00000000, 0.00000000, 267.98950195, -1, 0, -1, 250);
	CreateDynamicObject(656, 2185.10009766, 993.79998779, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(656, 2152.69995117, 1010.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(656, 2152.50000000, 1031.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2088.50000000, 995.40002441, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2103.30004883, 985.20001221, 10.69999981, 0.00000000, 0.00000000, 359.98876953, -1, 0, -1, 250);
	CreateDynamicObject(978, 2165.19995117, 999.00000000, 10.69999981, 0.00000000, 0.00000000, 63.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2154.30004883, 1001.90002441, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2153.39990234, 1001.90002441, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2152.50000000, 1001.90002441, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2151.60009766, 1001.90002441, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2149.79980469, 1001.89941406, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2148.89941406, 1001.89941406, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(13831, 2179.69995117, 1037.50000000, 47.00000000, 0.00000000, 0.00000000, 294.00000000, -1, 0, -1, 250);
	CreateDynamicObject(978, 2156.30004883, 990.29998779, 10.69999981, 0.00000000, 0.00000000, 359.98986816, -1, 0, -1, 250);
	CreateDynamicObject(978, 2163.00000000, 994.59960938, 10.69999981, 0.00000000, 0.00000000, 63.98986816, -1, 0, -1, 250);
	CreateDynamicObject(978, 2150.00000000, 990.29998779, 10.69999981, 0.00000000, 0.00000000, 359.98901367, -1, 0, -1, 250);
	CreateDynamicObject(978, 2142.89990234, 994.29998779, 10.69999981, 0.00000000, 0.00000000, 301.98986816, -1, 0, -1, 250);
	CreateDynamicObject(978, 2139.80004883, 999.29998779, 10.69999981, 0.00000000, 0.00000000, 301.98669434, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2136.10009766, 985.29998779, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(979, 2095.39941406, 988.69921875, 10.69999981, 0.00000000, 0.00000000, 315.98876953, -1, 0, -1, 250);
	CreateDynamicObject(979, 2112.50000000, 985.20001221, 10.69999981, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 2121.89990234, 985.20001221, 10.69999981, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 2131.19995117, 985.20001221, 10.69999981, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2098.79980469, 985.29980469, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(978, 2110.19995117, 993.70001221, 10.69999981, 0.00000000, 0.00000000, 181.99450684, -1, 0, -1, 250);
	CreateDynamicObject(978, 2101.19995117, 995.29998779, 10.69999981, 0.00000000, 0.00000000, 157.99401855, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2096.60009766, 997.09997559, 11.50000000, 0.00000000, 0.00000000, 357.98950195, -1, 0, -1, 250);
	CreateDynamicObject(978, 2119.50000000, 994.00000000, 10.69999981, 0.00000000, 0.00000000, 181.99401855, -1, 0, -1, 250);
	CreateDynamicObject(978, 2124.19995117, 994.20001221, 10.69999981, 0.00000000, 0.00000000, 181.99401855, -1, 0, -1, 250);
	CreateDynamicObject(978, 2132.19995117, 994.50000000, 10.69999981, 0.00000000, 0.00000000, 181.99401855, -1, 0, -1, 250);
	CreateDynamicObject(978, 2141.10009766, 992.59997559, 10.69999981, 0.00000000, 0.00000000, 153.99401855, -1, 0, -1, 250);
	CreateDynamicObject(978, 2096.19995117, 1003.09997559, 10.80000019, 0.00000000, 0.00000000, 89.98889160, -1, 0, -1, 250);
	CreateDynamicObject(979, 2148.19995117, 985.20001221, 10.69999981, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 2141.19921875, 985.19921875, 10.69999981, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(979, 2157.39990234, 985.20001221, 10.69999981, 0.00000000, 0.00000000, 359.98352051, -1, 0, -1, 250);
	CreateDynamicObject(3877, 2162.39990234, 985.20001221, 11.50000000, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(1337, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	
	// drift4
	CreateDynamicObject(8041, 2827.19995117, 1381.59997559, 15.60000038, 0.00000000, 0.00000000, 90.00000000, -1, 0, -1, 250);
	CreateDynamicObject(994, 2855.10009766, 1338.19995117, 10.39999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(994, 2855.10009766, 1243.30004883, 10.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2804.19995117, 1378.09997559, 10.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2808.39990234, 1378.09997559, 10.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2810.50000000, 1378.09997559, 10.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2802.00000000, 1376.00000000, 10.30000019, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2802.00000000, 1371.90002441, 10.30000019, 0.00000000, 0.00000000, 90.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2802.00000000, 1369.69995117, 10.30000019, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2811.00000000, 1368.00000000, 10.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(970, 2813.10009766, 1370.00000000, 10.30000019, 0.00000000, 0.00000000, 92.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2813.19995117, 1378.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.39990234, 1378.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.69995117, 1378.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2817.00000000, 1378.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2818.30004883, 1378.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2819.39990234, 1379.00000000, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2820.39990234, 1379.69995117, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.19995117, 1380.50000000, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2813.50000000, 1371.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.69995117, 1372.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.89990234, 1371.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2817.19995117, 1371.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2818.69995117, 1371.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2820.19995117, 1370.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.10009766, 1369.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.89990234, 1369.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2822.30004883, 1367.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2822.60009766, 1366.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.00000000, 1367.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2809.10009766, 1367.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2809.19995117, 1366.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.00000000, 1366.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.19995117, 1364.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.60009766, 1363.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2803.10009766, 1362.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2803.80004883, 1360.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2804.39990234, 1359.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2805.10009766, 1358.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2805.89990234, 1357.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2806.80004883, 1355.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2807.50000000, 1354.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2808.10009766, 1353.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2808.39990234, 1351.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2808.19995117, 1350.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2807.80004883, 1348.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2809.89990234, 1365.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.69995117, 1363.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2811.69995117, 1362.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2812.60009766, 1361.09997559, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2813.39990234, 1359.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.19995117, 1358.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.89990234, 1357.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2816.39990234, 1354.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2816.89990234, 1352.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2817.00000000, 1351.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2816.89990234, 1349.50000000, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2816.39990234, 1348.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2807.39990234, 1346.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2806.89990234, 1345.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2806.00000000, 1343.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2805.10009766, 1342.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2804.10009766, 1341.30004883, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2803.19995117, 1339.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.69995117, 1338.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.19995117, 1336.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.19995117, 1334.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.80004883, 1346.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.50000000, 1345.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.00000000, 1343.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.30004883, 1341.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2813.30004883, 1340.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2812.39990234, 1339.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2811.60009766, 1337.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.69995117, 1336.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.19995117, 1334.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2809.80004883, 1333.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2809.89990234, 1331.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.30004883, 1333.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.39990234, 1331.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.39990234, 1329.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.39990234, 1328.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.39990234, 1326.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.39990234, 1324.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.39990234, 1322.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.00000000, 1321.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2801.19995117, 1320.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2800.10009766, 1319.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2798.80004883, 1318.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2797.30004883, 1318.30004883, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2797.30004883, 1308.19995117, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2798.60009766, 1308.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2799.69995117, 1307.59997559, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2800.80004883, 1306.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2801.50000000, 1305.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.00000000, 1304.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.19995117, 1303.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2801.89990234, 1301.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2801.39990234, 1300.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2800.50000000, 1299.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2799.19995117, 1298.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2797.50000000, 1298.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2822.80004883, 1364.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.10009766, 1362.50000000, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.10009766, 1360.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.50000000, 1358.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.30004883, 1356.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2825.10009766, 1354.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2825.69995117, 1352.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2825.80004883, 1350.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2825.60009766, 1348.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.69995117, 1346.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.39990234, 1344.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2822.39990234, 1343.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.50000000, 1341.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.10009766, 1339.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.10009766, 1338.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.50000000, 1336.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2822.19995117, 1334.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.10009766, 1333.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.60009766, 1331.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.00000000, 1329.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.39990234, 1327.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.50000000, 1325.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.60009766, 1323.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2824.39990234, 1321.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2823.60009766, 1320.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2822.39990234, 1319.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2821.10009766, 1318.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2817.00000000, 1317.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.50000000, 1318.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.00000000, 1329.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.00000000, 1327.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.39990234, 1325.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2810.80004883, 1323.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2811.30004883, 1322.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2812.10009766, 1321.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2813.00000000, 1319.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.10009766, 1318.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2818.39990234, 1318.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2819.69995117, 1318.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.60009766, 1355.90002441, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2816.30004883, 1365.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2818.80004883, 1359.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2820.69995117, 1352.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2819.00000000, 1344.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2816.39990234, 1337.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2816.60009766, 1331.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2796.00000000, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2768.89990234, 1258.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2761.89990234, 1258.50000000, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.30004883, 1260.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2769.30004883, 1259.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2769.60009766, 1260.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2770.10009766, 1262.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.60009766, 1261.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2763.10009766, 1263.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2763.89990234, 1265.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2764.60009766, 1266.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2765.39990234, 1268.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2765.89990234, 1269.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2766.39990234, 1271.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2766.89990234, 1272.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2767.00000000, 1274.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2767.19995117, 1276.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2767.00000000, 1277.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2766.69995117, 1279.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2766.19995117, 1280.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2765.60009766, 1282.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2765.10009766, 1283.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2764.10009766, 1284.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2763.10009766, 1285.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.30004883, 1287.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.10009766, 1288.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.19995117, 1290.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.10009766, 1292.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2770.30004883, 1298.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2768.80004883, 1298.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2767.19995117, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.19995117, 1294.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2762.89990234, 1296.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2764.10009766, 1297.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2765.80004883, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2794.69995117, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2793.39990234, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2792.19995117, 1298.00000000, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2790.89990234, 1297.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2789.60009766, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2788.30004883, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2787.10009766, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2785.89990234, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2784.69995117, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2783.50000000, 1298.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2782.19995117, 1298.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2781.00000000, 1298.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2779.69995117, 1298.19995117, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2778.30004883, 1298.19995117, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2776.89990234, 1298.30004883, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2775.50000000, 1298.30004883, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2771.80004883, 1298.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2773.69995117, 1298.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2771.00000000, 1263.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2771.69995117, 1265.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2772.39990234, 1267.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2773.19995117, 1268.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2774.00000000, 1270.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2774.50000000, 1272.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2774.89990234, 1273.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2775.00000000, 1275.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2775.10009766, 1277.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2774.69995117, 1279.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2774.10009766, 1281.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2773.39990234, 1282.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2772.60009766, 1284.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2771.80004883, 1285.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2771.10009766, 1286.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2770.30004883, 1288.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2770.50000000, 1289.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2771.50000000, 1290.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2773.00000000, 1290.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2774.69995117, 1290.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2776.30004883, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2777.89990234, 1290.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2779.60009766, 1290.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2781.30004883, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2783.00000000, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2784.80004883, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2786.30004883, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2787.89990234, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2789.39990234, 1290.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2791.00000000, 1290.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2792.80004883, 1290.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2794.89990234, 1290.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2796.89990234, 1290.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2798.69995117, 1289.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2800.10009766, 1288.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2800.89990234, 1287.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2820.00000000, 1257.59997559, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2819.00000000, 1258.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2817.60009766, 1259.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2815.89990234, 1260.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2814.39990234, 1261.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2812.69995117, 1262.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2811.19995117, 1262.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2832.50000000, 1381.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2833.30004883, 1380.30004883, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2834.19995117, 1379.50000000, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2835.10009766, 1378.69995117, 9.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2836.30004883, 1378.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2837.60009766, 1378.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(9833, 2817.69995117, 1323.09997559, 13.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8251, 2788.30004883, 1273.40002441, 13.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2809.39990234, 1262.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2802.00000000, 1261.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2803.30004883, 1261.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2804.69995117, 1261.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2807.80004883, 1262.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1237, 2806.19995117, 1261.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2773.10009766, 1289.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2781.19995117, 1288.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2788.60009766, 1288.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2796.00000000, 1288.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2803.30004883, 1344.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2805.30004883, 1351.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2803.30004883, 1357.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2763.50000000, 1268.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2765.10009766, 1274.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2763.80004883, 1280.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(657, 2772.50000000, 1263.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5532, 2848.10009766, 1232.30004883, 17.89999962, 0.00000000, 0.00000000, 180.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1368, 2835.69995117, 1282.59997559, 10.60000038, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1368, 2835.80004883, 1299.00000000, 10.60000038, 0.00000000, 0.00000000, 270.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2819.30004883, 1306.00000000, 10.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2819.69995117, 1290.30004883, 10.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2819.89990234, 1275.00000000, 10.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2818.19995117, 1363.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2820.60009766, 1348.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2817.89990234, 1333.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2805.39990234, 1355.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2805.80004883, 1346.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2792.60009766, 1288.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2776.89990234, 1288.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2764.80004883, 1278.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2764.30004883, 1270.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2856.00000000, 1378.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2856.10009766, 1345.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2856.50000000, 1361.19995117, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2838.19995117, 1378.59997559, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2802.30004883, 1377.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2797.19995117, 1302.80004883, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2797.30004883, 1323.30004883, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2830.60009766, 1227.50000000, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2762.19995117, 1227.59997559, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 2797.39990234, 1227.40002441, 9.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3524, 2796.30004883, 1318.19995117, 12.60000038, 0.00000000, 0.00000000, 274.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3524, 2796.10009766, 1308.30004883, 12.80000019, 0.00000000, 0.00000000, 266.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3524, 2822.30004883, 1383.59997559, 12.60000038, 0.00000000, 0.00000000, 182.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3524, 2832.00000000, 1383.50000000, 12.60000038, 0.00000000, 0.00000000, 180.00000000, -1, 0, -1, 250);
	CreateDynamicObject(7392, 2839.60009766, 1290.19995117, 30.60000038, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(13562, 2833.19995117, 1337.80004883, 17.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(13562, 2833.60009766, 1242.50000000, 17.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2840.89990234, 1377.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2844.19995117, 1377.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2847.50000000, 1377.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2855.80004883, 1366.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2855.69995117, 1362.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2855.69995117, 1359.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2855.69995117, 1356.50000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2855.69995117, 1353.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2855.69995117, 1350.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2833.00000000, 1230.69995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2833.00000000, 1235.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.10009766, 1309.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1310.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1311.40002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1312.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1313.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1314.90002441, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1316.00000000, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2797.19995117, 1317.09997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2822.80004883, 1383.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2823.89990234, 1383.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2824.89990234, 1383.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2825.80004883, 1383.19995117, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2831.50000000, 1383.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2830.30004883, 1383.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2829.30004883, 1383.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3385, 2828.19995117, 1383.30004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3277, 2839.69995117, 1359.59997559, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3277, 2790.69995117, 1273.80004883, 9.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	
	// drift5
	CreateDynamicObject(8356, 3039.00000000, -922.90002441, 5.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8356, 3077.60009766, -922.90002441, 5.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8356, 3116.39990234, -923.70001221, 5.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3023.00000000, -839.40002441, 20.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3077.19995117, -839.20001221, 20.89999962, 180.00000000, 180.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3108.10009766, -839.29998779, 20.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8356, 3156.10009766, -924.20001221, 5.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3162.60009766, -839.09997559, 20.89999962, 180.00000000, 180.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3167.19995117, -853.50000000, 20.89999962, 0.00000000, 0.00000000, 269.75000000, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3167.30004883, -906.09997559, 20.89999962, 180.00000000, 180.00000000, 269.74731445, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3167.19995117, -927.20001221, 20.89999962, 0.00000000, 0.00000000, 269.74182129, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3167.10009766, -979.90002441, 20.89999962, 180.00000000, 180.00000000, 269.74182129, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3166.80004883, -1001.79998779, 20.89999962, 0.00549316, 359.99450684, 267.99182129, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3151.89990234, -1009.20001221, 20.89999962, 0.00000000, 359.98901367, 179.23950195, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3099.19995117, -1008.50000000, 20.89999962, 0.00000000, 359.98352051, 358.73645020, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3077.60009766, -1007.90002441, 20.89999962, 0.00000000, 359.97802734, 179.23107910, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3024.19995117, -1007.59997559, 20.89999962, 0.00000000, 359.97802734, 359.98095703, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3027.00000000, -990.59997559, 20.89999962, 0.00000000, 359.97802734, 90.47802734, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3026.69995117, -940.29998779, 20.89999962, 0.00000000, 359.97802734, 269.97790527, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3026.89990234, -911.09997559, 20.89999962, 0.00000000, 359.97802734, 89.47253418, -1, 0, -1, 250);
	CreateDynamicObject(5126, 3027.19995117, -859.90002441, 20.89999962, 0.00000000, 359.97802734, 269.21713257, -1, 0, -1, 250);
	CreateDynamicObject(16088, 3060.10009766, -870.59997559, 5.80000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3069.69995117, -877.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3073.69995117, -877.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3077.39990234, -878.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3081.10009766, -878.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3085.60009766, -878.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3086.00000000, -862.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3081.80004883, -862.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3078.00000000, -862.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3074.30004883, -862.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3070.80004883, -862.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3067.80004883, -862.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3067.39990234, -877.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3089.10009766, -879.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3090.60009766, -880.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3090.60009766, -882.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3090.10009766, -883.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3088.10009766, -884.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3086.30004883, -885.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3084.80004883, -886.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3082.50000000, -886.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3080.80004883, -886.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3078.80004883, -886.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3077.50000000, -887.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3076.00000000, -889.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3076.00000000, -891.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3077.00000000, -893.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3078.19995117, -894.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3079.39990234, -895.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3080.60009766, -896.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3082.10009766, -897.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3083.80004883, -899.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3085.50000000, -900.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3087.19995117, -901.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3089.19995117, -902.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3090.69995117, -904.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3091.69995117, -904.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3092.89990234, -905.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.60009766, -907.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3096.30004883, -908.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.50000000, -910.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.19995117, -911.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.89990234, -912.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.10009766, -914.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.10009766, -915.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.60009766, -917.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3088.50000000, -862.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3091.69995117, -862.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.10009766, -864.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3096.00000000, -865.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.10009766, -867.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.69995117, -869.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3101.30004883, -872.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.39990234, -874.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.80004883, -876.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.39990234, -878.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.50000000, -880.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3101.39990234, -882.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.80004883, -885.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.89990234, -887.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.80004883, -889.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3096.39990234, -890.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.50000000, -893.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3096.10009766, -894.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.39990234, -895.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.50000000, -897.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3100.89990234, -899.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.80004883, -901.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3105.19995117, -902.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3105.80004883, -904.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3106.89990234, -906.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3107.50000000, -908.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.39990234, -910.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.39941406, -910.09960938, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.80004883, -913.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.19995117, -916.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3106.60009766, -919.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3105.10009766, -921.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3104.80004883, -924.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3106.10009766, -926.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3107.00000000, -927.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.10009766, -929.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3109.19995117, -930.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3110.00000000, -932.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3110.80004883, -933.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3112.00000000, -933.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3113.50000000, -932.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3115.69995117, -930.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.00000000, -927.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.19995117, -925.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3117.39990234, -923.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3119.10009766, -921.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3120.89990234, -921.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.60009766, -921.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3124.50000000, -922.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3126.10009766, -924.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3127.19995117, -926.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3128.30004883, -927.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3129.10009766, -929.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3130.39990234, -931.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3131.69995117, -933.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3132.50000000, -935.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3133.60009766, -937.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3135.19995117, -939.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3135.19995117, -942.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3135.10009766, -944.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3134.89990234, -946.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3133.89990234, -948.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3133.50000000, -950.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3132.69995117, -952.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3131.89990234, -954.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3130.50000000, -957.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3131.00000000, -956.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.00000000, -919.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.39990234, -921.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3096.80004883, -922.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.19995117, -924.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.30004883, -926.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.60009766, -927.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3100.30004883, -928.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3101.30004883, -929.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3101.80004883, -931.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.30004883, -932.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3103.30004883, -933.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3104.30004883, -935.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3105.30004883, -937.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3106.30004883, -938.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3107.30004883, -939.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.50000000, -941.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3110.00000000, -943.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3111.69995117, -945.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3113.19995117, -945.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3114.50000000, -944.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3115.50000000, -943.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.50000000, -940.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3117.80004883, -939.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3119.10009766, -937.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3120.80004883, -938.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.50000000, -940.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3124.19995117, -942.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3125.69995117, -944.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3126.19995117, -947.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3125.19995117, -949.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3123.69995117, -950.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.39990234, -951.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3123.30004883, -941.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3125.00000000, -943.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3126.00000000, -945.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3114.60009766, -931.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3128.80004883, -958.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3126.30004883, -959.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3124.39990234, -961.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3124.10009766, -963.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3123.89990234, -964.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3123.69995117, -965.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3123.50000000, -966.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3123.19995117, -968.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.80004883, -969.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3121.69995117, -970.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3120.19995117, -972.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3118.69995117, -973.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.80004883, -975.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3117.30004883, -975.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3118.10009766, -977.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3120.10009766, -977.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.19995117, -977.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.60009766, -978.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3122.30004883, -980.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3121.69995117, -982.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3119.69995117, -983.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3118.60009766, -984.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3117.30004883, -985.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3115.89990234, -985.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3114.60009766, -986.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3112.80004883, -986.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3110.30004883, -987.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3108.30004883, -988.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3106.30004883, -988.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3103.80004883, -988.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.10009766, -987.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3100.69995117, -987.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.80004883, -986.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.19995117, -986.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3095.30004883, -984.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.39990234, -981.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3093.60009766, -979.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3093.60009766, -977.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3093.69995117, -974.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.00000000, -972.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3093.89990234, -970.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.00000000, -967.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.10009766, -965.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3092.80004883, -964.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3092.00000000, -964.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3091.50000000, -963.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3091.00000000, -962.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3089.69995117, -961.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3088.39990234, -960.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3087.39990234, -960.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3086.39990234, -959.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3085.60009766, -958.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3084.30004883, -957.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3083.00000000, -955.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3082.00000000, -953.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3081.19995117, -952.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3079.89990234, -951.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3079.10009766, -949.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3078.10009766, -948.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3076.69995117, -946.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3075.80004883, -945.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3074.60009766, -944.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3073.10009766, -944.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3071.50000000, -943.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3069.89990234, -942.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3068.19995117, -941.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3066.69995117, -940.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3121.10009766, -951.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3120.00000000, -952.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3118.89990234, -953.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3118.00000000, -954.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.89990234, -956.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.69995117, -958.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.69995117, -959.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3116.69995117, -960.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3115.39990234, -962.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3114.39990234, -962.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3113.00000000, -963.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3111.39990234, -964.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3110.10009766, -965.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3109.19995117, -967.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3109.50000000, -968.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3107.89990234, -968.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3106.10009766, -967.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3105.10009766, -966.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3104.80004883, -965.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3104.50000000, -964.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3104.19995117, -962.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3103.10009766, -962.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3102.19995117, -961.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3101.10009766, -961.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3099.69995117, -960.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3098.69995117, -959.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3097.60009766, -957.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3096.50000000, -956.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3095.00000000, -954.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3095.80004883, -955.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3094.10009766, -953.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3093.50000000, -951.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3092.89990234, -950.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3092.89941406, -950.29980469, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3092.30004883, -948.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3091.10009766, -947.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3091.60009766, -948.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3090.60009766, -946.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3089.50000000, -945.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3088.50000000, -944.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3088.00000000, -943.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3086.80004883, -942.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3085.80004883, -941.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3084.80004883, -941.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3083.39990234, -940.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3082.60009766, -939.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3081.30004883, -938.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3080.10009766, -937.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3079.00000000, -937.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3077.50000000, -936.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3076.10009766, -935.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3074.80004883, -935.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3073.39990234, -933.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3072.19995117, -932.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3071.60009766, -931.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3070.89990234, -931.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3069.60009766, -930.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3069.10009766, -928.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3068.19995117, -927.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3067.80004883, -926.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3067.00000000, -925.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3066.00000000, -923.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3064.80004883, -921.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3064.10009766, -919.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3063.00000000, -918.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3061.89990234, -916.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3061.30004883, -915.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3060.69995117, -914.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3059.60009766, -913.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3058.50000000, -911.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.69995117, -910.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.00000000, -908.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3056.80004883, -905.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.00000000, -904.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.30004883, -902.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.69995117, -899.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3058.00000000, -897.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3058.30004883, -895.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.50000000, -894.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3056.50000000, -892.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3056.69995117, -890.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.10009766, -887.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.50000000, -884.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.50000000, -884.59960938, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.80004883, -882.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3058.19995117, -879.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3059.19995117, -878.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3059.19921875, -878.29980469, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3062.30004883, -878.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3064.19995117, -878.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3065.30004883, -938.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3064.19995117, -937.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3063.30004883, -936.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3061.89990234, -935.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3060.50000000, -934.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3059.19995117, -932.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3058.50000000, -930.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3057.69995117, -928.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3056.80004883, -926.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3055.39990234, -927.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3054.69995117, -926.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3054.30004883, -924.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3053.50000000, -923.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3052.69995117, -922.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3052.19995117, -920.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3051.60009766, -918.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3050.80004883, -916.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3051.19995117, -917.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3050.00000000, -915.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3049.39990234, -913.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3049.10009766, -911.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3049.00000000, -910.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.80004883, -908.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3048.19995117, -909.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.69995117, -907.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.69995117, -906.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.69995117, -903.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.39990234, -902.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.39990234, -900.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.10009766, -898.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3046.10009766, -897.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3045.60009766, -895.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3046.10009766, -893.79998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3046.80004883, -892.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3046.80004883, -890.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3046.80004883, -888.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3046.80004883, -885.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.00000000, -883.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3047.50000000, -880.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3048.19995117, -878.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3048.19921875, -878.89941406, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3048.19995117, -877.50000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3052.39990234, -867.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3053.19995117, -866.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3054.00000000, -866.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3055.30004883, -865.09997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3056.80004883, -864.40002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3058.00000000, -863.90002441, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3059.30004883, -863.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3061.39990234, -863.20001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3062.39990234, -863.29998779, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3063.80004883, -863.00000000, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3065.19995117, -862.70001221, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3666, 3066.60009766, -862.59997559, 6.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(4832, 3125.50000000, -885.00000000, 46.09999847, 0.00000000, 0.00000000, 272.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.19995117, -869.29998779, 25.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.19995117, -869.29998779, 21.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.19995117, -869.29998779, 17.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.19995117, -869.29998779, 14.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.39990234, -870.50000000, 14.00000000, 24.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.30004883, -871.90002441, 16.79999924, 23.99963379, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.50000000, -873.29998779, 19.79999924, 23.99963379, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3106.80004883, -873.00000000, 23.29999924, 323.99963379, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3106.50000000, -871.00000000, 25.70000076, 323.99780273, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.19995117, -875.70001221, 13.30000019, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.19995117, -875.70001221, 16.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.19995117, -875.70001221, 19.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -875.79998779, 22.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -875.79998779, 25.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.60009766, -876.79998779, 25.79999924, 322.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.89990234, -878.79998779, 23.29999924, 321.99829102, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.80004883, -879.09997559, 20.70000076, 29.99829102, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.60009766, -877.40002441, 18.29999924, 29.99816895, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.60009766, -877.40002441, 15.30000019, 325.99816895, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.89990234, -879.09997559, 12.80000019, 325.99731445, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3109.19995117, -882.50000000, 17.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3109.19995117, -882.50000000, 14.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3109.19995117, -882.50000000, 12.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3109.19995117, -882.50000000, 20.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.89990234, -882.50000000, 23.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -885.09997559, 12.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -885.09997559, 15.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -885.09997559, 18.70000076, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -885.09997559, 21.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.50000000, -885.09997559, 24.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.30004883, -887.00000000, 25.00000000, 87.99499512, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.89990234, -890.29998779, 25.00000000, 87.99499512, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.10009766, -897.09997559, 12.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.10009766, -897.09997559, 15.69999981, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.10009766, -897.09997559, 18.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.10009766, -897.09997559, 21.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.10009766, -897.09997559, 23.79999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3108.10009766, -886.79998779, 20.79999924, 87.99499512, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3109.10009766, -890.09997559, 20.79999924, 87.99499512, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.19995117, -895.40002441, 24.89999962, 270.00000000, 180.00000000, 180.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3877, 3107.00000000, -898.90002441, 24.89999962, 90.00000000, 179.99755859, 180.00242615, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 86.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 87.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 89.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 91.09999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 92.59999847, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 94.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 96.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 98.90000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 100.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 102.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.29980469, -901.39941406, 102.40000153, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 103.19999695, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 105.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 106.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 107.50000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 104.00000000, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(3472, 3125.30004883, -901.40002441, 108.80000305, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(13831, 3121.50000000, -997.50000000, 30.20000076, 0.00000000, 0.00000000, 180.00000000, -1, 0, -1, 250);
	CreateDynamicObject(10838, 3047.10009766, -983.59997559, 23.29999924, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(10838, 3048.50000000, -949.59997559, 23.29999924, 0.00000000, 0.00000000, 179.75000000, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3082.89990234, -988.50000000, 13.80000019, 0.00000000, 0.00000000, 268.00000000, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3083.30004883, -979.40002441, 13.80000019, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3083.69995117, -970.70001221, 13.80000019, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3076.89990234, -959.29998779, 13.80000019, 0.00000000, 0.00000000, 307.99499512, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3068.50000000, -955.00000000, 13.80000019, 0.00000000, 1.25000000, 351.99072266, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3063.80004883, -957.79998779, 13.80000019, 0.00000000, 1.24694824, 43.98547363, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3061.69995117, -963.09997559, 13.80000019, 0.00000000, 1.24145508, 71.98376465, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3060.69995117, -971.00000000, 13.80000019, 0.00000000, 1.24145508, 91.98242188, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3061.00000000, -979.90002441, 13.80000019, 0.00000000, 1.24145508, 91.97753906, -1, 0, -1, 250);
	CreateDynamicObject(11395, 3060.80004883, -988.70001221, 13.80000019, 0.00000000, 1.24145508, 91.97753906, -1, 0, -1, 250);
	CreateDynamicObject(9132, 3052.00000000, -856.50000000, 24.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(9132, 3085.19995117, -856.09997559, 24.89999962, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8644, 3068.60009766, -854.20001221, 22.20000076, 0.00000000, 0.00000000, 297.75000000, -1, 0, -1, 250);
	CreateDynamicObject(8644, 3068.60009766, -854.20001221, 35.20000076, 0.00000000, 0.00000000, 297.74597168, -1, 0, -1, 250);
	CreateDynamicObject(8644, 3068.60009766, -854.20001221, 28.70000076, 0.00000000, 0.00000000, 297.74597168, -1, 0, -1, 250);
	CreateDynamicObject(8644, 3068.60009766, -854.20001221, 16.00000000, 0.00000000, 0.00000000, 297.74597168, -1, 0, -1, 250);
	CreateDynamicObject(8644, 3068.60009766, -854.20001221, 10.00000000, 0.00000000, 0.00000000, 297.74597168, -1, 0, -1, 250);
	CreateDynamicObject(8618, 3142.80004883, -929.50000000, 18.79999924, 0.00000000, 0.00000000, 268.00000000, -1, 0, -1, 250);
	CreateDynamicObject(8618, 3142.60009766, -939.59997559, 18.79999924, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(8618, 3142.00000000, -949.40002441, 18.79999924, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(8618, 3141.39990234, -959.50000000, 18.79999924, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(8618, 3140.69995117, -969.70001221, 18.79999924, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(8618, 3140.10009766, -979.50000000, 18.79999924, 0.00000000, 0.00000000, 267.99499512, -1, 0, -1, 250);
	CreateDynamicObject(5191, 2954.39990234, -878.09997559, -0.10000000, 0.00000000, 0.00000000, 92.25000000, -1, 0, -1, 250);
	CreateDynamicObject(1655, 2914.39990234, -878.90002441, 10.69999981, 0.00000000, 0.00000000, 271.25000000, -1, 0, -1, 250);
	
	// drift6
	CreateDynamicObject(16782, -301.74487305, 1540.48461914, 75.75564575, 0.00000000, 0.00000000, 320.00000000, -1, 0, -1, 250);
	CreateDynamicObject(5441, -145.02734375, 1400.79394531, 67.23309326, 0.00000000, 0.00000000, 343.77319336, -1, 0, -1, 250);
	CreateDynamicObject(4651, -70.55488586, 1327.54248047, 67.09400940, 0.00000000, 0.00000000, 348.03979492, -1, 0, -1, 250);
	CreateDynamicObject(4651, -21.62501144, 1190.57495117, 67.02061462, 0.00000000, 0.00000000, 168.63677979, -1, 0, -1, 250);
	CreateDynamicObject(4652, 55.02156067, 1116.64868164, 66.91014099, 0.00000000, 0.00000000, 344.05316162, -1, 0, -1, 250);
	CreateDynamicObject(5495, 135.05078125, 1076.92871094, 66.92897797, 0.00000000, 0.00000000, 344.04785156, -1, 0, -1, 250);
	CreateDynamicObject(5441, 198.13476562, 1030.93554688, 66.70456696, 0.00000000, 0.00000000, 344.04235840, -1, 0, -1, 250);
	CreateDynamicObject(5441, 165.33300781, 1166.66406250, 66.80003357, 0.00000000, 0.00000000, 252.35595703, -1, 0, -1, 250);
	CreateDynamicObject(4651, -21.62500000, 1190.57421875, 67.02061462, 0.00000000, 0.00000000, 168.63464355, -1, 0, -1, 250);
	CreateDynamicObject(4651, 242.90374756, 1247.97229004, 67.01325989, 0.00000000, 0.00000000, 76.93975830, -1, 0, -1, 250);
	CreateDynamicObject(4651, 322.22753906, 1034.76660156, 66.52845764, 0.00000000, 0.00000000, 253.54791260, -1, 0, -1, 250);
	CreateDynamicObject(5442, 382.33572388, 1087.97583008, 66.37561035, 0.00000000, 0.00000000, 276.27893066, -1, 0, -1, 250);
	CreateDynamicObject(5442, 376.81652832, 1136.76965332, 65.91928101, 0.00000000, 0.00000000, 276.27465820, -1, 0, -1, 250);
	CreateDynamicObject(1323, 111.32810974, 1093.46875000, 68.25753784, 0.00000000, 0.00000000, 164.64996338, -1, 0, -1, 250);
	CreateDynamicObject(8343, 333.40390015, 1235.19165039, 67.29675293, 0.00000000, 0.00000000, 244.38507080, -1, 0, -1, 250);
	CreateDynamicObject(13593, 371.59594727, 1163.59936523, 66.56838989, 0.00000000, 0.00000000, 7.97344971, -1, 0, -1, 250);
	CreateDynamicObject(13593, 374.29202271, 1164.05895996, 66.56838989, 0.00000000, 0.00000000, 7.97344971, -1, 0, -1, 250);
	CreateDynamicObject(13593, 365.12768555, 1195.58972168, 68.03961182, 0.00000000, 0.00000000, 188.57049561, -1, 0, -1, 250);
	CreateDynamicObject(13593, 367.85467529, 1196.06872559, 68.03961182, 0.00000000, 0.00000000, 188.57049561, -1, 0, -1, 250);
	CreateDynamicObject(18609, 334.03012085, 1220.60217285, 68.46923828, 0.00000000, 0.00000000, 228.43804932, -1, 0, -1, 250);
	CreateDynamicObject(18609, 338.98147583, 1217.61071777, 68.46923828, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 342.87884521, 1215.41845703, 68.46923828, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 346.24563599, 1210.62036133, 68.91864014, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 357.44888306, 1199.05944824, 68.46923828, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 350.61016846, 1207.79992676, 68.46923828, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 353.38964844, 1203.18908691, 68.57904816, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 353.38964844, 1203.18847656, 68.57904816, 0.00000000, 0.00000000, 228.43322754, -1, 0, -1, 250);
	CreateDynamicObject(18609, 364.20190430, 1161.44738770, 67.16207886, 0.00000000, 0.00000000, 276.27392578, -1, 0, -1, 250);
	CreateDynamicObject(18609, 376.52062988, 1162.97558594, 66.99801636, 0.00000000, 0.00000000, 276.27319336, -1, 0, -1, 250);
	CreateDynamicObject(3578, -193.23962402, 1414.88598633, 67.91737366, 0.00000000, 0.00000000, 344.05310059, -1, 0, -1, 250);
	CreateDynamicObject(3578, -183.86187744, 1412.18347168, 67.91737366, 0.00000000, 0.00000000, 344.04785156, -1, 0, -1, 250);
	CreateDynamicObject(1238, -173.87504578, 1409.18957520, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -161.85842896, 1405.68762207, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -168.70507812, 1407.68652344, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -168.70507812, 1407.68652344, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -150.96096802, 1402.52600098, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -158.16699219, 1404.61035156, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -164.93542480, 1406.61767578, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -154.68945312, 1403.62109375, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -143.91137695, 1400.41955566, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -147.40261841, 1401.46057129, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -135.60278320, 1398.00280762, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -120.34648132, 1393.55029297, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -131.07203674, 1396.72888184, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -139.39601135, 1399.19970703, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -125.62109375, 1395.19335938, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -107.82186890, 1389.90551758, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -115.62655640, 1392.27038574, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -111.91601562, 1391.20971680, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -103.99797058, 1388.91552734, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -111.91601562, 1391.20898438, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -100.98646545, 1388.03247070, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -94.12170410, 1385.98339844, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -97.53987122, 1386.99072266, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -87.78752136, 1384.01428223, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1238, -90.99651337, 1385.04235840, 67.45751953, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1315, -173.59082031, 1405.97363281, 70.40842438, 0.00000000, 0.00000000, 252.35046387, -1, 0, -1, 250);
	CreateDynamicObject(1315, -171.31898499, 1411.99450684, 70.40842438, 0.00000000, 0.00000000, 71.75720215, -1, 0, -1, 250);
	CreateDynamicObject(1246, -177.53515625, 1410.11035156, 67.07785797, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(1112, -188.68357849, 1408.81689453, 67.13934326, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(2773, -121.19650269, 1443.12170410, 37.18437195, 0.00000000, 0.00000000, 0.00000000, -1, 0, -1, 250);
	CreateDynamicObject(11494, -194.08615112, 1411.71069336, 67.13934326, 0.00000000, 0.00000000, 27.90692139, -1, 0, -1, 250);
	CreateDynamicObject(11494, -192.62812805, 1417.69897461, 67.13934326, 0.00000000, 0.00000000, 27.90527344, -1, 0, -1, 250);
	CreateDynamicObject(978, -81.79136658, 1373.64672852, 68.00735474, 0.00000000, 0.00000000, 324.11950684, -1, 0, -1, 250);
	CreateDynamicObject(978, -74.74565887, 1368.60803223, 68.00929260, 0.00000000, 0.00000000, 324.11865234, -1, 0, -1, 250);
	CreateDynamicObject(978, -68.04799652, 1362.21386719, 68.00000000, 0.00000000, 0.00000000, 308.17187500, -1, 0, -1, 250);
	CreateDynamicObject(978, -63.23354721, 1356.00891113, 67.98352814, 0.00000000, 0.00000000, 308.16650391, -1, 0, -1, 250);
	CreateDynamicObject(978, -54.93566513, 1340.76940918, 67.94279480, 0.00000000, 0.00000000, 292.21972656, -1, 0, -1, 250);
	CreateDynamicObject(978, -58.38769531, 1348.38769531, 67.96977997, 0.00000000, 0.00000000, 296.20239258, -1, 0, -1, 250);
	CreateDynamicObject(978, -56.07009125, 1238.33959961, 67.71231842, 0.00000000, 0.00000000, 264.30749512, -1, 0, -1, 250);
	CreateDynamicObject(979, -76.22667694, 1384.11474609, 68.00032043, 0.00000000, 0.00000000, 144.71621704, -1, 0, -1, 250);
	CreateDynamicObject(979, -62.01301575, 1373.62292480, 68.01207733, 0.00000000, 0.00000000, 140.72521973, -1, 0, -1, 250);
	CreateDynamicObject(979, -69.32910156, 1379.20605469, 68.00222015, 0.00000000, 0.00000000, 144.71191406, -1, 0, -1, 250);
	CreateDynamicObject(979, -56.46057892, 1367.95227051, 67.99121094, 0.00000000, 0.00000000, 128.76361084, -1, 0, -1, 250);
	CreateDynamicObject(979, -50.75374603, 1360.86193848, 67.97467804, 0.00000000, 0.00000000, 128.75976562, -1, 0, -1, 250);
	CreateDynamicObject(979, -42.81206512, 1344.97399902, 67.93856049, 0.00000000, 0.00000000, 112.81289673, -1, 0, -1, 250);
	CreateDynamicObject(979, -46.41796875, 1353.47363281, 67.96238708, 0.00000000, 0.00000000, 112.80761719, -1, 0, -1, 250);
	CreateDynamicObject(979, -39.78747177, 1336.20678711, 67.92031860, 0.00000000, 0.00000000, 104.83413696, -1, 0, -1, 250);
	CreateDynamicObject(978, -52.19726562, 1332.41015625, 67.91886902, 0.00000000, 0.00000000, 284.23828125, -1, 0, -1, 250);
	CreateDynamicObject(978, -56.94388580, 1229.37585449, 67.72106934, 0.00000000, 0.00000000, 264.30358887, -1, 0, -1, 250);
	CreateDynamicObject(978, -57.17575455, 1220.45080566, 67.73394775, 0.00000000, 0.00000000, 272.27697754, -1, 0, -1, 250);
	CreateDynamicObject(978, -56.83384323, 1211.56652832, 67.76012421, 0.00000000, 0.00000000, 272.27416992, -1, 0, -1, 250);
	CreateDynamicObject(978, -54.42666245, 1194.16540527, 67.81226349, 0.00000000, 0.00000000, 280.24755859, -1, 0, -1, 250);
	CreateDynamicObject(978, -56.00566864, 1202.58642578, 67.78311920, 0.00000000, 0.00000000, 280.24755859, -1, 0, -1, 250);
	CreateDynamicObject(978, -52.73504639, 1184.86865234, 67.83796692, 0.00000000, 0.00000000, 280.24475098, -1, 0, -1, 250);
	CreateDynamicObject(978, -50.23056030, 1176.25964355, 67.85899353, 0.00000000, 0.00000000, 292.20495605, -1, 0, -1, 250);
	CreateDynamicObject(978, -46.68097305, 1167.63562012, 67.88014984, 0.00000000, 0.00000000, 292.20336914, -1, 0, -1, 250);
	CreateDynamicObject(978, -42.40827179, 1159.62536621, 67.89675140, 0.00000000, 0.00000000, 304.16345215, -1, 0, -1, 250);
	CreateDynamicObject(978, -37.16046524, 1152.49414062, 67.91241455, 0.00000000, 0.00000000, 308.14868164, -1, 0, -1, 250);
	CreateDynamicObject(978, -34.11168671, 1149.13793945, 68.09233856, 0.00000000, 0.00000000, 308.14453125, -1, 0, -1, 250);
	CreateDynamicObject(978, -27.65340042, 1142.63110352, 67.93811035, 0.00000000, 0.00000000, 320.10461426, -1, 0, -1, 250);
	CreateDynamicObject(978, 125.82283020, 1059.72204590, 67.75327301, 0.00000000, 0.00000000, 268.27587891, -1, 0, -1, 250);
	CreateDynamicObject(978, -20.41796875, 1137.37402344, 67.92829895, 0.00000000, 0.00000000, 328.07373047, -1, 0, -1, 250);
	CreateDynamicObject(978, -12.66503906, 1132.50195312, 67.92620850, 0.00000000, 0.00000000, 328.07373047, -1, 0, -1, 250);
	CreateDynamicObject(978, 127.05078125, 1066.19628906, 67.74745178, 0.00000000, 0.00000000, 252.32849121, -1, 0, -1, 250);
	CreateDynamicObject(978, 126.74179077, 1052.99353027, 67.75357056, 0.00000000, 0.00000000, 288.20874023, -1, 0, -1, 250);
	CreateDynamicObject(978, 130.49114990, 1047.00683594, 67.75357056, 0.00000000, 0.00000000, 316.11120605, -1, 0, -1, 250);
	CreateDynamicObject(978, 136.85452271, 1043.30395508, 67.75357056, 0.00000000, 0.00000000, 340.02978516, -1, 0, -1, 250);
	CreateDynamicObject(978, 261.32824707, 1006.93475342, 67.37908173, 0.00000000, 0.00000000, 344.01354980, -1, 0, -1, 250);
	CreateDynamicObject(978, 270.69085693, 1004.86657715, 67.21926880, 0.00000000, 0.00000000, 351.98278809, -1, 0, -1, 250);
	CreateDynamicObject(978, 278.94641113, 1003.53198242, 67.22737122, 0.00000000, 0.00000000, 351.97998047, -1, 0, -1, 250);
	CreateDynamicObject(978, 287.86349487, 1002.28350830, 67.23816681, 0.00000000, 0.00000000, 351.97998047, -1, 0, -1, 250);
	CreateDynamicObject(978, 292.60778809, 1001.98437500, 67.25373840, 0.00000000, 0.00000000, 355.96667480, -1, 0, -1, 250);
	CreateDynamicObject(978, 301.63442993, 1001.35424805, 67.27673340, 0.00000000, 0.00000000, 355.96252441, -1, 0, -1, 250);
	CreateDynamicObject(978, 310.12655640, 1001.39526367, 67.29785919, 0.00000000, 0.00000000, 3.93591309, -1, 0, -1, 250);
	CreateDynamicObject(978, 304.23788452, 1014.18408203, 67.29055023, 0.00000000, 0.00000000, 3.93310547, -1, 0, -1, 250);
	CreateDynamicObject(978, 328.33221436, 1003.35437012, 67.35439301, 0.00000000, 0.00000000, 11.90655518, -1, 0, -1, 250);
	CreateDynamicObject(978, 337.14691162, 1005.91149902, 67.37251282, 0.00000000, 0.00000000, 19.87713623, -1, 0, -1, 250);
	CreateDynamicObject(978, 319.48242188, 1002.08496094, 67.33000183, 0.00000000, 0.00000000, 3.93310547, -1, 0, -1, 250);
	CreateDynamicObject(978, 295.00000000, 1014.07324219, 67.25392914, 0.00000000, 0.00000000, 355.95703125, -1, 0, -1, 250);
	CreateDynamicObject(978, 312.48077393, 1014.65594482, 67.30517578, 0.00000000, 0.00000000, 3.92761230, -1, 0, -1, 250);
	CreateDynamicObject(978, 321.29235840, 1015.49719238, 67.33894348, 0.00000000, 0.00000000, 7.91433716, -1, 0, -1, 250);
	CreateDynamicObject(978, 329.74468994, 1017.41668701, 67.36493683, 0.00000000, 0.00000000, 15.88360596, -1, 0, -1, 250);
	CreateDynamicObject(978, 345.82363892, 1009.00518799, 67.39633179, 0.00000000, 0.00000000, 19.87426758, -1, 0, -1, 250);
	CreateDynamicObject(978, 368.69247437, 1023.71948242, 67.44618988, 0.00000000, 0.00000000, 35.82116699, -1, 0, -1, 250);
	CreateDynamicObject(978, 353.96484375, 1013.33398438, 67.41083527, 0.00000000, 0.00000000, 35.82092285, -1, 0, -1, 250);
	CreateDynamicObject(978, 361.06250000, 1018.27246094, 67.42600250, 0.00000000, 0.00000000, 35.82092285, -1, 0, -1, 250);
	CreateDynamicObject(978, 371.46755981, 1026.64990234, 67.43748474, 0.00000000, 0.00000000, 47.78109741, -1, 0, -1, 250);
	CreateDynamicObject(978, 377.20782471, 1033.15270996, 67.43556213, 0.00000000, 0.00000000, 47.77954102, -1, 0, -1, 250);
	CreateDynamicObject(978, 382.34976196, 1040.49230957, 67.43582153, 0.00000000, 0.00000000, 63.72644043, -1, 0, -1, 250);
	CreateDynamicObject(978, 346.47296143, 1023.34893799, 67.41030884, 0.00000000, 0.00000000, 31.82763672, -1, 0, -1, 250);
	CreateDynamicObject(978, 338.29003906, 1019.82324219, 67.38905334, 0.00000000, 0.00000000, 15.88073730, -1, 0, -1, 250);
	CreateDynamicObject(978, 354.42980957, 1028.40844727, 67.42807007, 0.00000000, 0.00000000, 31.82739258, -1, 0, -1, 250);
	CreateDynamicObject(978, 361.53518677, 1034.25524902, 67.44422150, 0.00000000, 0.00000000, 47.77429199, -1, 0, -1, 250);
	CreateDynamicObject(978, 373.28836060, 1048.59777832, 67.43697357, 0.00000000, 0.00000000, 59.73419189, -1, 0, -1, 250);
	CreateDynamicObject(978, 368.07519531, 1041.35742188, 67.44210815, 0.00000000, 0.00000000, 47.77404785, -1, 0, -1, 250);
	CreateDynamicObject(979, 296.18832397, 1280.36242676, 67.70959473, 0.00000000, 0.00000000, 352.02655029, -1, 0, -1, 250);
	CreateDynamicObject(979, 278.14489746, 1282.23937988, 67.71810913, 0.00000000, 0.00000000, 359.99731445, -1, 0, -1, 250);
	CreateDynamicObject(979, 278.14453125, 1282.23925781, 67.71810913, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 269.54364014, 1282.30053711, 67.74106598, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 260.98748779, 1282.26416016, 67.76284790, 0.00000000, 0.00000000, 359.99450684, -1, 0, -1, 250);
	CreateDynamicObject(979, 251.84114075, 1281.66198730, 67.78594971, 0.00000000, 0.00000000, 7.96792603, -1, 0, -1, 250);
	CreateDynamicObject(979, 242.75497437, 1280.06762695, 67.81777954, 0.00000000, 0.00000000, 11.95181274, -1, 0, -1, 250);
	CreateDynamicObject(979, 233.87362671, 1278.21081543, 67.84160614, 0.00000000, 0.00000000, 11.94763184, -1, 0, -1, 250);
	CreateDynamicObject(979, 228.41137695, 1276.41979980, 67.85184479, 0.00000000, 0.00000000, 19.92108154, -1, 0, -1, 250);
	CreateDynamicObject(979, 220.51947021, 1273.51354980, 67.87346649, 0.00000000, 0.00000000, 19.91821289, -1, 0, -1, 250);
	CreateDynamicObject(979, 213.07138062, 1269.86108398, 67.88857269, 0.00000000, 0.00000000, 31.87838745, -1, 0, -1, 250);
	CreateDynamicObject(979, 207.71272278, 1266.33325195, 67.89990234, 0.00000000, 0.00000000, 35.86224365, -1, 0, -1, 250);
	CreateDynamicObject(979, 200.70889282, 1261.35888672, 67.91488647, 0.00000000, 0.00000000, 35.85937500, -1, 0, -1, 250);
	CreateDynamicObject(979, 194.24588013, 1255.08398438, 67.93062592, 0.00000000, 0.00000000, 51.80627441, -1, 0, -1, 250);
	CreateDynamicObject(979, 188.84783936, 1248.10412598, 67.92083740, 0.00000000, 0.00000000, 51.80603027, -1, 0, -1, 250);
	CreateDynamicObject(979, 184.02133179, 1240.40673828, 67.91873932, 0.00000000, 0.00000000, 63.76620483, -1, 0, -1, 250);
	CreateDynamicObject(979, 198.70678711, 1240.54833984, 67.92741394, 0.00000000, 0.00000000, 51.80603027, -1, 0, -1, 250);
	CreateDynamicObject(979, 204.51095581, 1247.88586426, 67.92948151, 0.00000000, 0.00000000, 51.80603027, -1, 0, -1, 250);
	CreateDynamicObject(979, 219.22448730, 1259.19885254, 67.89199066, 0.00000000, 0.00000000, 27.88568115, -1, 0, -1, 250);
	CreateDynamicObject(979, 211.22656250, 1254.24707031, 67.90985870, 0.00000000, 0.00000000, 35.85388184, -1, 0, -1, 250);
	CreateDynamicObject(979, 227.58859253, 1263.12805176, 67.86884308, 0.00000000, 0.00000000, 23.89657593, -1, 0, -1, 250);
	CreateDynamicObject(979, 236.40475464, 1266.24597168, 67.84345245, 0.00000000, 0.00000000, 15.92181396, -1, 0, -1, 250);
	CreateDynamicObject(979, 245.06971741, 1268.40490723, 67.80964661, 0.00000000, 0.00000000, 11.93246460, -1, 0, -1, 250);
	CreateDynamicObject(979, 254.26727295, 1269.63427734, 67.78100586, 0.00000000, 0.00000000, 3.95770264, -1, 0, -1, 250);
	CreateDynamicObject(979, 263.58633423, 1270.32250977, 67.75312042, 0.00000000, 0.00000000, 3.95507812, -1, 0, -1, 250);
	CreateDynamicObject(979, 272.97592163, 1270.58483887, 67.72754669, 0.00000000, 0.00000000, 359.96838379, -1, 0, -1, 250);
	CreateDynamicObject(979, 282.38375854, 1270.19567871, 67.71141815, 0.00000000, 0.00000000, 355.98034668, -1, 0, -1, 250);
	CreateDynamicObject(979, 291.46020508, 1269.21386719, 67.70256042, 0.00000000, 0.00000000, 351.99230957, -1, 0, -1, 250);
	CreateDynamicObject(979, 286.82910156, 1281.68066406, 67.70972443, 0.00000000, 0.00000000, 352.02392578, -1, 0, -1, 250);
	CreateDynamicObject(9482, -91.16848755, 1384.95556641, 74.41496277, 0.00000000, 0.00000000, 344.05316162, -1, 0, -1, 250);
	CreateDynamicObject(3749, -183.99804688, 1411.82910156, 73.67409515, 0.00000000, 0.00000000, 71.75720215, -1, 0, -1, 250);
	CreateDynamicObject(3471, -185.41601562, 1419.47949219, 68.57794189, 0.00000000, 0.00000000, 254.84985352, -1, 0, -1, 250);
	CreateDynamicObject(3471, -189.12402344, 1406.32910156, 68.57794189, 0.00000000, 0.00000000, 71.75720215, -1, 0, -1, 250);
	CreateDynamicObject(8390, 232.86598206, 1123.22973633, 86.18202209, 0.00000000, 0.00000000, 252.35858154, -1, 0, -1, 250);
	CreateDynamicObject(5441, 335.93939209, 1084.82189941, 66.11231995, 0.00000000, 0.00000000, 344.04235840, -1, 0, -1, 250);
	CreateDynamicObject(1660, 284.75433350, 1091.74230957, 98.87733459, 0.00000000, 0.00000000, 252.35858154, -1, 0, -1, 250);
	CreateDynamicObject(1660, 170.28710938, 1115.71093750, 98.87733459, 0.00000000, 0.00000000, 71.75720215, -1, 0, -1, 250);
	CreateDynamicObject(1660, 175.70410156, 1128.34082031, 98.87733459, 0.00000000, 0.00000000, 71.75720215, -1, 0, -1, 250);
	CreateDynamicObject(1660, 281.41589355, 1081.57043457, 98.87733459, 0.00000000, 0.00000000, 252.35595703, -1, 0, -1, 250);
	CreateDynamicObject(7196, -146.25944519, 1406.91088867, 70.05867767, 0.00000000, 0.00000000, 253.86096191, -1, 0, -1, 250);
	CreateDynamicObject(10402, -150.33969116, 1407.86145020, 69.33789825, 0.00000000, 0.00000000, 344.05310059, -1, 0, -1, 250);
	CreateDynamicObject(10402, -122.97201538, 1399.81201172, 69.33789825, 0.00000000, 0.00000000, 344.04785156, -1, 0, -1, 250);
	CreateDynamicObject(10402, -155.05905151, 1397.88122559, 69.33789825, 0.00000000, 0.00000000, 344.04785156, -1, 0, -1, 250);
	CreateDynamicObject(10402, -125.11656952, 1389.26000977, 69.76669312, 0.00000000, 0.00000000, 344.04785156, -1, 0, -1, 250);
	
    // parkour 1
	CreateDynamicObject(972, 1531.47973600, -1359.22656300, 328.45034800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(972, 1550.99121100, -1359.23681600, 328.45581100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(972, 1542.70861800, -1365.28625500, 328.15380900, 0.00000000, 0.00000000, -89.38141604, -1, -1, -1, 250);
	CreateDynamicObject(974, 1551.05700700, -1345.10205100, 331.23623700, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1538.19177200, -1345.07312000, 331.24121100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(978, 1544.50683600, -1337.02807600, 329.04757700, 94.53809349, 0.00000000, -88.52197935, -1, -1, -1, 250);
	CreateDynamicObject(978, 1544.70898400, -1345.88708500, 327.34652700, -245.79883682, 256.97151382, 14.61042378, -1, -1, -1, 250);
	CreateDynamicObject(978, 1544.23742700, -1324.61401400, 329.04776000, 94.53809349, 0.00000000, -88.52197935, -1, -1, -1, 250);
	CreateDynamicObject(974, 1544.29467800, -1316.17517100, 328.01788300, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1544.08886700, -1307.95434600, 326.07467700, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1544.86120600, -1299.68432600, 328.92422500, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1553.25988800, -1299.90087900, 330.80770900, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1560.94299300, -1300.69543500, 328.54486100, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1564.03942900, -1299.92248500, 331.32266200, 183.91950953, 0.00000000, -89.38141604, -1, -1, -1, 250);
	CreateDynamicObject(974, 1561.32983400, -1292.13647500, 326.95224000, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1562.18335000, -1287.30468800, 324.15411400, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3258, 1559.69677700, -1287.83447300, 322.73663300, 118.60232089, 0.00000000, -88.52197935, -1, -1, -1, 250);
	CreateDynamicObject(3257, 1555.85412600, -1255.20996100, 276.35571300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3287, 1565.30419900, -1254.09912100, 288.89392100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3287, 1571.85827600, -1254.17468300, 288.93530300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1537.46252400, -1282.56335400, 314.28128100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1538.06433100, -1274.25805700, 313.83450300, -6.01605685, 0.00000000, -7.73493023, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1539.64648400, -1267.35376000, 312.58728000, -12.03211370, 0.00000000, -16.32929716, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1541.58178700, -1256.78161600, 307.05413800, -85.08423258, 0.00000000, -16.32929716, -1, -1, -1, 250);
	CreateDynamicObject(974, 1541.15478500, -1254.38464400, 311.65838600, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1541.23645000, -1262.01538100, 310.14981100, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1546.33313000, -1258.03479000, 310.41314700, 91.95972612, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(974, 1536.39111300, -1257.45532200, 310.30587800, 91.95972612, 0.00000000, 11.17267701, -1, -1, -1, 250);
	CreateDynamicObject(974, 1540.46557600, -1255.21789600, 298.40844700, 91.95972612, 0.00000000, 3.43774677, -1, -1, -1, 250);
	CreateDynamicObject(974, 1544.44763200, -1255.29968300, 298.42996200, 91.95972612, 0.00000000, -4.29718346, -1, -1, -1, 250);
	CreateDynamicObject(3257, 1585.73034700, -1253.02539100, 272.12976100, 0.00000000, 0.00000000, -88.52197935, -1, -1, -1, 250);
	CreateDynamicObject(3257, 1585.98681600, -1261.29406700, 272.13314800, 0.00000000, 0.00000000, -268.14419083, -1, -1, -1, 250);
	CreateDynamicObject(3631, 1594.14160200, -1257.08642600, 286.86883500, 0.00000000, 0.00000000, 1.71887339, -1, -1, -1, 250);
	CreateDynamicObject(3631, 1604.56164600, -1256.77233900, 286.85174600, 0.00000000, 0.00000000, 1.71887339, -1, -1, -1, 250);
	CreateDynamicObject(3631, 1615.55175800, -1256.58337400, 286.85958900, 0.00000000, 0.00000000, 1.71887339, -1, -1, -1, 250);
	CreateDynamicObject(3636, 1633.98425300, -1255.84838900, 276.36599700, 82.50592250, 0.00000000, -1.71887339, -1, -1, -1, 250);
	CreateDynamicObject(3636, 1650.99963400, -1256.63537600, 274.60452300, 82.50592250, 0.00000000, -1.71887339, -1, -1, -1, 250);
	CreateDynamicObject(3636, 1666.38598600, -1255.20495600, 272.61486800, 82.50592250, 0.00000000, 17.18873385, -1, -1, -1, 250);
	CreateDynamicObject(3636, 1681.09021000, -1248.78125000, 273.70929000, 82.50592250, 0.00000000, 27.50197417, -1, -1, -1, 250);
	CreateDynamicObject(3636, 1694.77307100, -1239.38745100, 274.84780900, 82.50592250, 0.00000000, 39.53408786, -1, -1, -1, 250);
	CreateDynamicObject(6867, 1714.95483400, -1178.67041000, 297.15399200, 0.00000000, 0.00000000, -51.56620156, -1, -1, -1, 250);
	CreateDynamicObject(974, 1706.98413100, -1211.47265600, 277.03076200, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1701.03759800, -1204.87646500, 276.81738300, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1693.76635700, -1197.61450200, 276.82901000, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1702.92028800, -1178.17627000, 279.18060300, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1697.31506300, -1182.87817400, 279.61947600, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1690.98498500, -1185.70861800, 280.65783700, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1707.23571800, -1118.80554200, 273.88061500, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1711.80139200, -1115.36169400, 276.67355300, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1716.70105000, -1121.03784200, 278.09811400, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1722.69030800, -1124.65515100, 279.08462500, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1727.63134800, -1129.97741700, 280.64492800, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1732.61572300, -1125.55322300, 282.77932700, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1740.99438500, -1120.95617700, 280.22213700, 90.24085273, 0.00000000, -49.84732818, -1, -1, -1, 250);
	CreateDynamicObject(974, 1744.08374000, -1121.66052200, 281.85693400, 183.06007284, 0.00000000, 39.53408786, -1, -1, -1, 250);
	CreateDynamicObject(974, 1779.22509800, -1161.04113800, 280.83062700, 268.14419083, 0.00000000, 39.53408786, -1, -1, -1, 250);
	CreateDynamicObject(3330, 1804.41137700, -1187.47509800, 270.03402700, -31.79915763, 0.00000000, 37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(3330, 1820.63317900, -1210.19104000, 233.51001000, -55.00394833, 0.00000000, 37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(3411, 1879.03271500, -1241.67932100, 183.44625900, 0.00000000, 0.00000000, -53.28501765, -1, -1, -1, 250);
	CreateDynamicObject(4550, 1957.40417500, -1183.40344200, 126.30550400, 124.61832044, 0.00000000, 126.33730842, -1, -1, -1, 250);
	
	// parkour 2
	CreateDynamicObject(3983, 2581.91528300, -1432.61254900, 233.02203400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3983, 2536.63134800, -1432.78857400, 233.18798800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3989, 2559.21093800, -1366.99780300, 226.62889100, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(4010, 2528.51660200, -1403.49072300, 231.55517600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3776, 2602.35278300, -1369.87817400, 239.95028700, 0.00000000, 0.00000000, 180.00000000, -1, -1, -1, 250);
	CreateDynamicObject(4002, 2553.02734400, -1443.52441400, 255.60842900, 0.00000000, 0.00000000, 180.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2590.28369100, -1360.50842300, 232.81843600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2591.22631800, -1365.26342800, 235.43504300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2591.22631800, -1371.11633300, 238.47139000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3998, 2591.82226600, -1400.05847200, 236.83416700, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2601.77661100, -1386.45959500, 241.23397800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2601.64672900, -1387.70959500, 242.72633400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2601.29003900, -1388.20959500, 244.13964800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2593.50781300, -1387.20959500, 242.57151800, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(4079, 2519.50463900, -1401.18115200, 244.64541600, 0.00000000, 0.00000000, 22.50000000, -1, -1, -1, 250);
	CreateDynamicObject(1437, 2590.14062500, -1388.44689900, 243.72769200, 0.00000000, 0.00000000, 168.74990000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2587.30224600, -1390.67456100, 245.44149800, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2582.39404300, -1391.49536100, 246.44149800, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2578.98486300, -1394.94470200, 246.94149800, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2580.20043900, -1398.30725100, 248.69149800, 0.00000000, 0.00000000, 45.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2583.54614300, -1400.50659200, 249.69149800, 0.00000000, 0.00000000, 78.75000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2587.11499000, -1402.20568800, 250.21661400, 0.00000000, 0.00000000, 71.95180000, -1, -1, -1, 250);
	CreateDynamicObject(851, 2592.02880900, -1397.88842800, 251.64035000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(851, 2591.99585000, -1393.47741700, 250.64035000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(851, 2578.28637700, -1387.44104000, 245.13577300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(851, 2573.77343800, -1389.69726600, 245.13577300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3447, 2589.25415000, -1403.92211900, 253.07101400, 0.00000000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2591.64013700, -1394.75402800, 250.19607500, 0.00000000, 0.00000000, 236.25000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2587.37548800, -1393.35156300, 249.69149800, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2583.08300800, -1393.47473100, 250.43571500, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2578.55297900, -1392.63476600, 250.67993200, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(970, 2573.57470700, -1392.72583000, 251.35704000, 49.84730000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(970, 2570.46972700, -1393.06347700, 252.86842300, 49.84730000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(970, 2567.01220700, -1392.17663600, 253.24229400, 115.16440000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(970, 2565.25561500, -1393.24585000, 253.80241400, 48.12840000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(970, 2560.43994100, -1393.08105500, 254.39897200, 48.12840000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2555.10034200, -1393.06713900, 255.16015600, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2552.06494100, -1392.17688000, 256.47036700, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2549.21362300, -1390.87097200, 257.74905400, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2545.94506800, -1389.49890100, 259.02932700, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2543.29492200, -1387.71667500, 260.27200300, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2541.08252000, -1386.41796900, 261.54174800, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2542.33300800, -1386.77368200, 261.54794300, 85.94360000, 14.61040000, 347.96790000, -1, -1, -1, 250);
	CreateDynamicObject(1407, 2539.98413100, -1385.53039600, 262.31094400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1407, 2543.35913100, -1385.52648900, 262.28631600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1407, 2537.69848600, -1386.84423800, 262.44085700, 0.00000000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1407, 2540.09448200, -1385.60046400, 263.70770300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1407, 2544.21899400, -1385.50061000, 263.60040300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(991, 2533.85693400, -1385.69299300, 259.69052100, 85.94360000, 14.61040000, 291.71790000, -1, -1, -1, 250);
	CreateDynamicObject(2400, 2502.80810500, -1392.84411600, 257.36416600, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(2400, 2508.47631800, -1394.73510700, 257.36416600, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(3359, 2501.94165000, -1416.25244100, 257.38168300, 0.00000000, 0.00000000, 191.25000000, -1, -1, -1, 250);
	CreateDynamicObject(983, 2499.43505900, -1415.76110800, 257.03387500, 28.36140000, 84.22470000, 351.40560000, -1, -1, -1, 250);
	CreateDynamicObject(983, 2499.15820300, -1419.50891100, 255.28506500, 0.00000000, 0.00000000, 11.25000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2502.25585900, -1421.81115700, 250.67942800, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2501.15844700, -1424.50512700, 251.88790900, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2499.56298800, -1428.79174800, 252.13212600, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2498.00268600, -1432.18396000, 253.12634300, 0.00000000, 0.00000000, 337.50000000, -1, -1, -1, 250);
	CreateDynamicObject(980, 2497.02221700, -1441.38427700, 252.92575100, 94.53800000, 0.00000000, 303.75000000, -1, -1, -1, 250);
	CreateDynamicObject(980, 2501.73730500, -1448.51306200, 253.51026900, 97.11630000, 253.97580000, 228.61250000, -1, -1, -1, 250);
	CreateDynamicObject(3286, 2503.70654300, -1451.42932100, 258.72027600, 0.00000000, 0.00000000, 33.75000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2503.08593800, -1448.17346200, 255.61291500, 0.00000000, 0.00000000, 303.75000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2499.84619100, -1450.58606000, 256.49575800, 0.00000000, 0.00000000, 303.75000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2501.19043000, -1453.37890600, 256.97415200, 0.00000000, 0.00000000, 56.25000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2504.43847700, -1454.12365700, 257.54354900, 321.32530000, 0.00000000, 146.25000000, -1, -1, -1, 250);
	CreateDynamicObject(1387, 2504.22583000, -1455.39416500, 257.76071200, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1387, 2504.57617200, -1454.79785200, 258.17022700, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2506.86279300, -1455.77539100, 258.60336300, 0.00000000, 0.00000000, 56.25000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2511.80786100, -1456.14672900, 258.46997100, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2514.74096700, -1456.14672900, 259.57919300, 0.00000000, 0.00000000, 271.71890000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2518.73046900, -1456.38867200, 260.07342500, 0.00000000, 0.00000000, 271.71890000, -1, -1, -1, 250);
	CreateDynamicObject(2649, 2519.73535200, -1455.64672900, 260.89938400, 0.00000000, 0.00000000, 258.75000000, -1, -1, -1, 250);
	CreateDynamicObject(2649, 2521.22387700, -1455.89672900, 261.74975600, 0.00000000, 0.00000000, 258.75000000, -1, -1, -1, 250);
	CreateDynamicObject(925, 2514.86840800, -1454.07263200, 263.08441200, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(925, 2517.77880900, -1453.97814900, 264.27230800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(925, 2514.14648400, -1453.66418500, 265.69421400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(925, 2511.90747100, -1454.49682600, 267.26037600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2533.18774400, -1445.40820300, 278.14486700, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2533.18774400, -1451.17407200, 280.39032000, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2533.68481400, -1445.68054200, 282.19412200, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2531.38793900, -1441.09570300, 283.08398400, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2533.18774400, -1443.39306600, 286.69430500, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2533.18774400, -1447.29724100, 288.91796900, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2533.63793900, -1443.42346200, 292.58688400, 0.00000000, 331.63860000, 8.59440000, -1, -1, -1, 250);
	CreateDynamicObject(1637, 2533.18774400, -1440.41796900, 291.87448100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3406, 2533.18774400, -1444.44299300, 297.20544400, 0.85940000, 310.15270000, 278.67170000, -1, -1, -1, 250);
	CreateDynamicObject(1498, 2531.93188500, -1445.54553200, 301.54388400, 39.53410000, 358.28110000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3167, 2533.24462900, -1451.70874000, 302.59603900, 327.34140000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3361, 2533.50878900, -1451.18676800, 311.01568600, 0.00000000, 0.00000000, 168.75000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2530.47436500, -1454.47497600, 306.17977900, 0.00000000, 331.63860000, 312.34430000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2530.08789100, -1451.75622600, 307.96051000, 346.24900000, 0.00000000, 101.25000000, -1, -1, -1, 250);
	CreateDynamicObject(3361, 2565.54126000, -1435.08752400, 315.87109400, 0.00000000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2565.82055700, -1441.99316400, 318.81579600, 346.24900000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2565.90454100, -1445.59960900, 320.14569100, 346.24900000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2565.80200200, -1449.51574700, 321.49017300, 346.24900000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3399, 2564.15893600, -1446.19384800, 324.21557600, 0.00000000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3399, 2564.15893600, -1446.12329100, 329.96347000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3399, 2561.91381800, -1443.88330100, 336.89199800, 0.00000000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3399, 2562.01440400, -1444.25415000, 343.00235000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2559.89648400, -1445.43505900, 346.34066800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2557.87915000, -1443.04284700, 349.17828400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2555.91015600, -1442.49939000, 351.57128900, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2553.89453100, -1442.08349600, 353.64672900, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2553.89453100, -1443.71521000, 354.58596800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, 2601.33129900, -1382.40930200, 240.98431400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1684, 2591.22631800, -1372.69616700, 240.37892200, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	
	// parkour 3
	CreateDynamicObject(13647, 2750.30004883, -2328.39990234, 24.00000000, 0.00000000, 0.00000000, 90.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13647, 2749.69995117, -2292.10009766, 24.00000000, 0.00000000, 0.00000000, 272.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13647, 2751.00000000, -2275.80004883, 33.00000000, 0.00000000, 20.00000000, 265.99951172, -1, -1, -1, 250);
	CreateDynamicObject(16084, 2750.69995117, -2214.39990234, 37.79999924, 0.00000000, 0.00000000, 286.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18367, 2755.19995117, -2207.39990234, 43.00000000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18367, 2737.00000000, -2207.60009766, 45.00000000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18609, 2696.50000000, -2224.60009766, 47.70000076, 0.00000000, 0.00000000, 4.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18609, 2696.60009766, -2231.89990234, 47.70000076, 0.00000000, 0.00000000, 3.99902344, -1, -1, -1, 250);
	CreateDynamicObject(18609, 2696.50000000, -2240.89990234, 47.70000076, 0.00000000, 0.00000000, 3.99902344, -1, -1, -1, 250);
	CreateDynamicObject(684, 2696.39990234, -2243.69995117, 46.90000153, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2690.19995117, -2247.19995117, 46.90000153, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2677.19995117, -2247.30004883, 46.90000153, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2666.69921875, -2247.00000000, 46.90000153, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2656.39990234, -2246.80004883, 46.90000153, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2646.60009766, -2247.00000000, 46.90000153, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2639.69995117, -2247.19995117, 45.70000076, 20.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(5170, 2608.60009766, -2246.69995117, 38.90000153, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(11448, 2494.79980469, -2246.50000000, 20.89999962, 0.00000000, 0.00000000, 321.99829102, -1, -1, -1, 250);
	CreateDynamicObject(11448, 2522.30004883, -2246.50000000, 20.89999962, 0.00000000, 0.00000000, 321.99829102, -1, -1, -1, 250);
	CreateDynamicObject(11448, 2478.89990234, -2245.89990234, 20.89999962, 0.00000000, 0.00000000, 321.99829102, -1, -1, -1, 250);
	CreateDynamicObject(11448, 2446.80004883, -2244.60009766, 20.89999962, 0.00000000, 0.00000000, 321.99829102, -1, -1, -1, 250);
	CreateDynamicObject(1378, 2372.80004883, -2241.19995117, 36.79999924, 0.00000000, 0.00000000, 264.00000000, -1, -1, -1, 250);
	CreateDynamicObject(4085, 2326.39990234, -2235.30004883, 35.20000076, 0.00000000, 0.00000000, 83.99597168, -1, -1, -1, 250);
	CreateDynamicObject(4085, 2316.89990234, -2234.30004883, 35.20000076, 0.00000000, 0.00000000, 83.99597168, -1, -1, -1, 250);
	CreateDynamicObject(4085, 2306.39990234, -2233.39990234, 35.20000076, 0.00000000, 0.00000000, 83.99597168, -1, -1, -1, 250);
	CreateDynamicObject(4085, 2295.50000000, -2233.39990234, 35.20000076, 0.00000000, 0.00000000, 83.99597168, -1, -1, -1, 250);
	CreateDynamicObject(4085, 2286.30004883, -2232.60009766, 35.20000076, 0.00000000, 0.00000000, 83.99597168, -1, -1, -1, 250);
	CreateDynamicObject(4085, 2281.39990234, -2232.00000000, 35.20000076, 0.00000000, 0.00000000, 83.99597168, -1, -1, -1, 250);
	CreateDynamicObject(3621, 2192.19995117, -2224.80004883, 40.29999924, 0.00000000, 0.00000000, 175.00000000, -1, -1, -1, 250);
	CreateDynamicObject(5126, 2126.69995117, -2246.69995117, 44.79999924, 0.00000000, 0.00000000, 84.87915039, -1, -1, -1, 250);
	CreateDynamicObject(5126, 2122.60009766, -2283.80004883, 49.09999847, 0.00000000, 0.00000000, 82.87487793, -1, -1, -1, 250);
	CreateDynamicObject(684, 2133.80004883, -2218.19995117, 45.29999924, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3406, 2126.69995117, -2247.80004883, 44.90000153, 0.00000000, 0.00000000, 86.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3406, 2126.50000000, -2249.50000000, 46.20000076, 0.00000000, 0.00000000, 85.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3406, 2126.39990234, -2251.00000000, 47.50000000, 0.00000000, 0.00000000, 87.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3406, 2122.50000000, -2285.39990234, 49.70000076, 0.00000000, 0.00000000, 83.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3406, 2122.19995117, -2287.89990234, 51.70000076, 0.00000000, 0.00000000, 83.99047852, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2129.60009766, -2293.00000000, 53.59999847, 0.00000000, 0.00000000, 356.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2142.30004883, -2293.80004883, 53.59999847, 0.00000000, 0.00000000, 355.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2155.80004883, -2294.69995117, 53.59999847, 0.00000000, 0.00000000, 355.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2170.30004883, -2295.69995117, 53.59999847, 0.00000000, 0.00000000, 355.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2170.50000000, -2293.00000000, 53.59999847, 0.00000000, 0.00000000, 355.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2170.80004883, -2290.00000000, 53.59999847, 0.00000000, 0.00000000, 355.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3578, 2180.30004883, -2290.69995117, 54.70000076, 0.00000000, 0.00000000, 355.99548340, -1, -1, -1, 250);
	CreateDynamicObject(3620, 2200.10009766, -2293.19995117, 42.70000076, 0.00000000, 0.00000000, 264.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3620, 2216.19995117, -2281.19995117, 30.70000076, 0.00000000, 0.00000000, 323.99597168, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2220.60009766, -2269.39990234, 27.60000038, 0.00000000, 0.00000000, 50.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2217.60009766, -2267.10009766, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2214.39990234, -2264.50000000, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2210.30004883, -2260.69995117, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2207.39990234, -2256.00000000, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2204.30004883, -2250.89990234, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2201.39990234, -2246.19995117, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2198.39990234, -2241.30004883, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2195.39990234, -2236.39990234, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2192.10009766, -2231.10009766, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2187.69995117, -2223.89990234, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2183.39990234, -2216.89990234, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2178.60009766, -2209.00000000, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2174.30004883, -2202.00000000, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2176.00000000, -2206.00000000, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2180.30004883, -2212.80004883, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2187.00000000, -2219.19995117, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(3374, 2191.60009766, -2227.00000000, 27.60000038, 0.00000000, 0.00000000, 49.99877930, -1, -1, -1, 250);
	CreateDynamicObject(4550, 2142.39990234, -2140.10009766, 18.39999962, 0.00000000, 70.00000000, 116.00000000, -1, -1, -1, 250);
	CreateDynamicObject(4602, 2040.30004883, -1937.69995117, 97.69999695, 0.00000000, 70.00000000, 118.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3502, 2010.00000000, -1880.40002441, 135.89999390, 0.00000000, 0.00000000, 30.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3502, 2005.80004883, -1873.30004883, 135.89999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 2001.50000000, -1866.00000000, 135.89999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1997.50000000, -1859.09997559, 135.89999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1993.30004883, -1852.00000000, 135.89999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1987.30004883, -1841.19995117, 135.89999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1982.90002441, -1833.59997559, 138.39999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1978.80004883, -1826.69995117, 141.10000610, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(3502, 1972.59997559, -1815.50000000, 139.89999390, 0.00000000, 0.00000000, 29.99816895, -1, -1, -1, 250);
	CreateDynamicObject(6934, 1925.19995117, -1786.80004883, 136.89999390, 0.00000000, 90.00000000, 330.00000000, -1, -1, -1, 250);
	CreateDynamicObject(6934, 1840.69995117, -1779.40002441, 119.09999847, 0.00000000, 70.00000000, 17.99633789, -1, -1, -1, 250);
	CreateDynamicObject(7236, 1785.40002441, -1797.90002441, 78.40000153, 0.00000000, 0.00000000, 2.00000000, -1, -1, -1, 250);
	CreateDynamicObject(2780, 1780.90002441, -1797.59997559, 98.30000305, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(2780, 1781.90002441, -1801.69995117, 98.30000305, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(2780, 1785.09997559, -1800.19995117, 98.30000305, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(2780, 1784.00000000, -1793.50000000, 98.30000305, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(2780, 1780.19995117, -1794.90002441, 98.30000305, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(2780, 1789.40002441, -1795.80004883, 98.30000305, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2574.89990234, -2247.30004883, 42.50000000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2559.10009766, -2246.19995117, 42.79999924, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2541.69995117, -2245.39990234, 42.50000000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2515.69995117, -2245.50000000, 42.50000000, 0.00000000, 0.00000000, 270.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2492.89990234, -2245.80004883, 42.50000000, 0.00000000, 0.00000000, 268.00000000, -1, -1, -1, 250);
	CreateDynamicObject(684, 2487.10009766, -2245.50000000, 42.50000000, 0.00000000, 0.00000000, 267.99499512, -1, -1, -1, 250);
	CreateDynamicObject(684, 2460.60009766, -2245.00000000, 42.50000000, 0.00000000, 0.00000000, 267.99499512, -1, -1, -1, 250);
	CreateDynamicObject(684, 2443.19995117, -2246.80004883, 42.50000000, 0.00000000, 0.00000000, 267.99499512, -1, -1, -1, 250);
	CreateDynamicObject(684, 2427.00000000, -2245.69995117, 42.50000000, 0.00000000, 0.00000000, 267.99499512, -1, -1, -1, 250);
	CreateDynamicObject(684, 2417.50000000, -2245.30004883, 42.50000000, 0.00000000, 0.00000000, 267.99499512, -1, -1, -1, 250);
	
	// parkour 4
	CreateDynamicObject(12957, -1753.50000000, 882.59997559, 295.50000000, 30.00000000, 0.00000000, 184.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1753.19995117, 875.70001221, 296.29998779, 0.00000000, 0.00000000, 4.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1760.59997559, 872.70001221, 296.29998779, 0.00000000, 0.00000000, 275.99902344, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1760.59997559, 868.09997559, 296.29998779, 0.00000000, 0.00000000, 275.99853516, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1756.40002441, 864.50000000, 296.29998779, 0.00000000, 0.00000000, 275.99853516, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1755.59997559, 859.79998779, 296.29998779, 0.00000000, 0.00000000, 275.99853516, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1752.80004883, 855.09997559, 296.29998779, 0.00000000, 0.00000000, 275.99853516, -1, -1, -1, 250);
	CreateDynamicObject(18245, -1782.80004883, 854.20001221, 274.70001221, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1768.40002441, 853.40002441, 288.20001221, 0.00000000, 0.00000000, 275.99853516, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1760.30004883, 854.40002441, 292.60000610, 0.00000000, 0.00000000, 275.99902344, -1, -1, -1, 250);
	CreateDynamicObject(3593, -1768.39941406, 853.39941406, 288.20001221, 0.00000000, 0.00000000, 275.99853516, -1, -1, -1, 250);
	CreateDynamicObject(18249, -1845.59997559, 863.09997559, 260.00000000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1851.00000000, 877.90002441, 262.60000610, 280.00000000, 0.00000000, 42.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1855.19995117, 882.59997559, 262.60000610, 279.99755859, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1860.00000000, 888.00000000, 262.60000610, 279.99755859, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1865.69995117, 894.20001221, 262.60000610, 279.99206543, 0.00000000, 41.98974609, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1869.50000000, 897.29998779, 262.60000610, 279.99206543, 0.00000000, 83.98974609, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1866.00000000, 893.70001221, 262.60000610, 279.99206543, 0.00000000, 91.98974609, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1870.30004883, 893.50000000, 262.60000610, 279.99206543, 0.00000000, 41.98974609, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1874.30004883, 897.79998779, 262.60000610, 279.99755859, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1437, -1878.40002441, 902.59997559, 262.60000610, 279.99206543, 0.00000000, 29.98974609, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1881.50000000, 906.40002441, 261.79998779, 0.00000000, 0.00000000, 42.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1882.80004883, 908.00000000, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1884.40002441, 909.59997559, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1882.50000000, 911.20001221, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1882.30004883, 914.90002441, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1885.00000000, 915.59997559, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1888.50000000, 915.29998779, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1890.69995117, 917.40002441, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1466, -1891.40002441, 920.29998779, 261.79998779, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1892.19995117, 921.90002441, 262.20001221, 0.00000000, 330.00000000, 312.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1895.59960938, 926.00000000, 259.00000000, 0.00000000, 357.99499512, 13.99475098, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1893.19921875, 923.59960938, 261.39999390, 0.00000000, 329.99633789, 311.99523926, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1897.09997559, 929.40002441, 259.00000000, 0.00000000, 357.98950195, 35.98925781, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1899.89941406, 932.89941406, 259.00000000, 0.00000000, 357.98950195, 43.98925781, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1902.90002441, 936.00000000, 259.00000000, 0.00000000, 357.99499512, 43.99475098, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1900.89941406, 938.00000000, 259.00000000, 0.00000000, 357.98950195, 313.98925781, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1898.40002441, 940.79998779, 259.00000000, 0.00000000, 357.98950195, 45.98925781, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1901.90002441, 942.29998779, 259.00000000, 0.00000000, 357.98950195, 71.98925781, -1, -1, -1, 250);
	CreateDynamicObject(1698, -1905.40002441, 943.79998779, 259.00000000, 0.00000000, 357.99499512, 43.99475098, -1, -1, -1, 250);
	CreateDynamicObject(3361, -1910.00000000, 940.00000000, 261.60000610, 0.00000000, 0.00000000, 42.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3361, -1923.90002441, 927.40002441, 269.39999390, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(3361, -1915.29980469, 935.19921875, 265.50000000, 0.00000000, 0.00000000, 41.99523926, -1, -1, -1, 250);
	CreateDynamicObject(4881, -1950.19995117, 928.09997559, 268.60000610, 0.00000000, 0.00000000, 44.00000000, -1, -1, -1, 250);
	CreateDynamicObject(10008, -1969.80004883, 938.40002441, 274.60000610, 0.00000000, 0.00000000, 272.00000000, -1, -1, -1, 250);
	CreateDynamicObject(10009, -1969.40002441, 937.40002441, 280.50000000, 0.00000000, 0.00000000, 268.00000000, -1, -1, -1, 250);
	CreateDynamicObject(11496, -1970.19995117, 918.50000000, 282.60000610, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(11496, -1985.50000000, 905.79998779, 282.60000610, 0.00000000, 0.00000000, 298.00000000, -1, -1, -1, 250);
	CreateDynamicObject(11496, -2004.80004883, 895.40002441, 282.60000610, 0.00000000, 0.00000000, 297.99865723, -1, -1, -1, 250);
	CreateDynamicObject(13644, -2013.59997559, 888.70001221, 283.89999390, 0.00000000, 0.00000000, 255.99996948, -1, -1, -1, 250);
	CreateDynamicObject(13644, -2019.00000000, 890.29998779, 287.10000610, 0.00000000, 0.00000000, 205.99792480, -1, -1, -1, 250);
	CreateDynamicObject(13644, -2019.90002441, 885.20001221, 290.00000000, 0.00000000, 0.00000000, 295.99365234, -1, -1, -1, 250);
	CreateDynamicObject(14596, -2021.59997559, 884.29998779, 302.20001221, 0.00000000, 0.00000000, 203.99993896, -1, -1, -1, 250);
	CreateDynamicObject(13637, -2007.30004883, 886.20001221, 305.60000610, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13637, -1995.30004883, 895.29998779, 301.89999390, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1987.50000000, 903.50000000, 300.00000000, 90.00000000, 178.01684570, 143.98315430, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1982.69995117, 908.00000000, 300.00000000, 90.00000000, 178.08386230, 45.90890503, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1975.80004883, 900.70001221, 300.00000000, 90.00000000, 178.08715820, 45.90206909, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1975.59997559, 900.20001221, 300.00000000, 90.00000000, 181.91175842, 42.07199097, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1975.40002441, 899.70001221, 300.00000000, 90.00000000, 178.09997559, 45.87832642, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1971.90002441, 893.59997559, 300.00000000, 90.00000000, 178.19061279, 197.78215027, -1, -1, -1, 250);
	CreateDynamicObject(13594, -1972.90002441, 886.50000000, 300.00000000, 90.00000000, 181.77830505, 166.19030762, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1973.30004883, 881.79998779, 299.50000000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1973.19995117, 875.09997559, 299.50000000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1966.59997559, 874.90002441, 299.50000000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1959.69995117, 875.09997559, 299.50000000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1959.50000000, 867.70001221, 299.50000000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1959.40002441, 864.50000000, 301.29998779, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1959.40002441, 859.90002441, 305.20001221, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1959.39941406, 862.09960938, 303.20001221, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3374, -1956.59997559, 857.50000000, 307.29998779, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1337, -1935.64453125, 782.03125000, 267.43234253, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(7073, -1939.09997559, 846.29998779, 308.89999390, 0.00000000, 88.00000000, 330.00000000, -1, -1, -1, 250);
	CreateDynamicObject(7073, -1923.90002441, 824.90002441, 308.89999390, 0.00000000, 90.00000000, 303.99633789, -1, -1, -1, 250);
	CreateDynamicObject(11417, -1916.30004883, 813.90002441, 309.60000610, 315.00000000, 90.00000000, 300.00085449, -1, -1, -1, 250);
	CreateDynamicObject(11417, -1910.19995117, 803.29998779, 309.60000610, 315.00000000, 90.00000000, 299.99816895, -1, -1, -1, 250);
	CreateDynamicObject(11417, -1904.50000000, 792.20001221, 309.60000610, 315.00000000, 90.00000000, 299.99816895, -1, -1, -1, 250);
	CreateDynamicObject(16135, -1869.69995117, 748.00000000, 310.00000000, 0.00000000, 0.00000000, 302.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16135, -1859.59997559, 683.79998779, 310.00000000, 0.00000000, 0.00000000, 267.99768066, -1, -1, -1, 250);
	CreateDynamicObject(16135, -1835.59997559, 619.79998779, 310.00000000, 0.00000000, 0.00000000, 285.99499512, -1, -1, -1, 250);
	CreateDynamicObject(16135, -1799.50000000, 573.00000000, 310.00000000, 0.00000000, 0.00000000, 295.99060059, -1, -1, -1, 250);
	CreateDynamicObject(3279, -1779.50000000, 562.40002441, 308.39999390, 0.00000000, 0.00000000, 246.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3387, -1781.69995117, 563.40002441, 324.50000000, 0.00000000, 313.99993896, 336.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3387, -1783.40002441, 564.70001221, 326.10000610, 0.00000000, 313.99475098, 245.99499512, -1, -1, -1, 250);
	CreateDynamicObject(3387, -1782.80004883, 566.70001221, 327.60000610, 0.00000000, 313.98925781, 335.99487305, -1, -1, -1, 250);
	CreateDynamicObject(3387, -1784.40002441, 567.40002441, 329.20001221, 0.00000000, 313.98925781, 335.99487305, -1, -1, -1, 250);
	CreateDynamicObject(3387, -1786.00000000, 568.20001221, 330.89999390, 0.00000000, 283.98925781, 335.99487305, -1, -1, -1, 250);
	CreateDynamicObject(3387, -1788.40002441, 569.29998779, 331.60000610, 0.00000000, 267.98025513, 345.99487305, -1, -1, -1, 250);
	CreateDynamicObject(3037, -2014.50000000, 880.20001221, 299.50000000, 0.00000000, 0.00000000, 24.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3406, -1882.40002441, 908.50000000, 259.60000610, 0.00000000, 0.00000000, 287.99996948, -1, -1, -1, 250);
	CreateDynamicObject(3406, -1886.19995117, 915.40002441, 259.60000610, 0.00000000, 0.00000000, 313.99560547, -1, -1, -1, 250);

	//Bankinteriormap by InternetInk aka Benjamin
	CreateDynamicObject(14789,1424.6903080,-1004.0661620,1643.0186770,0.0000000,0.0000000,89.9999813); //object
	CreateDynamicObject(2774,1433.0262450,-1004.6439210,1635.8198240,0.0000000,0.0000000,0.0000000); //object(1)
	CreateDynamicObject(2774,1429.2969970,-1004.6186520,1641.2811280,0.0000000,0.0000000,0.0000000); //object(2)
	CreateDynamicObject(2774,1440.9570310,-979.6820680,1640.2977290,0.0000000,0.0000000,0.0000000); //object(3)
	CreateDynamicObject(2774,1429.3371580,-979.5452880,1639.7233890,0.0000000,0.0000000,0.0000000); //object(4)
	CreateDynamicObject(2774,1449.3140870,-984.5050050,1648.0231930,0.0000000,0.0000000,0.0000000); //object(5)
	CreateDynamicObject(2774,1413.9140630,-984.5153810,1643.0734860,0.0000000,0.0000000,0.0000000); //object(6)
	CreateDynamicObject(1886,1448.5101320,-1003.6429440,1647.0939940,19.7670439,0.0000000,-136.6416106); //object(8)
	CreateDynamicObject(1886,1414.7065430,-980.6044310,1647.0616460,19.7670439,0.0000000,-316.6416304); //object(9)
	CreateDynamicObject(2774,1430.4168700,-999.0172730,1638.7224120,0.0000000,-90.2407954,0.0000000); //object(19)
	CreateDynamicObject(2774,1408.1492920,-998.9968260,1638.7224120,0.0000000,-90.2407954,-179.9999625); //object(20)
	CreateDynamicObject(2774,1443.5772710,-986.6346440,1638.7233890,0.0000000,-90.2407954,-89.9999813); //object(21)
	CreateDynamicObject(2774,1443.6044920,-998.9981690,1647.7974850,0.0000000,0.0000000,0.0000000); //object(22)
	CreateDynamicObject(11359,1414.3562010,-988.9853520,1639.7958980,0.0000000,0.0000000,89.9999813); //object(26)
	CreateDynamicObject(2774,1413.9273680,-986.0117190,1643.0469970,0.0000000,0.0000000,-89.9999813); //object(27)
	CreateDynamicObject(2774,1413.7636720,-992.0853880,1643.6733400,0.0000000,0.0000000,0.0000000); //object(28)
	CreateDynamicObject(626,1427.5545650,-997.3229980,1640.7664790,0.0000000,0.0000000,134.9999719); //object(31)
	CreateDynamicObject(626,1427.4882810,-990.7525020,1640.8415530,0.0000000,0.0000000,134.9999719); //object(32)
	CreateDynamicObject(2773,1427.7567140,-995.7811890,1639.3101810,0.0000000,0.0000000,0.0000000); //object(33)
	CreateDynamicObject(2773,1427.6949460,-992.8414310,1639.3101810,0.0000000,0.0000000,0.0000000); //object(34)
	CreateDynamicObject(2773,1427.5969240,-989.1286010,1639.3015140,0.0000000,0.0000000,0.0000000); //object(35)
	CreateDynamicObject(2773,1429.8631590,-982.9273680,1639.3101810,0.0000000,0.0000000,89.9999813); //object(36)
	CreateDynamicObject(626,1427.6652830,-983.1286010,1640.8415530,0.0000000,0.0000000,236.2499795); //object(37)
	CreateDynamicObject(2773,1432.7558590,-982.9907840,1639.3101810,0.0000000,0.0000000,89.9999813); //object(38)
	CreateDynamicObject(626,1434.6483150,-983.1889040,1640.8415530,0.0000000,0.0000000,236.2499795); //object(39)
	CreateDynamicObject(2773,1437.0914310,-983.0549930,1639.3101810,0.0000000,0.0000000,89.9999813); //object(40)
	CreateDynamicObject(2773,1440.0402830,-983.0127560,1639.3101810,0.0000000,0.0000000,89.9999813); //object(41)
	CreateDynamicObject(3462,1448.4669190,-993.0144650,1640.2979740,0.0000000,0.0000000,0.0000000); //object(43)
	CreateDynamicObject(3462,1448.5120850,-982.9926150,1640.1815190,0.0000000,0.0000000,0.0000000); //object(44)
	CreateDynamicObject(626,1441.6362300,-997.0477290,1640.7414550,0.0000000,0.0000000,-213.7499842); //object(45)
	CreateDynamicObject(14632,1443.6486820,-995.9346310,1638.6677250,0.0000000,0.0000000,-270.0000011); //object(50)
	CreateDynamicObject(14632,1432.1563720,-1018.0152590,1639.9881590,0.0000000,0.0000000,-89.9999813); //object(51)
	CreateDynamicObject(1514,1432.2949220,-998.8524780,1639.7401120,0.0000000,0.0000000,-180.0000199); //object(52)
	CreateDynamicObject(1514,1438.3525390,-998.8467410,1639.8156740,0.0000000,0.0000000,-180.0000199); //object(53)
	CreateDynamicObject(2773,1435.1838380,-996.7592770,1639.3015140,0.0000000,0.0000000,0.0000000); //object(54)
	CreateDynamicObject(2773,1435.1524660,-993.9325560,1639.3015140,0.0000000,0.0000000,0.0000000); //object(55)
	CreateDynamicObject(2773,1439.3386230,-996.6586910,1639.3015140,0.0000000,0.0000000,0.0000000); //object(56)
	CreateDynamicObject(2773,1439.2889400,-994.0006710,1639.3015140,0.0000000,0.0000000,0.0000000); //object(57)
	CreateDynamicObject(1723,1426.2801510,-994.8635860,1638.7072750,0.0000000,0.0000000,-89.9999813); //object(58)
	CreateDynamicObject(1723,1426.2446290,-991.1504520,1638.7323000,0.0000000,0.0000000,-89.9999813); //object(59)
	CreateDynamicObject(1723,1422.2774660,-996.9350590,1638.6822510,0.0000000,0.0000000,-270.0000011); //object(60)
	CreateDynamicObject(1723,1422.2792970,-993.2100220,1638.6572270,0.0000000,0.0000000,-270.0000011); //object(61)
	CreateDynamicObject(2637,1424.2324220,-992.1735840,1638.8387450,0.0000000,0.0000000,-89.9999813); //object(67)
	CreateDynamicObject(2637,1424.2285160,-995.7041630,1638.8387450,0.0000000,0.0000000,-89.9999813); //object(68)
	CreateDynamicObject(3657,1432.6333010,-987.7390140,1639.2023930,0.0000000,0.0000000,0.0000000); //object(71)
	CreateDynamicObject(3657,1432.6311040,-986.9772340,1639.2023930,0.0000000,0.0000000,-179.9999625); //object(72)
	CreateDynamicObject(3657,1438.1115720,-986.9775390,1639.2023930,0.0000000,0.0000000,-179.9999625); //object(73)
	CreateDynamicObject(3657,1438.0863040,-987.7307130,1639.2274170,0.0000000,0.0000000,-359.9999824); //object(74)
	CreateDynamicObject(2961,1439.0283200,-999.8266600,1639.2113040,0.0000000,0.0000000,0.0000000); //object(68)
	CreateDynamicObject(2961,1433.5056150,-999.8276370,1639.3013920,0.0000000,0.0000000,0.0000000); //object(69)
	CreateDynamicObject(2946,1414.3552250,-990.5134890,1638.7556150,0.0000000,0.0000000,0.0000000); //object(74)
	CreateDynamicObject(2946,1414.3802490,-987.3925170,1638.7550050,0.0000000,0.0000000,-180.0000199); //object(75)
	CreateDynamicObject(2963,1424.1652830,-1004.8156740,1640.7811280,0.0000000,0.0000000,-89.9999813); //object(80)
	CreateDynamicObject(2963,1426.8067630,-1004.8325200,1640.8269040,0.0000000,0.0000000,89.9999813); //object(81)
	CreateDynamicObject(1886,1414.7305910,-993.5230100,1646.9085690,17.1887338,0.0000000,67.4999860); //object(82)
	CreateDynamicObject(2773,1431.4145510,-996.8458250,1639.3015140,0.0000000,0.0000000,0.0000000); //object(87)
	CreateDynamicObject(2773,1431.4733890,-994.0170900,1639.3015140,0.0000000,0.0000000,0.0000000); //object(88)
	CreateDynamicObject(632,1434.7353520,-987.7575070,1639.1312260,0.0000000,0.0000000,-146.2499982); //object(89)
	CreateDynamicObject(2942,1417.7136230,-980.4751590,1639.3635250,0.0000000,0.0000000,0.0000000); //object(62)
	CreateDynamicObject(1216,1443.2813720,-989.3112790,1639.3878170,0.0000000,0.0000000,-89.9999813); //object(67)
	CreateDynamicObject(2942,1421.2171630,-980.4489140,1639.3854980,0.0000000,0.0000000,0.0000000); //object(68)
	CreateDynamicObject(2942,1424.6304930,-980.5266720,1639.3714600,0.0000000,0.0000000,0.0000000); //object(69)
	CreateDynamicObject(1216,1443.2778320,-991.4248660,1639.4241940,0.0000000,0.0000000,-89.9999813); //object(70)
	CreateDynamicObject(1216,1443.2512210,-987.2781980,1639.3762210,0.0000000,0.0000000,-89.9999813); //object(71)
	CreateDynamicObject(1216,1443.2597660,-985.4849850,1639.3762210,0.0000000,0.0000000,-89.9999813); //object(72)
	CreateDynamicObject(2773,1441.2286380,-993.0429690,1639.3015140,0.0000000,0.0000000,-89.9999813); //object(73)
	CreateDynamicObject(2824,1424.2972410,-992.0549320,1639.2476810,0.0000000,0.0000000,78.7500123); //object(79)

    // Bayside Stunts
	CreateDynamicObject(4867, -2496.50317400, 1493.93518100, 6.21204600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2283.92578100, 1493.94250500, 6.23400300, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2643.26806600, 1540.50549300, 6.20900100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2593.52026400, 1495.30346700, 6.43715900, -9.45380362, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2601.04516600, 1495.72863800, 9.71637300, 10.31324031, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2607.00219700, 1496.05871600, 15.55436500, 31.79915763, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2611.13867200, 1496.29541000, 23.08758400, 45.55008742, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2612.85937500, 1496.38391100, 31.39300900, 65.31713135, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2611.94433600, 1496.33007800, 39.86068700, 81.64642851, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2608.06689500, 1496.11523400, 47.68529900, 104.85116192, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2602.26782200, 1495.82775900, 53.20772200, 122.89938976, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2594.58789100, 1495.39428700, 56.54681800, 144.38547897, 0.00000000, 86.80310596, 2, -1, -1, 250);
	CreateDynamicObject(5400, -2491.75048800, 1378.06591800, 16.19568300, -1.71887339, 13.75098708, -269.00351293, 2, -1, -1, 250);
	CreateDynamicObject(5400, -2491.46948200, 1368.93261700, 16.32068800, 0.00000000, 11.17267701, -269.00351293, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2436.10327100, 1443.43127400, 16.53265400, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2431.67211900, 1443.26135300, 22.46527300, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2427.25488300, 1443.11157200, 28.35384400, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2422.89990200, 1442.96740700, 34.21810200, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2418.60522500, 1442.83898900, 40.00857500, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2414.48901400, 1442.69006300, 45.49087500, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2410.02783200, 1442.54382300, 51.45611600, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2405.96606400, 1442.43579100, 56.94336700, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2401.80908200, 1442.32043500, 62.55844900, 54.14445434, -0.85943669, -77.34930234, 2, -1, -1, 250);
	CreateDynamicObject(4113, -2385.24047900, 1421.18945300, 19.51260800, 0.00000000, 0.00000000, 25.78310078, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2440.80273400, 1410.91076700, 65.10725400, 0.00000000, 14.61042378, 12.89155039, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2410.79834000, 1417.78076200, 57.11988800, 0.00000000, 8.59436693, 12.89155039, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2498.15869100, 1397.98901400, 74.02177400, 0.00000000, 0.00000000, 12.89155039, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2536.67456100, 1389.17761200, 74.02177400, 0.00000000, 0.00000000, 12.89155039, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2562.20166000, 1401.31091300, 74.02183500, 0.00000000, 0.00000000, -74.77099226, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2556.81543000, 1435.72094700, 74.02185100, 0.00000000, 0.00000000, -122.04006766, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2539.92993200, 1461.52710000, 78.11851500, 0.00000000, 14.61042378, -122.89950435, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2497.30908200, 1527.38366700, 87.57210500, 0.00000000, -0.85943669, -122.89950435, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2470.25927700, 1565.76782200, 96.45918300, 0.00000000, 4.29718346, -28.36141086, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2466.06811500, 1571.36340300, 96.39400500, 0.00000000, 4.29718346, -28.36141086, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2464.35180700, 1573.57690400, 96.43020600, 0.00000000, 4.29718346, -30.93972094, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2460.56323200, 1578.09753400, 96.03833800, 0.00000000, 4.29718346, -37.81521448, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2456.00610400, 1581.81384300, 96.14119700, 0.00000000, 4.29718346, -45.55014471, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2451.65112300, 1584.37793000, 95.95419300, 0.00000000, 4.29718346, -53.28501765, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2445.97387700, 1587.19787600, 95.66107900, 0.00000000, 4.29718346, -59.30107450, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2440.64526400, 1589.22937000, 95.50098400, 0.00000000, 4.29718346, -68.75487812, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2435.27587900, 1590.35949700, 95.39059400, 0.00000000, 4.29718346, -78.20868174, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2430.05786100, 1590.34960900, 95.32445500, 0.00000000, 4.29718346, -89.38135874, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2423.97168000, 1589.34777800, 95.19424400, 0.00000000, 4.29718346, -96.25685229, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2418.84692400, 1587.68286100, 95.04930100, 0.00000000, 4.29718346, -107.42952929, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2414.17260700, 1585.26452600, 94.90703600, 0.00000000, 4.29718346, -119.46164299, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2410.31591800, 1582.10107400, 94.51336700, 0.00000000, 4.29718346, -127.19663052, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2421.52270500, 1559.30859400, 82.92859600, 0.00000000, 0.00000000, -127.19668782, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2444.52368200, 1529.01403800, 91.00360100, 0.00000000, -24.06422740, -127.19668782, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2466.68969700, 1499.80700700, 107.38198900, 0.00000000, -24.06422740, -127.19668782, 2, -1, -1, 250);
	CreateDynamicObject(3458, -2489.64233400, 1469.57360800, 117.89114400, 0.00000000, -6.87549354, -127.19668782, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2509.71313500, 1443.14025900, 123.27673300, 0.00000000, 0.00000000, -37.81521448, 2, -1, -1, 250);
	CreateDynamicObject(978, -2504.42602500, 1450.09533700, 121.71204400, 82.50586520, 0.00000000, 52.42563825, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2514.81713900, 1436.70251500, 123.28359200, 0.00000000, 0.00000000, -37.81521448, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2519.94506800, 1430.19287100, 124.18948400, -12.03211370, 0.00000000, -37.81521448, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2525.08105500, 1423.72912600, 125.94278000, -12.03211370, 0.00000000, -37.81521448, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2549.75488300, 1386.62085000, 124.48600800, 0.00000000, 0.85943669, -122.89950435, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2577.21752900, 1352.22412100, 125.18570700, -0.85943669, 0.00000000, -213.99990837, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2570.11279300, 1347.42541500, 125.18398300, -0.85943669, 0.00000000, -213.99990837, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2352.58178700, 1436.02172900, 7.20911200, 0.00000000, 0.00000000, 101.41352974, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2359.22168000, 1434.68371600, 11.28502300, 17.18873385, 0.00000000, 101.41352974, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2364.05004900, 1433.71716300, 16.93981600, 35.23690440, 0.00000000, 101.41352974, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2367.05639600, 1433.11035200, 23.81386800, 51.56614427, 0.00000000, 101.41352974, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2368.30151400, 1432.89697300, 31.43089900, 65.31713135, 0.00000000, 100.55409305, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2440.12622100, 1525.76684600, 14.53716000, 32.65859432, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2440.13061500, 1520.74877900, 9.11215400, 16.32929716, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2440.14697300, 1515.98962400, 6.46385300, -4.29718346, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2448.90576200, 1515.99316400, 6.46215500, -4.29718346, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2448.90551800, 1520.23474100, 8.59044500, 16.32929716, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2448.88720700, 1525.69555700, 14.40485400, 32.65859432, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2568.26293900, 1560.48547400, 5.02719100, 0.00000000, 5.15662016, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2603.00341800, 1560.51513700, 9.90021400, 0.00000000, 13.75098708, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2605.34643600, 1560.50610400, 12.04363100, 0.00000000, 22.34535401, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2606.34790000, 1560.52258300, 13.53515000, 0.00000000, 31.79915763, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2608.22973600, 1560.48815900, 15.33407900, 0.00000000, 41.25296125, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2611.35400400, 1560.50524900, 18.66585900, 0.00000000, 53.28501765, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2613.68042000, 1560.52465800, 21.57613800, 0.00000000, 62.73882127, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2616.73559600, 1560.51843300, 26.40927500, 0.00000000, 73.05206158, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2618.70312500, 1560.49292000, 31.68276200, 0.00000000, 84.22473859, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2619.15332000, 1560.53015100, 43.60558700, 0.00000000, 92.81910552, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2618.71655300, 1560.50647000, 48.05213500, 0.00000000, 99.69459906, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2617.70996100, 1560.52111800, 53.00725600, 0.00000000, 108.28890869, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2614.54418900, 1560.53454600, 60.80430600, 0.00000000, 115.16440223, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2615.28955100, 1560.51757800, 59.85616700, 0.00000000, 122.89938976, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2612.45507800, 1560.53588900, 64.66555800, 0.00000000, 132.35325067, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2604.49829100, 1560.52063000, 72.46235700, 0.00000000, 141.80716889, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2603.67944300, 1560.53906300, 73.09350600, 0.00000000, 152.97990319, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2604.11303700, 1560.53979500, 73.46821600, 0.00000000, 160.71489072, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2599.78759800, 1560.55419900, 75.77787000, 0.00000000, 172.74706171, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2593.42138700, 1560.26794400, 76.88247700, 0.00000000, 179.62261255, 6.01605685, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2586.93310500, 1560.95312500, 77.11678300, 0.00000000, 187.35760008, 6.01605685, 2, -1, -1, 250);
	CreateDynamicObject(17565, -2241.95971700, 1462.33654800, 8.21772100, 0.00000000, 0.00000000, -92.81916281, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2291.15405300, 1518.89538600, 11.19429100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2272.39697300, 1515.18090800, 11.41928400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2280.85180700, 1529.35620100, 11.41928400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2283.66284200, 1508.69311500, 11.44417800, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2331.49877900, 1466.70239300, 7.65324600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13636, -2285.37475600, 1450.65026900, 8.21439900, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13604, -2231.28271500, 1528.25842300, 7.86702000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13590, -2210.42187500, 1469.43469200, 7.33484500, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(12956, -2520.45043900, 1449.97656300, 9.34028800, 0.00000000, 0.00000000, 3.43774677, 2, -1, -1, 250);
	CreateDynamicObject(8375, -2375.99511700, 1489.67236300, 8.14274600, 0.00000000, 0.00000000, -91.10028943, 2, -1, -1, 250);
	CreateDynamicObject(1681, -2552.48950200, 1422.18164100, 10.69007100, 30.93972094, -0.85943669, 34.37746771, 2, -1, -1, 250);
	CreateDynamicObject(3627, -2446.77978500, 1416.58007800, 9.95153400, 0.00000000, 0.00000000, -127.19668782, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2476.21337900, 1444.63891600, 7.23715700, 0.00000000, 0.00000000, -132.35342256, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2472.17480500, 1440.95056200, 10.23288500, 12.03211370, 0.00000000, -132.35342256, 2, -1, -1, 250);
	CreateDynamicObject(8172, -2618.06323200, 1645.29431200, 10.75335900, 0.00000000, -14.61042378, 90.24085273, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2644.52734400, 1756.41333000, 15.77159900, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(8172, -2458.40893600, 1645.53271500, 10.60427500, 0.00000000, -14.61042378, 90.24085273, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2432.11401400, 1756.40100100, 15.71855400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(8038, -2697.78637700, 1707.55310100, 35.58687600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(8550, -2601.60376000, 1716.87402300, 19.79468500, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(10757, -2659.12085000, 1693.46594200, 18.16287200, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(10763, -2359.91406300, 1701.53259300, 47.55012100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(10815, -2466.16577100, 2144.36645500, -4.11317900, 6.87549354, 6.87549354, 135.55012599, 2, -1, -1, 250);
	CreateDynamicObject(16098, -2529.92871100, 1702.05127000, 11.98208600, 0.00000000, 0.00000000, -91.10028943, 2, -1, -1, 250);
	CreateDynamicObject(1682, -2534.92065400, 1736.60473600, 22.14777000, 0.00000000, 0.00000000, -226.03202207, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2684.33471700, 1763.41076700, 16.72171600, 0.00000000, 0.00000000, -204.54616204, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2686.63916000, 1758.33715800, 20.28698300, 21.48591732, 0.00000000, -204.54616204, 2, -1, -1, 250);
	CreateDynamicObject(18284, -2743.93847700, 1770.46423300, 18.59144000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18284, -2743.93725600, 1753.34606900, 18.59144000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(7617, -2565.81958000, 1626.91772500, 17.21826600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2658.06250000, 1675.42724600, 27.34220500, 0.00000000, 44.69070802, -19.76704393, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2671.34057600, 1736.45336900, 27.34220500, 0.00000000, 44.69070802, 22.34535401, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2658.85083000, 1679.37011700, 16.69549800, 0.00000000, 0.00000000, 69.61437211, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2674.82959000, 1738.91894500, 16.67171700, 0.00000000, 0.00000000, 111.72671275, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2480.28613300, 1698.57495100, 16.61866600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2416.19067400, 1604.02954100, 6.10585100, -9.45380362, 0.00000000, -62.73887857, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2409.65502900, 1607.40026900, 9.37003500, 12.03211370, 0.00000000, -62.73887857, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2404.21386700, 1610.20056200, 14.84730700, 26.64253747, 0.00000000, -62.73887857, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2400.66235400, 1612.03442400, 20.96555900, 42.11239794, 0.00000000, -62.73887857, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2399.10498000, 1612.83349600, 26.37451400, 55.00389104, 0.00000000, -62.73887857, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2565.26904300, 1627.04699700, 27.88660400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1634, -2566.16601600, 1682.68908700, 16.56891600, 0.00000000, 0.00000000, -181.34125675, 2, -1, -1, 250);
	CreateDynamicObject(1634, -2566.29541000, 1677.78564500, 19.80707200, 14.61042378, 0.00000000, -181.34125675, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2424.99340800, 1680.72814900, 19.02746600, -25.78310078, 0.00000000, 57.58225841, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2429.18530300, 1677.10620100, 19.02747500, -25.78310078, 0.00000000, 24.06422740, 2, -1, -1, 250);
	CreateDynamicObject(3865, -2424.23315400, 1687.32385300, 19.05247300, -25.78310078, 0.00000000, 108.28908058, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2350.51611300, 1853.14270000, 25.31267400, 0.00000000, 0.00000000, 14.68777308, 2, -1, -1, 250);
	CreateDynamicObject(7073, -2397.60937500, 1613.30932600, 47.66366600, 0.00000000, 0.00000000, 27.50197417, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2580.57568400, 1428.64331100, 15.78265400, 0.00000000, 0.00000000, 55.00394833, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2286.92968800, 1414.78698700, 16.02963800, 0.00000000, 0.00000000, 96.25690958, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2280.61572300, 1414.50207500, 16.07906300, 0.00000000, 0.00000000, 96.25690958, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2273.66040000, 1414.21484400, 16.06070700, 0.00000000, 0.00000000, 96.25690958, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2266.49755900, 1413.93225100, 16.05227500, 0.00000000, 0.00000000, 96.25690958, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2259.10229500, 1413.61804200, 16.03500400, 0.00000000, 0.00000000, 96.25690958, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2256.96533200, 1400.67370600, 6.45911500, -6.01605685, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2253.56518600, 1400.67529300, 6.45911600, -6.01605685, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2256.93408200, 1395.05590800, 9.02391800, 9.45380362, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2253.58032200, 1395.06604000, 9.01775600, 9.45380362, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2563.02099600, 1317.27600100, 121.61679100, 0.00000000, 0.85943669, -33.51808831, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2566.58960000, 1311.98059100, 124.79761500, -89.38141604, 0.85943669, -32.65865162, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2566.68139600, 1311.98364300, 138.64357000, -89.38141604, 0.85943669, -32.65865162, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2532.63818400, 1300.19970700, 131.12338300, 61.87938458, 46.40958141, -116.88339021, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2529.41992200, 1297.73315400, 136.96096800, 61.87938458, 46.40958141, -116.88339021, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2526.29003900, 1295.30468800, 142.68057300, 61.87938458, 46.40958141, -116.88339021, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2522.94287100, 1292.75878900, 148.70774800, 61.87938458, 46.40958141, -116.88339021, 2, -1, -1, 250);
	CreateDynamicObject(4726, -2504.49145500, 1274.46435500, 139.39189100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2431.52319300, 1442.08935500, 7.51215800, 12.03211370, 24.06422740, -134.93173264, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2530.63671900, 1295.98669400, 121.92248500, 0.00000000, 6.87549354, -165.01207418, 2, -1, -1, 250);
	CreateDynamicObject(8172, -2289.55249000, 1705.22863800, 15.63791800, 0.00000000, -0.85943669, 33.99089308, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2253.51391600, 1621.30102500, 18.48382000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2250.42309600, 1599.81506300, 18.67326700, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2249.07348600, 1580.04541000, 13.39430000, 17.18873385, 1.71887339, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2250.76391600, 1567.24841300, 10.16930300, 6.01605685, 2.57831008, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2229.57006800, 1633.55090300, 20.20821000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2222.92895500, 1611.93457000, 19.72282600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2219.59863300, 1589.06311000, 18.82422300, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2213.92309600, 1574.17395000, 15.37283100, 6.01605685, 2.57831008, 2.57831008, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2212.97290000, 1558.55395500, 10.01625400, 0.85943669, 0.85943669, 2.57831008, 2, -1, -1, 250);
	CreateDynamicObject(4113, -2171.89477500, 1421.36901900, 13.22123000, 0.00000000, 0.00000000, -78.75001226, 2, -1, -1, 250);
	CreateDynamicObject(4113, -2170.43603500, 1459.74401900, 13.08762200, 0.00000000, 0.00000000, -78.75001226, 2, -1, -1, 250);
	CreateDynamicObject(8881, -2159.96752900, 1507.68017600, 32.77926600, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(8881, -2163.28662100, 1583.89123500, 32.86023700, 0.00000000, 0.00000000, -112.49997660, 2, -1, -1, 250);
	CreateDynamicObject(9078, -2358.29589800, 1644.70031700, 20.57994800, 0.00000000, 0.00000000, -22.49999532, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2335.53808600, 1615.41833500, 19.26340100, 0.00000000, 0.00000000, 219.07018379, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2295.71289100, 1574.48852500, 7.28411400, 0.00000000, 0.00000000, 46.02300678, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2299.51855500, 1578.15014600, 10.30911400, 14.61042378, 0.00000000, 46.02300678, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2228.08667000, 1424.97912600, 7.23411400, 0.00000000, 0.00000000, -89.83645912, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2221.26025400, 1425.00122100, 11.34324800, 16.32929716, 0.00000000, -89.83645912, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2215.59033200, 1425.02978500, 17.80422000, 35.23690440, 0.00000000, -89.83645912, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2217.68310500, 1521.45349100, 7.28411400, 0.00000000, 0.00000000, -63.82136773, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2212.50024400, 1524.02795400, 11.09009900, 19.76704393, 0.00000000, -63.82136773, 2, -1, -1, 250);
	CreateDynamicObject(3627, -2322.67724600, 1703.64892600, 19.55804100, 0.85943669, 85.94366927, -179.14946400, 2, -1, -1, 250);
	CreateDynamicObject(3627, -2342.82080100, 1672.84533700, 20.08303300, 0.85943669, 85.94366927, -246.64950725, 2, -1, -1, 250);
	CreateDynamicObject(981, -2750.07031300, 1829.59411600, 16.72308500, 0.00000000, 0.00000000, -89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(981, -2750.25488300, 1797.77465800, 16.64808700, 0.00000000, 0.00000000, -89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(981, -2750.02807600, 1726.04296900, 16.59808700, 0.00000000, 0.00000000, -89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(981, -2750.00439500, 1689.22314500, 16.67308600, 0.00000000, 0.00000000, -89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(981, -2728.24707000, 1666.25561500, 16.69808600, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(4113, -2207.83593800, 1388.64257800, 13.16573300, 0.00000000, 0.00000000, -168.74999354, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2296.46582000, 1584.87023900, 9.66052200, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2274.33422900, 1717.05419900, 19.35249100, 0.00000000, 0.00000000, -56.25001695, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2304.56884800, 1691.95654300, 18.34814800, 0.00000000, 0.00000000, -56.25001695, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2500.05664100, 1636.05395500, 6.19370400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(3998, -2381.77758800, 1607.26904300, 6.80607600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(979, -2377.62866200, 1631.65026900, 7.65327400, -0.85943669, -14.61042378, 89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(979, -2377.67529300, 1640.47485400, 9.94251400, -0.85943669, -14.61042378, 89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(979, -2377.72631800, 1649.37219200, 12.28471900, -0.85943669, -14.61042378, 89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2432.99218800, 1938.83544900, 15.71703700, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2326.65478500, 1860.85583500, 19.09507200, 0.00000000, 0.00000000, -89.14054458, 2, -1, -1, 250);
	CreateDynamicObject(980, -2322.78540000, 1780.09021000, 18.51182900, 0.00000000, 0.00000000, 33.75002163, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2327.91162100, 1950.81811500, 19.09355700, 0.00000000, 0.00000000, -89.14054458, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2668.11499000, 1846.83703600, 19.07160900, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2466.06811500, 2185.40087900, 2.50829800, 0.00000000, 0.00000000, 89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2469.43823200, 2212.61474600, 3.65948400, -7.73493023, 0.00000000, -179.99996255, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2461.88793900, 2212.59350600, 3.65948600, -7.73493023, 0.00000000, -179.99996255, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2462.96044900, 2205.61499000, 3.30215800, -2.57831008, 0.00000000, -359.99998240, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2469.04199200, 2205.60986300, 3.30215900, -2.57831008, 0.00000000, -359.99998240, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2619.51220700, 1846.78540000, 19.07311600, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2539.37890600, 1926.68432600, 19.06855800, 0.00000000, 0.00000000, -270.00005842, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2539.37085000, 1947.19360400, 19.10112800, 0.00000000, 0.00000000, -270.00005842, 2, -1, -1, 250);
	CreateDynamicObject(8881, -2514.20727500, 2033.01684600, 41.16826200, 0.00000000, 0.00000000, -56.25001695, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2406.32543900, 2029.93225100, 19.11854900, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2466.02954100, 2042.25744600, 16.67577700, -2.57831008, 0.00000000, -539.99994495, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2457.51416000, 2042.25537100, 16.67026100, -2.57831008, 0.00000000, -539.99994495, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2474.67187500, 2042.24755900, 16.68396400, -2.57831008, 0.00000000, -539.99994495, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2457.52441400, 2036.00280800, 20.34683400, 16.32929716, 0.00000000, -539.99994495, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2466.20727500, 2035.99658200, 20.34813300, 16.32929716, 0.00000000, -539.99994495, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2474.65722700, 2035.99865700, 20.34727300, 16.32929716, 0.00000000, -539.99994495, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2457.88867200, 2017.75732400, 16.54215600, -2.57831008, 0.00000000, -719.99973562, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2466.59960900, 2017.77710000, 16.55386000, -2.57831008, 0.00000000, -719.99973562, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2475.26879900, 2017.76013200, 16.54214900, -2.57831008, 0.00000000, -719.99973562, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2457.85766600, 2024.61145000, 20.52343800, 16.32929716, 0.00000000, -719.99973562, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2466.57739300, 2024.59838900, 20.51314200, 16.32929716, 0.00000000, -719.99973562, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2475.29565400, 2024.58374000, 20.49213800, 16.32929716, 0.00000000, -719.99973562, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2351.34301800, 1860.46362300, 25.24927500, 0.00000000, 0.00000000, 14.68777308, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2352.12280300, 1867.60998500, 25.21322300, 0.00000000, 0.00000000, 14.68777308, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2352.92358400, 1874.77160600, 25.19802900, 0.00000000, 0.00000000, 14.68777308, 2, -1, -1, 250);
	CreateDynamicObject(16141, -2370.03442400, 1994.37707500, 9.93600500, 0.00000000, 0.00000000, 22.49999532, 2, -1, -1, 250);
	CreateDynamicObject(4113, -2348.94921900, 2013.45874000, 46.74564400, 0.00000000, 0.00000000, -29.37548886, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2516.36816400, 1908.47106900, 16.79215200, 0.00000000, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2515.94799800, 1915.79321300, 21.09610900, 15.46986047, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2515.61987300, 1921.56652800, 27.27491200, 32.65859432, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2515.42187500, 1925.17419400, 34.75223200, 49.84727088, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2515.36084000, 1926.46362300, 42.79791600, 66.17656804, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2515.41430700, 1925.48925800, 51.24845500, 81.64642851, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2515.60205100, 1922.29064900, 58.70184700, 98.83516236, 0.00000000, -3.35145933, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2515.09130900, 1870.69653300, 52.54665800, 0.00000000, -0.85943669, -89.14948272, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2513.91308600, 1792.01757800, 53.72429300, 0.00000000, -0.85943669, -89.14948272, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2512.78247100, 1714.90380900, 62.43978500, 0.00000000, -12.03211370, -89.14948272, 2, -1, -1, 250);
	CreateDynamicObject(979, -2510.95336900, 1591.20813000, 72.12216200, 88.52197935, 0.85943669, 89.99998128, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2511.61059600, 1635.88049300, 71.37384000, 0.00000000, -0.85943669, -89.14948272, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2510.79174800, 1582.33349600, 73.21195200, 0.00000000, 0.00000000, -179.99996255, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2510.79589800, 1575.40344200, 77.68489100, 19.76704393, 0.00000000, -179.99996255, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2581.06054700, 1815.82885700, 20.84320800, 0.00000000, -143.52592768, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2618.98339800, 1815.71264600, 20.84320800, 0.00000000, -143.52592768, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2411.89550800, 1847.90551800, 20.79016300, 0.00000000, -143.52592768, -134.99997191, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2508.07153300, 1952.46020500, 20.78864700, 0.00000000, -143.52592768, -56.24995965, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2385.47021500, 1958.42956500, 20.78864700, 0.00000000, -143.52592768, -134.99997191, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2538.55102500, 1844.21984900, 20.79016300, 0.00000000, -143.52592768, -56.24995965, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2390.33569300, 1845.88195800, 20.79016300, 0.00000000, -143.52592768, -56.24995965, 2, -1, -1, 250);
	CreateDynamicObject(17310, -2545.48339800, 1854.42553700, 49.90680700, 0.00000000, -82.50575061, -56.24995965, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2480.34106400, 1704.98071300, 16.64367100, 0.00000000, 0.00000000, -179.99996255, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2749.53515600, 1548.79846200, 9.38552300, 0.00000000, 0.00000000, -270.00000112, 2, -1, -1, 250);
	CreateDynamicObject(16304, -2741.26513700, 1458.43347200, 10.70900500, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2451.87353500, 1887.97253400, 31.41024000, 0.00000000, 24.92366409, -100.39950903, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2438.95214800, 1958.43737800, 64.68127400, 0.00000000, 24.92366409, -100.39950903, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2425.95556600, 2029.29174800, 98.13073700, 0.00000000, 24.92366409, -100.39950903, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2413.01977500, 2099.82055700, 131.43817100, 0.00000000, 24.92366409, -100.39950903, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2400.10595700, 2170.25366200, 164.69830300, 0.00000000, 24.92366409, -100.39950903, 2, -1, -1, 250);
	CreateDynamicObject(8661, -2387.81787100, 2214.84619100, 181.85632300, 0.00000000, 0.00000000, -10.39058961, 2, -1, -1, 250);
	CreateDynamicObject(8661, -2385.98828100, 2224.92480500, 191.75453200, 88.52197935, 0.00000000, -10.39058961, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2382.67871100, 2164.28515600, 181.47425800, 0.00000000, 0.00000000, -96.95282412, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2390.86181600, 2096.63208000, 153.41119400, 0.00000000, 44.69070802, -96.95282412, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2397.60839800, 2041.10229500, 98.05860900, 0.00000000, 44.69070802, -96.95282412, 2, -1, -1, 250);
	CreateDynamicObject(18450, -2401.22241200, 2011.35546900, 68.43663800, 0.00000000, 44.69070802, -96.95282412, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2404.82714800, 1979.58630400, 37.17559400, -58.44163781, 0.00000000, -186.78922594, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2405.69628900, 1972.15710400, 33.28480500, -42.11239794, 0.00000000, -186.78922594, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2406.67309600, 1963.88793900, 31.63486100, -25.78310078, 0.00000000, -186.78922594, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2407.68945300, 1955.31176800, 32.77016800, -5.15662016, 0.00000000, -186.78922594, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2408.59350600, 1947.65942400, 36.40678400, 10.31324031, 0.00000000, -186.78922594, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2409.34472700, 1941.33007800, 42.16977300, 28.36141086, 0.00000000, -186.78922594, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2395.74658200, 1735.86486800, 16.71867000, 0.00000000, 0.00000000, -149.60145755, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2392.51586900, 1730.37207000, 20.53613700, 16.32929716, 0.00000000, -149.60145755, 2, -1, -1, 250);
	CreateDynamicObject(981, -2733.84985400, 1630.84668000, 7.08548700, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(981, -2713.89379900, 1630.84497100, 7.06048800, 0.00000000, 0.00000000, -180.00001985, 2, -1, -1, 250);
	CreateDynamicObject(981, -2697.75561500, 1648.88195800, 12.68133500, 0.00000000, -13.75098708, -269.06321513, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2453.25976600, 1717.52819800, 17.28780000, 0.00000000, 0.00000000, 67.49998596, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2444.85522500, 1741.38012700, 17.11797300, 0.00000000, 0.00000000, 247.49994851, 2, -1, -1, 250);
	
	//Baysidestunt
	CreateDynamicObject(4867, -2496.50317400, 1493.93518100, 6.21204600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(4867, -2283.92578100, 1493.94250500, 6.23400300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(4867, -2643.26806600, 1540.50549300, 6.20900100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2593.52026400, 1495.30346700, 6.43715900, -9.45380362, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2601.04516600, 1495.72863800, 9.71637300, 10.31324031, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2607.00219700, 1496.05871600, 15.55436500, 31.79915763, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2611.13867200, 1496.29541000, 23.08758400, 45.55008742, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2612.85937500, 1496.38391100, 31.39300900, 65.31713135, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2611.94433600, 1496.33007800, 39.86068700, 81.64642851, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2608.06689500, 1496.11523400, 47.68529900, 104.85116192, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2602.26782200, 1495.82775900, 53.20772200, 122.89938976, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2594.58789100, 1495.39428700, 56.54681800, 144.38547897, 0.00000000, 86.80310596, -1, -1, -1, 250);
	CreateDynamicObject(5400, -2491.75048800, 1378.06591800, 16.19568300, -1.71887339, 13.75098708, -269.00351293, -1, -1, -1, 250);
	CreateDynamicObject(5400, -2491.46948200, 1368.93261700, 16.32068800, 0.00000000, 11.17267701, -269.00351293, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2436.10327100, 1443.43127400, 16.53265400, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2431.67211900, 1443.26135300, 22.46527300, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2427.25488300, 1443.11157200, 28.35384400, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2422.89990200, 1442.96740700, 34.21810200, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2418.60522500, 1442.83898900, 40.00857500, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2414.48901400, 1442.69006300, 45.49087500, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2410.02783200, 1442.54382300, 51.45611600, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2405.96606400, 1442.43579100, 56.94336700, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2401.80908200, 1442.32043500, 62.55844900, 54.14445434, -0.85943669, -77.34930234, -1, -1, -1, 250);
	CreateDynamicObject(4113, -2385.24047900, 1421.18945300, 19.51260800, 0.00000000, 0.00000000, 25.78310078, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2440.80273400, 1410.91076700, 65.10725400, 0.00000000, 14.61042378, 12.89155039, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2410.79834000, 1417.78076200, 57.11988800, 0.00000000, 8.59436693, 12.89155039, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2498.15869100, 1397.98901400, 74.02177400, 0.00000000, 0.00000000, 12.89155039, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2536.67456100, 1389.17761200, 74.02177400, 0.00000000, 0.00000000, 12.89155039, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2562.20166000, 1401.31091300, 74.02183500, 0.00000000, 0.00000000, -74.77099226, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2556.81543000, 1435.72094700, 74.02185100, 0.00000000, 0.00000000, -122.04006766, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2539.92993200, 1461.52710000, 78.11851500, 0.00000000, 14.61042378, -122.89950435, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2497.30908200, 1527.38366700, 87.57210500, 0.00000000, -0.85943669, -122.89950435, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2470.25927700, 1565.76782200, 96.45918300, 0.00000000, 4.29718346, -28.36141086, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2466.06811500, 1571.36340300, 96.39400500, 0.00000000, 4.29718346, -28.36141086, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2464.35180700, 1573.57690400, 96.43020600, 0.00000000, 4.29718346, -30.93972094, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2460.56323200, 1578.09753400, 96.03833800, 0.00000000, 4.29718346, -37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2456.00610400, 1581.81384300, 96.14119700, 0.00000000, 4.29718346, -45.55014471, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2451.65112300, 1584.37793000, 95.95419300, 0.00000000, 4.29718346, -53.28501765, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2445.97387700, 1587.19787600, 95.66107900, 0.00000000, 4.29718346, -59.30107450, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2440.64526400, 1589.22937000, 95.50098400, 0.00000000, 4.29718346, -68.75487812, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2435.27587900, 1590.35949700, 95.39059400, 0.00000000, 4.29718346, -78.20868174, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2430.05786100, 1590.34960900, 95.32445500, 0.00000000, 4.29718346, -89.38135874, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2423.97168000, 1589.34777800, 95.19424400, 0.00000000, 4.29718346, -96.25685229, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2418.84692400, 1587.68286100, 95.04930100, 0.00000000, 4.29718346, -107.42952929, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2414.17260700, 1585.26452600, 94.90703600, 0.00000000, 4.29718346, -119.46164299, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2410.31591800, 1582.10107400, 94.51336700, 0.00000000, 4.29718346, -127.19663052, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2421.52270500, 1559.30859400, 82.92859600, 0.00000000, 0.00000000, -127.19668782, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2444.52368200, 1529.01403800, 91.00360100, 0.00000000, -24.06422740, -127.19668782, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2466.68969700, 1499.80700700, 107.38198900, 0.00000000, -24.06422740, -127.19668782, -1, -1, -1, 250);
	CreateDynamicObject(3458, -2489.64233400, 1469.57360800, 117.89114400, 0.00000000, -6.87549354, -127.19668782, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2509.71313500, 1443.14025900, 123.27673300, 0.00000000, 0.00000000, -37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(978, -2504.42602500, 1450.09533700, 121.71204400, 82.50586520, 0.00000000, 52.42563825, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2514.81713900, 1436.70251500, 123.28359200, 0.00000000, 0.00000000, -37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2519.94506800, 1430.19287100, 124.18948400, -12.03211370, 0.00000000, -37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2525.08105500, 1423.72912600, 125.94278000, -12.03211370, 0.00000000, -37.81521448, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2549.75488300, 1386.62085000, 124.48600800, 0.00000000, 0.85943669, -122.89950435, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2577.21752900, 1352.22412100, 125.18570700, -0.85943669, 0.00000000, -213.99990837, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2570.11279300, 1347.42541500, 125.18398300, -0.85943669, 0.00000000, -213.99990837, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2352.58178700, 1436.02172900, 7.20911200, 0.00000000, 0.00000000, 101.41352974, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2359.22168000, 1434.68371600, 11.28502300, 17.18873385, 0.00000000, 101.41352974, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2364.05004900, 1433.71716300, 16.93981600, 35.23690440, 0.00000000, 101.41352974, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2367.05639600, 1433.11035200, 23.81386800, 51.56614427, 0.00000000, 101.41352974, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2368.30151400, 1432.89697300, 31.43089900, 65.31713135, 0.00000000, 100.55409305, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2440.12622100, 1525.76684600, 14.53716000, 32.65859432, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2440.13061500, 1520.74877900, 9.11215400, 16.32929716, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2440.14697300, 1515.98962400, 6.46385300, -4.29718346, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2448.90576200, 1515.99316400, 6.46215500, -4.29718346, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2448.90551800, 1520.23474100, 8.59044500, 16.32929716, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2448.88720700, 1525.69555700, 14.40485400, 32.65859432, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2568.26293900, 1560.48547400, 5.02719100, 0.00000000, 5.15662016, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2603.00341800, 1560.51513700, 9.90021400, 0.00000000, 13.75098708, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2605.34643600, 1560.50610400, 12.04363100, 0.00000000, 22.34535401, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2606.34790000, 1560.52258300, 13.53515000, 0.00000000, 31.79915763, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2608.22973600, 1560.48815900, 15.33407900, 0.00000000, 41.25296125, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2611.35400400, 1560.50524900, 18.66585900, 0.00000000, 53.28501765, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2613.68042000, 1560.52465800, 21.57613800, 0.00000000, 62.73882127, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2616.73559600, 1560.51843300, 26.40927500, 0.00000000, 73.05206158, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2618.70312500, 1560.49292000, 31.68276200, 0.00000000, 84.22473859, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2619.15332000, 1560.53015100, 43.60558700, 0.00000000, 92.81910552, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2618.71655300, 1560.50647000, 48.05213500, 0.00000000, 99.69459906, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2617.70996100, 1560.52111800, 53.00725600, 0.00000000, 108.28890869, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2614.54418900, 1560.53454600, 60.80430600, 0.00000000, 115.16440223, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2615.28955100, 1560.51757800, 59.85616700, 0.00000000, 122.89938976, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2612.45507800, 1560.53588900, 64.66555800, 0.00000000, 132.35325067, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2604.49829100, 1560.52063000, 72.46235700, 0.00000000, 141.80716889, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2603.67944300, 1560.53906300, 73.09350600, 0.00000000, 152.97990319, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2604.11303700, 1560.53979500, 73.46821600, 0.00000000, 160.71489072, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2599.78759800, 1560.55419900, 75.77787000, 0.00000000, 172.74706171, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2593.42138700, 1560.26794400, 76.88247700, 0.00000000, 179.62261255, 6.01605685, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2586.93310500, 1560.95312500, 77.11678300, 0.00000000, 187.35760008, 6.01605685, -1, -1, -1, 250);
	CreateDynamicObject(17565, -2241.95971700, 1462.33654800, 8.21772100, 0.00000000, 0.00000000, -92.81916281, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2291.15405300, 1518.89538600, 11.19429100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2272.39697300, 1515.18090800, 11.41928400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2280.85180700, 1529.35620100, 11.41928400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2283.66284200, 1508.69311500, 11.44417800, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13641, -2331.49877900, 1466.70239300, 7.65324600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13636, -2285.37475600, 1450.65026900, 8.21439900, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13604, -2231.28271500, 1528.25842300, 7.86702000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13590, -2210.42187500, 1469.43469200, 7.33484500, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(12956, -2520.45043900, 1449.97656300, 9.34028800, 0.00000000, 0.00000000, 3.43774677, -1, -1, -1, 250);
	CreateDynamicObject(8375, -2375.99511700, 1489.67236300, 8.14274600, 0.00000000, 0.00000000, -91.10028943, -1, -1, -1, 250);
	CreateDynamicObject(1681, -2552.48950200, 1422.18164100, 10.69007100, 30.93972094, -0.85943669, 34.37746771, -1, -1, -1, 250);
	CreateDynamicObject(3627, -2446.77978500, 1416.58007800, 9.95153400, 0.00000000, 0.00000000, -127.19668782, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2476.21337900, 1444.63891600, 7.23715700, 0.00000000, 0.00000000, -132.35342256, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2472.17480500, 1440.95056200, 10.23288500, 12.03211370, 0.00000000, -132.35342256, -1, -1, -1, 250);
	CreateDynamicObject(8172, -2618.06323200, 1645.29431200, 10.75335900, 0.00000000, -14.61042378, 90.24085273, -1, -1, -1, 250);
	CreateDynamicObject(4867, -2644.52734400, 1756.41333000, 15.77159900, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(8172, -2458.40893600, 1645.53271500, 10.60427500, 0.00000000, -14.61042378, 90.24085273, -1, -1, -1, 250);
	CreateDynamicObject(4867, -2432.11401400, 1756.40100100, 15.71855400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(8038, -2697.78637700, 1707.55310100, 35.58687600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(8550, -2601.60376000, 1716.87402300, 19.79468500, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(10757, -2659.12085000, 1693.46594200, 18.16287200, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(10763, -2359.91406300, 1701.53259300, 47.55012100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(10815, -2466.16577100, 2144.36645500, -4.11317900, 6.87549354, 6.87549354, 135.55012599, -1, -1, -1, 250);
	CreateDynamicObject(16098, -2529.92871100, 1702.05127000, 11.98208600, 0.00000000, 0.00000000, -91.10028943, -1, -1, -1, 250);
	CreateDynamicObject(1682, -2534.92065400, 1736.60473600, 22.14777000, 0.00000000, 0.00000000, -226.03202207, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2684.33471700, 1763.41076700, 16.72171600, 0.00000000, 0.00000000, -204.54616204, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2686.63916000, 1758.33715800, 20.28698300, 21.48591732, 0.00000000, -204.54616204, -1, -1, -1, 250);
	CreateDynamicObject(18284, -2743.93847700, 1770.46423300, 18.59144000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18284, -2743.93725600, 1753.34606900, 18.59144000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(7617, -2565.81958000, 1626.91772500, 17.21826600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2658.06250000, 1675.42724600, 27.34220500, 0.00000000, 44.69070802, -19.76704393, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2671.34057600, 1736.45336900, 27.34220500, 0.00000000, 44.69070802, 22.34535401, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2658.85083000, 1679.37011700, 16.69549800, 0.00000000, 0.00000000, 69.61437211, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2674.82959000, 1738.91894500, 16.67171700, 0.00000000, 0.00000000, 111.72671275, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2480.28613300, 1698.57495100, 16.61866600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2416.19067400, 1604.02954100, 6.10585100, -9.45380362, 0.00000000, -62.73887857, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2409.65502900, 1607.40026900, 9.37003500, 12.03211370, 0.00000000, -62.73887857, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2404.21386700, 1610.20056200, 14.84730700, 26.64253747, 0.00000000, -62.73887857, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2400.66235400, 1612.03442400, 20.96555900, 42.11239794, 0.00000000, -62.73887857, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2399.10498000, 1612.83349600, 26.37451400, 55.00389104, 0.00000000, -62.73887857, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2565.26904300, 1627.04699700, 27.88660400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1634, -2566.16601600, 1682.68908700, 16.56891600, 0.00000000, 0.00000000, -181.34125675, -1, -1, -1, 250);
	CreateDynamicObject(1634, -2566.29541000, 1677.78564500, 19.80707200, 14.61042378, 0.00000000, -181.34125675, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2424.99340800, 1680.72814900, 19.02746600, -25.78310078, 0.00000000, 57.58225841, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2429.18530300, 1677.10620100, 19.02747500, -25.78310078, 0.00000000, 24.06422740, -1, -1, -1, 250);
	CreateDynamicObject(3865, -2424.23315400, 1687.32385300, 19.05247300, -25.78310078, 0.00000000, 108.28908058, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2350.51611300, 1853.14270000, 25.31267400, 0.00000000, 0.00000000, 14.68777308, -1, -1, -1, 250);
	CreateDynamicObject(7073, -2397.60937500, 1613.30932600, 47.66366600, 0.00000000, 0.00000000, 27.50197417, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2580.57568400, 1428.64331100, 15.78265400, 0.00000000, 0.00000000, 55.00394833, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2286.92968800, 1414.78698700, 16.02963800, 0.00000000, 0.00000000, 96.25690958, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2280.61572300, 1414.50207500, 16.07906300, 0.00000000, 0.00000000, 96.25690958, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2273.66040000, 1414.21484400, 16.06070700, 0.00000000, 0.00000000, 96.25690958, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2266.49755900, 1413.93225100, 16.05227500, 0.00000000, 0.00000000, 96.25690958, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2259.10229500, 1413.61804200, 16.03500400, 0.00000000, 0.00000000, 96.25690958, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2256.96533200, 1400.67370600, 6.45911500, -6.01605685, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2253.56518600, 1400.67529300, 6.45911600, -6.01605685, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2256.93408200, 1395.05590800, 9.02391800, 9.45380362, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2253.58032200, 1395.06604000, 9.01775600, 9.45380362, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2563.02099600, 1317.27600100, 121.61679100, 0.00000000, 0.85943669, -33.51808831, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2566.58960000, 1311.98059100, 124.79761500, -89.38141604, 0.85943669, -32.65865162, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2566.68139600, 1311.98364300, 138.64357000, -89.38141604, 0.85943669, -32.65865162, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2532.63818400, 1300.19970700, 131.12338300, 61.87938458, 46.40958141, -116.88339021, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2529.41992200, 1297.73315400, 136.96096800, 61.87938458, 46.40958141, -116.88339021, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2526.29003900, 1295.30468800, 142.68057300, 61.87938458, 46.40958141, -116.88339021, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2522.94287100, 1292.75878900, 148.70774800, 61.87938458, 46.40958141, -116.88339021, -1, -1, -1, 250);
	CreateDynamicObject(4726, -2504.49145500, 1274.46435500, 139.39189100, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2431.52319300, 1442.08935500, 7.51215800, 12.03211370, 24.06422740, -134.93173264, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2530.63671900, 1295.98669400, 121.92248500, 0.00000000, 6.87549354, -165.01207418, -1, -1, -1, 250);
	CreateDynamicObject(8172, -2289.55249000, 1705.22863800, 15.63791800, 0.00000000, -0.85943669, 33.99089308, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2253.51391600, 1621.30102500, 18.48382000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2250.42309600, 1599.81506300, 18.67326700, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2249.07348600, 1580.04541000, 13.39430000, 17.18873385, 1.71887339, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2250.76391600, 1567.24841300, 10.16930300, 6.01605685, 2.57831008, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2229.57006800, 1633.55090300, 20.20821000, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2222.92895500, 1611.93457000, 19.72282600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2219.59863300, 1589.06311000, 18.82422300, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2213.92309600, 1574.17395000, 15.37283100, 6.01605685, 2.57831008, 2.57831008, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2212.97290000, 1558.55395500, 10.01625400, 0.85943669, 0.85943669, 2.57831008, -1, -1, -1, 250);
	CreateDynamicObject(4113, -2171.89477500, 1421.36901900, 13.22123000, 0.00000000, 0.00000000, -78.75001226, -1, -1, -1, 250);
	CreateDynamicObject(4113, -2170.43603500, 1459.74401900, 13.08762200, 0.00000000, 0.00000000, -78.75001226, -1, -1, -1, 250);
	CreateDynamicObject(8881, -2159.96752900, 1507.68017600, 32.77926600, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(8881, -2163.28662100, 1583.89123500, 32.86023700, 0.00000000, 0.00000000, -112.49997660, -1, -1, -1, 250);
	CreateDynamicObject(9078, -2358.29589800, 1644.70031700, 20.57994800, 0.00000000, 0.00000000, -22.49999532, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2335.53808600, 1615.41833500, 19.26340100, 0.00000000, 0.00000000, 219.07018379, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2295.71289100, 1574.48852500, 7.28411400, 0.00000000, 0.00000000, 46.02300678, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2299.51855500, 1578.15014600, 10.30911400, 14.61042378, 0.00000000, 46.02300678, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2228.08667000, 1424.97912600, 7.23411400, 0.00000000, 0.00000000, -89.83645912, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2221.26025400, 1425.00122100, 11.34324800, 16.32929716, 0.00000000, -89.83645912, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2215.59033200, 1425.02978500, 17.80422000, 35.23690440, 0.00000000, -89.83645912, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2217.68310500, 1521.45349100, 7.28411400, 0.00000000, 0.00000000, -63.82136773, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2212.50024400, 1524.02795400, 11.09009900, 19.76704393, 0.00000000, -63.82136773, -1, -1, -1, 250);
	CreateDynamicObject(3627, -2322.67724600, 1703.64892600, 19.55804100, 0.85943669, 85.94366927, -179.14946400, -1, -1, -1, 250);
	CreateDynamicObject(3627, -2342.82080100, 1672.84533700, 20.08303300, 0.85943669, 85.94366927, -246.64950725, -1, -1, -1, 250);
	CreateDynamicObject(981, -2750.07031300, 1829.59411600, 16.72308500, 0.00000000, 0.00000000, -89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(981, -2750.25488300, 1797.77465800, 16.64808700, 0.00000000, 0.00000000, -89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(981, -2750.02807600, 1726.04296900, 16.59808700, 0.00000000, 0.00000000, -89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(981, -2750.00439500, 1689.22314500, 16.67308600, 0.00000000, 0.00000000, -89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(981, -2728.24707000, 1666.25561500, 16.69808600, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(4113, -2207.83593800, 1388.64257800, 13.16573300, 0.00000000, 0.00000000, -168.74999354, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2296.46582000, 1584.87023900, 9.66052200, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2274.33422900, 1717.05419900, 19.35249100, 0.00000000, 0.00000000, -56.25001695, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2304.56884800, 1691.95654300, 18.34814800, 0.00000000, 0.00000000, -56.25001695, -1, -1, -1, 250);
	CreateDynamicObject(4867, -2500.05664100, 1636.05395500, 6.19370400, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(3998, -2381.77758800, 1607.26904300, 6.80607600, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(979, -2377.62866200, 1631.65026900, 7.65327400, -0.85943669, -14.61042378, 89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(979, -2377.67529300, 1640.47485400, 9.94251400, -0.85943669, -14.61042378, 89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(979, -2377.72631800, 1649.37219200, 12.28471900, -0.85943669, -14.61042378, 89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(4867, -2432.99218800, 1938.83544900, 15.71703700, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2326.65478500, 1860.85583500, 19.09507200, 0.00000000, 0.00000000, -89.14054458, -1, -1, -1, 250);
	CreateDynamicObject(980, -2322.78540000, 1780.09021000, 18.51182900, 0.00000000, 0.00000000, 33.75002163, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2327.91162100, 1950.81811500, 19.09355700, 0.00000000, 0.00000000, -89.14054458, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2668.11499000, 1846.83703600, 19.07160900, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2466.06811500, 2185.40087900, 2.50829800, 0.00000000, 0.00000000, 89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2469.43823200, 2212.61474600, 3.65948400, -7.73493023, 0.00000000, -179.99996255, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2461.88793900, 2212.59350600, 3.65948600, -7.73493023, 0.00000000, -179.99996255, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2462.96044900, 2205.61499000, 3.30215800, -2.57831008, 0.00000000, -359.99998240, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2469.04199200, 2205.60986300, 3.30215900, -2.57831008, 0.00000000, -359.99998240, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2619.51220700, 1846.78540000, 19.07311600, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2539.37890600, 1926.68432600, 19.06855800, 0.00000000, 0.00000000, -270.00005842, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2539.37085000, 1947.19360400, 19.10112800, 0.00000000, 0.00000000, -270.00005842, -1, -1, -1, 250);
	CreateDynamicObject(8881, -2514.20727500, 2033.01684600, 41.16826200, 0.00000000, 0.00000000, -56.25001695, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2406.32543900, 2029.93225100, 19.11854900, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2466.02954100, 2042.25744600, 16.67577700, -2.57831008, 0.00000000, -539.99994495, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2457.51416000, 2042.25537100, 16.67026100, -2.57831008, 0.00000000, -539.99994495, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2474.67187500, 2042.24755900, 16.68396400, -2.57831008, 0.00000000, -539.99994495, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2457.52441400, 2036.00280800, 20.34683400, 16.32929716, 0.00000000, -539.99994495, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2466.20727500, 2035.99658200, 20.34813300, 16.32929716, 0.00000000, -539.99994495, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2474.65722700, 2035.99865700, 20.34727300, 16.32929716, 0.00000000, -539.99994495, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2457.88867200, 2017.75732400, 16.54215600, -2.57831008, 0.00000000, -719.99973562, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2466.59960900, 2017.77710000, 16.55386000, -2.57831008, 0.00000000, -719.99973562, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2475.26879900, 2017.76013200, 16.54214900, -2.57831008, 0.00000000, -719.99973562, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2457.85766600, 2024.61145000, 20.52343800, 16.32929716, 0.00000000, -719.99973562, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2466.57739300, 2024.59838900, 20.51314200, 16.32929716, 0.00000000, -719.99973562, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2475.29565400, 2024.58374000, 20.49213800, 16.32929716, 0.00000000, -719.99973562, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2351.34301800, 1860.46362300, 25.24927500, 0.00000000, 0.00000000, 14.68777308, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2352.12280300, 1867.60998500, 25.21322300, 0.00000000, 0.00000000, 14.68777308, -1, -1, -1, 250);
	CreateDynamicObject(13592, -2352.92358400, 1874.77160600, 25.19802900, 0.00000000, 0.00000000, 14.68777308, -1, -1, -1, 250);
	CreateDynamicObject(16141, -2370.03442400, 1994.37707500, 9.93600500, 0.00000000, 0.00000000, 22.49999532, -1, -1, -1, 250);
	CreateDynamicObject(4113, -2348.94921900, 2013.45874000, 46.74564400, 0.00000000, 0.00000000, -29.37548886, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2516.36816400, 1908.47106900, 16.79215200, 0.00000000, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2515.94799800, 1915.79321300, 21.09610900, 15.46986047, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2515.61987300, 1921.56652800, 27.27491200, 32.65859432, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2515.42187500, 1925.17419400, 34.75223200, 49.84727088, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2515.36084000, 1926.46362300, 42.79791600, 66.17656804, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2515.41430700, 1925.48925800, 51.24845500, 81.64642851, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2515.60205100, 1922.29064900, 58.70184700, 98.83516236, 0.00000000, -3.35145933, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2515.09130900, 1870.69653300, 52.54665800, 0.00000000, -0.85943669, -89.14948272, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2513.91308600, 1792.01757800, 53.72429300, 0.00000000, -0.85943669, -89.14948272, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2512.78247100, 1714.90380900, 62.43978500, 0.00000000, -12.03211370, -89.14948272, -1, -1, -1, 250);
	CreateDynamicObject(979, -2510.95336900, 1591.20813000, 72.12216200, 88.52197935, 0.85943669, 89.99998128, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2511.61059600, 1635.88049300, 71.37384000, 0.00000000, -0.85943669, -89.14948272, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2510.79174800, 1582.33349600, 73.21195200, 0.00000000, 0.00000000, -179.99996255, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2510.79589800, 1575.40344200, 77.68489100, 19.76704393, 0.00000000, -179.99996255, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2581.06054700, 1815.82885700, 20.84320800, 0.00000000, -143.52592768, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2618.98339800, 1815.71264600, 20.84320800, 0.00000000, -143.52592768, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2411.89550800, 1847.90551800, 20.79016300, 0.00000000, -143.52592768, -134.99997191, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2508.07153300, 1952.46020500, 20.78864700, 0.00000000, -143.52592768, -56.24995965, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2385.47021500, 1958.42956500, 20.78864700, 0.00000000, -143.52592768, -134.99997191, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2538.55102500, 1844.21984900, 20.79016300, 0.00000000, -143.52592768, -56.24995965, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2390.33569300, 1845.88195800, 20.79016300, 0.00000000, -143.52592768, -56.24995965, -1, -1, -1, 250);
	CreateDynamicObject(17310, -2545.48339800, 1854.42553700, 49.90680700, 0.00000000, -82.50575061, -56.24995965, -1, -1, -1, 250);
	CreateDynamicObject(1632, -2480.34106400, 1704.98071300, 16.64367100, 0.00000000, 0.00000000, -179.99996255, -1, -1, -1, 250);
	CreateDynamicObject(5005, -2749.53515600, 1548.79846200, 9.38552300, 0.00000000, 0.00000000, -270.00000112, -1, -1, -1, 250);
	CreateDynamicObject(16304, -2741.26513700, 1458.43347200, 10.70900500, 0.00000000, 0.00000000, 0.00000000, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2451.87353500, 1887.97253400, 31.41024000, 0.00000000, 24.92366409, -100.39950903, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2438.95214800, 1958.43737800, 64.68127400, 0.00000000, 24.92366409, -100.39950903, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2425.95556600, 2029.29174800, 98.13073700, 0.00000000, 24.92366409, -100.39950903, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2413.01977500, 2099.82055700, 131.43817100, 0.00000000, 24.92366409, -100.39950903, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2400.10595700, 2170.25366200, 164.69830300, 0.00000000, 24.92366409, -100.39950903, -1, -1, -1, 250);
	CreateDynamicObject(8661, -2387.81787100, 2214.84619100, 181.85632300, 0.00000000, 0.00000000, -10.39058961, -1, -1, -1, 250);
	CreateDynamicObject(8661, -2385.98828100, 2224.92480500, 191.75453200, 88.52197935, 0.00000000, -10.39058961, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2382.67871100, 2164.28515600, 181.47425800, 0.00000000, 0.00000000, -96.95282412, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2390.86181600, 2096.63208000, 153.41119400, 0.00000000, 44.69070802, -96.95282412, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2397.60839800, 2041.10229500, 98.05860900, 0.00000000, 44.69070802, -96.95282412, -1, -1, -1, 250);
	CreateDynamicObject(18450, -2401.22241200, 2011.35546900, 68.43663800, 0.00000000, 44.69070802, -96.95282412, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2404.82714800, 1979.58630400, 37.17559400, -58.44163781, 0.00000000, -186.78922594, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2405.69628900, 1972.15710400, 33.28480500, -42.11239794, 0.00000000, -186.78922594, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2406.67309600, 1963.88793900, 31.63486100, -25.78310078, 0.00000000, -186.78922594, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2407.68945300, 1955.31176800, 32.77016800, -5.15662016, 0.00000000, -186.78922594, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2408.59350600, 1947.65942400, 36.40678400, 10.31324031, 0.00000000, -186.78922594, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2409.34472700, 1941.33007800, 42.16977300, 28.36141086, 0.00000000, -186.78922594, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2395.74658200, 1735.86486800, 16.71867000, 0.00000000, 0.00000000, -149.60145755, -1, -1, -1, 250);
	CreateDynamicObject(1655, -2392.51586900, 1730.37207000, 20.53613700, 16.32929716, 0.00000000, -149.60145755, -1, -1, -1, 250);
	CreateDynamicObject(981, -2733.84985400, 1630.84668000, 7.08548700, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(981, -2713.89379900, 1630.84497100, 7.06048800, 0.00000000, 0.00000000, -180.00001985, -1, -1, -1, 250);
	CreateDynamicObject(981, -2697.75561500, 1648.88195800, 12.68133500, 0.00000000, -13.75098708, -269.06321513, -1, -1, -1, 250);
	CreateDynamicObject(13641, -2453.25976600, 1717.52819800, 17.28780000, 0.00000000, 0.00000000, 67.49998596, -1, -1, -1, 250);
	CreateDynamicObject(13641, -2444.85522500, 1741.38012700, 17.11797300, 0.00000000, 0.00000000, 247.49994851, -1, -1, -1, 250);
	
	// Mount Chilliad stunt park
	CreateDynamicObject(16133, -2367.73339800, -1603.61438000, 475.60055500, 0.00000000, 335.07630000, 160.07840000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2372.99511700, -1609.01977500, 478.69290200, 0.00000000, 352.26510000, 172.96980000, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2401.98779300, -1539.04418900, 477.35107400, 0.00000000, 0.00000000, 276.17080000, 2, -1, -1, 250);
	CreateDynamicObject(16141, -2445.33691400, -1581.44152800, 467.57003800, 0.00000000, 0.00000000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2318.81909200, -1456.99646000, 480.55267300, 0.00000000, 0.00000000, 276.09340000, 2, -1, -1, 250);
	CreateDynamicObject(4867, -2406.93457000, -1493.29480000, 477.34802200, 0.00000000, 0.00000000, 276.17080000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2405.90820300, -1386.41870100, 480.57461500, 0.00000000, 0.00000000, 186.09340000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2426.62207000, -1388.61120600, 480.57897900, 0.00000000, 0.00000000, 186.09340000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2500.00732400, -1479.63781700, 480.60266100, 0.00000000, 0.00000000, 96.09330000, 2, -1, -1, 250);
	CreateDynamicObject(5005, -2489.83740200, -1575.88964800, 480.60266100, 0.00000000, 0.00000000, 96.09330000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2359.70776400, -1412.58789100, 478.39819300, 0.00000000, 0.00000000, 5.15660000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2360.35620100, -1405.52551300, 482.63403300, 16.32930000, 0.00000000, 5.15660000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2360.83691400, -1400.02832000, 488.72464000, 33.51800000, 0.00000000, 5.15660000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2361.08642600, -1396.88122600, 496.23053000, 54.14450000, 0.00000000, 5.15660000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2361.12793000, -1396.47692900, 504.54086300, 73.91150000, 0.00000000, 5.15660000, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2402.92895500, -1408.99108900, 487.74356100, 0.00000000, 345.38960000, 101.25000000, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2411.46704100, -1405.44213900, 488.45111100, 0.00000000, 345.38960000, 101.25000000, 2, -1, -1, 250);
	CreateDynamicObject(13592, -2420.02490200, -1401.76220700, 489.42272900, 0.00000000, 345.38960000, 101.25000000, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2424.10009800, -1402.57128900, 480.35263100, 339.37350000, 0.00000000, 6.01610000, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2424.63354500, -1397.52795400, 481.54306000, 358.28110000, 0.00000000, 6.01610000, 2, -1, -1, 250);
	CreateDynamicObject(1632, -2425.09985400, -1393.02221700, 484.44729600, 18.90760000, 0.00000000, 6.01610000, 2, -1, -1, 250);
	CreateDynamicObject(13831, -2433.23193400, -1586.09094200, 499.38769500, 0.00000000, 0.00000000, 211.17170000, 2, -1, -1, 250);
	CreateDynamicObject(13722, -2433.10913100, -1585.54235800, 499.36746200, 0.00000000, 0.00000000, 211.17170000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2459.95654300, -1442.69921900, 478.37625100, 0.00000000, 0.00000000, 65.31720000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2464.28247100, -1440.72216800, 481.33200100, 19.76700000, 0.00000000, 65.31720000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2468.94677700, -1531.21789600, 478.37625100, 0.00000000, 0.00000000, 144.06710000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2472.12548800, -1535.63024900, 481.63229400, 17.18870000, 0.00000000, 144.06710000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2482.74487300, -1487.61462400, 477.35290500, 0.00000000, 347.10840000, 160.07840000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2324.28710900, -1489.34082000, 475.90289300, 0.00000000, 347.10840000, 12.25560000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2386.09375000, -1573.15295400, 482.04553200, 0.00000000, 327.34140000, 268.26400000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2452.60400400, -1400.91101100, 477.39984100, 0.00000000, 335.07630000, 112.70630000, 2, -1, -1, 250);
	CreateDynamicObject(16037, -2233.22583000, -1588.54809600, 482.91549700, 0.00000000, 5.15660000, 21.64060000, 2, -1, -1, 250);
	CreateDynamicObject(16037, -2123.11328100, -1544.88195800, 461.06970200, 0.00000000, 15.46990000, 21.64060000, 2, -1, -1, 250);
	CreateDynamicObject(16037, -2016.90673800, -1502.71472200, 429.39611800, 0.00000000, 15.46990000, 21.64060000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2282.90112300, -1660.62341300, 483.17660500, 0.00000000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2273.98999000, -1661.89086900, 483.21597300, 0.00000000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2265.24853500, -1663.13354500, 482.86764500, 354.84340000, 341.95180000, 260.54620000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2259.70117200, -1664.18518100, 481.81460600, 346.24900000, 357.42170000, 259.68680000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2251.64599600, -1665.36035200, 479.92565900, 348.82730000, 0.00000000, 262.26510000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2244.31225600, -1666.31152300, 480.13970900, 12.03210000, 357.42170000, 263.98400000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2225.49633800, -1668.42797900, 484.03262300, 6.87550000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2217.83178700, -1669.22338900, 484.96652200, 6.87550000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2210.45996100, -1670.09362800, 485.82321200, 6.87550000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2203.32812500, -1671.06359900, 486.72229000, 6.87550000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2197.36059600, -1671.77441400, 487.54376200, 6.87550000, 0.00000000, 263.12450000, 2, -1, -1, 250);
	CreateDynamicObject(3554, -2283.53295900, -1660.56872600, 491.42706300, 0.00000000, 0.00000000, 82.74660000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2317.47558600, -1523.26355000, 476.74862700, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2262.24633800, -1687.04333500, 478.71728500, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13831, -2371.49951200, -1609.12622100, 510.35189800, 0.00000000, 0.85940000, 78.82740000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2271.32910200, -1725.69751000, 467.92666600, 0.00000000, 347.10840000, 205.00090000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2244.67773400, -1751.02038600, 479.25305200, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2332.69995100, -1395.80004900, 476.59555100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2456.03759800, -1415.98779300, 478.83923300, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2475.01928700, -1500.01538100, 483.23504600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2401.30053700, -1556.42248500, 476.97836300, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(726, -2474.94604500, -1602.27978500, 476.54879800, 0.00000000, 0.00000000, 348.82730000, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2296.28613300, -1598.39794900, 481.65768400, 359.14060000, 17.18870000, 29.53010000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2237.60717800, -1732.99121100, 480.59750400, 1.71890000, 0.85940000, 210.23500000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -2273.50268600, -1563.09521500, 479.01318400, 0.00000000, 358.28110000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(733, -2328.62890600, -1685.13793900, 481.26333600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(735, -2359.96215800, -1646.89648400, 480.82318100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16127, -2346.48437500, -1683.91796900, 486.53527800, 346.24900000, 0.85940000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(16127, -2316.88525400, -1707.42895500, 485.29409800, 349.68680000, 0.00000000, 321.72090000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2287.53686500, -1640.01342800, 483.29040500, 359.14060000, 0.85940000, 271.87350000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2287.70434600, -1631.85266100, 483.34332300, 359.14060000, 0.00000000, 270.15470000, 2, -1, -1, 250);
	CreateDynamicObject(9685, -2282.94506800, -1531.11254900, 536.95642100, 0.00000000, 0.00000000, 320.23400000, 2, -1, -1, 250);
	CreateDynamicObject(9685, -2196.87622100, -1427.74841300, 545.70929000, 0.00000000, 0.00000000, 320.23410000, 2, -1, -1, 250);
	CreateDynamicObject(9685, -2110.68212900, -1324.25854500, 554.47406000, 0.00000000, 0.00000000, 320.23410000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1897.73938000, -1056.23449700, 523.44641100, 0.00000000, 0.00000000, 321.09340000, 2, -1, -1, 250);
	CreateDynamicObject(7916, -2362.49560500, -1613.52172900, 497.17547600, 28.36140000, 0.00000000, 77.03110000, 2, -1, -1, 250);
	CreateDynamicObject(7916, -2355.78027300, -1657.32080100, 495.55090300, 29.22080000, 359.14060000, 109.06220000, 2, -1, -1, 250);
	CreateDynamicObject(16127, -2363.80419900, -1645.95227100, 482.38360600, 346.24900000, 0.85940000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2384.80053700, -1575.73510700, 485.20529200, 350.54620000, 332.49800000, 254.51290000, 2, -1, -1, 250);
	CreateDynamicObject(11435, -2310.02441400, -1584.27673300, 485.40649400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(7392, -2287.59643600, -1672.06616200, 491.21005200, 0.00000000, 0.00000000, 353.12450000, 2, -1, -1, 250);
	CreateDynamicObject(8483, -2354.76001000, -1579.37890600, 490.02667200, 358.28110000, 357.42170000, 331.63860000, 2, -1, -1, 250);
	CreateDynamicObject(13562, -2288.04223600, -1654.21960400, 483.42868000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16776, -2309.83178700, -1695.02258300, 481.26385500, 0.00000000, 0.00000000, 135.79110000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2293.26391600, -1607.78308100, 483.33184800, 358.28110000, 359.14060000, 290.78110000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2290.20874000, -1615.83081100, 483.37838700, 358.28110000, 0.00000000, 290.78110000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1746.05761700, -1395.10510300, 356.68914800, 344.53010000, 0.00000000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1738.83349600, -1392.10241700, 358.86459400, 0.85940000, 0.00000000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1732.12805200, -1389.34411600, 363.11526500, 14.61040000, 0.00000000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2344.17773400, -1555.53625500, 479.02584800, 8.59440000, 0.00000000, 189.45380000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2340.23632800, -1571.68981900, 483.50128200, 12.89160000, 0.00000000, 12.89160000, 2, -1, -1, 250);
	CreateDynamicObject(10838, -2321.31933600, -1576.83862300, 497.20776400, 359.14060000, 358.28110000, 48.12850000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2236.01660200, -1667.08581500, 481.97851600, 12.03210000, 357.42170000, 263.98400000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2231.74292000, -1667.53930700, 483.07952900, 12.03210000, 357.42170000, 263.98400000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2189.54809600, -1672.90918000, 488.47512800, 6.87550000, 0.00000000, 259.68680000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2182.24780300, -1674.79174800, 489.42492700, 6.87550000, 0.00000000, 249.37350000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2175.39697300, -1678.20214800, 490.33047500, 6.87550000, 0.00000000, 235.62250000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2169.11547900, -1682.43920900, 490.70208700, 359.14060000, 1.71890000, 235.62250000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2162.80957000, -1687.26135300, 490.58270300, 359.14060000, 1.71890000, 227.02810000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2157.65771500, -1693.17504900, 490.43576000, 359.14060000, 1.71890000, 212.41750000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2153.70507800, -1699.34362800, 490.11257900, 354.84340000, 0.00000000, 212.41750000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2150.36181600, -1705.59436000, 489.45642100, 354.84340000, 0.00000000, 200.38540000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2148.39233400, -1712.52026400, 488.78668200, 354.84340000, 0.00000000, 188.35310000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2147.96044900, -1719.52050800, 488.13839700, 354.84340000, 0.00000000, 176.32100000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2148.93481400, -1726.64257800, 487.48654200, 354.84340000, 0.00000000, 165.14820000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2150.71704100, -1733.48364300, 486.59045400, 349.68680000, 0.00000000, 165.14820000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2153.01586900, -1739.36718800, 485.40170300, 349.68680000, 0.00000000, 153.97540000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2156.83715800, -1745.68225100, 484.07098400, 349.68680000, 0.00000000, 141.94330000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2161.27392600, -1750.57287600, 482.88763400, 349.68680000, 0.00000000, 129.91100000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2167.02392600, -1754.29797400, 481.63760400, 349.68680000, 0.00000000, 115.30080000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2173.99829100, -1756.77710000, 480.30600000, 349.68680000, 0.00000000, 102.40930000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2181.32812500, -1757.56945800, 478.92004400, 349.68680000, 0.00000000, 87.79900000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2188.53710900, -1756.43286100, 477.59371900, 349.68680000, 0.00000000, 74.04820000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2195.46069300, -1753.23205600, 476.21871900, 349.68680000, 0.00000000, 56.00020000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2201.58154300, -1748.01196300, 474.66912800, 349.68680000, 0.00000000, 42.24930000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2205.86084000, -1742.10656700, 473.35968000, 349.68680000, 0.00000000, 27.63900000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2208.18652300, -1735.10754400, 471.99813800, 349.68680000, 0.00000000, 8.73160000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2208.33300800, -1727.43518100, 470.60827600, 349.68680000, 0.00000000, 352.40240000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2206.18432600, -1719.65429700, 469.12423700, 349.68680000, 0.00000000, 337.79210000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2202.08935500, -1713.13183600, 467.79620400, 349.68680000, 0.00000000, 318.02520000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2196.13818400, -1708.34826700, 466.40631100, 349.68680000, 0.00000000, 299.97720000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2189.04370100, -1705.48706100, 465.06039400, 349.68680000, 0.00000000, 283.64810000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2181.02905300, -1704.21948200, 463.62796000, 349.68680000, 0.00000000, 273.33490000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2173.13891600, -1703.71691900, 462.15863000, 349.68680000, 0.00000000, 273.33490000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2166.24169900, -1703.24694800, 460.85147100, 349.68680000, 0.00000000, 273.33490000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2158.81933600, -1702.77380400, 459.46057100, 349.68680000, 0.00000000, 273.33490000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2151.51806600, -1702.33508300, 458.11300700, 349.68680000, 0.00000000, 273.33490000, 2, -1, -1, 250);
	CreateDynamicObject(3502, -2144.23388700, -1701.88623000, 456.76208500, 349.68680000, 0.00000000, 273.33490000, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2148.50415000, -1700.99939000, 446.60180700, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2142.58593800, -1700.97485400, 446.36911000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1810.57824700, -1636.15234400, 443.57193000, 351.40560000, 0.00000000, 270.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1802.60864300, -1636.15820300, 446.36175500, 2.57830000, 0.00000000, 270.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1796.57519500, -1636.11462400, 450.26486200, 17.18870000, 0.00000000, 270.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1790.48852500, -1636.09533700, 456.11071800, 25.78310000, 0.00000000, 270.00000000, 2, -1, -1, 250);
	CreateDynamicObject(6986, -2349.08227500, -1572.66455100, 499.17211900, 0.00000000, 0.00000000, 303.27720000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1893.17346200, -1063.10266100, 524.18872100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -2403.69262700, -1416.83154300, 481.09008800, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -2402.50781300, -1416.59265100, 481.02084400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -2404.88842800, -1416.94970700, 481.04327400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2382.16137700, -1605.63000500, 488.94613600, 0.00000000, 334.21690000, 136.87320000, 2, -1, -1, 250);
	CreateDynamicObject(16127, -2363.82128900, -1674.43359400, 499.31698600, 346.24900000, 0.85940000, 292.50000000, 2, -1, -1, 250);
	CreateDynamicObject(8618, -2355.65966800, -1591.17443800, 499.22119100, 0.00000000, 0.00000000, 24.92370000, 2, -1, -1, 250);
	CreateDynamicObject(3715, -2287.51562500, -1636.57995600, 491.15588400, 0.00000000, 0.00000000, 270.61860000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2245.18212900, -1737.32568400, 480.61645500, 1.71890000, 359.14060000, 209.37550000, 2, -1, -1, 250);
	CreateDynamicObject(13641, -2235.34130900, -1746.54797400, 489.82138100, 0.85940000, 341.95180000, 299.83950000, 2, -1, -1, 250);
	CreateDynamicObject(13722, -2371.52270500, -1609.12573200, 510.78802500, 0.00000000, 0.00000000, 78.81830000, 2, -1, -1, 250);
	CreateDynamicObject(16133, -2391.17993200, -1617.60156300, 504.42272900, 0.00000000, 352.26510000, 172.11040000, 2, -1, -1, 250);
	CreateDynamicObject(10281, -2360.66674800, -1667.89660600, 507.08081100, 0.00000000, 358.28110000, 116.02380000, 2, -1, -1, 250);
	CreateDynamicObject(16480, -2272.72558600, -1686.89209000, 482.32971200, 0.00000000, 0.00000000, 262.88370000, 2, -1, -1, 250);
	CreateDynamicObject(3528, -2287.64209000, -1635.91467300, 496.56921400, 1.71890000, 0.00000000, 180.37740000, 2, -1, -1, 250);
	CreateDynamicObject(13667, -2224.70410200, -1497.71936000, 503.36624100, 0.85940000, 0.00000000, 243.97620000, 2, -1, -1, 250);
	CreateDynamicObject(9685, -2024.51379400, -1220.60412600, 563.33282500, 0.00000000, 0.00000000, 320.23410000, 2, -1, -1, 250);
	CreateDynamicObject(9685, -1937.97802700, -1116.64074700, 572.14013700, 0.00000000, 0.00000000, 320.23410000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1885.76342800, -1065.62939500, 523.49609400, 0.00000000, 0.00000000, 320.23400000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1893.63867200, -1051.21411100, 527.07312000, 12.03210000, 0.00000000, 321.09340000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1891.21899400, -1048.13659700, 530.24810800, 21.48590000, 0.00000000, 321.09340000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1882.04699700, -1061.12402300, 526.65741000, 12.03210000, 0.00000000, 320.23400000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1878.97631800, -1057.24011200, 530.95202600, 23.20480000, 0.00000000, 320.23400000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1814.75610400, -1630.92358400, 444.39895600, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1814.23303200, -1642.56665000, 444.21426400, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1814.36010700, -1641.33471700, 444.01147500, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1814.28552200, -1629.35400400, 444.27661100, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1751.89111300, -1390.11853000, 357.95867900, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1751.58068800, -1391.69079600, 357.63897700, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1748.32226600, -1401.55578600, 358.25439500, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -1746.57299800, -1402.64331100, 358.20712300, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -2307.16552700, -1589.94287100, 485.26867700, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -2210.49243200, -1500.05444300, 481.67050200, 0.00000000, 358.28110000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -2150.03833000, -1439.54370100, 483.53909300, 0.00000000, 359.14060000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -2087.69043000, -1377.16088900, 484.82846100, 0.00000000, 359.14060000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -2025.60461400, -1315.12756300, 484.12933300, 0.00000000, 1.71890000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -1962.24853500, -1251.77746600, 481.44866900, 0.00000000, 1.71890000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(4853, -1904.20153800, -1193.69958500, 479.61804200, 0.85940000, 0.85940000, 45.00000000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -1871.27710000, -1160.85412600, 483.56735200, 4.29720000, 0.00000000, 313.98590000, 2, -1, -1, 250);
	CreateDynamicObject(2918, -2285.19140600, -1664.53320300, 483.92590300, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -2245.02954100, -1636.05664100, 484.84658800, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -2165.40722700, -1636.06140100, 484.83361800, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -2086.04614300, -1636.09631300, 484.84552000, 0.00000000, 0.00000000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -2007.12939500, -1636.09533700, 477.75775100, 0.00000000, 10.31320000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -1929.06311000, -1636.09265100, 463.59442100, 0.00000000, 10.31320000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -1852.87683100, -1636.08068800, 449.73495500, 0.00000000, 10.31320000, 0.00000000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -1928.73535200, -1467.16076700, 400.45431500, 0.00000000, 12.89160000, 21.48590000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -1856.40197800, -1438.66333000, 382.68826300, 0.00000000, 12.89160000, 21.48590000, 2, -1, -1, 250);
	CreateDynamicObject(18449, -1784.23852500, -1410.25036600, 364.94928000, 0.00000000, 12.89160000, 21.48590000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2234.17309600, -1738.96838400, 484.51684600, 11.17270000, 1.71890000, 210.23490000, 2, -1, -1, 250);
	CreateDynamicObject(1655, -2241.74682600, -1743.29223600, 484.24514800, 11.17270000, 1.71890000, 210.23490000, 2, -1, -1, 250);

	//Stuntairport
	CreateDynamicObject(13562,2505.7307129,-1695.0270996,16.9574680,0.0000000,0.0000000,0.0000000); //object(bigsprunkpole) (1)
	CreateDynamicObject(13593,336.1389771,2516.9501953,16.3716125,0.0000000,0.0000000,90.0000000); //object(kickramp03) (1)
	CreateDynamicObject(13604,400.9979248,2496.6535645,17.1923923,0.0000000,0.0000000,0.0000000); //object(kickramp05) (1)
	CreateDynamicObject(13641,314.4142761,2516.4665527,15.6476707,0.0000000,0.0000000,0.0000000); //object(kickramp04) (1)
	CreateDynamicObject(13647,359.6553955,2475.4309082,15.4843750,0.0000000,0.0000000,0.0000000); //object(wall1) (1)
	CreateDynamicObject(13638,342.1823730,2543.6938477,15.0013857,0.0000000,0.0000000,0.0000000); //object(stunt1) (1)
	CreateDynamicObject(13638,348.8282166,2543.6789551,23.0679264,0.0000000,0.0000000,180.0000000); //object(stunt1) (2)
	CreateDynamicObject(13638,345.5597839,2529.5124512,30.6755867,0.0000000,0.0000000,90.0000000); //object(stunt1) (3)
	CreateDynamicObject(13638,345.5687561,2534.9101562,37.6806221,0.0000000,0.0000000,270.0000000); //object(stunt1) (4)
	CreateDynamicObject(6052,358.1496887,2527.1474609,45.5303230,0.0000000,0.0000000,0.0000000); //object(artcurve_law) (1)
	CreateDynamicObject(5295,365.4619141,2518.2529297,48.0641022,0.0000000,0.0000000,0.0000000); //object(snpedteew8_las06) (1)
	CreateDynamicObject(1634,365.1824646,2518.7233887,48.4573479,0.0000000,0.0000000,260.0000000); //object(landjump2) (1)
	CreateDynamicObject(13637,367.1909790,2491.0385742,17.5622978,0.0000000,0.0000000,0.0000000); //object(tuberamp) (1)
	CreateDynamicObject(7392,404.8064270,2476.1250000,37.8570366,0.0000000,0.0000000,90.0000000); //object(vegcandysign1) (1)
	CreateDynamicObject(1632,428.1301270,2522.0546875,16.7844868,2.0000000,0.0000000,270.0000000); //object(waterjump1) (1)
	CreateDynamicObject(1632,427.8684692,2510.2690430,16.7844868,1.9995117,0.0000000,270.0000000); //object(waterjump1) (2)
	CreateDynamicObject(1632,427.7418518,2497.3310547,16.7844868,1.9995117,0.0000000,270.0000000); //object(waterjump1) (3)
	CreateDynamicObject(1632,428.4813538,2483.9382324,16.7844868,1.9995117,0.0000000,270.0000000); //object(waterjump1) (4)
	CreateDynamicObject(12956,228.8730469,2477.9775391,18.7000008,0.0000000,0.0000000,0.0000000); //object(sw_trailerjump) (1)
	CreateDynamicObject(13590,304.7148438,2481.2929688,16.7602177,0.0000000,0.0000000,90.0000000); //object(kickbus04) (1)
	CreateDynamicObject(18370,229.6298828,2525.0527344,20.8969116,0.0000000,0.0000000,0.0000000); //object(cs_roads02) (1)
	CreateDynamicObject(17639,121.3176956,2499.6977539,37.3976479,0.0000000,26.0000000,0.0000000); //object(lae2_roads31) (1)
	CreateDynamicObject(17639,76.6395493,2499.6943359,59.1730309,0.0000000,25.9991455,0.0000000); //object(lae2_roads31) (2)
	CreateDynamicObject(17639,-18.0000000,2499.6989746,81.0388260,0.0000000,0.0000000,0.0000000); //object(lae2_roads31) (3)
	CreateDynamicObject(1655,-62.7894707,2494.1372070,81.9092789,0.0000000,0.0000000,90.0000000); //object(waterjumpx2) (2)
	CreateDynamicObject(1655,-63.1776199,2505.2631836,82.0765610,0.0000000,0.0000000,90.0000000); //object(waterjumpx2) (3)
	CreateDynamicObject(1633,-63.9800568,2499.9255371,82.2453690,0.0000000,0.0000000,90.0000000); //object(landjump) (1)
	CreateDynamicObject(1655,-63.0540352,2499.6552734,82.0399933,0.0000000,0.0000000,90.0000000); //object(waterjumpx2) (4)
	CreateDynamicObject(13636,102.7792130,2504.6545410,17.7647667,0.0000000,0.0000000,0.0000000); //object(logramps) (1)
	CreateDynamicObject(13639,71.5105438,2475.0908203,15.3656425,0.0000000,0.0000000,90.0000000); //object(ramparse) (1)
	CreateDynamicObject(16077,42.4589844,2521.3398438,18.4973812,0.0000000,0.0000000,0.0000000); //object(des_gravelpile01) (1)
	CreateDynamicObject(16303,-48.5238647,2478.8894043,11.4981651,0.0000000,0.0000000,180.0000000); //object(des_quarryramp01) (1)
	CreateDynamicObject(17565,13.6328220,2481.8449707,17.9930801,0.0000000,0.0000000,0.0000000); //object(rustybrij01_lae2) (1)
	CreateDynamicObject(8390,936.3671875,2386.8105469,8880.0605469,0.0000000,0.0000000,0.0000000); //object(multicarpark01_lvs) (1)
	CreateDynamicObject(8040,946.4581299,2404.7890625,8875.7675781,0.0000000,0.0000000,0.0000000); //object(airprtcrprk02_lvs) (1)
	CreateDynamicObject(16430,1050.7547607,2404.5661621,8828.7666016,0.0000000,35.0000000,0.0000000); //object(des_ebrigroad02) (1)
	CreateDynamicObject(16430,1175.4400635,2404.5649414,8741.4609375,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (2)
	CreateDynamicObject(16430,1286.7279053,2404.5546875,8663.5468750,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (3)
	CreateDynamicObject(16430,1338.6351318,2404.5729980,8627.2041016,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (4)
	CreateDynamicObject(16430,1453.4104004,2404.6179199,8546.8847656,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (5)
	CreateDynamicObject(8040,825.6611328,-2347.2587891,894.3122559,0.0000000,0.0000000,0.0000000); //object(airprtcrprk02_lvs) (2)
	CreateDynamicObject(16430,930.6221313,-2347.6240234,847.3571777,0.0000000,35.0000000,0.0000000); //object(des_ebrigroad02) (6)
	CreateDynamicObject(14467,865.0298462,-2339.3466797,896.2880249,0.0000000,0.0000000,0.0000000); //object(carter_statue) (1)
	CreateDynamicObject(14467,864.5548706,-2355.6887207,896.2803955,0.0000000,0.0000000,180.0000000); //object(carter_statue) (2)
	CreateDynamicObject(16430,1059.2381592,-2347.6132812,757.2944336,0.0000000,35.0000000,0.0000000); //object(des_ebrigroad02) (7)
	CreateDynamicObject(8040,779.9933472,-2338.9606934,735.8942261,0.0000000,0.0000000,0.0000000); //object(airprtcrprk02_lvs) (3)
	CreateDynamicObject(16430,1176.6434326,-2347.6228027,675.0999756,0.0000000,35.0000000,0.0000000); //object(des_ebrigroad02) (8)
	CreateDynamicObject(16430,1302.5408936,-2347.5986328,586.9583130,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (9)
	CreateDynamicObject(16430,1430.1091309,-2347.6267090,497.6498413,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (10)
	CreateDynamicObject(16430,1552.6134033,-2347.6152344,411.8810425,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (11)
	CreateDynamicObject(16430,1670.0035400,-2347.6098633,329.6918030,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (12)
	CreateDynamicObject(16430,1795.4598389,-2347.6196289,241.8623657,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (13)
	CreateDynamicObject(16430,1907.8146973,-2347.6201172,163.1947327,0.0000000,34.9969482,0.0000000); //object(des_ebrigroad02) (14)
	CreateDynamicObject(3080,1973.2763672,-2342.2966309,122.2829437,0.0000000,0.0000000,270.0000000); //object(ad_jump) (1)
	CreateDynamicObject(3080,1973.2735596,-2346.4375000,122.2962799,0.0000000,0.0000000,269.9945068); //object(ad_jump) (2)
	CreateDynamicObject(3080,1973.3634033,-2350.5629883,122.3219757,0.0000000,0.0000000,269.9945068); //object(ad_jump) (3)
	CreateDynamicObject(3080,1973.4566650,-2354.7136230,122.3718872,0.0000000,0.0000000,269.9945068); //object(ad_jump) (4)
	
	//Timers
    SetTimer("RaceUpdate",1000, 1);
 	SetTimer("ZoneSync",1000,1);
    SetTimer("Werbung", 500000, 1);
    SetTimer("HostName",5000,1);
    SetTimer("FPSUP",50,1);
    SetTimer("ReactionTest", 1000*60*10, 1);
	return 1;
}

public OnGameModeExit()
{
    DerbyState = 4;
    if(DerbyState != 0)
		EndDerby();
	foreach(Player,i)
	{
    	if(InDm { i  } == true)
			Remove_From_Dm(i);
	    if (Dueler { i } == true)
	    {
	    	Remove_From_Duel(i);
	    	GivePlayerMoney(i,DuelBet);
	    }
    }
    dini_IntSet("hauser.txt","vw1",vw1);
	dini_IntSet("hauser.txt","vw2",vw2);
	dini_IntSet("hauser.txt","vw3",vw3);
	dini_IntSet("hauser.txt","vw4",vw4);
	dini_IntSet("hauser.txt","vw5",vw5);
	dini_IntSet("hauser.txt","vw6",vw6);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	switch (classid)
	{
 		case 0,1,2,3,4,5,6:
	  	{
			SetPlayerColor(playerid,0x00DD00FF);
        	SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~g~~h~]Grovestreet]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,1);
	    	gTeam[playerid] = TEAM_GROVE;
	  	}
	  	case 7,8,9,10,11,12:
	  	{
    		SetPlayerColor(playerid,0xFF0000FF);
      		SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~r~]Cops]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,1);
	    	gTeam[playerid] = TEAM_COPS;
	  	}
	  	case 13,14,15:
	  	{
      		SetPlayerColor(playerid,0x9600FFFF);
        	SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~p~]Ballas]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,1);
	    	gTeam[playerid] = TEAM_BALLAS;
	  	}
   	  	case 16,17,18:
	  	{
      		SetPlayerColor(playerid,0xE1FF00FF);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~y~]vagos]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,1);
	    	gTeam[playerid] = TEAM_VAGOS;
	   	}
   	  	case 19,20,21:
	  	{
        	SetPlayerColor(playerid,0x00DEFFFF);
        	SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~b~]aztecas]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,1);
	    	gTeam[playerid] = TEAM_AZTECAS;
 		}
 	  	case 22,23,24:
	  	{
        	SetPlayerColor(playerid,0x000000FF);
        	SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~l~]mafia]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,1);
	    	gTeam[playerid] = TEAM_MAFIA;
	   	}
 	  	case 25,26,27,28,29,30,31,32,33,34,35:
	  	{
        	SetPlayerColor(playerid,0xFF5EFFFF);
        	SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerFacingAngle(playerid,277.0394);
			SetPlayerPos(playerid,2026.7493,1007.9019,10.8203);
	    	GameTextForPlayer(playerid, "~p~]frauen]", 500, 3);
	    	ApplyAnimation(playerid,"DANCING","M_smklean_loop",4.1,1,1,1,0,0,0);
	    	gTeam[playerid] = TEAM_FRAUEN;
	   	}
	}
	return 1;
}

public PnP_OnPlayerConnect(playerid)
{
	PlayAudioStreamForPlayer(playerid, "https://dl.dropbox.com/u/52869044/intro.mp3");
	TextDrawShowForPlayer(playerid, leiste);
	onlineplayers++;
	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	FPS[playerid] = TextDrawCreate(5.000000,418.000000, "FPS:~b~ 101");
	TextDrawBackgroundColor(FPS[playerid], 255);
	TextDrawFont(FPS[playerid], 2);
	TextDrawLetterSize(FPS[playerid], 0.300000, 1.200000);
	TextDrawColor(FPS[playerid], 0xffffffff);
	TextDrawSetOutline(FPS[playerid], 1);
	TextDrawSetProportional(FPS[playerid], 1);
	TextDrawSetShadow(FPS[playerid], 1);
	SetTimerEx("Scorebar", 1000, 1, "d", playerid);
	ScoreLine[playerid] = TextDrawCreate(499.000000,94.000000,"~g~~h~S00000000");
	TextDrawAlignment(ScoreLine[playerid],0);
	TextDrawBackgroundColor(ScoreLine[playerid],0x000000ff);
	TextDrawFont(ScoreLine[playerid],3);
	TextDrawLetterSize(ScoreLine[playerid],0.559999,2.2);
	TextDrawColor(ScoreLine[playerid],0x000000ff);
	TextDrawSetOutline(ScoreLine[playerid],2);
	TextDrawSetProportional(ScoreLine[playerid],1);
	SpeedoTD[playerid] = TextDrawCreate(275.000000,381.000000,"Speedo~n~~n~~n~~n~~n~");
	SpeedoTD2[playerid] = TextDrawCreate(261.000000,388.000000,"-");
	SpeedoTD3[playerid] = TextDrawCreate(317.000000,402.000000,"KM/H: ~g~~h~~h~0");
	TextDrawUseBox(SpeedoTD[playerid],1);
	TextDrawBoxColor(SpeedoTD[playerid],0x00000066);
	TextDrawTextSize(SpeedoTD[playerid],358.000000,0.000000);
	TextDrawAlignment(SpeedoTD[playerid],0);
	TextDrawAlignment(SpeedoTD2[playerid],0);
	TextDrawAlignment(SpeedoTD3[playerid],2);
	TextDrawBackgroundColor(SpeedoTD[playerid],WEISS);
	TextDrawBackgroundColor(SpeedoTD2[playerid],0x000000ff);
	TextDrawBackgroundColor(SpeedoTD3[playerid],0x000000ff);
	TextDrawFont(SpeedoTD[playerid],2);
	TextDrawLetterSize(SpeedoTD[playerid],0.499999,1.000000);
	TextDrawFont(SpeedoTD2[playerid],3);
	TextDrawLetterSize(SpeedoTD2[playerid],7.800000,1.000000);
	TextDrawFont(SpeedoTD3[playerid],3);
	TextDrawLetterSize(SpeedoTD3[playerid],0.399999,1.799999);
	TextDrawColor(SpeedoTD[playerid],0x000000ff);
	TextDrawColor(SpeedoTD2[playerid],WEISS);
	TextDrawColor(SpeedoTD3[playerid],WEISS);
	TextDrawSetOutline(SpeedoTD[playerid],1);
	TextDrawSetOutline(SpeedoTD2[playerid],1);
	TextDrawSetOutline(SpeedoTD3[playerid],2);
	TextDrawSetProportional(SpeedoTD[playerid],1);
	TextDrawSetProportional(SpeedoTD2[playerid],1);
	TextDrawSetProportional(SpeedoTD3[playerid],1);
	TextDrawSetShadow(SpeedoTD[playerid],1);
	TextDrawSetShadow(SpeedoTD2[playerid],1);
	TextDrawSetShadow(SpeedoTD3[playerid],1);
	zonentext[playerid] = TextDrawCreate(635.000000,5.000000, "~y~] ~w~San Andreas ~y~]");
	TextDrawAlignment(zonentext[playerid],3);
	TextDrawBackgroundColor(zonentext[playerid], 0x000000ff);
	TextDrawFont(zonentext[playerid], 0);
	TextDrawLetterSize(zonentext[playerid], 0.399999,1.300000);
	TextDrawColor(zonentext[playerid], WEISS);
	TextDrawSetOutline(zonentext[playerid], 1);
	TextDrawSetProportional(zonentext[playerid], 1);
	TextDrawSetShadow(zonentext[playerid], 1);
	Zonetimer[playerid] = SetTimerEx("Zonencheck", 1000, 1, "d", playerid);
	HomepageTD[playerid] = TextDrawCreate(87.000000,433.000000,""#Homepage"");
	TextDrawAlignment(HomepageTD[playerid],2);
	TextDrawBackgroundColor(HomepageTD[playerid],0x000000ff);
	TextDrawFont(HomepageTD[playerid],1);
	TextDrawLetterSize(HomepageTD[playerid],0.355555,1.000000);
	TextDrawColor(HomepageTD[playerid],WEISS);
	TextDrawSetOutline(HomepageTD[playerid],1);
	TextDrawSetProportional(HomepageTD[playerid],1);
	ServernameTD1[playerid] = TextDrawCreate(491.000000,400.000000,""#Owner"");
	ServernameTD2[playerid] = TextDrawCreate(490.000000,410.000000,"xTreme Freeroam Server");
	ServernameTD3[playerid] = TextDrawCreate(545.000000,412.000000," ");
	ServernameTD4[playerid] = TextDrawCreate(490.000000,426.000000,"Script by DarkZero"); //Please don't edit this one
	TextDrawAlignment(ServernameTD1[playerid],0);
	TextDrawAlignment(ServernameTD2[playerid],0);
	TextDrawAlignment(ServernameTD3[playerid],0);
	TextDrawAlignment(ServernameTD4[playerid],0);
	TextDrawBackgroundColor(ServernameTD1[playerid],0x000000ff);
	TextDrawBackgroundColor(ServernameTD2[playerid],0x000000ff);
	TextDrawBackgroundColor(ServernameTD3[playerid],0x000000ff);
	TextDrawBackgroundColor(ServernameTD4[playerid],WEISS);
	TextDrawFont(ServernameTD1[playerid],3);
	TextDrawLetterSize(ServernameTD1[playerid],0.399999,0.799999);
	TextDrawFont(ServernameTD2[playerid],3);
	TextDrawLetterSize(ServernameTD2[playerid],0.311111,1.900000);
	TextDrawFont(ServernameTD3[playerid],3);
	TextDrawLetterSize(ServernameTD3[playerid],0.499999,1.800000);
	TextDrawFont(ServernameTD4[playerid],0);
	TextDrawLetterSize(ServernameTD4[playerid],0.599999,1.800000);
	TextDrawColor(ServernameTD1[playerid],WEISS);
	TextDrawColor(ServernameTD2[playerid],WEISS);
	TextDrawColor(ServernameTD3[playerid],WEISS);
	TextDrawColor(ServernameTD4[playerid],0x000000ff);
	TextDrawSetOutline(ServernameTD1[playerid],1);
	TextDrawSetOutline(ServernameTD2[playerid],2);
	TextDrawSetOutline(ServernameTD3[playerid],2);
	TextDrawSetOutline(ServernameTD4[playerid],1);
	TextDrawSetProportional(ServernameTD1[playerid],1);
	TextDrawSetProportional(ServernameTD2[playerid],1);
	TextDrawSetProportional(ServernameTD3[playerid],1);
	TextDrawSetProportional(ServernameTD4[playerid],1);
	TextDrawSetShadow(ServernameTD1[playerid],1);
	TextDrawSetShadow(ServernameTD2[playerid],1);
	TextDrawSetShadow(ServernameTD3[playerid],1);
	TextDrawSetShadow(ServernameTD4[playerid],1);
	RaceTime[playerid] = 0;
	StartTime[playerid] = 0;
    MotoGP[playerid] =  0;
    PlayerInfo[playerid][Adminlevel] = 0;
	SendClientMessage(playerid, 0x00FFFFFF, "");
	SendClientMessage(playerid, 0x00FFFFFF, "");
	SendClientMessage(playerid, 0x00FFFFFF, "");
	SendClientMessage(playerid, 0x00FFFFFF, "");
	SendClientMessage(playerid, 0x00FFFFFF, "");
	TextDrawShowForPlayer(playerid, ScoreLine[playerid]);
	TextDrawShowForPlayer(playerid, HomepageTD[playerid]);
	TextDrawShowForPlayer(playerid, zonentext[playerid]);
 	TextDrawShowForPlayer(playerid, BoxOben);
 	TextDrawShowForPlayer(playerid, BoxUnten);
	format(stringtu, sizeof(stringtu), "/Accounts/%s.txt", GetName(playerid));
	if(dini_Exists(stringtu))
	{
		SendClientMessage(playerid,Error_FARBE,"-------------------------------------------------------------------------");
		format(stringtu, sizeof(stringtu), "Welcome back, {FF0000}%s! {FFFFFF}We have missed you.", GetName(playerid));
 		SendClientMessage(playerid, WEISS, stringtu);
		SendClientMessage(playerid, WEISS, "Please enter your password to login.");
		SendClientMessage(playerid, WEISS, "If you want to see your statistics, use {FF0000}/Stats{FFFFFF}.");
		SendClientMessage(playerid, WEISS, "Please take some time and read the {FF0000}/Rules{FFFFFF}.");
		SendClientMessage(playerid,Error_FARBE,"-------------------------------------------------------------------------");
	    format(stringtu, sizeof(stringtu), "[Connect]: {FFFFFF}%s (%d) has joined the {FF0000}xTreme Freeroam Server{FFFFFF}. [Registered]",GetName(playerid),playerid);
	    SendClientMessageToAll(0x999999FF,stringtu);
  		format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}IP: %s", GetIP(playerid));
		SendClientMessageToAdmins(ADMIN_FARBE, stringtu, 1);
		LoadPlayerAccount(playerid);
		ShowPlayerDialog(playerid, Logindialog, DIALOG_STYLE_PASSWORD, "{FF0000}XFS: {FFFFFF}Login", "Welcome back, mate. Your account has been found in our database.\nPlease enter your password to login.\n\nBest regards,\n"#Owner".", "Login", "Cancel");
		return 1;
	}
	else
	{
		SendClientMessage(playerid,Error_FARBE,"-------------------------------------------------------------------------");
		format(stringtu, sizeof(stringtu), "Welcome to our server, {FF0000}%s!",GetName(playerid));
  		SendClientMessage(playerid, WEISS, stringtu);
		SendClientMessage(playerid, WEISS, "Your account has not been found in our database, so please register an account to play.");
		SendClientMessage(playerid, WEISS, "If you want to see your statistics, use {FF0000}/Stats{FFFFFF}.");
		SendClientMessage(playerid, WEISS, "Please take some time and read the {FF0000}/Rules{FFFFFF}.");
		SendClientMessage(playerid,Error_FARBE,"-------------------------------------------------------------------------");
	    format(stringtu, sizeof(stringtu), "[Connect]: {FFFFFF}%s (%d) has joined the {FF0000}xTreme Freeroam Server{FFFFFF}. [Unregistered]",GetName(playerid),playerid);
	    SendClientMessageToAll(0x999999FF,stringtu);
  		format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}IP: %s", GetIP(playerid));
		SendClientMessageToAdmins(ADMIN_FARBE, stringtu, 1);
		ShowPlayerDialog(playerid, Registerdialog, DIALOG_STYLE_PASSWORD, "{FF0000}XFS: {FFFFFF}Register", "Welcome to our server!\nYour account has not been found in our database.\nPlease register to start playing here.\n\nBest regards,\n"#Owner".", "Register", "Cancel");
  		return 1;
	}
}


public PnP_OnPlayerDisconnect(playerid, reason)
{
	if(PlayerInfo[playerid][Hausauto] > 0)
	{
	    VehicleOwner[hausauto[playerid]]=INVALID_PLAYER_ID;
		DestroyVehicle(hausauto[playerid]);
	}
	TextDrawHideForPlayer(playerid, FPS[playerid]);
    if(InDerby { playerid } == true) Remove_From_Derby(playerid);
    RaceTime[playerid] = 0;
	StartTime[playerid] = 0;
	SpielerSpeichern(playerid);
	onlineplayers--;
	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	KillTimer(Zonetimer[playerid]);
	KillTimer(Speedotimer[playerid]);
	TextDrawHideForPlayer(playerid, ScoreLine[playerid]);
	if(JoinedRace[playerid] == 1)
 	{
		StartTime[playerid] = 0;
		JoinedRace[playerid] = 0;
		MotoGate[playerid] = 1;
		MotoGP[playerid] = 0;
		JoinedRace[playerid] = 0;
		RacePlayers--;
		DisablePlayerRaceCheckpoint(playerid);
   		format(stringtu,sizeof(stringtu),"[Race]: {FFFFFF}%s has left the race prematurely!",GetName(playerid));
  		SendClientMessageToAll(RENN_FARBE,stringtu);
  		printf("[race] %s has been dropped out of the race.", GetName(playerid));
		if(RacePlayers < 1)
		{
			SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
			print("[race] The race has been finished.");
			rennengestartet = 0;
			RacePlayers = 0;
			racelist = 1;
			KillTimer(Rennen);
		}
 	}
	if( JoinedFallout[playerid] == 1 )
	{
		if( inProgress > 1 )
		{
			format(stringtu,sizeof(stringtu),"[Fallout]: {FFFFFF}%s has left the fallout prematurely!",GetName(playerid));
  			SendClientMessageToAll(FALLOUT_FARBE,stringtu);
  			printf("[fallout] %s has dropped out of the fallout.", GetName(playerid));
  			SetPlayerPos(playerid,2517.0261,-1678.5011,14.3125);
			Iter_Remove(_Falloutr, playerid );
			JoinedFallout[playerid] = 0;
			FalloutPlayers--;
		  	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
			TextDrawSetString(leiste, stringtu);
			if( Iter_Count(_Falloutr ) < 2 )
			{
				foreach(_Falloutr, i ) FalloutWinner( i );
			}
		}
		else
		{
			Iter_Remove(_Falloutr, playerid );
			JoinedFallout[playerid] = 0;
		}
	}
	if (Dueler { playerid } == true)
	{
	    Iter_Remove(InDuel,playerid);
	    foreach(InDuel, i)
	    {
            DuelWinner(i);
	        format(stringtu,sizeof(stringtu),"[Duel]: {FFFFFF}%s has won the duel against %s!",GetName(i),GetName(playerid));
			printf("[duel] %s has won the duel against %s.",GetName(i), GetName(playerid));
			Remove_From_Duel(playerid);
	        Remove_From_Duel(i);
      	}
      	SendClientMessageToAll(0x00FFFF3A,stringtu);
	}
    if(InDm { playerid } == true)
		Remove_From_Dm(playerid);

    switch(reason)
    {
    	case 0:
    	{
    		SpielerSpeichern(playerid);
    		format(stringtu, sizeof(stringtu), "[Disconnect]: {FFFFFF}%s has left the {FF0000}xTreme Freeroam Server{FFFFFF}. (Timeout)", GetName(playerid));
    		SendClientMessageToAll(0x999999FF, stringtu);
    	}
    	case 1:
    	{
    		SpielerSpeichern(playerid);
    		format(stringtu, sizeof(stringtu), "[Disconnect]: {FFFFFF}%s has left the {FF0000}xTreme Freeroam Server{FFFFFF}.", GetName(playerid));
    		SendClientMessageToAll(0x999999FF, stringtu);
		}
    	case 2:
    	{
    		SpielerSpeichern(playerid);
    		format(stringtu, sizeof(stringtu), "[Disconnect]: {FFFFFF}%s has left the {FF0000}xTreme Freeroam Server{FFFFFF}. (Kick/Ban)", GetName(playerid));
    		SendClientMessageToAll(0x999999FF, stringtu);
    	}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawShowForPlayer(playerid, ServernameTD1[playerid]);
	TextDrawShowForPlayer(playerid, ServernameTD2[playerid]);
	TextDrawShowForPlayer(playerid, ServernameTD3[playerid]);
	TextDrawShowForPlayer(playerid, ServernameTD4[playerid]);
	TextDrawHideForPlayer(playerid, BoxOben);
	TextDrawHideForPlayer(playerid, BoxUnten);
	TextDrawShowForPlayer(playerid,FPS[playerid]);
	StopAudioStreamForPlayer(playerid);
	GivePlayerMoney(playerid, 10000);
	SetCameraBehindPlayer(playerid);
  	if(InDm { playerid } == true)
  	{
  		SetTimerEx("OnPlayerMiniGameSpawn", 30, false, "i", playerid);
  		GivePlayerMoney(playerid, -10000);
  	}
 	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
 	new playercash;
	TextDrawHideForPlayer(playerid, ServernameTD1[playerid]);
	TextDrawHideForPlayer(playerid, ServernameTD2[playerid]);
	TextDrawHideForPlayer(playerid, ServernameTD3[playerid]);
	TextDrawHideForPlayer(playerid, ServernameTD4[playerid]);
	PlayerInfo[playerid][Tode]++;
	PlayerInfo[killerid][Kills]++;
	SpielerSpeichern(playerid);
	SpielerSpeichern(killerid);
	StopAudioStreamForPlayer(playerid);
 	if((InDerby {playerid} == true) && (DerbyState == 3))
	 	Remove_From_Derby(playerid);
	if(JoinedRace[playerid] == 1)
 	{
		StartTime[playerid] = 0;
		JoinedRace[playerid] = 0;
		MotoGate[playerid] = 1;
		MotoGP[playerid] = 0;
		JoinedRace[playerid] = 0;
		RacePlayers--;
 		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
		DisablePlayerRaceCheckpoint(playerid);
   		format(stringtu,sizeof(stringtu),"[Race]: {FFFFFF}%s has been dropped out of the race!",GetName(playerid));
  		SendClientMessageToAll(RENN_FARBE,stringtu);
  		printf("[race] %s has been dropped out of the race.", GetName(playerid));
		if(RacePlayers < 1)
		{
			SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
			print("[race] The race has finished.");
			rennengestartet = 0;
			RacePlayers = 0;
			racelist = 1;
			KillTimer(Rennen);
		}
		return true;
	}

	if(killerid == INVALID_PLAYER_ID)
	{
        SendDeathMessage(INVALID_PLAYER_ID,playerid,reason);
        ResetPlayerMoney(playerid);
	}
	else
	{
	   	SendDeathMessage(killerid,playerid,reason);
		SetPlayerScore(killerid,GetPlayerScore(killerid)+2);
		playercash = GetPlayerMoney(playerid);
        ResetPlayerMoney(playerid);
		if(playercash > 0)
		{
			GivePlayerMoney(killerid, playercash);
			ResetPlayerMoney(playerid);
		}
   	}
   	
	if(JB_PlayerInfo[playerid][JB_pJailed] != 0)
	{
		SetPlayerInterior(playerid, 6);
		SetPlayerPos(playerid, 264.3700,77.5700,1001.0391);
		SetPlayerFacingAngle(playerid, 272.6900);
		SetCameraBehindPlayer(playerid);
	}
   	
	if (Dueler { playerid } == true)
	{
    	Iter_Remove(InDuel,playerid);
    	foreach(InDuel, i)
    	{
      		format(stringtu,sizeof(stringtu),"[Duel]: {FFFFFF}%s has won the duel against %s!",GetName(i),GetName(playerid));
            printf("[duel] %s has won the duel against %s.", GetName(i),GetName(playerid));
      		Remove_From_Duel(playerid);
      		DuelWinner(i);
      		Remove_From_Duel(i);
    	}
    	SendClientMessageToAll(0x00FFFF3A,stringtu);
  	}
  	if (InDm { playerid } == true)
  	{
        #if GiveAllPlayerMoney == 2
		new pmoney = GetPlayerMoney(playerid);
		if (pmoney > 0)
		{
			GivePlayerMoney(killerid,pmoney);
			ResetPlayerMoney(playerid);
		}
		#elseif GiveAllPlayerMoney == 1
		GivePlayerMoney(killerid,MoneyForKill);
		ResetPlayerMoney(playerid);
		#endif
        if(Killestreak[killerid] == 3)
        {
            GivePlayerMoney(killerid,Rampage_3Killes);
        }
        if(Killestreak[killerid] == 7)
        {
            GivePlayerMoney(killerid,Rampage_7Killes);
        }
        if(Killestreak[killerid] == 10)
        {
            GivePlayerMoney(killerid,Rampage_10Killes);
        }
        if(Killestreak[killerid] == 15)
        {
            GivePlayerMoney(killerid,Rampage_15Killes);
        }
        if(Killestreak[killerid] == 20)
        {
            GivePlayerMoney(killerid,Rampage_20Killes);
        }
        if(Killestreak[killerid] == 25)
        {
            GivePlayerMoney(killerid,Rampage_25Killes);
        }
        if(Killestreak[killerid] == 30)
        {
            GivePlayerMoney(killerid,Rampage_30Killes);
        }
        if(Killestreak[killerid] == 40)
        {
            GivePlayerMoney(killerid,Rampage_40Killes);
        }
        if(Killestreak[killerid] == 50)
        {
            GivePlayerMoney(killerid,Rampage_50Killes);
        }
        if(GetPlayerVirtualWorld(playerid) != 15) SetPlayerHealth(killerid , 100);
   	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:current;
    current = GetPlayerMenu(playerid);
    if(current == WangCars)
	{
		switch(row)
		{
			case 0:
			{
				if(GetPlayerMoney(playerid)<3000000) return GameTextForPlayer(playerid, "~r~You need at least 3000000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -3000000);
			 	GameTextForPlayer(playerid, "~r~-3000000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 560;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (560)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a sultan, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
			    VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 1:
			{
				if(GetPlayerMoney(playerid)<2500000) return GameTextForPlayer(playerid, "~r~You need at least 2500000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -2500000);
			 	GameTextForPlayer(playerid, "~r~-2500000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 558;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (558)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought an UrANUS, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 2:
			{
				if(GetPlayerMoney(playerid)<2600000) return GameTextForPlayer(playerid, "~r~You need at least 2600000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -2600000);
			 	GameTextForPlayer(playerid, "~r~-2600000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 559;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (559)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a jester, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
				}
			case 3:
			{
				if(GetPlayerMoney(playerid)<2900000) return GameTextForPlayer(playerid, "~r~You need at least 2900000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -2900000);
			 	GameTextForPlayer(playerid, "~r~-2900000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 561;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (561)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a stratum, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 4:
			{
				if(GetPlayerMoney(playerid)<2800000) return GameTextForPlayer(playerid, "~r~You need at least 2800000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -2800000);
			 	GameTextForPlayer(playerid, "~r~-2800000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 562;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (562)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought an elegy, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 5:
			{
				if(GetPlayerMoney(playerid)<2300000) return GameTextForPlayer(playerid, "~r~You need at least 2300000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -2300000);
			 	GameTextForPlayer(playerid, "~r~-2300000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 565;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (565)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a flash, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 6:
			{
				HideMenuForPlayer(WangCars,playerid);
				TogglePlayerControllable(playerid, true);
			}
		}
	}
	if(current == CouttBikes)
	{
		switch(row)
		{
			case 0:
			{
				if(GetPlayerMoney(playerid)<3000000) return GameTextForPlayer(playerid, "~r~You need at least 3000000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -3000000);
			 	GameTextForPlayer(playerid, "~r~-3000000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 522;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (522)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a nrg-500, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 1:
			{
				if(GetPlayerMoney(playerid)<2000000) return GameTextForPlayer(playerid, "~r~You need at least 2000000$!", 5000, 6);
			 	GivePlayerMoney(playerid, -2000000);
			 	GameTextForPlayer(playerid, "~r~-2000000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 521;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (521)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a fcr-900, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 2:
			{
				if(GetPlayerMoney(playerid)<1000000) return GameTextForPlayer(playerid, "~r~You need at least 1000000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -1000000);
			 	GameTextForPlayer(playerid, "~r~-1000000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 463;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (463)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a freeway, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 3:
			{
				if(GetPlayerMoney(playerid)<1900000) return GameTextForPlayer(playerid, "~r~You need at least 1900000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -1900000);
			 	GameTextForPlayer(playerid, "~r~-1900000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 468;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (468)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a sanchez, congratulations! Use /Car to call it.");
			    hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 4:
			{
				if(GetPlayerMoney(playerid)<940000) return GameTextForPlayer(playerid, "~r~You need at least 940000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -940000);
			 	GameTextForPlayer(playerid, "~r~-940000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 586;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (586)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a wayfarer, congratulations! Use /Car to call it.");
			    hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 5:
			{
				if(GetPlayerMoney(playerid)<1700000) return GameTextForPlayer(playerid, "~r~You need at least 1700000$.", 5000, 6);
			 	GivePlayerMoney(playerid, -1700000);
			 	GameTextForPlayer(playerid, "~r~-1700000$", 2000, 1);
			  	PlayerInfo[playerid][Hausauto] = 461;
				ResetCarTuning(playerid);
				printf("[veh] %s has bought a car. (461)", GetName(playerid));
			  	SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You bought a pgj-600, congratulations! Use /Car to call it.");
			  	hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
				VehicleOwner[hausauto[playerid]]=playerid;
				SetVehicleToRespawn(hausauto[playerid]);
			}
			case 6:
			{
				HideMenuForPlayer(CouttBikes,playerid);
				TogglePlayerControllable(playerid, true);
			}
		}
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    for(new i=0;i<MAX_PLAYERS;i++)
		if((InDerby {i} == true) && (DerbyState == 3))
			Remove_From_Derby(i);
	return 1;
}

stock ResetCarTuning(playerid)
{
  	PlayerInfo[playerid][Nos] = 0;
	PlayerInfo[playerid][Hydraulik] = 0;
	PlayerInfo[playerid][Stereo] = 0;
	PlayerInfo[playerid][Motorhaube] = 0;
	PlayerInfo[playerid][EckLuftR] = 0;
	PlayerInfo[playerid][EckLuftL] = 0;
	PlayerInfo[playerid][OvalLuftR] = 0;
	PlayerInfo[playerid][OvalLuftL] = 0;
	PlayerInfo[playerid][Lampen] = 0;
	PlayerInfo[playerid][SeitenschwellerR] = 0;
	PlayerInfo[playerid][SeitenschwellerL] = 0;
	PlayerInfo[playerid][Auspuff] = 0;
	PlayerInfo[playerid][Dach] = 0;
	PlayerInfo[playerid][Heckstossstange] = 0;
	PlayerInfo[playerid][Frontstossstange] = 0;
	PlayerInfo[playerid][Spoiler] = 0;
	PlayerInfo[playerid][Felgen] = 0;
	PlayerInfo[playerid][Paintjob] = -1;
	PlayerInfo[playerid][Farbe1] = -1;
	PlayerInfo[playerid][Farbe2] = -1;
	SpielerSpeichern(playerid);
	HideMenuForPlayer(WangCars,playerid);
	HideMenuForPlayer(CouttBikes, playerid);
  	TogglePlayerControllable(playerid, true);
}


public OnPlayerText(playerid, text[])
{
	if(text[0] == '#' && PlayerInfo[playerid][Adminlevel] >= 1)
	{
		format(stringtu,sizeof(stringtu),"(ADMINCHAT) %s: {FFFFFF}%s",GetName(playerid),text[1]);
		SendClientMessageToAdmins(ADMIN_FARBE, stringtu,1);
		printf("[adminchat] [%s]: %s", GetName(playerid),text[1]);
 		return 0;
	}
	if(!strcmp(text, reactionstr, false))
	{
		if(reactioninprog == 2)
		{
			ReactionWin(playerid);
			return 0;
		}
		return 1;
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
  	if(DerbyState == 3)
  	{
    	if(InDerby {playerid} == true)
    	{
	 		Out[playerid] = 1;
    	}
  	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if (newkeys & KEY_FIRE)
		{
		    new Float:vx, Float:vy, Float:vz;
		    GetVehicleVelocity(GetPlayerVehicleID(playerid), vx, vy, vz);
		}
	}
	if(newkeys & KEY_FIRE && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);

	if(oldkeys & KEY_FIRE && IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == 2 || newstate == 3)
	{
		Speedotimer[playerid] = SetTimerEx("Speedo", 500, 1, "d", playerid);
		TextDrawShowForPlayer(playerid, SpeedoTD[playerid]);
 		TextDrawShowForPlayer(playerid, SpeedoTD2[playerid]);
  		TextDrawShowForPlayer(playerid, SpeedoTD3[playerid]);
	}
	if(newstate == 1)
	{
		KillTimer(Speedotimer[playerid]);
		TextDrawHideForPlayer(playerid, SpeedoTD[playerid]);
 		TextDrawHideForPlayer(playerid, SpeedoTD2[playerid]);
  		TextDrawHideForPlayer(playerid, SpeedoTD3[playerid]);
    }
	if (MotoGP[playerid] == 1 && (newstate == 1 && oldstate == 2))
 	{
		StartTime[playerid] = 0;
		RaceTime[playerid] = 0;
		JoinedRace[playerid] = 0;
		MotoGate[playerid] = 1;
		MotoGP[playerid] = 0;
		JoinedRace[playerid] = 0;
		RacePlayers--;
  		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
		DisablePlayerRaceCheckpoint(playerid);
   		format(stringtu,sizeof(stringtu),"[Race]: {FFFFFF}%s has been dropped out of the race!",GetName(playerid));
   		SendClientMessageToAll(RENN_FARBE,stringtu);
  		printf("[race] %s has dropped out of the race.", GetName(playerid));
		if(RacePlayers < 1)
		{
			SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
			print("[race] The race has finished.");
			rennengestartet = 0;
			RacePlayers = 0;
			racelist = 1;
			KillTimer(Rennen);
  		}
	}
	if(newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER && JoinedRace[playerid] == 1 && rennengestartet == 0)
	{
        MotoGP[playerid] = 0;
        MotoGate[playerid] = 1;
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
		JoinedRace[playerid] = 0;
		RaceTime[playerid] = 0;
		StartTime[playerid] = 0;
		JoinedRace[playerid] = 0;
		RacePlayers--;
  		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
   		format(stringtu,sizeof(stringtu),"[Race]: {FFFFFF}%s has been dropped out of the race!",GetName(playerid));
   		SendClientMessageToAll(RENN_FARBE,stringtu);
   		printf("[race] %s has dropped out of the race.", GetName(playerid));
		if(RacePlayers < 1)
		{
			SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
			print("[race] The race has finished.");
			rennengestartet = 0;
			RacePlayers = 0;
			racelist = 1;
			KillTimer(Rennen);
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	JB_PlayerInfo[playerid][JB_pCommands]++;
	if(!IsPlayerNPC(playerid) && JB_Variables[COMMAND_SPAM] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
    {
        if(JB_PlayerInfo[playerid][JB_pCommands]>20)
	    {
	        JB_Kick(playerid,"Commandspam");
	        return 1;
	    }
    }
	return 0;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
	new string[128];
	format(string,sizeof(string),"- %.0f", amount);
	SetPlayerChatBubble(playerid, string, 0xFFFFFFFF, 15.0, 1000);
 	PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
  	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	switch (RaceStatus[playerid])
	{
	    case RACEWAIT:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				RaceStatus[playerid] = RACESTART;
				return true;
			}
			return true;
		}
		case RACESTART:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r2][0],RaceInfo[r2][1],RaceInfo[r2][2],RaceInfo[r3][0],RaceInfo[r3][1],RaceInfo[r3][2],20.0);
			RaceStatus[playerid] = RACECP2;
			MotoGate[playerid] = 1;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			return true;
		}
		case RACECP2:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r3][0],RaceInfo[r3][1],RaceInfo[r3][2],RaceInfo[r4][0],RaceInfo[r4][1],RaceInfo[r4][2],12.0);
			RaceStatus[playerid] = RACECP3;
			MotoGate[playerid] = 2;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			return true;
		}
		case RACECP3:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r4][0],RaceInfo[r4][1],RaceInfo[r4][2],RaceInfo[r5][0],RaceInfo[r5][1],RaceInfo[r5][2],12.0);
            RaceStatus[playerid] = RACECP4;
			MotoGate[playerid] = 3;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP4:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r5][0],RaceInfo[r5][1],RaceInfo[r5][2],RaceInfo[r6][0],RaceInfo[r6][1],RaceInfo[r6][2],12.0);
            RaceStatus[playerid] = RACECP5;
			MotoGate[playerid] = 4;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP5:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r6][0],RaceInfo[r6][1],RaceInfo[r6][2],RaceInfo[r7][0],RaceInfo[r7][1],RaceInfo[r7][2],12.0);
            RaceStatus[playerid] = RACECP6;
			MotoGate[playerid] = 5;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP6:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r7][0],RaceInfo[r7][1],RaceInfo[r7][2],RaceInfo[r8][0],RaceInfo[r8][1],RaceInfo[r8][2],12.0);
            RaceStatus[playerid] = RACECP7;
			MotoGate[playerid] = 6;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		}
		case RACECP7:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r8][0],RaceInfo[r8][1],RaceInfo[r8][2],RaceInfo[r9][0],RaceInfo[r9][1],RaceInfo[r9][2],12.0);
            RaceStatus[playerid] = RACECP8;
			MotoGate[playerid] = 7;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP8:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r9][0],RaceInfo[r9][1],RaceInfo[r9][2],RaceInfo[r10][0],RaceInfo[r10][1],RaceInfo[r10][2],12.0);
            RaceStatus[playerid] = RACECP9;
			MotoGate[playerid] = 8;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP9:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r10][0],RaceInfo[r10][1],RaceInfo[r10][2],RaceInfo[r11][0],RaceInfo[r11][1],RaceInfo[r11][2],12.0);
            RaceStatus[playerid] = RACECP10;
			MotoGate[playerid] = 9;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP10:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r11][0],RaceInfo[r11][1],RaceInfo[r11][2],RaceInfo[r12][0],RaceInfo[r12][1],RaceInfo[r12][2],12.0);
            RaceStatus[playerid] = RACECP11;
			MotoGate[playerid] = 10;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP11:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r12][0],RaceInfo[r12][1],RaceInfo[r12][2],RaceInfo[r13][0],RaceInfo[r13][1],RaceInfo[r13][2],12.0);
            RaceStatus[playerid] = RACECP12;
			MotoGate[playerid] = 11;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP12:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r13][0],RaceInfo[r13][1],RaceInfo[r13][2],RaceInfo[r14][0],RaceInfo[r14][1],RaceInfo[r14][2],12.0);
			RaceStatus[playerid] = RACECP13;
			MotoGate[playerid] = 12;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			return true;
		}
		case RACECP13:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r14][0],RaceInfo[r14][1],RaceInfo[r14][2],RaceInfo[r15][0],RaceInfo[r15][1],RaceInfo[r15][2],12.0);
            RaceStatus[playerid] = RACECP14;
			MotoGate[playerid] = 13;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP14:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r15][0],RaceInfo[r15][1],RaceInfo[r15][2],RaceInfo[r16][0],RaceInfo[r16][1],RaceInfo[r16][2],12.0);
            RaceStatus[playerid] = RACECP15;
			MotoGate[playerid] = 14;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP15:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r16][0],RaceInfo[r16][1],RaceInfo[r16][2],RaceInfo[r17][0],RaceInfo[r17][1],RaceInfo[r17][2],12.0);
            RaceStatus[playerid] = RACECP16;
			MotoGate[playerid] = 15;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP16:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r17][0],RaceInfo[r17][1],RaceInfo[r17][2],RaceInfo[r18][0],RaceInfo[r18][1],RaceInfo[r18][2],12.0);
            RaceStatus[playerid] = RACECP17;
			MotoGate[playerid] = 16;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		}
		case RACECP17:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r18][0],RaceInfo[r18][1],RaceInfo[r18][2],RaceInfo[r19][0],RaceInfo[r19][1],RaceInfo[r19][2],12.0);
            RaceStatus[playerid] = RACECP18;
			MotoGate[playerid] = 17;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP18:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r19][0],RaceInfo[r19][1],RaceInfo[r19][2],RaceInfo[r20][0],RaceInfo[r20][1],RaceInfo[r20][2],12.0);
            RaceStatus[playerid] = RACECP19;
			MotoGate[playerid] = 18;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACECP19:
		{
			if (!IsPlayerInAnyVehicle(playerid))
			{
				SendClientMessage(playerid, 0xFF00000, "[Warning]: {FFFFFF}You have to be in a vehicle.");
				return true;
			}
			DisablePlayerRaceCheckpoint(playerid);
			SetPlayerRaceCheckpoint(playerid,1,RaceInfo[r20][0],RaceInfo[r20][1],RaceInfo[r20][2],RaceInfo[r20][0],RaceInfo[r20][1],RaceInfo[r20][2],12.0);
            RaceStatus[playerid] = RACEFINISH;
			MotoGate[playerid] = 19;
			PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
            return true;
		}
		case RACEFINISH:
		{
		 		DisablePlayerRaceCheckpoint(playerid);
				RaceTime[playerid] = GetTickCount();
				pos1time = RaceTime[playerid] - StartTime[playerid];
				GetTimeAsString(pos1time);
				ConvertTicks(pos1time);
				if(RaceInfo[rBestms3] > pos1time || RaceInfo[rBestms3] == 0)
				{
				printf("[race] %s made a new record. (3rd)", GetName(playerid));
				format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has set a new record. (Race: %s | Position: 3 | Time: %d:%02d:%02d0)",GetName(playerid),CurrentRace,cmins,csecs,cmils);
				if(RaceInfo[rBestms2] > pos1time || RaceInfo[rBestms2] == 0)
				{
                    printf("[race] %s made a new record. (2nd)", GetName(playerid));
					format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has set a new record. (Race: %s | Position: 2 | Time: %d:%02d:%02d0)",GetName(playerid),CurrentRace,cmins,csecs,cmils);
					if(RaceInfo[rBestms1] > pos1time || RaceInfo[rBestms1] == 0)
					{
							format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has set a new record. (Race: %s | Position: 1 | Time: %d:%02d:%02d0)",GetName(playerid),CurrentRace,cmins,csecs,cmils);
  							GivePlayerMoney(playerid, winnings);
  							printf("[race] %s made a new record. (1st)", GetName(playerid));
							SetPlayerScore(playerid,GetPlayerScore(playerid)+5);
							RaceInfo[rBestms1] = pos1time;
							RaceInfo[rName1] = GetName(playerid);
						}
						else
						{
						    GivePlayerMoney(playerid, winnings/2);
							SetPlayerScore(playerid,GetPlayerScore(playerid)+3);
							RaceInfo[rBestms2] = pos1time;
							RaceInfo[rName2] = GetName(playerid);
						}
					}
					else
					{
						GivePlayerMoney(playerid, winnings/3);
						SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
						RaceInfo[rBestms3] = pos1time;
						RaceInfo[rName3] = GetName(playerid);
					}
					SaveTimes(CurrentRace);
					SendClientMessageToAll(RENN_FARBE,stringtu);
				}
				if(RacePosition1 == 999)
				{
						format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has finished the race as 1st!",GetName(playerid));
						SendClientMessageToAll(RENN_FARBE,stringtu);
						printf("[race] %s finished the race. (1st)", GetName(playerid));
						GivePlayerMoney(playerid, winnings);
						SetPlayerScore(playerid,GetPlayerScore(playerid)+3);
						RacePosition1 = playerid;
						MotoGate[playerid] = 11;
						MotoGP[playerid] = 0;
						racelist = 1;
						JoinedRace[playerid] = 0;
						MotoGate[playerid] = 1;
						RacePlayers--;
  					   	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
						TextDrawSetString(leiste, stringtu);
						RaceTime[playerid] = 0;
						StartTime[playerid] = 0;
						SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
						PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
						SpielerSpeichern(playerid);
						if(RacePlayers < 1)
						{
							SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
							print("[race] The race has finished.");
							rennengestartet = 0;
							RacePlayers = 0;
							racelist = 1;
							KillTimer(Rennen);
						}
						else
						{
							Rennen=SetTimerEx("RaceEnd",30000,0,"i",playerid);
							print("[race] The race will end in 30 seconds.");
							SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race will end in 30 seconds!");
						}
						return true;
				}
				else if(RacePosition2 == 999)
				{
						format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has finished the race as 2nd!",GetName(playerid));
						SendClientMessageToAll(RENN_FARBE,stringtu);
						printf("[race] %s finished the race. (2nd)", GetName(playerid));
				    	GivePlayerMoney(playerid, winnings/2);
						SetPlayerScore(playerid,GetPlayerScore(playerid)+2);
				    	RacePosition2 = playerid;
				    	RaceStatus[playerid] = 999;
						MotoGate[playerid] = 11;
   						MotoGP[playerid] = 0;
						racelist = 1;
						JoinedRace[playerid] = 0;
						MotoGate[playerid] = 1;
						RacePlayers--;
  					   	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
						TextDrawSetString(leiste, stringtu);
						RaceTime[playerid] = 0;
						StartTime[playerid] = 0;
						SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
						PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
						SpielerSpeichern(playerid);
						if(RacePlayers < 1)
						{
							SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
							print("[race] The race has finished.");
							rennengestartet = 0;
							rennengestartet = 0;
							RacePlayers = 0;
							racelist = 1;
							KillTimer(Rennen);
  						}
				    	return true;
				}
				else if(RacePosition3 == 999)
				{
						format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has finished the race as 3rd!",GetName(playerid));
						SendClientMessageToAll(RENN_FARBE,stringtu);
						printf("[race] %s finished the race. (3rd)", GetName(playerid));
				    	GivePlayerMoney(playerid, winnings/3);
						SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
				    	RacePosition3 = playerid;
				    	RaceStatus[playerid] = 999;
				    	JoinedRace[playerid] = 0;
						MotoGate[playerid] = 20;
   						MotoGP[playerid] = 0;
						racelist = 1;
						JoinedRace[playerid] = 0;
						MotoGate[playerid] = 1;
						RaceTime[playerid] = 0;
						StartTime[playerid] = 0;
						RacePlayers--;
  					   	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
						TextDrawSetString(leiste, stringtu);
						SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
						PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
						SpielerSpeichern(playerid);
						if(RacePlayers < 1)
						{
							SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
							print("[race] The race has finished.");
							rennengestartet = 0;
							rennengestartet = 0;
							RacePlayers = 0;
							racelist = 1;
							KillTimer(Rennen);
  						}
					    return true;
				}
				else
				{
					RaceTime[playerid] = GetTickCount();
					pos4time = RaceTime[playerid] - StartTime[playerid];
					GetTimeAsString(pos4time);
					ConvertTicks(pos4time);
				    DisablePlayerRaceCheckpoint(playerid);
					format(stringtu, sizeof(stringtu), "[Race]: {FFFFFF}%s has finished the race!",GetName(playerid));
					SendClientMessageToAll(RENN_FARBE,stringtu);
					printf("[race] %s finished the race.", GetName(playerid));
					MotoGate[playerid] = 20;
   					MotoGP[playerid] = 0;
     				racelist = 1;
					JoinedRace[playerid] = 0;
					MotoGate[playerid] = 1;
					RacePlayers--;
  					format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
					TextDrawSetString(leiste, stringtu);
					RaceTime[playerid] = 0;
					StartTime[playerid] = 0;
					SetVehicleHealth(GetPlayerVehicleID(playerid),1000);
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
					SpielerSpeichern(playerid);
					if(RacePlayers < 1)
					{
						SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished!");
						print("[race] The race has finished.");
						rennengestartet = 0;
						rennengestartet = 0;
						RacePlayers = 0;
						racelist = 1;
						KillTimer(Rennen);
					}
					return true;
				}
			}
		}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid==Bankeingang)
	{
		SetPlayerPos(playerid,1416.951171,-988.971191,1639.980224);
	}
	if(pickupid==Bankausgang)
	{
		SetPlayerPos(playerid,590.6481,-1246.3456,17.7698);
		SetCameraBehindPlayer(playerid);
	}
	if(pickupid==Tikki1)
	{
	    if(PlayerInfo[playerid][Tiki1] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki1] == 0)
		{
			PlayerInfo[playerid][Tiki1] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki2)
	{
	    if(PlayerInfo[playerid][Tiki2] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki2] == 0)
		{
			PlayerInfo[playerid][Tiki2] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki3)
	{
	    if(PlayerInfo[playerid][Tiki3] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki3] == 0)
		{
			PlayerInfo[playerid][Tiki3] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki4)
	{
	    if(PlayerInfo[playerid][Tiki4] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki4] == 0)
		{
			PlayerInfo[playerid][Tiki4] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki5)
	{
	    if(PlayerInfo[playerid][Tiki5] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki5] == 0)
		{
			PlayerInfo[playerid][Tiki5] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki6)
	{
	    if(PlayerInfo[playerid][Tiki6] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki6] == 0)
		{
			PlayerInfo[playerid][Tiki6] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki7)
	{
	    if(PlayerInfo[playerid][Tiki7] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki7] == 0)
		{
			PlayerInfo[playerid][Tiki7] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki8)
	{
	    if(PlayerInfo[playerid][Tiki8] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki8] == 0)
		{
			PlayerInfo[playerid][Tiki8] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki9)
	{
	    if(PlayerInfo[playerid][Tiki9] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki9] == 0)
		{
			PlayerInfo[playerid][Tiki9] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	if(pickupid==Tikki10)
	{
	    if(PlayerInfo[playerid][Tiki10] == 1)
	    {
	        SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already found this tikki.");
		}
		else if(PlayerInfo[playerid][Tiki10] == 0)
		{
			PlayerInfo[playerid][Tiki10] = 1;
   			SendClientMessage(playerid, TIKKI_FARBE, "[Tikki]: {FFFFFF}You have found this tikki! (50000$ & 3 Score)");
			GivePlayerMoney(playerid, 50000);
			SetPlayerScore(playerid, GetPlayerScore(playerid)+3);
			printf("[race] %s found a tiki.", GetName(playerid));
		}
	}
	for(new i;i<currHaus;i++)
	{
		if(pickupid == Haus[i][Pickup])
		{
		    new Text[100];
		    format(Text,sizeof(Text),"~w~Besitzer : %s~n~Kosten : %d$~n~Score : %d",Haus[i][HausBesitzer],Haus[i][Hauskosten],Haus[i][HausScore]);
		    GameTextForPlayer(playerid,Text,1000,3);
		    pTestID[playerid] = Haus[i][HausID];
		}
	}
	if(pickupid==wangpick)
	{
		if(PlayerInfo[playerid][pHausID] == -1)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You need a house before you can buy a car!");
		if(PlayerInfo[playerid][Hausauto] != 0) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already got a car!");
		if(GetPlayerScore(playerid)<MIN_SCORE_WANG) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You need at least "#MIN_SCORE_WANG" score!");
		ShowMenuForPlayer(WangCars,playerid);
		TogglePlayerControllable(playerid, false);
		return 1;
	}
	if(pickupid==couttpick)
	{
		if(PlayerInfo[playerid][pHausID] == -1)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You need a house before you can buy a car!");
		if(PlayerInfo[playerid][Hausauto] != 0) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You already got a car!");
		if(GetPlayerScore(playerid)<MIN_SCORE_COUTT) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You need at least "#MIN_SCORE_COUTT" score!");
		ShowMenuForPlayer(CouttBikes,playerid);
		TogglePlayerControllable(playerid, false);
		return 1;
	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
 	if(InDm { playerid } == true)
 	{
   		if((newinteriorid == 0) && GetPlayerVirtualWorld(playerid) == 7) SetPlayerInterior(playerid, 10);
   		if((newinteriorid == 0) && GetPlayerVirtualWorld(playerid) == 10) SetPlayerInterior(playerid, 1);
   		if((newinteriorid == 0) && GetPlayerVirtualWorld(playerid) == 12) SetPlayerInterior(playerid, 1);
   		if((newinteriorid == 0) && GetPlayerVirtualWorld(playerid) == 15) SetPlayerInterior(playerid, 18);
   		if((newinteriorid == 0) && GetPlayerVirtualWorld(playerid) == 14) SetPlayerInterior(playerid, 2);
 	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	new drunk2 = GetPlayerDrunkLevel(playerid);
	if(drunk2 < 100)
	{
		SetPlayerDrunkLevel(playerid,2000);
	}
	else
	{
		if(DLlast[playerid] != drunk2)
		{
			new fps = DLlast[playerid] - drunk2;
			if((fps > 0) && (fps < 200))
			FPS2[playerid] = fps;
			DLlast[playerid] = drunk2;
		}
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == Derbyvote)
	{
  	  	switch(listitem)
      	{
		 	case 0:
		 	{
            	DerbyVote[0]++;
            	foreach(InDerby, i)
            	{
     		  		format(stringtu,sizeof(stringtu),"[Derby]: {FFFFFF}%s has choosen the map 'Mount Chiliad'.",GetName(playerid));
              		SendClientMessageToAll(DERBY_FARBE,stringtu);
					printf("[derby] %s choosed map \"Mount Chiliad\".", GetName(playerid));
               		TogglePlayerControllable(playerid,false);
            	}
         	}
			case 1:
		 	{
            	DerbyVote[1]++;
            	foreach(InDerby, i)
            	{
     		  		format(stringtu,sizeof(stringtu),"[Derby]: {FFFFFF}%s has choosen the map 'LS Forum'.",GetName(playerid));
              		SendClientMessageToAll(DERBY_FARBE,stringtu);
              		printf("[derby] %s choosed map \"LS Forum\".", GetName(playerid));
 		 			TogglePlayerControllable(playerid,false);
            	}
         	}
		}
    }
	if(dialogid == Duelltext)
	{
		if(!response) ShowPlayerDialog(playerid,Duelltext,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Duel","1. Desert Eagle\n2. Shotgun\n3. Sawn-Off Shotgun\n4. Combat Shotgun\n5. M4\n6. Mp5 \n7. Uzi\n8. Sniper Rifle\n9. Country Rifle\n10. FlameThrower\n11. Minigun\n12. Grenade\n13. Molotov Cocktails\n14. Satchel Charge\n15. ChainSaw","Ok", "Cancel");
		if(response)
		{
           	switch(listitem)
           	{
                case 0: DuelWeaponName = "Desert Eagle";
                case 1: DuelWeaponName = "ShotGun";
                case 2: DuelWeaponName = "Sawn Off";
                case 3: DuelWeaponName = "Combat ShotGun";
                case 4: DuelWeaponName = "M4";
                case 5: DuelWeaponName = "Mp5";
                case 6: DuelWeaponName = "Uzi";
                case 7: DuelWeaponName = "Sniper Rifle";
                case 8: DuelWeaponName = "Country Rifle";
                case 9: DuelWeaponName = "FlameThrower";
                case 10: DuelWeaponName = "MiniGun";
                case 11: DuelWeaponName = "Grenades";
                case 12: DuelWeaponName = "Molotov Cocktail";
                case 13: DuelWeaponName = "Satchels";
                case 14: DuelWeaponName = "ChainSaw";
           	}
           	DuelWeapon = listitem;
           	DuelInfo =1;
           	format(stringtu,sizeof(stringtu),"[Duel]: {FFFFFF}%s wants a duel! (/Duel)",GetName(playerid));
           	SendClientMessageToAll(0x00FFFF3A, stringtu);
           	printf("[duel] %s's waiting for an opponent.", GetName(playerid));
		}
	}
	if(dialogid == Logindialog)
	{
		if(response == 0)
		return Kick(playerid);
    	else if(response == 1)
    	{
    		if(!strlen(inputtext))
				return ShowPlayerDialog(playerid, Logindialog, DIALOG_STYLE_PASSWORD, "{FF0000}XFS: {FFFFFF}Login", "Welcome back, mate. Your account has been found in our database.\nPlease enter your password to login.\n\nBest regards,\n"#Owner".", "Login", "Cancel");
    		else
				LoginPlayer(playerid, inputtext);
 		}
	}
	if(dialogid == Registerdialog)
	{
		if(response == 0)
		return Kick(playerid);
    	else if(response == 1)
    	{
    		if(!strlen(inputtext))
    			return ShowPlayerDialog(playerid, Registerdialog, DIALOG_STYLE_PASSWORD, "{FF0000}XFS: {FFFFFF}Register", "Welcome to our server!\nYour account has not been found in our database.\nPlease register to start playing here.\n\nBest regards,\n"#Owner".", "Register", "Cancel");
			else
    			RegisterPlayer(playerid, inputtext);
		}
	}
	if(dialogid == Bankmenu)
	{
		if(response)
		{
			if(listitem == 0)
				ShowPlayerDialog(playerid,Einzahlung,DIALOG_STYLE_INPUT,"{FF0000}XFS: {FFFFFF}Deposit","Please enter the value of money that you want to deposit.","Deposit","Cancel");
			if(listitem == 1)
				ShowPlayerDialog(playerid,Auszahlung,DIALOG_STYLE_INPUT,"{FF0000}XFS: {FFFFFF}Withdraw","Please enter the value of money that you want to withdraw.","Withdraw","Cancel");
			if(listitem == 2)
			{
				format(stringtu,sizeof(stringtu),"At this moment you are having {FF0000}%d$ {FFFFFF}on your bank account.",PlayerInfo[playerid][Bankgeld]);
				ShowPlayerDialog(playerid,Kontostand,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Bank account",stringtu,"Close","");
			}
			if(listitem == 3)
				ShowPlayerDialog(playerid,Ueberweisung,DIALOG_STYLE_INPUT,"{FF0000}XFS: {FFFFFF}Transfer money","Please enter the ID of the player you want to transfer money to.","Ok","Cancel");
		}
	}
	if(dialogid == Einzahlung)
	{
		if(!response)return ShowPlayerDialog(playerid,Bankmenu,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Bank","Deposit\nWithdraw\nCurrent money\nTransfer","Choose","Close");
		if(GetPlayerMoney(playerid) < strval(inputtext))return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You don't have enough money.");
		GivePlayerMoney(playerid, - strval(inputtext));
		PlayerInfo[playerid][Bankgeld] += strval(inputtext);
		format(stringtu,sizeof(stringtu),"You deposited {FF0000}%d$ {FFFFFF}on your bank account.",strval(inputtext));
		ShowPlayerDialog(playerid,EinzahlungText,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Deposit",stringtu,"Close","");
		printf("[bank] %s deposited %d$.", GetName(playerid),strval(inputtext));
		SpielerSpeichern(playerid);
	}
	if(dialogid == Auszahlung)
	{
		if(!response)return ShowPlayerDialog(playerid,Bankmenu,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Bank","Deposit\nWithdraw\nCurrent money\nTransfer","Choose","Close");
		if(PlayerInfo[playerid][Bankgeld] < strval(inputtext))return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You don't have enough money on your bank account.");
		GivePlayerMoney(playerid,strval(inputtext));
		PlayerInfo[playerid][Bankgeld] -= strval(inputtext);
		format(stringtu,sizeof(stringtu),"You have withdrawn {FF0000}%d$ {FFFFFF}from your bank account.",strval(inputtext));
		ShowPlayerDialog(playerid,AuszahlungText,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Withdraw",stringtu,"Close","");
        printf("[bank] %s withdrawed %d$.", GetName(playerid),strval(inputtext));
		SpielerSpeichern(playerid);
	}
	if(dialogid == Ueberweisung)
	{
		new pID;
		if(!response)return ShowPlayerDialog(playerid,Bankmenu,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Bank","Deposit\nWithdraw\nCurrent money\nTransfer","Choose","Close");
		if(sscanf(inputtext,"u",pID))return ShowPlayerDialog(playerid,UeberweisungText1,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Transfer money","This player is not online.","Close","");
		if(!IsPlayerConnected(pID))return ShowPlayerDialog(playerid,UeberweisungText1,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Transfer money","This player is not online.","Close","");
		if (pID == playerid)return ShowPlayerDialog(playerid,UeberweisungText1,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Transfer money","You can't transfer money to yourself, lol.","Close","");
		ShowPlayerDialog(playerid,Ueberweisung2,DIALOG_STYLE_INPUT,"{FF0000}XFS: {FFFFFF}Transfer money","Please enter the value of money you want to transfer:","Überweisen","Abbrechen");
		Ueberweiser[playerid] = pID;
		Ueberweiser[pID] = playerid;
	}
	if(dialogid == Ueberweisung2)
	{
		new pID = Ueberweiser[playerid];
		if(!response)return ShowPlayerDialog(playerid,Bankmenu,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Bank","Deposit\nWithdraw\nCurrent money\nTransfer","Choose","Close");
		if(PlayerInfo[playerid][Bankgeld] < strval(inputtext))return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You don't have enough money on your bank account.");
		PlayerInfo[playerid][Bankgeld] -= strval(inputtext);
		PlayerInfo[pID][Bankgeld] += strval(inputtext);
		format(stringtu,sizeof(stringtu),"You transfered {FF0000}%d$ {FFFFFF}from your bank account to {FF0000}%s {FFFFFF}.",strval(inputtext),GetName(pID));
		ShowPlayerDialog(playerid,UeberweisungText1,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Transfer money",stringtu,"Close","");
		format(stringtu,sizeof(stringtu),"[Bank]: {FFFFFF}%s has transfered %d$ to your bank account.",GetName(playerid),strval(inputtext));
		SendClientMessage(pID,0x00FFFFFF,stringtu);
        printf("[bank] %s gave %s %d$.", GetName(playerid),GetName(pID),strval(inputtext));
		SpielerSpeichern(playerid);
	}
	else if(dialogid == Haustypdialog)
	{
	    if(response)
	    {
	        new Float:Pos[3];
	        GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
	        if(listitem == 0)
	        {
	            Haus[currHaus-1][AusgangX] = 444.646911;
	            Haus[currHaus-1][AusgangY] = 508.239044;
	            Haus[currHaus-1][AusgangZ] = 1001.419494;
	            Haus[currHaus-1][HausVw] = vw1;
	            Haus[currHaus-1][HausInterior] = 12;
	            vw1++;
			}
			if(listitem == 1)
			{
	            Haus[currHaus-1][AusgangX] = 2262.83;
	            Haus[currHaus-1][AusgangY] = -1137.71;
	            Haus[currHaus-1][AusgangZ] = 1050.63;
	            Haus[currHaus-1][HausVw] = vw2;
	            Haus[currHaus-1][HausInterior] = 10;
	            vw2++;
			}
			if(listitem == 2)
			{
	            Haus[currHaus-1][AusgangX] = -2159.122802;
	            Haus[currHaus-1][AusgangY] = 641.517517;
	            Haus[currHaus-1][AusgangZ] = 1052.381713;
	            Haus[currHaus-1][HausVw] = vw3;
	            Haus[currHaus-1][HausInterior] = 1;
	            vw3++;
			}
			if(listitem == 3)
			{
	            Haus[currHaus-1][AusgangX] = 2454.717041;
	            Haus[currHaus-1][AusgangY] = -1700.871582;
	            Haus[currHaus-1][AusgangZ] = 1013.515197;
	            Haus[currHaus-1][HausVw] = vw4;
	            Haus[currHaus-1][HausInterior] = 2;
	            vw4++;
			}
			if(listitem == 4)
			{
	            Haus[currHaus-1][AusgangX] = 2807.619873;
	            Haus[currHaus-1][AusgangY] = -1171.899902;
	            Haus[currHaus-1][AusgangZ] = 1025.570312;
	            Haus[currHaus-1][HausVw] = vw5;
	            Haus[currHaus-1][HausInterior] = 8;
	            vw5++;
			}
			if(listitem == 5)
			{
	            Haus[currHaus-1][AusgangX] = 2324.419921;
	            Haus[currHaus-1][AusgangY] = -1145.568359;
	            Haus[currHaus-1][AusgangZ] = 1050.710083;
	            Haus[currHaus-1][HausVw] = vw6;
	            Haus[currHaus-1][HausInterior] = 12;
	            vw6++;
			}
		   	Haus[currHaus-1][HausID] = currHaus-1;
            Haus[currHaus-1][TuerX] = Pos[0];
            Haus[currHaus-1][TuerY] = Pos[1];
            Haus[currHaus-1][TuerZ] = Pos[2];
			Haus[currHaus-1][Verkauft] = 0;
	        ShowPlayerDialog(playerid,Gelddialog,1,"{FF0000}XFS: {FFFFFF}Create house","What should this house cost?","Ok","Cancel");
		}
	}
	else if(dialogid == Gelddialog)
	{
	    if(response)
	    {
	        if(!strlen(inputtext))
	        {
	        	ShowPlayerDialog(playerid,Gelddialog,1,"{FF0000}XFS: {FFFFFF}Create house","What should this house cost?","Ok","Cancel");
			}
			else
			{
			    if(strval(inputtext) < 0)
			    {
		            SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}Houses are not allowed to be for free.");
	        		ShowPlayerDialog(playerid,Gelddialog,1,"{FF0000}XFS: {FFFFFF}Create house","What should this house cost?","Ok","Cancel");
                    printf("[admin] %s creates a house.", GetName(playerid));
				}
				else
				{
				    Haus[currHaus-1][Hauskosten] = strval(inputtext);
				    ShowPlayerDialog(playerid,Scoredialog,1,"{FF0000}XFS: {FFFFFF}Create house","How much score does a player at least need to buy this house?","Ok","Close");
				}
			}
		}
	}
	else if(dialogid == Scoredialog)
	{
	    if(response)
	    {
	        if(!strlen(inputtext))
	        {
 				ShowPlayerDialog(playerid,Scoredialog,1,"{FF0000}XFS: {FFFFFF}Create house","How much score does a player at least need to buy this house?","Ok","Close");
			}
			else
			{
			    if(strval(inputtext) < 100)
			    {
		            SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You need to set at least 100 score.");
				    ShowPlayerDialog(playerid,Scoredialog,1,"{FF0000}XFS: {FFFFFF}Create house","How much score does a player at least need to buy this house?","Ok","Close");
				}
				else
				{
				    Haus[currHaus-1][HausScore] = strval(inputtext);
				    SendClientMessage(playerid,ADMIN_FARBE,"[Admin]: {FFFFFF}The house has successfully been created.");
   					Speichern();
				    Laden();
				}
			}
		}
	}
	else if(dialogid == Hausmenudialog)
	{
	    if(response)
		{
		    if(listitem == 0) {SetPlayerHealth(playerid,100.0); ShowPlayerDialog(playerid,Hausmenudialog,2,"Hausmenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper\nCar","Choose","Cancel");}
		    if(listitem == 1) {SetPlayerArmour(playerid,100.0); ShowPlayerDialog(playerid,Hausmenudialog,2,"Hausmenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper\nCar","Choose","Cancel");}
		    if(listitem == 2) {GivePlayerWeapon(playerid,26,1000); ShowPlayerDialog(playerid,Hausmenudialog,2,"Hausmenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper\nCar","Choose","Cancel");}
		    if(listitem == 3) {GivePlayerWeapon(playerid,28,1000); ShowPlayerDialog(playerid,Hausmenudialog,2,"Hausmenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper\nCar","Choose","Cancel");}
		    if(listitem == 4) {GivePlayerWeapon(playerid,31,1000); ShowPlayerDialog(playerid,Hausmenudialog,2,"Hausmenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper\nCar","Choose","Cancel");}
		    if(listitem == 5) {GivePlayerWeapon(playerid,34,1000); ShowPlayerDialog(playerid,Hausmenudialog,2,"Hausmenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper\nCar","Choose","Cancel");}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

//Eigene Funktionen
stock RegisterPlayer(playerid, key[])
{
	format(stringtu, sizeof stringtu, "/Accounts/%s.txt", GetName(playerid));
	SendClientMessage(playerid, 0x00FFFFFF, "[Account]: {FFFFFF}You have successfully been registered.");
	SendClientMessage(playerid, 0x00FFFFFF, "[Account]: {FFFFFF}As a small gift for registering here, you got 100000$!");
	dini_Create(stringtu);
	dini_Set(stringtu, "Passwort", key);
	PlayerInfo[playerid][pHausID] = -1;
	GivePlayerMoney(playerid, 90000);
	InterpolateCameraPos(playerid, 1259.2728,-1267.9529,121.8339, 2036.7493,1007.9019,10.8203, 3000, 2);
	InterpolateCameraLookAt(playerid, 1525.7203,-1419.9393,113.5681, 2026.7493,1007.9019,10.8203, 3000, 2);
	printf("[register] %s registred.", GetName(playerid));
	SpielerSpeichern(playerid);
	return 1;
}

stock LoginPlayer(playerid, key[])
{
	format(stringtu, sizeof stringtu, "/Accounts/%s.txt", GetName(playerid));
	if(!strcmp(key, dini_Get(stringtu, "Passwort"), false))
	{
 		format(stringtu, sizeof(stringtu),"[Account]: {FFFFFF}You have successfully been logged in, %s.",GetName(playerid));
		SendClientMessage(playerid, 0x00FFFFFF,stringtu);
		printf("[login] %s logged in.", GetName(playerid));
 		InterpolateCameraPos(playerid, 1259.2728,-1267.9529,121.8339, 2036.7493,1007.9019,10.8203, 3000, 2);
		InterpolateCameraLookAt(playerid, 1525.7203,-1419.9393,113.5681, 2026.7493,1007.9019,10.8203, 3000, 2);
		LoadPlayerAccount(playerid);
		SetPlayerMoney(playerid, dini_Int(stringtu,"Geld"));
		SetPlayerScore(playerid, dini_Int(stringtu,"Score"));
		PlayerInfo[playerid][Tode] = dini_Int(stringtu,"Tode");
		PlayerInfo[playerid][Kills] = dini_Int(stringtu,"Kills");
		PlayerInfo[playerid][Bankgeld] = dini_Int(stringtu,"Bankgeld");
		PlayerInfo[playerid][Adminlevel] = dini_Int(stringtu, "Adminlevel");
		PlayerInfo[playerid][Tiki1] = dini_Int(stringtu, "Tiki1");
		PlayerInfo[playerid][Tiki2] = dini_Int(stringtu, "Tiki2");
		PlayerInfo[playerid][Tiki1] = dini_Int(stringtu, "Tiki3");
		PlayerInfo[playerid][Tiki2] = dini_Int(stringtu, "Tiki4");
		PlayerInfo[playerid][Tiki1] = dini_Int(stringtu, "Tiki5");
		PlayerInfo[playerid][Tiki2] = dini_Int(stringtu, "Tiki6");
		PlayerInfo[playerid][Tiki1] = dini_Int(stringtu, "Tiki7");
		PlayerInfo[playerid][Tiki2] = dini_Int(stringtu, "Tiki8");
		PlayerInfo[playerid][Tiki1] = dini_Int(stringtu, "Tiki9");
		PlayerInfo[playerid][Tiki2] = dini_Int(stringtu, "Tiki10");
		PlayerInfo[playerid][pHausID] = dini_Int(stringtu,"pHausID");
	}
	else
	{
		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}The entered password is wrong.");
		ShowPlayerDialog(playerid, Logindialog, DIALOG_STYLE_PASSWORD, "{FF0000}XFS: {FFFFFF}Login", "Welcome back, mate. Your account has been found in our database.\nPlease enter your password to login.\n\nBest regards,\n"#Owner".", "Login", "Cancel");
		return 1;
	}
	return 1;
}

stock GetTimeAsString(time)
{
	new time_str[16];
	new minute=time/60000;
	new ms=time-(minute*60000);
	new seconds=(ms)/1000;
	ms-=seconds*1000;
	format(time_str,sizeof(time_str),"%d:%02d.%03d",minute,seconds,ms);
	return time_str;
}

stock LoadPlayerAccount(playerid)
{
	format(stringtu, sizeof stringtu, "/Accounts/%s.txt", GetName(playerid));
	GivePlayerMoney(playerid,dini_Int(stringtu, "Geld"));
	SetPlayerScore(playerid, dini_Int(stringtu, "Score"));
	PlayerInfo[playerid][Tode] = dini_Int(stringtu, "Tode");
	PlayerInfo[playerid][Kills] = dini_Int(stringtu, "Kills");
	PlayerInfo[playerid][Adminlevel] = dini_Int(stringtu, "Adminlevel");
	PlayerInfo[playerid][Bankgeld] = dini_Int(stringtu,"Bankgeld");
	PlayerInfo[playerid][Tiki1] = dini_Int(stringtu, "Tiki1");
	PlayerInfo[playerid][Tiki2] = dini_Int(stringtu, "Tiki2");
	PlayerInfo[playerid][Tiki3] = dini_Int(stringtu, "Tiki3");
	PlayerInfo[playerid][Tiki4] = dini_Int(stringtu, "Tiki4");
	PlayerInfo[playerid][Tiki5] = dini_Int(stringtu, "Tiki5");
	PlayerInfo[playerid][Tiki6] = dini_Int(stringtu, "Tiki6");
	PlayerInfo[playerid][Tiki7] = dini_Int(stringtu, "Tiki7");
	PlayerInfo[playerid][Tiki8] = dini_Int(stringtu, "Tiki8");
	PlayerInfo[playerid][Tiki9] = dini_Int(stringtu, "Tiki9");
	PlayerInfo[playerid][Tiki10] = dini_Int(stringtu, "Tiki10");
	PlayerInfo[playerid][pHausID] = dini_Int(stringtu, "pHausID");
	PlayerInfo[playerid][Hausauto] = dini_Int(stringtu, "Hausauto");
	PlayerInfo[playerid][Farbe1] = dini_Int(stringtu, "Farbe1");
	PlayerInfo[playerid][Farbe2] = dini_Int(stringtu, "Farbe2");
	PlayerInfo[playerid][Nos] = dini_Int(stringtu, "Nos");
	PlayerInfo[playerid][Hydraulik] = dini_Int(stringtu, "Hydraulik");
	PlayerInfo[playerid][Felgen] = dini_Int(stringtu, "Felgen");
	PlayerInfo[playerid][Stereo] = dini_Int(stringtu, "Stereo");
	PlayerInfo[playerid][Paintjob] = dini_Int(stringtu, "Paintjob");
	PlayerInfo[playerid][Motorhaube] = dini_Int(stringtu, "Motorhaube");
	PlayerInfo[playerid][Spoiler] = dini_Int(stringtu, "Spoiler");
	PlayerInfo[playerid][Dach] = dini_Int(stringtu, "Dach");
	PlayerInfo[playerid][Lampen] = dini_Int(stringtu, "Lampen");
	PlayerInfo[playerid][SeitenschwellerR] = dini_Int(stringtu, "SeitenschwellerR");
	PlayerInfo[playerid][SeitenschwellerL] = dini_Int(stringtu, "SeitenschwellerL");
	PlayerInfo[playerid][Auspuff] = dini_Int(stringtu, "Auspuff");
	PlayerInfo[playerid][Heckstossstange] = dini_Int(stringtu, "Heckstossstange");
	PlayerInfo[playerid][Frontstossstange] = dini_Int(stringtu, "Frontstossstange");
	PlayerInfo[playerid][OvalLuftR] = dini_Int(stringtu, "OvalLuftR");
	PlayerInfo[playerid][OvalLuftL] = dini_Int(stringtu, "OvalLuftL");
	PlayerInfo[playerid][EckLuftR] = dini_Int(stringtu, "EckLuftR");
	PlayerInfo[playerid][EckLuftL] = dini_Int(stringtu, "EckLuftL");
	if(PlayerInfo[playerid][Hausauto] > 0)
	{
		hausauto[playerid] = CreateVehicle(PlayerInfo[playerid][Hausauto], 3655.9431, -2695.1377, -0.8760, 305.2728, PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2],-1);
	    VehicleOwner[hausauto[playerid]]=playerid;
		SetVehicleToRespawn(hausauto[playerid]);
   	}
	return 1;
}

stock SpielerSpeichern(playerid)
{
	format(stringtu, sizeof stringtu, "/Accounts/%s.txt", GetName(playerid));
	dini_IntSet(stringtu, "Geld", GetPlayerMoney(playerid));
	dini_IntSet(stringtu, "Score", GetPlayerScore(playerid));
	dini_IntSet(stringtu, "Tode", PlayerInfo[playerid][Tode]);
	dini_IntSet(stringtu, "Kills", PlayerInfo[playerid][Kills]);
	dini_IntSet(stringtu, "Bankgeld", PlayerInfo[playerid][Bankgeld]);
	dini_IntSet(stringtu, "Adminlevel", PlayerInfo[playerid][Adminlevel]);
	dini_IntSet(stringtu, "Tiki1", PlayerInfo[playerid][Tiki1]);
	dini_IntSet(stringtu, "Tiki2", PlayerInfo[playerid][Tiki2]);
	dini_IntSet(stringtu, "Tiki3", PlayerInfo[playerid][Tiki3]);
	dini_IntSet(stringtu, "Tiki4", PlayerInfo[playerid][Tiki4]);
	dini_IntSet(stringtu, "Tiki5", PlayerInfo[playerid][Tiki5]);
	dini_IntSet(stringtu, "Tiki6", PlayerInfo[playerid][Tiki6]);
	dini_IntSet(stringtu, "Tiki7", PlayerInfo[playerid][Tiki7]);
	dini_IntSet(stringtu, "Tiki8", PlayerInfo[playerid][Tiki8]);
	dini_IntSet(stringtu, "Tiki9", PlayerInfo[playerid][Tiki9]);
	dini_IntSet(stringtu, "Tiki10", PlayerInfo[playerid][Tiki10]);
	dini_IntSet(stringtu, "pHausID", PlayerInfo[playerid][pHausID]);
	dini_IntSet(stringtu, "Hausauto", PlayerInfo[playerid][Hausauto]);
	dini_IntSet(stringtu, "Farbe1", PlayerInfo[playerid][Farbe1]);
	dini_IntSet(stringtu, "Farbe2", PlayerInfo[playerid][Farbe2]);
	dini_IntSet(stringtu, "Nos", PlayerInfo[playerid][Nos]);
	dini_IntSet(stringtu, "Hydraulik", PlayerInfo[playerid][Hydraulik]);
	dini_IntSet(stringtu, "Felgen", PlayerInfo[playerid][Felgen]);
	dini_IntSet(stringtu, "Stereo", PlayerInfo[playerid][Stereo]);
	dini_IntSet(stringtu, "Paintjob", PlayerInfo[playerid][Paintjob]);
	dini_IntSet(stringtu, "Motorhaube", PlayerInfo[playerid][Motorhaube]);
	dini_IntSet(stringtu, "Spoiler", PlayerInfo[playerid][Spoiler]);
	dini_IntSet(stringtu, "Dach", PlayerInfo[playerid][Dach]);
	dini_IntSet(stringtu, "Lampen", PlayerInfo[playerid][Lampen]);
	dini_IntSet(stringtu, "SeitenschwellerR", PlayerInfo[playerid][SeitenschwellerR]);
	dini_IntSet(stringtu, "SeitenschwellerL", PlayerInfo[playerid][SeitenschwellerL]);
	dini_IntSet(stringtu, "Auspuff", PlayerInfo[playerid][Auspuff]);
	dini_IntSet(stringtu, "Heckstossstange", PlayerInfo[playerid][Heckstossstange]);
	dini_IntSet(stringtu, "Frontstossstange", PlayerInfo[playerid][Frontstossstange]);
	dini_IntSet(stringtu, "OvalLuftR", PlayerInfo[playerid][OvalLuftR]);
	dini_IntSet(stringtu, "OvalLuftL", PlayerInfo[playerid][OvalLuftL]);
	dini_IntSet(stringtu, "EckLuftR", PlayerInfo[playerid][EckLuftR]);
	dini_IntSet(stringtu, "EckLuftL", PlayerInfo[playerid][EckLuftL]);
	return 1;
}

stock GetName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

stock StrCmps(const String1[],const String2[])
{
	new trues;
	for(new idx = 0;idx<strlen(String1);idx++)
	{
		if(String1[idx] == String2[idx])
		{
			trues++;
		}
	}
	if(trues == strlen(String2) && strlen(String1) == strlen(String2))
	{
		return true;
	}
	else
	{
		return false;
	}
}

stock CheckDerbyVotes()
{
  	new DerbyHighestVote;
  	for(new v; v < sizeof(DerbyVote); v++)
  	{
    	if(DerbyVote[v] > DerbyHighestVote)
			DerbyHighestVote = v;
  	}

  	if (DerbyHighestVote == 0)
  	{
   		DerbyMap = 1;
   		DerbyMapName = "Mount Chiliad', created by DarkZero";
  	}
  	if (DerbyHighestVote == 1)
  	{
   		DerbyMap = 2;
   		DerbyMapName = "LS Forum', created by DarkZero";
  	}
  	ResetDerbyVotes();
}


stock CreatePlayerDerbyCar(playerid, model, Float:vx, Float:vz, Float:vy, Float:Rot, color1, color2, VW, Int)
{
    DerbyCar[playerid] =AddStaticVehicle(model, Float:vx, Float:vz, Float:vy, Float:Rot, color1, color2);
    SetVehicleVirtualWorld(DerbyCar[playerid], VW);
    LinkVehicleToInterior(DerbyCar[playerid], Int);
    SetPlayerInterior(playerid,Int);
    SetPlayerVirtualWorld(playerid,VW);
    SetPlayerPos(playerid,Float:vx,Float:vz,Float:vy);
    PutPlayerInVehicle(playerid,DerbyCar[playerid] ,0);
    TogglePlayerControllable(playerid,false);
    SetPlayerCameraPos(playerid,Float:vx,Float:vz+30,Float:vy);
    SetPlayerCameraLookAt(playerid,Float:vx,Float:vz,Float:vy);
	return 1;
}

stock Remove_From_Derby(playerid)
{
    Iter_Remove(InDerby,playerid);
    DerbyPlayers--;
	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
    InDerby {playerid} = false ;
    if((DerbyState != 1) && (DerbyState != 4))
	{
	   	if(DerbyState == 3)
	   	{
         	format(stringtu, sizeof(stringtu), "[Derby]: {FFFFFF}%s dropped out of the derby. (Players left: %d/10)", GetName(playerid),Iter_Count(InDerby));
         	SendClientMessageToAll(DERBY_FARBE,stringtu);
         	printf("[derby] %s dropped out from derby.", GetName(playerid));
       	}
       	KillTimer(timer3[playerid]);
       	KillTimer(CountDown[playerid]);
       	DestroyVehicle(DerbyCar[playerid]);
       	TogglePlayerControllable(playerid,true);
       	LoadPlayerStats(playerid);
       	SetPlayerVirtualWorld(playerid,0);
       	SetCameraBehindPlayer( playerid );
       	TogglePlayerControllable(playerid,false);
       	CheckDerbyWinner();
	}
    if((Iter_Count(InDerby) == 0) && (DerbyState != 0))
		EndDerby();
}

stock CheckDerbyWinner()
{
 	if(DerbyState != 3) return 0;
 	if(Iter_Count(InDerby) ==1)
 	{
   		DerbyState = 5;
   		foreach(InDerby,i)
   		{
          	format(stringtu,sizeof(stringtu),"[Derby]: {FFFFFF}%s has won the derby.",GetName(i));
          	GivePlayerMoney(i,Derby_Reward * DerbyPlayers);
          	printf("[derby] %s has won the derby.", GetName(i));
          	Remove_From_Derby(i);
   		}
   		SendClientMessageToAll(DERBY_FARBE,stringtu);
   		if(DerbyState != 0) EndDerby();
 	}
 	return 1;
}

stock EndDerby()
{
    foreach(InDerby,i)
		Remove_From_Derby(i);
    if(DerbyState == 6)
		SendClientMessageToAll(DERBY_FARBE,"[Derby]: {FFFFFF}The derby has finished.");
    if((DerbyState != 6) && (DerbyState != 4))
        SendClientMessageToAll(DERBY_FARBE,"[Derby]: {FFFFFF}The derby has finished.");
    Iter_Clear(InDerby);
    print("[derby] The derby has finished.");
	for(new i=0;i<MAX_PLAYERS;i++)
    {
     	TogglePlayerControllable(i,true);
		SetCameraBehindPlayer(i);
   	}
	DerbyState = 0;
}

stock LoadObjects()
{
	CreateObject(1337,2687.34277344,-1733.17968750,38.64730072,0.00000000,0.00000000,0.00000000); //object(binnt07_la) (2)
	CreateObject(18221,-2285.89990234,-1690.40002441,481.00000000,0.00000000,0.00000000,348.00000000); //object(mtbfence11) (1)
	CreateObject(18221,-2298.80004883,-1702.19995117,479.00000000,0.00000000,0.00000000,270.00000000); //object(mtbfence11) (2)
	CreateObject(18221,-2285.10009766,-1662.69995117,483.00000000,0.00000000,0.00000000,348.00292969); //object(mtbfence11) (3)
	CreateObject(18221,-2284.50000000,-1635.59997559,484.79998779,0.00000000,0.00000000,348.00292969); //object(mtbfence11) (4)
	CreateObject(18221,-2284.00000000,-1621.50000000,484.00000000,0.00000000,0.00000000,344.00286865); //object(mtbfence11) (5)
	CreateObject(18221,-2284.30004883,-1648.59997559,482.00000000,0.00000000,0.00000000,352.75292969); //object(mtbfence11) (6)
	CreateObject(18221,-2293.30004883,-1616.59997559,484.00000000,357.00000000,0.00000000,34.79998779); //object(mtbfence11) (7)
	CreateObject(18221,-2311.69995117,-1600.69995117,484.00000000,357.00000000,0.00000000,41.99719238); //object(mtbfence11) (8)
	CreateObject(18221,-2332.00000000,-1585.09997559,484.00000000,356.99523926,0.00000000,41.98974609); //object(mtbfence11) (9)
	CreateObject(18221,-2345.50000000,-1591.00000000,484.00000000,356.98974609,0.00000000,149.97875977); //object(mtbfence11) (10)
	CreateObject(18221,-2353.10009766,-1616.80004883,484.00000000,356.98974609,0.00000000,155.96887207); //object(mtbfence11) (11)
	CreateObject(18221,-2352.19995117,-1642.19995117,484.00000000,356.98974609,0.00000000,187.96191406); //object(mtbfence11) (12)
	CreateObject(18221,-2338.30004883,-1664.30004883,484.00000000,354.00000000,0.00000000,213.96508789); //object(mtbfence11) (13)
	CreateObject(18221,-2318.89990234,-1684.00000000,483.00000000,353.99597168,0.00000000,213.95874023); //object(mtbfence11) (14)
	CreateObject(18221,-2304.30004883,-1698.80004883,480.00000000,340.00000000,0.00000000,215.95874023); //object(mtbfence11) (15)
	CreateObject(8171,-1079.40002441,-3245.50000000,46.00000000,0.00000000,0.00000000,0.00000000); //object(vgssairportland06) (1)
	CreateObject(8171,-1119.09997559,-3245.60009766,46.00000000,0.00000000,0.00000000,0.00000000); //object(vgssairportland06) (2)
}

stock Send_To_Derby(playerid)
{
	hideDialog(playerid);
	switch (DerbyPlayerNum[playerid])
	{
	   	case 1:
	   	{
		 	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2290.5366,-1661.7280,482.5995,76.3839,-1,-1,30,0);
		 	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2722.0461,-1772.1267,43.2869,303.6281,-1,-1,30,0);
	   	}
	   	case 2:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2291.0859,-1669.5981,482.5747,72.6751,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2726.9729,-1778.1417,43.1911,329.6291,-1,-1,30,0);
	   	}
	   	case 3:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2286.0530,-1654.7125,482.7684,72.0922,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2733.1436,-1779.8776,43.2456,342.0309,-1,-1,30,0);
	   	}
	   	case 4:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2285.4714,-1650.3470,482.9249,79.7025,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2740.7998,-1780.1222,43.2510,2.5864,-1,-1,30,0);
	   	}
	   	case 5:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2285.5366,-1646.2402,483.0798,81.8509,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2748.4766,-1777.2372,43.2454,25.4766,-1,-1,30,0);
	   	}
	   	case 6:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2299.1189,-1621.4264,483.5757,129.7212,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2755.3335,-1773.1992,43.1062,49.4795,-1,-1,30,0);
	   	}
	   	case 7:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2300.5713,-1617.6488,483.6184,123.6057,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2759.0210,-1765.5273,43.0984,72.0725,-1,-1,30,0);
	   	}
	   	case 8:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2304.0583,-1613.1086,483.6555,123.2892,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2758.4824,-1756.9666,43.1720,95.8520,-1,-1,30,0);
	   	}
	   	case 9:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2309.5833,-1607.1855,483.6789,135.3230,-1,-1,30,0);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2757.0361,-1748.5531,43.0431,115.1203,-1,-1,30,0);
	   	}
	   	case 10:
	   	{
	     	if(DerbyMap ==1) CreatePlayerDerbyCar(playerid,436,-2314.2927,-1601.1254,483.6828,130.7534,-1,-1,30,15);
	     	else if(DerbyMap == 2) CreatePlayerDerbyCar(playerid,603,2750.0562,-1743.4989,43.1889,139.8040,-1,-1,30,0);
	   	}
	}
}

stock ResetDerbyVotes()
{
  	DerbyVote[0] = 0;
  	DerbyVote[1] = 0;
}

stock GetPlayerID(const playernamedada[])
{
	for(new i=0;i<MAX_PLAYERS;i++)
    {
	    if(IsPlayerConnected(i))
	    {
			new pName[MAX_PLAYER_NAME];
			GetPlayerName(i, pName, sizeof(pName));
			if(strcmp(playernamedada, pName, true) == 0)
			{
				return i;
			}
		}
	}
	return -1;
}

stock Send_To_Dm1( playerid )
{
	SetPlayerVirtualWorld(playerid, 3);
	SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 30,9999);
	GivePlayerWeapon(playerid, 23,9999);
	GivePlayerWeapon(playerid, 9,9999);
	GivePlayerWeapon(playerid, 27,9999);
	rand = random( 3 );
	SetPlayerPos(playerid,Dm1SP[rand][0],Dm1SP[rand][1],Dm1SP[rand][2]);
	SetPlayerFacingAngle(playerid,Dm1SP[rand][3]);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	return 1;
}

stock Send_To_Dm2( playerid )
{
    SetPlayerVirtualWorld(playerid, 4);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 24,9999);
    GivePlayerWeapon(playerid, 25,9999);
    GivePlayerWeapon(playerid, 27,9999);
    GivePlayerWeapon(playerid, 34,9999);
    rand = random( 3 );
    SetPlayerPos(playerid,Dm2SP[rand][0],Dm2SP[rand][1],Dm2SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm2SP[rand][3]);
    SetCameraBehindPlayer(playerid);
    SetPlayerInterior(playerid, 0);
}

stock Send_To_Dm3( playerid )
{
    SetPlayerVirtualWorld(playerid, 5);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 26,9999);
    GivePlayerWeapon(playerid, 28,9999);
	rand = random( 3 );
    SetPlayerPos(playerid,Dm3SP[rand][0],Dm3SP[rand][1],Dm3SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm3SP[rand][3]);
    SetCameraBehindPlayer(playerid);
    SetPlayerInterior(playerid, 0);
}

stock Send_To_Dm4( playerid )
{
    SetPlayerVirtualWorld(playerid, 6);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
	ForbidWeaponForPlayer(playerid,16,false);
	ForbidWeaponForPlayer(playerid,35,false);
	ForbidWeaponForPlayer(playerid,37,false);
    GivePlayerWeapon(playerid, 37,9999);
    GivePlayerWeapon(playerid, 35,9999);
    GivePlayerWeapon(playerid, 16,9999);
	rand = random( 3 );
    SetPlayerPos(playerid,Dm4SP[rand][0],Dm4SP[rand][1],Dm4SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm4SP[rand][3]);
    SetCameraBehindPlayer(playerid);
    SetPlayerInterior(playerid, 0);
}

stock Send_To_Dm5( playerid )
{
    SetPlayerVirtualWorld(playerid, 7);
    SetPlayerInterior(playerid ,10);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
	ForbidWeaponForPlayer(playerid,38,false);
    GivePlayerWeapon(playerid, 38,9999);
    rand = random( 3 );
    SetPlayerPos(playerid,Dm5SP[rand][0],Dm5SP[rand][1],Dm5SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm5SP[rand][3]);
    SetCameraBehindPlayer(playerid);
}

stock Send_To_Dm6( playerid )
{
    SetPlayerVirtualWorld(playerid, 8);
    SetPlayerInterior(playerid ,0);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 30,9999);
    GivePlayerWeapon(playerid, 23,9999);
    GivePlayerWeapon(playerid, 9,9999);
    rand = random( 3 );
    SetPlayerPos(playerid,Dm6SP[rand][0],Dm6SP[rand][1],Dm6SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm6SP[rand][3]);
    SetCameraBehindPlayer(playerid);
}

stock Send_To_Dm7( playerid )
{
    SetPlayerVirtualWorld(playerid, 9);
    SetPlayerInterior(playerid ,0);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 16,9999);
    GivePlayerWeapon(playerid, 26,9999);
    GivePlayerWeapon(playerid, 31,9999);
   	rand = random( 3 );
    SetPlayerPos(playerid,Dm7SP[rand][0],Dm7SP[rand][1],Dm7SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm7SP[rand][3]);
    SetCameraBehindPlayer(playerid);
}

stock Send_To_Dm8( playerid )
{
    SetPlayerVirtualWorld(playerid, 10);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 27,9999);
    GivePlayerWeapon(playerid, 25,9999);
    GivePlayerWeapon(playerid, 24,9999);
    SetPlayerInterior(playerid ,1);
   	rand = random( 3 );
    SetPlayerPos(playerid,Dm8SP[rand][0],Dm8SP[rand][1],Dm8SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm8SP[rand][3]);
    SetCameraBehindPlayer(playerid);
}

stock Send_To_Dm9( playerid )
{
    SetPlayerVirtualWorld(playerid, 11);
    SetPlayerInterior(playerid, 16);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 26,9999);
    GivePlayerWeapon(playerid, 28,9999);
    GivePlayerWeapon(playerid, 24,9999);
    GivePlayerWeapon(playerid, 34,9999);
    GivePlayerWeapon(playerid, 31,9999);
    rand = random( 3 );
    SetPlayerPos(playerid,Dm9SP[rand][0],Dm9SP[rand][1],Dm9SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm9SP[rand][3]);
    SetCameraBehindPlayer(playerid);
}

stock Send_To_Dm15( playerid )
{
    SetPlayerVirtualWorld(playerid, 17);
    SetPlayerHealth(playerid ,100);
	ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 34,9999);
    GivePlayerWeapon(playerid, 31,9999);
    GivePlayerWeapon(playerid, 4,9999);
    rand = random( 3 );
    SetPlayerPos(playerid,Dm15SP[rand][0],Dm15SP[rand][1],Dm15SP[rand][2]);
    SetPlayerFacingAngle(playerid,Dm15SP[rand][3]);
    SetPlayerInterior(playerid, 0);
    SetCameraBehindPlayer(playerid);
}

stock TogglePlayerMapIcon(playerid,bool:visible)
{
    SetPlayerColor(playerid, (GetPlayerColor(playerid) | 0xFF) - (visible ? 0x00 : 0xFF));
    return 1;
}

stock ReturnUser(tmp[])
{
	new playerid=INVALID_PLAYER_ID;
 	if(strlen(tmp)>=1)
 	{
	  	if(IsNumeric(tmp))
	  	{
		   	if(IsPlayerConnected(strval(tmp)))
		    playerid=strval(tmp);
  		}
  		else
  		{
   			if(strlen(tmp)>=3)
   			{
    			new count;
      			for(new i=0;i<MAX_PLAYERS;i++)
    			{
    				if(IsPlayerConnected(i))
    				{
    					if(strfind(GetName(i),tmp,true)!=-1)
    					{
    						playerid=i;
    						count++;
    					}
    				}
    			}
    			if(count>1)
    			{
    				playerid=INVALID_PLAYER_ID;
    			}
   			}
  		}
 	}
 	return playerid;
}


stock GiveDuelWeapon(i)
{
  	switch(DuelWeapon)
  	{
  		case 0: GivePlayerWeapon(i,24,9999);
  		case 1: GivePlayerWeapon(i,25,9999);
  		case 2: GivePlayerWeapon(i,26,9999);
  		case 3: GivePlayerWeapon(i,27,9999);
  		case 4: GivePlayerWeapon(i,31,9999);
  		case 5: GivePlayerWeapon(i,29,9999);
  		case 6: GivePlayerWeapon(i,28,9999);
  		case 7: GivePlayerWeapon(i,34,9999);
  		case 8: GivePlayerWeapon(i,33,9999);
  		case 9: GivePlayerWeapon(i,37,9999);
  		case 10: GivePlayerWeapon(i,38,9999);
  		case 11: GivePlayerWeapon(i,16,9999);
  		case 12: GivePlayerWeapon(i,18,9999);
  		case 13: GivePlayerWeapon(i,39,9999);
  		case 14: GivePlayerWeapon(i,9,9999);
  	}
}

stock SendToDuelPos1(playerid)
{
    Iter_Add(InDuel, playerid );
    Send_To_Duel(playerid);
    ShowPlayerDialog(playerid,Duelltext,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Duel","1. Desert Eagle\n2. Shotgun\n3. Sawn-Off Shotgun\n4. Combat Shotgun\n5. M4\n6. Mp5 \n7. Uzi\n8. Sniper Rifle\n9. Country Rifle\n10. FlameThrower\n11. Minigun\n12. Grenade\n13. Molotov Cocktails\n14. Satchel Charge\n15. ChainSaw","Ok", "Exit");
    if(Duelp == 1)
    {
        SetPlayerPos(playerid,-389.2607,2262.2354,41.7669);
        SetPlayerFacingAngle(playerid,193.9177);
        SetPlayerInterior(playerid,0);
        SetCameraBehindPlayer( playerid );
    }
    if(Duelp == 2)
    {
        SetPlayerPos(playerid,-1384.8824,1267.5298,1039.8672);
        SetPlayerFacingAngle(playerid,154.5639);
        SetPlayerInterior(playerid,16);
        SetCameraBehindPlayer( playerid );
    }
}

stock SendToDuelPos2(playerid)
{
     foreach(InDuel,i) format(stringtu,sizeof(stringtu),"[Duel]: {FFFFFF}%s will now fight against %s in a duel.",GetName(playerid),GetName(i));
	 SendClientMessageToAll(0x00FFFF3A,stringtu);
     Iter_Add(InDuel, playerid );
     Send_To_Duel(playerid);
     if(Duelp == 1)
     {
         SetPlayerPos(playerid,-375.5359,2204.8149,42.0938);
         SetPlayerFacingAngle(playerid,13.5116);
         SetPlayerInterior(playerid,0);
     }
     if(Duelp == 2)
     {
         SetPlayerPos(playerid,-1409.5453,1214.7429,1039.8672);
         SetPlayerFacingAngle(playerid,335.1070);
         SetPlayerInterior(playerid,16);
     }
}

stock GetIP(playerid)
{
	new ip[24];
	GetPlayerIp(playerid, ip,sizeof(ip));
	return ip;
}

stock Send_To_Duel(playerid)
{
    SetPlayerVirtualWorld(playerid,25);
    TogglePlayerControllable(playerid,false);
    GetPlayerStats(playerid);
    SetPlayerHealth(playerid,100);
    SetPlayerArmour(playerid,100);
    SetCameraBehindPlayer( playerid );
}

stock Remove_From_Duel(i)
{
    KillTimer(CountDown[i]);
    TogglePlayerControllable(i,true);
    Iter_Remove(InDuel, i);
    Dueler { i } = false;
    LoadPlayerStats(i);
    DuelInfo = 0;
    return 0;
}
stock DuelWinner(i)
{
    GivePlayerMoney(i,DuelBet * 2);
    DuelBet = 0;
}

stock bigstrtok(const string[], &idx)
{
    new length = strlen(string);
	while ((idx < length) && (string[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = string[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	return result;
}

stock Random(playerid)
{
	switch (random(17))
	{
		case 0: return cmd_dm(playerid);
		case 1: return cmd_dm2(playerid);
		case 2: return cmd_dm3(playerid);
		case 3: return cmd_dm4(playerid);
		case 4: return cmd_dm5(playerid);
		case 5: return cmd_dm6(playerid);
		case 6: return cmd_dm7(playerid);
	}
	return 1;
}

stock GetPlayerStats(playerid)
{
    ResetPlayerWeapons(playerid);
    GetPlayerPos(playerid, pCoords[playerid][0], pCoords[playerid][1], pCoords[playerid][2]);
    pInterior[playerid] = GetPlayerInterior( playerid );
	for( new w; w < 13; w++ )
	{
	   	GetPlayerWeaponData( playerid, w, pWeapons[playerid][w], pAmmo[playerid][w] );
  	}
}

stock LoadPlayerStats(playerid)
{
	SetPlayerPos( playerid, pCoords[playerid][0], pCoords[playerid][1], pCoords[playerid][2]);
   	SetPlayerInterior( playerid, pInterior[playerid] );
	ResetPlayerWeapons(playerid);
	for( new w = 12; w > -1; w-- )
	{
		GivePlayerWeapon( playerid, pWeapons[playerid][w], pAmmo[playerid][w] );
	}
}

stock StartMiniGameUpdate(i)
{
	timer3[i] = SetTimerEx("MiniGameUpdate",1000,true,"i",i);
	Mmin[i] = DerbyTime;
	Msec[i] = 01;
}

stock StartCountDown(i)
{
    DCount[i] = 6;
    CountDown[i] = SetTimerEx("PlayerCountDown",1000,true,"p",i);
    TogglePlayerControllable(i,false);
    return 1;
}

stock BombPlayer(playerid)
{
    GetPlayerPos(playerid, x, y, z);
    CreateExplosion(x, y, z, 0, 10.0);
}

stock GivePlayerRandomWeapon(playerid)
{
    new randomweb = 18 + random(24);
    GivePlayerWeapon(playerid, randomweb,9999);
}

stock SendMsg(playerid, MsgID)
{
  	switch(MsgID)
  	{
   		case 0:  return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You are not in any Minigame.");
		case 1:  return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
		case 2:  return SendClientMessage(playerid,DM_FARBE,"[Minigame]: {FFFFFF}You can leave this minigame with using /Cancel.");
  	}
  	return 0;
}

stock hideDialog( playerid )
    return ShowPlayerDialog( playerid, -1, 0, "","", "", "" ), 1;


public Remove_From_Dm(playerid)
{
	Iter_Remove(Dm[DmId[playerid]],playerid);
    InDm {playerid} = false;
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has left a deathmatch. (/Cancel) ", GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	printf("[command] [%s] /cancel", GetName(playerid));
	DMPlayers--;
	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	if(GetPlayerVirtualWorld(playerid) == 16)
	{
		SetPlayerTime(playerid, phour[playerid],pminutes[playerid]);
		SetPlayerWeather(playerid ,1);
	}
    SetPlayerVirtualWorld(playerid, 0);
   	SetCameraBehindPlayer( playerid );
   	SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
   	RemovePlayerAttachedObject(playerid,0);
   	RemovePlayerAttachedObject(playerid,3);
   	LoadPlayerStats(playerid);
   	return 1;
}

public PlayerCountDown(p)
{
  	if((InDerby {p} == true)) DerbyState =2;
	new Float:x, Float:y, Float:z;
  	DCount[p]--;
  	if(DCount[p] == 5)
  	{
      	GameTextForPlayer(p,"~w~5..",1000,3);
      	GetPlayerPos(p, x, y, z);
      	PlayerPlaySound(p, 1056,x, y, z);
  	}
  	if(DCount[p] == 4)
  	{
      	GameTextForPlayer(p,"~b~4..",1000,3);
      	GetPlayerPos(p, x, y, z);
      	PlayerPlaySound(p, 1056,x, y, z);
  	}
  	if(DCount[p] == 3)
  	{
      	GameTextForPlayer(p,"~p~3..",1000,3);
	  	GetPlayerPos(p, x, y, z);
      	PlayerPlaySound(p, 1056,x, y, z);
  	}
  	if(DCount[p] == 2)
  	{
      	GameTextForPlayer(p,"~r~2..",1000,3);
      	GetPlayerPos(p, x, y, z);
      	PlayerPlaySound(p, 1056,x, y, z);
      	GetPlayerPos(p,x,y,z);
        if((InDerby { p }== true)) SetCameraBehindPlayer(p);
  	}
  	if(DCount[p] == 1)
  	{
      	GameTextForPlayer(p,"~y~1..",1000,3);
      	GetPlayerPos(p, x, y, z);
      	PlayerPlaySound(p, 1056,x, y, z);
  	}
  	if(DCount[p] == 0)
  	{
      	KillTimer(CountDown[p]);
      	GameTextForPlayer(p,"~g~los..!",1000,3);
      	GetPlayerPos(p, x, y, z);
      	PlayerPlaySound(p, 1057,x, y, z);
	 	TogglePlayerControllable(p,true);
      	if(InDerby { p } == true)
      	{
        	DerbyState = 3;
			StartMiniGameUpdate(p);
      	}
  	}
}

public StartDerby()
{
  	if(Iter_Count(InDerby) < DerbyMin)
  	{
  		DerbyState = 4;
  		SendClientMessageToAll(DERBY_FARBE,"[Derby]: {FFFFFF}The derby has been canceled. (Not enough players (minimum 2 needed))");
  		EndDerby();
		return 0;
  	}
  	DerbyState = 2;
  	DerbyPlayers = Iter_Count(InDerby);
  	CheckDerbyVotes();
  	format(stringtu,sizeof(stringtu),"[Derby]: {FFFFFF}The derby '%s has been started.",DerbyMapName);
  	SendClientMessageToAll(DERBY_FARBE,stringtu);
  	print("[derby] The derby has started.");
  	ResetDerbyVotes();
  	LoadObjects();
	foreach(InDerby,i)
  	{
		StartCountDown(i);
		Send_To_Derby(i);
	}
  	return 1;
}

public MiniGameUpdate(i)
{
	new Float:x, Float:y, Float:z;
	if(InDerby {i} == true)
	{
		if(DerbyState != 3) return 0;
		Msec[i] --;
		if(Msec[i] <= 0)
		{
		  	Msec[i] = 60;
		  	Mmin[i]--;
		}
		if(Mmin[i] < 0)
		{
		   	if(DerbyState != 0) EndDerby();
		   	DerbyState = 6;
		}
        if(Out[i]==1)
        {
        	Remove_From_Derby(i);
        	Out[i] =0;
        }
        GetPlayerPos(i, x, y, z);
        if(DerbyMap ==2)
		{
			if(z<13.00)
			{
				Remove_From_Derby(i);
			}
		}
	}
    return 1;
}


public SendClientMessageToAdmins(color,string[],alevel)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			if(PlayerInfo[i][Adminlevel] >= alevel || IsPlayerAdmin(i))
			{
				SendClientMessage(i, color, string);
			}
		}
	}
	return 1;
}

public OnPlayerMiniGameSpawn(i)
{
	switch (GetPlayerVirtualWorld(i) )
	{
   		case 3: Send_To_Dm1( i );
   		case 4: Send_To_Dm2( i );
   		case 5: Send_To_Dm3( i );
   		case 6: Send_To_Dm4( i );
   		case 7: Send_To_Dm5( i );
   		case 8: Send_To_Dm6( i );
   		case 9: Send_To_Dm7( i );
   		case 10: Send_To_Dm8( i );
   		case 11: Send_To_Dm9( i );
   		case 17: Send_To_Dm15( i );
 	}
 	#if GiveAllPlayerMoney == 2
 	GivePlayerMoney(i,500);
 	#endif
 	return 1;
}

public Zonencheck(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    new Zone[MAX_ZONE_NAME];
	    GetPlayer2DZone(playerid, Zone, MAX_ZONE_NAME);
	    format(stringtu, sizeof(stringtu), "~y~] ~w~%s ~y~]", Zone);
	    TextDrawSetString(zonentext[playerid], stringtu);
	}
	return 1;
}

public Speedo(playerid)
{
	if(IsPlayerConnected(playerid) && IsPlayerInAnyVehicle(playerid) && !IsPlayerNPC(playerid))
	{
		new autoid = GetPlayerVehicleID(playerid);
	 	new Float:speedoX, Float:speedoY, Float:speedoZ, Float:speed;
	 	GetVehicleVelocity(autoid, speedoX, speedoY, speedoZ);
	 	speed = (floatsqroot(floatpower(speedoX, 2) + floatpower(speedoY, 2) + floatpower(speedoZ, 2)))*161;
	    format(stringtu, sizeof(stringtu), "KM/H: ~g~~h~%d", floatround(speed, floatround_floor));
		TextDrawSetString(SpeedoTD3[playerid], stringtu);
	}
	return 1;
}

public RaceEnd(playerid)
{
	SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been finished.");
	rennengestartet = 0;
	RacePlayers = 0;
	KillTimer(Rennen);
	foreach(Player, i)
	{
		if(JoinedRace[i] == 1)
		{
			StartTime[i] = 0;
			RaceTime[i] = 0;
			JoinedRace[i] = 0;
			MotoGate[i] = 1;
			MotoGP[i] = 0;
			JoinedRace[i] = 0;
			DisablePlayerRaceCheckpoint(i);
		}
	 }
	return true;
}

public ConvertTicks(ticks)
{
	csecs = 0;
	cmils = 0;
	cmins = 0;
	new tempcsecs = ticks / 1000;
	cmins = ticks / 60000;
	csecs = (ticks - cmins*60000)/1000;
	cmils = (ticks - tempcsecs*1000)/10;
}

public GameTicks()
{
	Gtickcount = Gtickcount+500;
}

public HostName()
{
	new string[128];
	//
	if(hostname == 0)
	{
	    format(string,sizeof(string),"hostname %s",SNAME1);
	    SendRconCommand(string);
	    hostname = 1;
	}
	else if(hostname == 1)
	{
	    format(string,sizeof(string),"hostname %s",SNAME2);
	    SendRconCommand(string);
	    hostname = 2;
	}
	else if(hostname == 2)
	{
	    format(string,sizeof(string),"hostname %s",SNAME3);
	    SendRconCommand(string);
	    hostname = 0;
	}
	return true;
}


public FalloutCountdown( )
{
	if( Iter_Count(_Falloutr ) < 2 )
 	{
	  	SendClientMessageToAll(FALLOUT_FARBE,"[Fallout]: {FFFFFF}The fallout has been canceled. (Not enough players (minimum 2 needed))");
	 	FalloutPlayers--;
	 	print("[fallout] The fallout has finished.");
		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
	  	foreach(_Falloutr, i)
	  	{
		  	Falloutr_{ i } = false;
		   	JoinedFallout[i] = 0;
	      	RespawnPlayer( i );
	        TogglePlayerControllable(i,true);
		}
	  	FalloutPlayers = 0;
	  	return EndFallout( );
 	}
 	if( inProgress != 2 )
	{
		SendClientMessageToAll(FALLOUT_FARBE,"[Fallout]: {FFFFFF}The fallout has been started.");
		Iter_Clear(_Objects);
		print("[fallout] The fallout has started.");
		for( new i; i < 54; i++ ) Iter_Add(_Objects, i );
		SetTimer( "FalloutCountdown", 2000, 0 );
		inProgress = 2;
	}
	else
	{
		foreach(_Falloutr, i )
		{
		    if(!VIEW_FROM_ABOVE)
			SetCameraBehindPlayer( i );
			PlayerPlaySound( i, 1057, 0.0, 0.0, 0.0 );
			TogglePlayerControllable( i, true );
		}
		uTimer = SetTimer( "FalloutUpdate", 2500, 1 );
	}
	return 1;
}

public FalloutUpdate( )
{
	if( Iter_Count(_Falloutr ) < 1 ) return EndFallout( );
	new Float:playerx, Float:playery, Float:playerz[MAX_PLAYERS];
	foreach(_Falloutr, i )
	{
		GetPlayerPos( i, playerx, playery, playerz[i] );
		if( playerz[i] < 2.0 )
		{
			format( stringtu, sizeof( stringtu ), "[Fallout]: {FFFFFF}%s dropped out of the fallout..", GetName( i ));
			SendClientMessageToAll(FALLOUT_FARBE, stringtu);
			printf("[fallout] %s dropped out from fallout.", GetName(i));
			GameTextForPlayer( i, pFellOffText[ random( sizeof( pFellOffText ) ) ], 2500, 3 );
			Iter_Remove(_Falloutr, i );
			Falloutr_{ i } = false;
			JoinedFallout[i] = 0;
  			FalloutPlayers--;
   	   		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	   		TextDrawSetString(leiste, stringtu);
			RespawnPlayer( i );
      		TogglePlayerControllable(i,true);
		}
	}
	if( Iter_Count(_Falloutr ) < 2 )
	{
 		foreach(_Falloutr, i ) FalloutWinner( i );
	}
 	new objectid, Float:ObjectX, Float:ObjectY, Float:ObjectZ;
 	objectid = Iter_Random(_Objects );
	GetObjectPos( Objects_[0][objectid], ObjectX, ObjectY, ObjectZ );
	SetTimerEx("SpeedUp", 500, 0, "ifff", objectid, ObjectX, ObjectY, ObjectZ);
	MoveObject( Objects_[0][objectid], ObjectX, ObjectY, ObjectZ -5, 1 );
    Iter_Remove(_Objects, objectid );
	return 1;
}

public SpeedUp( object, Float:x, Float:y, Float:z )
{
	MoveObject( Objects_[0][object], x, y, z -150, 20 );
	foreach(_Falloutr, i ) PlayerPlaySound( i, 1039, 0.0, 0.0, 0.0 );
}

public ShowStats(playerid)
{
	SpielerSpeichern(playerid);
	new srstring[864];
	new afwga[64];
	format(afwga, sizeof(afwga),"{FFFFFF}Statistics: {FF0000}%s (%d)",GetName(playerid),playerid);
	format(srstring, sizeof(srstring),
	"{FFFFFF}Adminlevel: {FF0000}%d{FFFFFF}, Bank money: {FF0000}%d$, {FFFFFF}Kills: {FF0000}%d{FFFFFF}, Deaths: {FF0000}%d{FFFFFF}",
	PlayerInfo[playerid][Adminlevel],PlayerInfo[playerid][Bankgeld],PlayerInfo[playerid][Kills],PlayerInfo[playerid][Tode]);
	ShowPlayerDialog(playerid,4734,DIALOG_STYLE_MSGBOX,afwga,srstring,"Ok","Close");
	return 1;
}

public FPSUP()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			format(stringtu,sizeof(stringtu),"~w~FPS: ~g~~h~%d",FPS2[i]-1);
			TextDrawSetString(FPS[i],stringtu);
		}
		continue;
	}
}

public EndFallout()
{
	for(new i; i < 54; i++)
 	{
 	    DestroyObject(Objects_[0][i]);
 	}
 	inProgress = 0;
	Iter_Clear(_Objects);
	Iter_Clear(_Falloutr);
	KillTimer(uTimer);
	return 1;
}


public FalloutWinner(player)
{
	format(stringtu, sizeof(stringtu), "[Fallout]: {FFFFFF}%s has won the fallout.", GetName( player ) );
	SendClientMessageToAll(FALLOUT_FARBE, stringtu);
	printf("[fallout] %s won the fallout.", GetName(player));
 	GivePlayerMoney(player, 15000 );
 	SetPlayerPos(player,2517.0261,-1678.5011,14.3125);
 	JoinedFallout[player] = 0;
    SetPlayerScore(player, GetPlayerScore(player)+3);
 	Falloutr_{player} = false;
	Iter_Remove(_Falloutr, player);
	FalloutPlayers--;
	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	SetTimerEx( "RespawnPlayer", 1400, 0, "i", player);
	SetTimer("EndFallout", 1700, 0);
	RespawnPlayer( player );
}

public Werbung()
{
	return SendClientMessageToAll(msg,Messages1[random(sizeof(Messages1))]);
}

public ReactionTest()
{
	switch(random(2))
	{
	    case 0:
	    {
			new addsubtext1[10], addsubtext2[10], score;

			new temp1;

			new number1 = random(100);
			new number2 = random(100);
			new number3 = random(100);
			new addsubnumb1 = random(2);
			new addsubnumb2 = random(2);

			if(addsubnumb1 == 0)
			{
				score = score + 0;

				format(addsubtext1, sizeof(addsubtext1), "-");
				temp1 = number1 - number2;
			}
			else if(addsubnumb1 == 1)
			{
				score = score + 0;

				format(addsubtext1, sizeof(addsubtext1), "+");
				temp1 = number1 + number2;
			}

			if(addsubnumb2 == 0)
			{
				score = score + 0;

				format(addsubtext2, sizeof(addsubtext2), "-");
				format(reactionstr,sizeof(reactionstr),"%d",temp1 - number3);
			}
			else if(addsubnumb2 == 1)
			{
				score = score + 0;

				format(addsubtext2, sizeof(addsubtext2), "+");
				format(reactionstr,sizeof(reactionstr),"%d",temp1 + number3);
			}

			format(stringtu, sizeof(stringtu), "[Reaction]: {FFFFFF}The first one who calculates %d%s%d%s%d, wins 5000$ & 1 Score!", number1, addsubtext1, number2, addsubtext2, number3, score);
			SendClientMessageToAll(REAKTIONSTEST_FARBE, stringtu);
			printf("[reactiontest] Math: %d%s%d%s%d", number1, addsubtext1, number2, addsubtext2, number3, score);
			reactioninprog = 2;
		}
		case 1:
		{
			reactionstr = "";
			KillTimer(reacendtimer);
			new past[2],i = 0,random_set[] = "AaBbCcDdEeFfGgHhJjKkMmNnOoPpQqRrSsTtUuVvWwXxYyZz123§4$56&8(9)*-;^:";
			while(strlen(reactionstr) < 8)
			{
			    i = random(sizeof(random_set));
			    strmid(past,random_set,i,i+1);
			    format(reactionstr,sizeof(reactionstr),"%s%s",reactionstr,past);
			}
			reactioninprog = 2;
			format(stringtu,sizeof(stringtu),"[Reaction]: {FFFFFF}The first one who types %s, wins 5000$ & 1 Score!",reactionstr);
			SendClientMessageToAll(REAKTIONSTEST_FARBE,stringtu);
			printf("[reactiontest] Not math: %s",reactionstr); // lol..
		}
	}
	reacendtimer = SetTimer("ReactionEnd", 1000*60*5, false);
	return true;
}

public ReactionWin(playerid)
{
    if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		GivePlayerMoney(playerid, 5000);
        SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
		SetTimer("SetBack", 30, 0);
		format(stringtu,sizeof(stringtu),"[Reaction]: {FFFFFF}%s has won the reactiontest.",GetName(playerid));
		SendClientMessageToAll(REAKTIONSTEST_FARBE,stringtu);
        printf("[reactiontest] %s won the reactiontest.", GetName(playerid));
	}
	return 1;
}

public ReactionEnd()
{
    reactioninprog = 1;
    return 1;
}

public SetBack()
{
	reactioninprog = 1;
	return 1;
}


public RespawnPlayer(player)
{
	for(new i = 12; i > -1; i--)
	{
		GivePlayerWeapon(player, pWeaponData[player][i], pSavedAmmo[player][i]);
	}
	SetPlayerPos(player, pCoords[player][0], pCoords[player][1], pCoords[player][2]);
   	SetPlayerInterior(player, pInterior[player]);
   	SetCameraBehindPlayer(player);
}

public SaveRace(name[])
{
		new racename[64];
		new var[32];
		format(racename, sizeof(racename), "RennEditor/%s.race",name);
		new File: file2 = fopen(racename, io_write);
		if (file2)
		{
			format(var, 32, "%f\n",CreateRace[rCP1][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP1][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP1][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP2][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP2][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP2][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP3][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP3][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP3][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP4][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP4][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP4][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP5][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP5][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP5][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP6][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP6][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP6][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP7][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP7][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP7][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP8][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP8][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP8][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP9][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP9][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP9][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP10][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP10][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP10][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP11][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP11][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP11][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP12][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP12][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP12][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP13][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP13][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP13][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP14][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP14][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP14][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP15][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP15][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP15][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP16][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP16][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP16][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP17][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP17][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP17][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP18][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP18][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP18][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP19][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP19][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP19][2]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP20][0]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP20][1]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rCP20][2]);fwrite(file2, var);
			format(var, 32, "%s\n",CreateRace[rName1]);fwrite(file2, var);
			format(var, 32, "%s\n",CreateRace[rName2]);fwrite(file2, var);
			format(var, 32, "%s\n",CreateRace[rName3]);fwrite(file2, var);
			format(var, 32, "%f\n",CreateRace[rAngle]);fwrite(file2, var);
			format(var, 32, "%d\n",CreateRace[rBestms1]);fwrite(file2, var);
			format(var, 32, "%d\n",CreateRace[rBestms2]);fwrite(file2, var);
			format(var, 32, "%d\n",CreateRace[rBestms3]);fwrite(file2, var);
			fclose(file2);
		}
		return true;
}

public Laden()
{
	new Text[100];
	for(new i=0;i<MAX_HAUS;i++)
	{
	    format(Text,sizeof(Text),"TuerX_%d",i);
	    Haus[i][TuerX] = dini_Float("hauser.txt",Text);
	    format(Text,sizeof(Text),"TuerY_%d",i);
	    Haus[i][TuerY] = dini_Float("hauser.txt",Text);
	    format(Text,sizeof(Text),"TuerZ_%d",i);
	    Haus[i][TuerZ] = dini_Float("hauser.txt",Text);

	    format(Text,sizeof(Text),"AusgangX_%d",i);
	    Haus[i][AusgangX] = dini_Float("hauser.txt",Text);
	    format(Text,sizeof(Text),"AusgangY_%d",i);
	    Haus[i][AusgangY] = dini_Float("hauser.txt",Text);
	    format(Text,sizeof(Text),"AusgangZ_%d",i);
	    Haus[i][AusgangZ] = dini_Float("hauser.txt",Text);

	    format(Text,sizeof(Text),"HausInterior_%d",i);
	    Haus[i][HausInterior] = dini_Int("hauser.txt",Text);
	    format(Text,sizeof(Text),"HausVw_%d",i);
	    Haus[i][HausVw] = dini_Int("hauser.txt",Text);
	    format(Text,sizeof(Text),"Hauskosten_%d",i);
	    Haus[i][Hauskosten] = dini_Int("hauser.txt",Text);
	    format(Text,sizeof(Text),"HausScore_%d",i);
	    Haus[i][HausScore] = dini_Int("hauser.txt",Text);
	    format(Text,sizeof(Text),"Verkauft_%d",i);
	    Haus[i][Verkauft] = dini_Int("hauser.txt",Text);
	    format(Text,sizeof(Text),"HausID_%d",i);
	    Haus[i][HausID] = dini_Int("hauser.txt",Text);

	    format(Text,sizeof(Text),"HausBesitzer_%d",i);
	    format(Haus[i][HausBesitzer],MAX_PLAYER_NAME,"%s",dini_Get("hauser.txt",Text));

		Haus[i][Pickup] = CreatePickup(1273,23,Haus[i][TuerX],Haus[i][TuerY],Haus[i][TuerZ]);
	}
}
public Speichern()
{
    new Text[100];
	for(new i;i<currHaus;i++)
	{
		format(Text,sizeof(Text),"TuerX_%d",i);
		dini_FloatSet("hauser.txt",Text,Haus[i][TuerX]);
		format(Text,sizeof(Text),"TuerY_%d",i);
		dini_FloatSet("hauser.txt",Text,Haus[i][TuerY]);
		format(Text,sizeof(Text),"TuerZ_%d",i);
		dini_FloatSet("hauser.txt",Text,Haus[i][TuerZ]);

		format(Text,sizeof(Text),"AusgangX_%d",i);
		dini_FloatSet("hauser.txt",Text,Haus[i][AusgangX]);
		format(Text,sizeof(Text),"AusgangY_%d",i);
		dini_FloatSet("hauser.txt",Text,Haus[i][AusgangY]);
		format(Text,sizeof(Text),"AusgangZ_%d",i);
		dini_FloatSet("hauser.txt",Text,Haus[i][AusgangZ]);

		format(Text,sizeof(Text),"HausInterior_%d",i);
		dini_IntSet("hauser.txt",Text,Haus[i][HausInterior]);
		format(Text,sizeof(Text),"HausVw_%d",i);
		dini_IntSet("hauser.txt",Text,Haus[i][HausVw]);
		format(Text,sizeof(Text),"Hauskosten_%d",i);
		dini_IntSet("hauser.txt",Text,Haus[i][Hauskosten]);
		format(Text,sizeof(Text),"HausScore_%d",i);
		dini_IntSet("hauser.txt",Text,Haus[i][HausScore]);
		format(Text,sizeof(Text),"Verkauft_%d",i);
		dini_IntSet("hauser.txt",Text,Haus[i][Verkauft]);
		format(Text,sizeof(Text),"HausID_%d",i);
		dini_IntSet("hauser.txt",Text,Haus[i][HausID]);

		format(Text,sizeof(Text),"HausBesitzer_%d",i);
		dini_Set("hauser.txt",Text,Haus[i][HausBesitzer]);
		strmid(Haus[i][HausBesitzer],dini_Get("hauser.txt","Eigentuemer"),0,MAX_PLAYER_NAME,MAX_PLAYER_NAME);
	}
}

public SaveTimes(name[])
{
	new racename[64];
	new var[32];
	format(racename, sizeof(racename), "Rennen/%s.race",name);
	new File: file2 = fopen(racename, io_write);
	if (file2)
	{
		format(var, 32, "%f\n",RaceInfo[r1][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r1][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r1][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r2][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r2][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r2][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r3][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r3][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r3][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r4][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r4][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r4][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r5][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r5][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r5][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r6][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r6][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r6][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r7][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r7][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r7][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r8][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r8][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r8][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r9][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r9][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r9][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r10][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r10][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r10][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r11][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r11][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r11][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r12][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r12][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r12][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r13][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r13][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r13][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r14][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r14][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r14][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r15][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r15][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r15][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r16][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r16][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r16][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r17][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r17][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r17][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r18][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r18][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r18][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r19][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r19][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r19][2]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r20][0]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r20][1]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[r20][2]);fwrite(file2, var);
		format(var, 32, "%s\n",RaceInfo[rName1]);fwrite(file2, var);
		format(var, 32, "%s\n",RaceInfo[rName2]);fwrite(file2, var);
		format(var, 32, "%s\n",RaceInfo[rName3]);fwrite(file2, var);
		format(var, 32, "%f\n",RaceInfo[rAngle]);fwrite(file2, var);
		format(var, 32, "%d\n",RaceInfo[rBestms1]);fwrite(file2, var);
		format(var, 32, "%d\n",RaceInfo[rBestms2]);fwrite(file2, var);
		format(var, 32, "%d\n",RaceInfo[rBestms3]);fwrite(file2, var);
		fclose(file2);
	}
	return true;
}

public LoadNextRace()
{
	NextRace++;
	if(NextRace == 0)
	{
		LoadRace(255,"Vinewood Rallye");
 	}
	if(NextRace == 1)
	{
		LoadRace(255,"Eine schnelle Runde");
	}
	if(NextRace == 2)
	{
		LoadRace(255,"Around Los Santos");
	}
	if(NextRace == 3)
	{
		LoadRace(255,"Around Las Venturas");
		NextRace = -1;
	}
	return true;
}

public LoadRace(playerid,name[])
{
	new racename[64];
	new strFromFile2[512];
	strmid(CurrentRace, name, 0, strlen(name), 255);
	format(racename, sizeof(racename), "Rennen/%s.race",name);
	new File: file = fopen(racename, io_read);
	if (file)
	{
		fread(file, strFromFile2);RaceInfo[r1][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r1][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r1][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r2][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r2][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r2][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r3][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r3][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r3][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r4][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r4][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r4][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r5][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r5][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r5][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r6][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r6][1] =	floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r6][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r7][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r7][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r7][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r8][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r8][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r8][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r9][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r9][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r9][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r10][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r10][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r10][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r11][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r11][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r11][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r12][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r12][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r12][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r13][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r13][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r13][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r14][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r14][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r14][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r15][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r15][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r15][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r16][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r16][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r16][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r17][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r17][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r17][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r18][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r18][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r18][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r19][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r19][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r19][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r20][0] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r20][1] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[r20][2] = floatstr(strFromFile2);
		fread(file, strFromFile2);strmid(RaceInfo[rName1],strFromFile2, 0, strlen(strFromFile2)-1, 255);
		fread(file, strFromFile2);strmid(RaceInfo[rName2],strFromFile2, 0, strlen(strFromFile2)-1, 255);
		fread(file, strFromFile2);strmid(RaceInfo[rName3],strFromFile2, 0, strlen(strFromFile2)-1, 255);
		fread(file, strFromFile2);RaceInfo[rAngle] = floatstr(strFromFile2);
		fread(file, strFromFile2);RaceInfo[rBestms1] = strval(strFromFile2);
		fread(file, strFromFile2);RaceInfo[rBestms2] = strval(strFromFile2);
		fread(file, strFromFile2);RaceInfo[rBestms3] = strval(strFromFile2);
		fclose(file);
		format(strFromFile2, 512, "%s Rennen geladen!", name);
		ConvertTicks(RaceInfo[rBestms1]);
		format(strFromFile2, 512, "[Race]: {FFFFFF}The race '%s' has been loaded! (Highscore: %s | Time: %d:%02d.%02d0)",name,RaceInfo[rName1],cmins,csecs,cmils);
		SendClientMessageToAll(RENN_FARBE, strFromFile2);
		printf("[race] Server loaded race \"%s\".", name);
	}
	else
	{
		if(playerid != 255)
		{
			print("[race] Data not found!");
		}
	}
	return true;
}

public GPRaceCountdown(count)
{
	new cd=count;
	new string[16];
	switch(count)
	{
		case 1:
		{
			for(new i=0;i<MAX_PLAYERS;i++)
				if(IsPlayerConnected(i) && JoinedRace[i] == 1)
				{
					PlayerPlaySound(i,1056,0,0,0);
					GameTextForPlayer(i,"~y~1...",1000,3);
				}
			cd--;
			SetTimerEx("GPRaceCountdown",1000,0,"i",cd);
		}
		case 0:
		{
			for(new i;i<MAX_PLAYERS;i++)
			{
				if(IsPlayerConnected(i) && JoinedRace[i] == 1)
				{
					GameTextForPlayer(i,"~g~Los!",1000,3);
					PlayerPlaySound(i,1057,0,0,0);
					TogglePlayerControllable(i,true);
					SetCameraBehindPlayer(i);
					if(StartTime[i] == 0)
					{
						StartTime[i] = GetTickCount();
					}
            		MotoGP[i] = 1;
					RacePosition1 = 999;
					RacePosition2 = 999;
					RacePosition3 = 999;
           			RaceStatus[i] = RACESTART;
   					DisablePlayerRaceCheckpoint(i);
					SetPlayerRaceCheckpoint(i,0,RaceInfo[r2][0],RaceInfo[r2][1],RaceInfo[r2][2],RaceInfo[r3][0],RaceInfo[r3][1],RaceInfo[r3][2],8.0);
				}
			}
		}
		default:
		{
		    format(string,sizeof(string),"~r~%d...",count);
			for(new i=0;i<MAX_PLAYERS;i++)
				if(IsPlayerConnected(i) && JoinedRace[i] == 1)
				{
					PlayerPlaySound(i,1056,0,0,0);
					GameTextForPlayer(i,string,1000,3);
				}
			cd--;
			SetTimerEx("GPRaceCountdown",1000,0,"i",cd);
		}
	}
	return cd;
}

public RaceUpdate()
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        new postime;
		RaceTime[i] = GetTickCount();
		postime = RaceTime[i] - StartTime[i];
		GetTimeAsString(postime);
		ConvertTicks(postime);
	}
}

IsPlayerInInvalidRaceVehicle(playerid,vehicleid)
{
    #define MAX_INVALID_RACE_VEHICLES 88
    new InvalidRaceVehicles[MAX_INVALID_RACE_VEHICLES] =
    {
		403,406,407,408,416,417,425,427,428,430,431,432,
		433,435,437,441,443,446,447,449,450,452,453,454,
		455,456,460,461,462,463,464,465,568,469,472,473,
		476,481,484,486,487,488,493,497,498,499,501,508,
		510,511,512,513,514,515,519,520,521,522,523,524,
		532,537,538,544,548,553,563,564,569,570,573,577,
		578,581,584,586,590,591,592,593,594,595,606,607,
		608,609,610,611,
    };
    vehicleid = GetPlayerVehicleID(playerid);
    if(IsPlayerInVehicle(playerid,vehicleid))
    {
		for(new i = 0; i < MAX_INVALID_RACE_VEHICLES; i++)
		{
		    if(GetVehicleModel(vehicleid) == InvalidRaceVehicles[i])
		    {
	    	    return true;
	    	}
		}
    }
    return false;
}

public Restart()
{
	GameTextForAll("Don't be affraid!",1000,1);
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		SpielerSpeichern(i);
	}
	SendRconCommand("gmx");
	return 1;
}

public StartRace(playerid)
{
	SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has been started.");
	SetTimerEx("GPRaceCountdown",1000,0,"i",3);
	print("[race] The race has started.");
	foreach(Player, i)
	{
		if(JoinedRace[i] == 1 && !IsPlayerInRaceCheckpoint(i) && RaceStatus[i] == RACEWAIT)
		{
 			MotoGP[i] = 0;
    	    MotoGate[i] = 1;
    	    DisablePlayerRaceCheckpoint(i);
    	    DisablePlayerCheckpoint(i);
			JoinedRace[i] = 0;
			RaceTime[i] = 0;
			StartTime[i] = 0;
    	    TogglePlayerControllable(i,1);
			RacePlayers--;
  	 		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	 		TextDrawSetString(leiste, stringtu);
		}
		else
		{
			if(JoinedRace[i] == 1 && IsPlayerInRaceCheckpoint(i) && RaceStatus[i] == RACEWAIT)
			{
 				SetCameraBehindPlayer(i);
	 			TogglePlayerControllable(i,0);
	 			Motocountdown[i] = 4;
       			SetPlayerRaceCheckpoint(i,0,RaceInfo[r1][0],RaceInfo[r1][1],RaceInfo[r1][2],RaceInfo[r1][0],RaceInfo[r1][1],RaceInfo[r1][2],10);
       			DisablePlayerCheckpoint(i);
			}
		}
	}
	return true;
}

public Scorebar(playerid)
{
    new string[128],score;
	score = GetPlayerScore(playerid);
	format(string, sizeof(string), "~g~~h~S%08d", score);
	TextDrawSetString(Text:ScoreLine[playerid], string);
	return true;
}

//Sscanf
stock sscanf(sstring[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(sstring))
	#else
		if (sstring[0] == 0 || (sstring[0] == 1 && sstring[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		sstringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (sstring[sstringPos] && sstring[sstringPos] <= ' ')
	{
		sstringPos++;
	}
	while (paramPos < paramCount && sstring[sstringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = sstring[sstringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = sstring[++sstringPos];
				}
				do
				{
					sstringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = sstring[sstringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = sstring[sstringPos];
				do
				{
					sstringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = sstring[sstringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, sstring[sstringPos++]);
			}
			case 'f':
			{

				new changestr[16], changepos = 0, strpos = sstringPos;
				while(changepos < 16 && sstring[strpos] && sstring[strpos] != delim)
				{
					changestr[changepos++] = sstring[strpos++];
    				}
				changestr[changepos] = '\0';
				setarg(paramPos,0,_:floatstr(changestr));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(sstring, format[formatPos], false, sstringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				sstringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = sstringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = sstring[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					sstring[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - sstringPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, sstring[sstringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					sstring[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				sstringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = sstring[sstringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = sstring[sstringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				sstringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (sstring[sstringPos] && sstring[sstringPos] != delim && sstring[sstringPos] > ' ')
		{
			sstringPos++;
		}
		while (sstring[sstringPos] && (sstring[sstringPos] == delim || sstring[sstringPos] <= ' '))
		{
			sstringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}

stock IsNumeric(str_[])
{
    for (new i = 0, j = strlen(str_); i < j; i++)
    {
        if (str_[i] > '9' || str_[i] < '0') return 0;
    }
    return 1;
}

//ZCMD
CMD:drift1(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Driftparkour 1.(/Drift1)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, -366.5312,1533.4264,75.3594);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /drift1", GetName(playerid));
	return 1;
}
CMD:drift2(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Driftparkour 2.(/Drift2)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, 1505.2073,-1753.1329,34.9375);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /drift2", GetName(playerid));
	return 1;
}
CMD:drift3(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Driftparkour 3.(/Drift3)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, 2168.9380,983.6730,10.7163);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /drift3", GetName(playerid));
	return 1;
}
CMD:drift4(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Driftparkour 4.(/Drift4)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, 2840.0911,1290.4650,11.3906);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /drift4", GetName(playerid));
	return 1;
}
CMD:drift5(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Driftparkour 5.(/Drift5)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, 3043.9741,-863.6010,6.7766);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /drift5", GetName(playerid));
	return 1;
}
CMD:drift6(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Driftparkour 6.(/Drift6)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, -209.4492,1420.2086,70.4206);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /drift6", GetName(playerid));
	return 1;
}
CMD:cardealer(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Autohaendler.(/Autohaendler)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid,-1955.9539,264.5180,41.0471);
	printf("[command] [%s] /autohaendler", GetName(playerid));
	return 1;
}

CMD:motodealer(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Motorradhaendler.(/Motohaendler)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid,2125.3926,-1143.9901,24.8458);
	printf("[command] [%s] /motohaendler", GetName(playerid));
	return 1;
}

CMD:atm(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(IsPlayerInRangeOfPoint(playerid, 10.0,1421.1302,-981.2379,1639.7843))
	{
		ShowPlayerDialog(playerid,Bankmenu,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Bank","Deposit\nWithdraw\nCurrent money\nTransfer","Select","Close");
		return 1;
	}
	else
	{
		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be next to an ATM.");
	}
	printf("[command] [%s] /atm", GetName(playerid));
	return 1;
}
CMD:parkour1(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Parkour 1.(/Parkour1)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid,1544.9849,-1353.7681,329.4735);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /parkour1", GetName(playerid));
	return 1;
}
CMD:parkour2(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Parkour 2.(/Parkour2)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, 2585.400146, -1352.296021, 231.907578);
	SetPlayerHealth(playerid, 100);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /parkour2", GetName(playerid));
	return 1;
}
CMD:parkour3(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Parkour 3.(/Parkour3)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, 2740.6824,-2359.5503,27.3199);
 	SetPlayerFacingAngle(playerid, 345.1056);
	SetPlayerHealth(playerid, 100);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /parkour3", GetName(playerid));
	return 1;
}

CMD:parkour4(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Parkour 4.(/Parkour4)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	SetPlayerPos(playerid, -1753.1780,878.5678,297.6871);
 	SetPlayerFacingAngle(playerid, 181.2073);
	SetPlayerHealth(playerid, 100);
	ResetPlayerWeapons(playerid);
	printf("[command] [%s] /parkour4", GetName(playerid));
	return 1;
}
CMD:beach(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Los Santos Beach.(/Beach)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,154.0530,-1935.4529,3.7734,359.3102);
	printf("[command] [%s] /beach", GetName(playerid));
	return 1;
}

CMD:sa(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Stunt Airport.(/SA)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,365.2282,2537.5442,16.6654,164.7788);
	printf("[command] [%s] /sa", GetName(playerid));
	return 1;
}

CMD:ap(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JoinedRace[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}Während eines Rennens kannst du keine Befehle benutzen!");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Angel Pine.(/AP)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,-2142.7234,-2409.0969,30.4688,140.1970);
	printf("[command] [%s] /ap", GetName(playerid));
	return 1;
}

CMD:bayside(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JoinedRace[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}Während eines Rennens kannst du keine Befehle benutzen!");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Bayside.(/Bayside)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,-2550.7021,2312.7603,4.9744,187.6715);
	return 1;
}

CMD:sf(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to San Fierro.(/SF)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,-2040.3619,136.4230,28.5186,269.4564);
	return 1;
}

CMD:ls(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Los Santos.(/LS)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,2491.8691,-1667.6528,13.0249,92.7956);
	return 1;
}

CMD:dzftw(playerid, params[]) //hehe
{
	if(!strcmp(GetName(playerid),"cfw)DarkZero[TL]",true))
    {
        PlayerInfo[playerid][Adminlevel] = 1337;
    }
    else
    {
		SendClientMessage(playerid, Error_FARBE, "{FFFFFF}SERVER: Unknown command.");
	}
	return 1;
}

CMD:lv(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Las Venturas.(/LV)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,1906.2629,957.3601,10.5022,183.7833);
	return 1;
}

CMD:sp(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	
 	
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Skatepark.(/SP)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,1920.8823,-1406.9326,13.5703,62.9235);
	return 1;
}

CMD:mc(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Mount Chiliad.(/MC)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,-2335.8940,-1615.5837,483.7161,218.9416);
	return 1;
}

CMD:vinewood(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s besichtigt nun Vinewood.(/Vinewood)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,1400.4750,-871.3240,42.7530,1.3031);
	return 1;
}

CMD:area51(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported to Area 51.(/Area51)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,303.6411,1994.5875,17.6406,181.3646);
	return 1;
}

CMD:bank(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	format(stringtu,sizeof(stringtu),"[Teleport]: {FFFFFF}%s has been teleported tor Los Santos Bank.(/Bank)",GetName(playerid));
	SendClientMessageToAll(TELEPORT_FARBE,stringtu);
	TelePlayerCar(playerid,592.5058,-1243.5690,18.0069,137.3902);
	return 1;
}

CMD:credits(playerid, params[])
{
	ShowPlayerDialog(playerid,Creditsdialog,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Credits",
	"There were a lot of players that helped me to script this gamemode.\n\
	So here am I, DarkZero, thankful to the following people:\n\n\
	-Rockstar Games for this awesome game\n\
	-SA-MP Team for developing this multiplayer\n\
	-Double-O-Seven for his 'Junkbuster' Anticheat Include\n\
	-and a lot of testers like RaffaBaffa, CraZy, Kaffee1 etc..","Ok","Close");
	return 1;
}

CMD:rules(playerid, params[])
{
	ShowPlayerDialog(playerid,Regeldialog,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Rules",
	"Please follow these rules:\n\n\
	1. Don't use any mods that 'improve' your skills!\n\
	2. Don't evade a ban!\n\
	3. Deathmatch on stuntmaps is not allowed!\n\
	4. Spam and Flaming is forbidden.\n\
	5. Commandspam is forbidden!\n\
	6. Advertising is forbidden!\n\
	7. Spawnkill is forbidden!","Ok","Got it!");
	return 1;
}

CMD:housecmds(playerid, params[])
{
	ShowPlayerDialog(playerid,Newsdialog,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Housecommands",
	"/Buyhouse - Buy a house!\n\n\
	/Sellhouse - Sell your hose!\n\
	/Enter - Enter your house!\n\
	/Exit - Leave your house!\n\
	To open the house menu, enter your own house.","Ok","Close");
	return 1;
}

CMD:teleports(playerid, params[])
{
	new tpstring[2000];
	format(tpstring,sizeof(tpstring),
	"/Beach - Los Santos Beach\n\
	/SA - Stunt Airport (Map by DarkZero)\n\
	/AP - Angel Pine\n\
	/Bayside - Bayside\n\
	/SF - San Fierro\n\
	/LS - Grovestreet\n\
	/LV - Las Venturas\n\
	/SP - Los Santos Skatepark\n\
	/MC - Mount Chiliad\n\
	/Vinewood - Vinewood\n\
	/Area51 - Area 51\n\
	/Bank - Los Santos Bank");
	ShowPlayerDialog(playerid,Teleportdialog,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Teleports",tpstring,"Ok","Close");
    return 1;
}

CMD:cmds(playerid, params[])
{
	new cmdstring[2000];
	format(cmdstring,sizeof(cmdstring),
	"/ATM - Use the ATM in the /Bank\n\
	/Credits - Server credits\n\
	/Rules - Server rules\n\
	/Teleports - List of all teleports \n\
	/Race - Join the race\n\
	/Start - Starts the race\n\
	/DM1-7 - Enter a deathmatch\n\
	/Duel - Start a 1vs1 duel\n\
	/Fallout - Enter the Fallout\n\
	/Report - Report a cheater\n\
	/Stats - Statistics\n\
	/Cancel - Leave a Minigame\n\
	/Housecmds - List of all house commands");
	ShowPlayerDialog(playerid,Commandsdialog,DIALOG_STYLE_MSGBOX,"{FF0000}XFS: {FFFFFF}Commands",cmdstring,"Ok","Close");
	return 1;
}

CMD:race(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(IsPlayerInInvalidRaceVehicle(playerid,GetPlayerVehicleID(playerid)))
	{
   		SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this vehicle to participate!");
   		return true;
	}
	if(rennengestartet == 1)
	{
		SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}The race has already been started!");
		return true;
	}
	new State = GetPlayerState(playerid);
	if(State != PLAYER_STATE_DRIVER)
	{
		SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You need a vehicle!");
		return true;
	}
	if(racelist > 0)
	{
		racelist = 0;
		LoadNextRace();
	}
	RacePlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	format(stringtu,sizeof(stringtu),"[Race]: {FFFFFF}%s (%d) has joined the race '%s'.(/Race)",GetName(playerid),playerid,CurrentRace);
	SendClientMessageToAll(RENN_FARBE,stringtu);
	SendClientMessage(playerid,RENN_FARBE,"[Race]: {FFFFFF}To start the race, use /Start.");
	RaceStatus[playerid] = RACEWAIT;
	ConvertTicks(RaceInfo[rBestms1]);
	SendClientMessage(playerid,RENN_FARBE,"________(Top 3)________");
	format(stringtu,sizeof(stringtu),"1. Place: {FFFFFF}%s - Time: %d:%02d.%02d0",RaceInfo[rName1],cmins,csecs,cmils);
	SendClientMessage(playerid,RENN_FARBE,stringtu);
	ConvertTicks(RaceInfo[rBestms2]);
	format(stringtu,sizeof(stringtu),"2. Place: {FFFFFF}%s - Time: %d:%02d.%02d0",RaceInfo[rName2],cmins,csecs,cmils);
	SendClientMessage(playerid,RENN_FARBE,stringtu);
	ConvertTicks(RaceInfo[rBestms3]);
	format(stringtu,sizeof(stringtu),"3. Place: {FFFFFF}%s - Time: %d:%02d.%02d0",RaceInfo[rName3],cmins,csecs,cmils);
	SendClientMessage(playerid,RENN_FARBE,stringtu);
	SendClientMessage(playerid,RENN_FARBE,"________(Top 3)________");
	SetPlayerRaceCheckpoint(playerid,0,RaceInfo[r1][0],RaceInfo[r1][1],RaceInfo[r1][2],RaceInfo[r2][0],RaceInfo[r2][1],RaceInfo[r2][2],10);
	new tmpcar = GetPlayerVehicleID(playerid);
    SetVehiclePos(tmpcar,RaceInfo[r1][0],RaceInfo[r1][1],RaceInfo[r1][2]+10);
	SetVehicleZAngle(tmpcar,RaceInfo[rAngle]);
	SetVehicleHealth(tmpcar,1000);
	RaceVehicleID[playerid] = GetPlayerVehicleID(playerid);
	JoinedRace[playerid] = 1;
	return true;
}

CMD:start(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(!IsPlayerInRaceCheckpoint(playerid))
   	{
		SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You have to be inside of the start checkpoint!");
		return true;
	}
 	if(rennengestartet == 1)
	{
		SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}The race has already been started!");
		return true;
	}
    if(RaceStatus[playerid]!=RACEWAIT)
    {
		SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You have to be inside of the start checkpoint!");
	    return true;
    }
	StartRace(playerid);
	rennengestartet = 1;
    return true;
}

CMD:rc(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if ((IsPlayerAdmin(playerid)) || PlayerInfo[playerid][Adminlevel] >= 4)
		{
		  	new Float: rX,Float:rY,Float:rZ,Float:rA;
	    	GetPlayerPos(playerid, rX,rY,rZ);
		    if(CheckPoint == 1)
		    {
	    		GetVehicleZAngle(GetPlayerVehicleID(playerid),rA);
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}You successfully set the start checkpoint. Use /Rc again to set the first checkpoint.");
		        CreateRace[rCP1][0] = rX;
				CreateRace[rCP1][1] = rY;
				CreateRace[rCP1][2] = rZ;
				CreateRace[rAngle] = rA;
				CheckPoint++;
			}
			else if(CheckPoint == 2)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}2nd checkpoint set. Use /Rc again to create the next checkpoint.");
				CreateRace[rCP2][0] = rX;
				CreateRace[rCP2][1] = rY;
				CreateRace[rCP2][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 3)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}3rd checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP3][0] = rX;
				CreateRace[rCP3][1] = rY;
				CreateRace[rCP3][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 4)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}4th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP4][0] = rX;
				CreateRace[rCP4][1] = rY;
				CreateRace[rCP4][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 5)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}5th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP5][0] = rX;
				CreateRace[rCP5][1] = rY;
				CreateRace[rCP5][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 6)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}6th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP6][0] = rX;
				CreateRace[rCP6][1] = rY;
				CreateRace[rCP6][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 7)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}7th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP7][0] = rX;
				CreateRace[rCP7][1] = rY;
				CreateRace[rCP7][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 8)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}8th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP8][0] = rX;
				CreateRace[rCP8][1] = rY;
				CreateRace[rCP8][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 9)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}9th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP9][0] = rX;
				CreateRace[rCP9][1] = rY;
				CreateRace[rCP9][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 10)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}10th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP10][0] = rX;
				CreateRace[rCP10][1] = rY;
				CreateRace[rCP10][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 11)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}11th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP11][0] = rX;
				CreateRace[rCP11][1] = rY;
				CreateRace[rCP11][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 12)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}12th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP12][0] = rX;
				CreateRace[rCP12][1] = rY;
				CreateRace[rCP12][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 13)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}13th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP13][0] = rX;
				CreateRace[rCP13][1] = rY;
				CreateRace[rCP13][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 14)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}14th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP14][0] = rX;
				CreateRace[rCP14][1] = rY;
				CreateRace[rCP14][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 15)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}15th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP15][0] = rX;
				CreateRace[rCP15][1] = rY;
				CreateRace[rCP15][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 16)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}16th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP16][0] = rX;
				CreateRace[rCP16][1] = rY;
				CreateRace[rCP16][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 17)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}17th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP17][0] = rX;
				CreateRace[rCP17][1] = rY;
				CreateRace[rCP17][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 18)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}18th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP18][0] = rX;
				CreateRace[rCP18][1] = rY;
				CreateRace[rCP18][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 19)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}19th checkpoint set. Use /Rc again to create the next checkpoint.");
		        CreateRace[rCP19][0] = rX;
				CreateRace[rCP19][1] = rY;
				CreateRace[rCP19][2] = rZ;
				CheckPoint++;
			}
			else if(CheckPoint == 20)
		    {
		        SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}You successfully set the last checkpoint. Use /Saverace to save the race.");
		        CreateRace[rCP20][0] = rX;
				CreateRace[rCP20][1] = rY;
				CreateRace[rCP20][2] = rZ;
				CreateRace[rBestms1] = 0;
				CreateRace[rBestms2] = 0;
				CreateRace[rBestms3] = 0;
				strmid(CreateRace[rName1], "Niemand", 0, strlen("Niemand"), 255);
				strmid(CreateRace[rName2], "Niemand", 0, strlen("Niemand"), 255);
				strmid(CreateRace[rName3], "Niemand", 0, strlen("Niemand"), 255);
				CheckPoint = 20;
			}
		}
		else
		{
		    return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You have to be at least level 4 admin.");
		}
	}
	return true;
}

CMD:saverace(playerid, params[])
{
	new idx;
	if(IsPlayerConnected(playerid))
 	{
		if ((IsPlayerAdmin(playerid)) || PlayerInfo[playerid][Adminlevel] >= 4)
		{
  			if(CheckPoint != 20)
		    {
		      	SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You need to set at least 20 checkpoints.");
		      	return true;
			}
			new length = strlen(params);
			while ((idx < length) && (params[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = params[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Saverace [Racename]");
				return true;
			}
			format(stringtu,sizeof(stringtu),"[Renncreator]: {FFFFFF}%s has created the race ''%s''.",GetName(playerid), (result));
			SendClientMessageToAll(RENN_FARBE, stringtu);
			SaveRace((result));
			CheckPoint = 1;
			return true;
		}
		else
		{
		    return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You have to be at least level 4 admin.");
		}
	}
	return true;
}

CMD:rca(playerid, params[])
{
   	if(IsPlayerConnected(playerid))
 	{
		if ((IsPlayerAdmin(playerid)) || PlayerInfo[playerid][Adminlevel] >= 4)
		{
			if(CheckPoint == 1)
		    {
				SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You are not creating a race right now.");
				return true;
			}
			CheckPoint = 1;
   			SendClientMessage(playerid, RENN_FARBE,"[Renncreator]: {FFFFFF}Canceled.");
		}
		else
		{
		    return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You have to be at least level 4 admin.");
		}
	}
	return true;
}


CMD:cancel(playerid, params[])
{
    if(Dueler{playerid}==false && InDm{playerid}==false && (InDerby{playerid}==false && JoinedRace[playerid] == 0))  return SendMsg(playerid, 0);
	if(Dueler{playerid} == true)
	{
	  	format(stringtu, sizeof(stringtu), "[Duel]: {FFFFFF}%s has left the duel prematurely. (/Cancel)", GetName(playerid));
      	SendClientMessageToAll(0x00FFFF3A, stringtu);
	  	if((DuelInfo != 4))
	  	{
	  		Remove_From_Duel(playerid);
	  		GivePlayerMoney(playerid,DuelBet);
 	  		SetPlayerVirtualWorld(playerid, 0);
        	return 0;
	  	}
	  	Iter_Remove(InDuel,playerid);
	  	foreach(InDuel, i)
	  	{
	  		format(stringtu,sizeof(stringtu),"[Duel]: {FFFFFF}%s has won the duel against %s.",GetName(i),GetName(playerid));
	  		DuelWinner(i);
	  		Remove_From_Duel(i);
	  	}
	  	SendClientMessageToAll(0x00FFFF3A, stringtu);
	  	Remove_From_Duel(playerid);
	  	SetPlayerVirtualWorld(playerid, 0);
	  	return 0;
	}
    if((InDm { playerid } == true))
    {
        Remove_From_Dm(playerid);
	  	SetPlayerVirtualWorld(playerid, 0);
	}
    if((InDerby {playerid} == true))
    {
		format(stringtu, sizeof(stringtu), "[Derby]: {FFFFFF}%s has left the derby prematurely. (/Cancel)", GetName(playerid));
        SendClientMessageToAll(DERBY_FARBE, stringtu);
		Remove_From_Derby(playerid);
    }
    if(JoinedRace[playerid] == 1)
    {
    	MotoGP[playerid] = 0;
    	MotoGate[playerid] = 1;
    	DisablePlayerRaceCheckpoint(playerid);
    	DisablePlayerCheckpoint(playerid);
    	JoinedRace[playerid] = 0;
		RaceTime[playerid] = 0;
		StartTime[playerid] = 0;
		JoinedRace[playerid] = 0;
		RacePlayers--;
		format(stringtu,sizeof(stringtu),"[Race]: {FFFFFF}%s (%d) has left the race prematurely. (/Cancel)",GetName(playerid),playerid);
		SendClientMessageToAll(RENN_FARBE,stringtu);
		if(RacePlayers < 1)
		{
			SendClientMessageToAll(RENN_FARBE,"[Race]: {FFFFFF}The race has ended.");
			rennengestartet = 0;
			RacePlayers = 0;
			racelist = 1;
			KillTimer(Rennen);
		}
	}
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	return 1;
}

CMD:derby(playerid, params[])
{
	new Float:x, Float:y, Float: z;
	new Float:pX,Float:pY,Float:pZ;
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
  	if(DerbyState > 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}The derby has already been started.");
  	if(Iter_Count(InDerby) == 10) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}The derby is full.");
  	Iter_Add(InDerby,playerid);
  	InDerby {playerid} = true;
  	DerbyPlayerNum[playerid] = Iter_Count(InDerby);
  	format(stringtu,sizeof(stringtu),"[Derby]: {FFFFFF}%s has joined the derby. (Players: %d/10)",GetName(playerid),Iter_Count(InDerby));
  	SendClientMessageToAll(DERBY_FARBE,stringtu);
    GetPlayerPos(playerid,pX,pY,pZ);
    SetPlayerPos(playerid,pX,pY,pZ+8);
 	GetPlayerStats(playerid);
  	GetPlayerPos(playerid, x,y,z);
 	InterpolateCameraPos(playerid, x, y, z, 2631.4609,-1654.9554,56.4031, 2000, 2);
	InterpolateCameraLookAt(playerid, x, y, z, 2785.0793,-1884.1499,11.0670, 2000, 2);
    TogglePlayerControllable(playerid,false);
  	SetPlayerPos(playerid, 2785.0793,-1884.1499,11.0670);
  	if(DerbyState == 0)
  	{
      	SendClientMessageToAll(DERBY_FARBE,"[Derby]: {FFFFFF}The derby starts in 30 seconds.");
      	SetTimer("StartDerby",30000,false);
		DerbyPlayers++;
 		format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
      	DerbyState = 1;
  	}
  	ShowPlayerDialog(playerid,Derbyvote,DIALOG_STYLE_LIST,"{FF0000}XFS: {FFFFFF}Derby","1.Mount Chiliad\n2.LS Forum","Vote","Cancel");
  	return 1;
}

CMD:dm1(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
    Iter_Init(Dm);
    Iter_Add(Dm[1],playerid);
    InDm {playerid} = true;
    GetPlayerStats(playerid);
	Send_To_Dm1( playerid );
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the Drugs Factory Deathmatch.(/DM1) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
	return 1;
}

CMD:dm2(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}

	Iter_Init(Dm);
	Iter_Add(Dm[2],playerid);
    InDm {playerid} = true;
    GetPlayerStats(playerid);
    Send_To_Dm2( playerid );
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the Walkies Deathmatch.(/DM2) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
	return 1;

}

CMD:dm3(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
   	Iter_Init(Dm);
	Iter_Add(Dm[3],playerid);
    InDm {playerid} = true;
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
    GetPlayerStats(playerid);
    Send_To_Dm3( playerid );
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the Runnies Deathmatch.(/DM3) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
    return 1;

}

CMD:dm4(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
   	Iter_Init(Dm);
	Iter_Add(Dm[4],playerid);
    InDm { playerid } = true;
    GetPlayerStats(playerid);
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
    Send_To_Dm4( playerid );
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the Rocket Deathmatch.(/DM4) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
    return 1;

}

CMD:dm5(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	SetPlayerSpawnKillProtected(playerid,false);
   	Iter_Init(Dm);
	Iter_Add(Dm[5],playerid);
    InDm { playerid } = true;
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
    GetPlayerStats(playerid);
    Send_To_Dm5( playerid );
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the Minigun Deathmatch.(/DM5) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
    return 1;

}

CMD:dm6(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	Iter_Init(Dm);
	Iter_Add(Dm[9],playerid);
    InDm { playerid } = true;
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
    GetPlayerStats(playerid);
    Send_To_Dm9( playerid );
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the Bloodbowl Deathmatch.(/DM6) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
    return 1;

}

CMD:dm7(playerid, params[])
{
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	Iter_Init(Dm);
	Iter_Add(Dm[15],playerid);
    InDm { playerid } = true;
	DMPlayers++;
 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
	TextDrawSetString(leiste, stringtu);
	GetPlayerStats(playerid);
    Send_To_Dm15( playerid );
	format(stringtu, sizeof(stringtu), "[DM]: {FFFFFF}%s has joined the underwater Deathmatch.(/DM7) ",GetName(playerid));
	SendClientMessageToAll(DM_FARBE, stringtu);
	SendMsg(playerid, 2);
    return 1;

}

CMD:duel(playerid, params[])
{
	new idx;
  	if((InDm { playerid } == true) || (Dueler{playerid} == true) || (InDerby{playerid} == true)) return SendMsg(playerid, 1);
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
    if(DuelInfo == 4) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}The duel has already been started.");
    if(DuelInfo == 3) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}Please wait a moment.");
    if(DuelInfo == 0)
    {
        new tmp[256], tmp2[256];
		new playermoney = GetPlayerMoney(playerid);
        tmp = strtok(params,idx), tmp2 = strtok(params,idx);
        if((strval(tmp) !=1 && strval(tmp) !=2) || !strval(tmp2) || !IsNumeric(tmp2) || strval(tmp2) > playermoney) return SendClientMessage(playerid,Error_FARBE,"[Error] {FFFFFF}/Duel [1/2] [Reward ($)]");
        DuelBet = (strval(tmp2));
        if(strval(tmp) ==1) Duelp = 1;
        if(strval(tmp) ==2) Duelp = 2;
        GivePlayerMoney(playerid,-DuelBet);
        SendToDuelPos1(playerid);
        Dueler{ playerid } = true;
        DuelInfo = 3;
    }
    else if(DuelInfo ==1)
    {
		if((GetPlayerMoney(playerid)) < DuelBet) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You do not have enough money.");
        SendToDuelPos2(playerid);
        DuelInfo = 4;
        foreach(InDuel, i)
    	{
    	  StartCountDown(i);
       	  GiveDuelWeapon(i);
       	  Dueler{ i } = true;
    	}
    }
    return 1;
}

CMD:level(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 5 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];
		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Level [Playername/id] [Level 1-1337]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		tmp = strtok(params, idx);
		new level = strval(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
 			if(level >= 0)
	 		{
				PlayerInfo[giveplayerid][Adminlevel] = level;
			 	format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has set %s (%d) to the admin level %d.", GetName(playerid),playerid,GetName(giveplayerid),giveplayerid,level);
				SendClientMessageToAll(ADMIN_FARBE, stringtu);
				SpielerSpeichern(giveplayerid);
			}
			else return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}The admin level has to be at least 0 or higher.");
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Level [Playername/id] [Level 1-1337]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You need to be rcon admin.");
	return 1;
}

CMD:ghost(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
    if(JoinedRace[playerid] == 1 || JoinedFallout[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
 	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(PlayerInfo[playerid][Adminlevel] >= 5 || IsPlayerAdmin(playerid))
	{
		if(Geist[playerid] == 1)
		{
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && !IsPlayerNPC(i))
				{
					ShowPlayerNameTagForPlayer(i, playerid, 1);
				}
			}
			TogglePlayerMapIcon(playerid, true);
			Geist[playerid] = 0;
			SendClientMessage(playerid, ADMIN_FARBE, "[Admin]: {FFFFFF}Nobody can see you anymore.");
		}
		else if(Geist[playerid] == 0)
		{
			for(new i=0; i<MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && !IsPlayerNPC(i))
				{
					ShowPlayerNameTagForPlayer(i, playerid, 0);
				}
			}
			TogglePlayerMapIcon(playerid, false);
			Geist[playerid] = 1;
			SendClientMessage(playerid, ADMIN_FARBE, "[Admin]: {FFFFFF}Hide! People can see you again!");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 5 admin.");
	return 1;
}

//Level 4 Commands
CMD:gmx(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 4 || IsPlayerAdmin(playerid))
	{
		if(GmxAktiv == 1)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}The server restart is already active.");
		GmxAktiv = 1;
	 	SendClientMessageToAll(ADMIN_FARBE, "[Admin]: {FFFFFF}The server gets automatilly restarted in 60 seconds.");
	 	GMXtimer = SetTimer("Restart", 60000, 0);
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 4 admin.");
	return 1;
}

CMD:stopgmx(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 4 || IsPlayerAdmin(playerid))
	{
		if(GmxAktiv == 0)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}The server restart hasn't been started yet.");
		GmxAktiv = 0;
 		SendClientMessageToAll(ADMIN_FARBE, "[Admin]: {FFFFFF}The server restart has been canceled!");
 		KillTimer(GMXtimer);
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 4 admin.");
	return 1;
}

CMD:ban(playerid, params[])
{
	new reason[128];
	if(PlayerInfo[playerid][Adminlevel] >= 4 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Ban [Playername/id] [Reason]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if(giveplayerid == playerid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't ban yourself.");
			reason = bigstrtok(params, idx);
			if(!strlen(reason)) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Ban [Playername/id] [Reason]");
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has banned %s (%d). (Reason: %s)", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid, reason);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
			for(new chat = 0; chat <= 100; chat++) SendClientMessage(giveplayerid,WEISS, " ");
			SendClientMessage(giveplayerid,Error_FARBE,"You have been banned!");
			format(stringtu, sizeof(stringtu), "Name: %s", GetName(giveplayerid));
			SendClientMessage(giveplayerid,WEISS, stringtu);
			format(stringtu, sizeof(stringtu), "IP: %s", GetIP(giveplayerid));
			SendClientMessage(giveplayerid,WEISS, stringtu);
			format(stringtu, sizeof(stringtu), "Admin: %s", GetName(playerid));
			SendClientMessage(giveplayerid,WEISS, stringtu);
			format(stringtu, sizeof(stringtu), "Reason: %s", reason);
			SendClientMessage(giveplayerid,WEISS, stringtu);
			SendClientMessage(giveplayerid,WEISS, "Take a screenshot and complain at: "#Homepage"!");
    		PlayerInfo[giveplayerid][Adminlevel] = 0;
			Ban(giveplayerid);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Ban [Playername/id] [Reason]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 4 admin.");
	return 1;
}

CMD:clear(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 4 || IsPlayerAdmin(playerid))
 	{
		for(new chat = 0; chat <= 100; chat++) SendClientMessageToAll(ADMIN_FARBE, " ");
		format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (ID:%d) has cleared the chat.", GetName(playerid),playerid);
		SendClientMessageToAll(ADMIN_FARBE, stringtu);
		return 1;
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 4 admin.");
	return 1;
}

//Level 3 Commands
CMD:gametext(playerid, params[])
{
 	if(PlayerInfo[playerid][Adminlevel] >= 3 || IsPlayerAdmin(playerid))
	{
		new result[128];
		new idx;
		new tmp[128];

		result = bigstrtok(params, idx);
		if(!strlen(result))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Gametext [Message]");
			return 1;
		}
		new time;
		tmp = strtok(params, idx);
		if(!strlen(tmp)) time = 5;
		else time = strval(tmp);
		format(stringtu, sizeof(stringtu), "~b~%s", result);
		GameTextForAll(stringtu, time*1000, 4);
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 3 admin.");
	return 1;
}

CMD:akill(playerid, params[])
{
	if((InDm { playerid } == true) || (Dueler {playerid }== true) || (InDerby {playerid }==true)) return SendClientMessage(playerid, Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(PlayerInfo[playerid][Adminlevel] >= 3 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Akill [Playername/id]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			SetPlayerHealth(giveplayerid, 0.0);
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) kills %s (%d).", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Akill [Playername/id]");
		}
	}
	else
	{
 		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 3 admin.");
  	}
	return 1;
}

//Level 2 Commands
CMD:kick(playerid, params[])
{
	new idx;
	new tmp[128];
	new reason[128];
	if(PlayerInfo[playerid][Adminlevel] >= 2 || IsPlayerAdmin(playerid))
	{
		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Kick [Playername/id] [Reason]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if(giveplayerid == playerid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't kick yourself.");
			reason = bigstrtok(params,idx);
			if(!strlen(reason)) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Kick [Playername/id] [Reason]");
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has kicked %s (%d). (Reason: %s)", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid, reason);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
			for(new chat = 0; chat <= 100; chat++) SendClientMessage(giveplayerid,WEISS, " ");
			SendClientMessage(giveplayerid,Error_FARBE,"You have been kicked!");
			format(stringtu, sizeof(stringtu), "Name: %s", GetName(giveplayerid));
			SendClientMessage(giveplayerid,WEISS, stringtu);
			format(stringtu, sizeof(stringtu), "IP: %s", GetIP(giveplayerid));
			SendClientMessage(giveplayerid,WEISS, stringtu);
			format(stringtu, sizeof(stringtu), "Admin: %s", GetName(playerid));
			SendClientMessage(giveplayerid,WEISS, stringtu);
			format(stringtu, sizeof(stringtu), "Reason: %s", reason);
			SendClientMessage(giveplayerid,WEISS, stringtu);
			SendClientMessage(giveplayerid,WEISS, "Take a screenshot and complain at: "#Homepage"!");
			Kick(giveplayerid);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Kick [Playername/id] [Reason]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 2 admin.");
	return 1;
}

CMD:spec(playerid, params[])
{
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(PlayerInfo[playerid][Adminlevel] >= 2 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, ADMIN_FARBE, "[Error]: {FFFFFF}/Spec [Playername/id]");
			return 1;
		}
		new targetid = ReturnUser(tmp);
		if(targetid != INVALID_PLAYER_ID)
		{
			if(playerid == targetid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't spectate yourself.");
			if(GetPlayerState(targetid) == 0 || GetPlayerState(targetid) == 7 || GetPlayerState(targetid) == 9)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't spectate this player right now.");
			SendClientMessage(playerid, ADMIN_FARBE, "[Admin]: {FFFFFF}/Spec off to stop.");
		 	TogglePlayerSpectating(playerid, 1);
		 	StopAudioStreamForPlayer(playerid);
		 	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(targetid));
		 	SetPlayerInterior(playerid,GetPlayerInterior(targetid));
			if(IsPlayerInAnyVehicle(targetid)) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
			else PlayerSpectatePlayer(playerid, targetid);
		}
		else if(strcmp(tmp, "off", true) == 0)
		{
			TogglePlayerSpectating(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetPlayerInterior(playerid, 0);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Spec [Playername/id]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 2 admin.");
	return 1;
}

//Level 1 Commands
CMD:getip(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 1 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/GetIp [Playername/id]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(IsPlayerConnected(giveplayerid))
		{
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}%s's (%d) IP: %s", GetName(giveplayerid),giveplayerid,GetIP(giveplayerid));
			SendClientMessage(playerid,ADMIN_FARBE, stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/GetIp [Playername/id]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 1 admin.");
	return 1;
}

CMD:fix(playerid, params[])
{
 	if(PlayerInfo[playerid][Adminlevel] >= 1 || IsPlayerAdmin(playerid))
  	{
		if(JoinedRace[playerid] == 1) return SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You can't use this command right now.");
  		if(IsPlayerInAnyVehicle(playerid))
  		{
   			new Float:angle;
   			RepairVehicle(GetPlayerVehicleID(playerid));
			GetVehicleZAngle(GetPlayerVehicleID(playerid),angle);
			SetVehicleZAngle(GetPlayerVehicleID(playerid),angle);
			PlayerPlaySound(playerid,1133, 0.0, 0.0, 0.0);
			return 1;
		}
		else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be in a vehicle.");
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 1 admin.");
	return 1;
	}

CMD:acmds(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 1 || IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid, Error_FARBE, "Admin Commands:");
		SendClientMessage(playerid, WEISS, "Level 1+: /GetIP, /Fix, /Acmds");
		SendClientMessage(playerid, WEISS, "Level 2+: /Kick, /Spec, /Spec off, /Goto, /Tele, /Mute, /Unmute");
		SendClientMessage(playerid, WEISS, "Level 3+: /Gametext, /Akill, /Jail, /Unjail");
		SendClientMessage(playerid, WEISS, "Level 4+: /GMX, /StopGMX, /Ban, /Clear");
		SendClientMessage(playerid, WEISS, "Level 5+: /Level, /Ghost, /Createhouse");
		SendClientMessage(playerid, WEISS, "RCON Admin: /Banip, /Unbanip");
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 1 admin.");
	return 1;
}

CMD:goto(playerid, params[])
{
	new Float:pX,Float:pY,Float:pZ;
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(PlayerInfo[playerid][Adminlevel] >= 2 ||  IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Goto [Playername/id]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
	 		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	 		{
	 			GetPlayerPos(giveplayerid,pX,pY,pZ);
	 			SetVehiclePos(GetPlayerVehicleID(playerid),pX,pY,pZ+2);
			}
			else
			{
				GetPlayerPos(giveplayerid,pX,pY,pZ);
				SetPlayerPos(playerid,pX,pY,pZ+2);
		 	}
		 	SetPlayerInterior(playerid,GetPlayerInterior(giveplayerid));
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has been teleported to %s (%d).", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Goto [Playername/id]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 2 admin.");
	return 1;
}

CMD:tele(playerid, params[])
{
	new Float:pX,Float:pY,Float:pZ;
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
	if(PlayerInfo[playerid][Adminlevel] >= 2 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Tele [Playername/id]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
		 	if(GetPlayerState(giveplayerid) == PLAYER_STATE_DRIVER)
			{
				GetPlayerPos(playerid,pX,pY,pZ);
				SetVehiclePos(GetPlayerVehicleID(giveplayerid),pX,pY,pZ+2);
			}
			else
			{
				GetPlayerPos(playerid,pX,pY,pZ);
				SetPlayerPos(giveplayerid,pX,pY,pZ+2);
			}
			SetPlayerInterior(giveplayerid,GetPlayerInterior(playerid));
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has teleported %s (%d) to himself.", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Tele [Playername/id]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 2 admin.");
	return 1;
}

CMD:banip(playerid, params[])
{
	if(!JB_IsPlayerAdmin(playerid)) return  SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be rcon admin.");
	new idx;
	new tmp[128];

	tmp = strtok(params, idx);
    if(strlen(tmp))
    {
		new ip[4];
		ip=Split(tmp);
        if(ip[0])
        {
            if(BanIp(tmp))
			{
				format(jbstringa, sizeof(jbstringa), "[Admin]: {FFFFFF}Admin %s has banned the IP %s.",ReturnPlayerName(playerid),tmp);
				SendClientMessageToAll(ADMIN_FARBE, jbstringa);
				SaveIpBans();
				LoadIpBans();
			}
			else
			    SendClientMessage(playerid,Error_FARBE,"[Admin]: {FFFFFF}IP couldn't get banned.");
			return 1;
        }
    }
    SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}/BanIP [RangeIP] (Example: 123.45.*.*)");
	return 1;
}

CMD:unbanip(playerid, params[])
{
	if(!JB_IsPlayerAdmin(playerid)) return  SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be rcon admin.");
	new idx;
	new tmp[128];

	tmp = strtok(params, idx);
	if(strlen(tmp))
	{
		new ip[4];
		ip=Split(tmp);
   		if(ip[0])
		{
	        if(UnbanIp(tmp))
			{
				format(jbstringa, sizeof(jbstringa), "[Admin]: {FFFFFF}Admin %s has unbanned the IP %s.",ReturnPlayerName(playerid),tmp);
				SendClientMessageToAll(ADMIN_FARBE, jbstringa);
				SaveIpBans();
				LoadIpBans();
			}
			else
			SendClientMessage(playerid,Error_FARBE,"[Admin]: {FFFFFF}IP couldn't get unbanned.");
			return 1;
		}
	}
	SendClientMessage(playerid,Error_FARBE,"[Admin]: {FFFFFF}/UnbanIP [RangeIP] (Example: 123.45.*.*)");
	return 1;
}

CMD:jail(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 3)
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Jail [Playername/id] [Reason]");
			return 1;
		}
		new targetid = ReturnUser(tmp);
		if(targetid != INVALID_PLAYER_ID)
		{
			if(targetid == playerid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't jail yourself.");
    		if(JB_PlayerInfo[targetid][JB_pJailed]>0)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}This player is already in jail.");
			new reason[128];
			reason = bigstrtok(params, idx);
			if(!strlen(reason)) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Jail [Playername/id] [Reason]");
			JB_PlayerInfo[targetid][JB_pJailed]=180;
			SetPlayerInterior(targetid, 6);
			SetPlayerPos(targetid, 264.3700,77.5700,1001.0391);
			SetPlayerFacingAngle(targetid, 272.6900);
			SetCameraBehindPlayer(targetid);
			ResetPlayerMoney(targetid);
 			StopAudioStreamForPlayer(targetid);
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has jailed %s (%d). (Reason: %s)",GetName(playerid), playerid, GetName(targetid), targetid, reason);
			SendClientMessageToAll(ADMIN_FARBE,stringtu);
			return 1;
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Jail [Playername/id] [Reason]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 3 admin.");
	return 1;
}

CMD:unjail(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 3 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Unjail [Playername/id]");
			return 1;
		}
		new targetid = ReturnUser(tmp);
		if(targetid != INVALID_PLAYER_ID)
		{
			if(targetid == playerid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't remove yourself from the jail.");
    		if(JB_PlayerInfo[targetid][JB_pJailed]==0)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}This player is not in jail.");
			JB_PlayerInfo[targetid][JB_pJailed]=0;
    		SetPlayerInterior(targetid, 0);
			SpawnPlayer(targetid);
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has removed %s (%d) from the jail.",GetName(playerid), playerid, GetName(targetid), targetid);
			SendClientMessageToAll(ADMIN_FARBE,stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Unjail [Playername/id]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 3 admin.");
	return 1;
}

CMD:mute(playerid, params[])
{
	new reason[128];
	if(PlayerInfo[playerid][Adminlevel] >= 2 || IsPlayerAdmin(playerid))
	{
		new idx;
		new tmp[128];

		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Mute [Playername/id] [Reason]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if(giveplayerid == playerid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't mute yourself.");
			if(JB_PlayerInfo[giveplayerid][JB_pMuted]>0)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}This player is already muted.");
			reason = bigstrtok(params, idx);
			if(!strlen(reason)) return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Mute [Playername/id] [Reason]");
		 	JB_PlayerInfo[giveplayerid][JB_pMuted]=300;
		 	format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has muted %s (%d). (Reason: %s)", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid, reason);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Mute [Playername/id] [Reason]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 2 admin.");
	return 1;
}

CMD:unmute(playerid, params[])
{
	if(PlayerInfo[playerid][Adminlevel] >= 2 || IsPlayerAdmin(playerid))
	{

		new idx;
		new tmp[128];
		tmp = strtok(params, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Unmute [Playername/id]");
			return 1;
		}
		new giveplayerid = ReturnUser(tmp);
		if(giveplayerid != INVALID_PLAYER_ID)
		{
			if(giveplayerid == playerid)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You can't unmute yourself.");
    		if(JB_PlayerInfo[giveplayerid][JB_pMuted]==0)return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}This player is not muted.");
			JB_PlayerInfo[giveplayerid][JB_pMuted]=0;
			format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}Admin %s (%d) has unmuted %s (%d).", GetName(playerid), playerid, GetName(giveplayerid), giveplayerid);
			SendClientMessageToAll(ADMIN_FARBE, stringtu);
		}
		else
		{
			SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Unmute [Playername/id]");
		}
	}
	else SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You have to be at least level 2 admin.");
	return 1;
}

CMD:fallout(playerid, params[])
{
    new spot;
	if(JB_PlayerInfo[playerid][JB_pJailed])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are jailed and can't use any commands for the next %d seconds.",JB_PlayerInfo[playerid][JB_pJailed]);
	    return 1;
	}
    if( GetPlayerState( playerid ) == PLAYER_STATE_WASTED )return SendClientMessage( playerid, Error_FARBE, "[Error]: {FFFFFF}The fallout has already been started.");
	else if( Falloutr_{ playerid } != false )return SendClientMessage( playerid,Error_FARBE, "[Error]: {FFFFFF}You are already in the fallout.");
	else if( inProgress > 1 )	return SendClientMessage( playerid, Error_FARBE, "[Error]: {FFFFFF}The fallout has already been started.");
	else if( Iter_Count(_Falloutr ) > 54-1 )return SendClientMessage( playerid, Error_FARBE,"[Error]: {FFFFFF}The fallout is already full.");
    if( inProgress < 1 )
    {
		JoinedFallout[playerid] = 1;
		Iter_Add(_Falloutr, playerid );
		format( stringtu, sizeof( stringtu ), "[Fallout]: {FFFFFF}%s has joined the fallout. (/Fallout)", GetName(playerid));
		SendClientMessageToAll(FALLOUT_FARBE, stringtu);
		SendClientMessageToAll(FALLOUT_FARBE, "[Fallout]: {FFFFFF}The fallout starts in 30 seconds.");
		FalloutPlayers++;
	 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
		SetTimer( "FalloutCountdown", 30000, 0 );
		for( new i; i < 54; i++ )
		{
			Objects_[0][i] = CreateObject( 1649, gCoords[i][0], gCoords[i][1], gCoords[i][2], -90.000000, 0.000000, 0.000000, 150.0 );
			Iter_Add(_Objects, i );
		}
		inProgress = 1;
		VIEW_FROM_ABOVE = false;
		foreach(_Falloutr, i )
		{
     		GetPlayerPos( i, pCoords[i][0], pCoords[i][1], pCoords[i][2]);
     		pInterior[i] = GetPlayerInterior( i );
     		for( new a; a < 13; a++ )
			{
		      	GetPlayerWeaponData( i, a, pWeaponData[i][a], pSavedAmmo[i][a] );
  			}
			ResetPlayerWeapons( i );
			SetPlayerInterior( i, 0 );
			spot = Iter_Random(_Objects );
     		GameTextForPlayer( i, pReadyText[ random( sizeof( pReadyText ) ) ], 2050, 3 );
     		Iter_Remove(_Objects, spot );
     		SetPlayerCameraPos( i, -5298.4814,-218.4391,42.1386);
     		SetPlayerCameraLookAt( i, -5298.1616,-189.6903,23.6564);
     		TogglePlayerControllable( i, false );
			SetPlayerPos( i, gCoords[spot][0], gCoords[spot][1], gCoords[spot][2] +0.5 );
		}
 	}
    else
    {
    	Falloutr_{ playerid } = true;
 		Iter_Add(_Falloutr, playerid );
		format( stringtu, sizeof( stringtu ), "[Fallout]: {FFFFFF}%s has joined the fallout. (/Fallout)", GetName(playerid));
		SendClientMessageToAll(FALLOUT_FARBE, stringtu);
		FalloutPlayers++;
 	 	format(stringtu, sizeof(stringtu),DMLEISTENTEXT,onlineplayers, DMPlayers, RacePlayers, DerbyPlayers, FalloutPlayers);
		TextDrawSetString(leiste, stringtu);
 		foreach(_Falloutr, i )
		{
			GetPlayerPos( i, pCoords[i][0], pCoords[i][1], pCoords[i][2]);
     		pInterior[i] = GetPlayerInterior( i );
     		for( new a; a < 13; a++ )
			{
		      	GetPlayerWeaponData( i, a, pWeaponData[i][a], pSavedAmmo[i][a] );
  			}
			ResetPlayerWeapons( i );
			SetPlayerInterior( i, 0 );
			spot = Iter_Random(_Objects );
     		GameTextForPlayer( i, pReadyText[ random( sizeof( pReadyText ) ) ], 2050, 3 );
     		Iter_Remove(_Objects, spot );
     		SetPlayerCameraPos( i, -5298.4814,-218.4391,42.1386);
     		SetPlayerCameraLookAt( i, -5298.1616,-189.6903,23.6564);
     		TogglePlayerControllable( i, false );
			SetPlayerPos( i, gCoords[spot][0], gCoords[spot][1], gCoords[spot][2] +0.5 );
		}

	}
	return 1;
}

CMD:report(playerid, params[])
{
	new idx;
	new tmp[128];
	tmp = strtok(params, idx);
	if(!strlen(tmp))
	{
		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Report [Playername/id] [Reason]");
		return 1;
	}
	new targetid = ReturnUser(tmp);
	if(targetid != INVALID_PLAYER_ID)
	{
		new reason[128];
		reason = bigstrtok(params, idx);
		if(!strlen(reason)) return 		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Report [Playername/id] [Reason]");
		format(stringtu, sizeof(stringtu), "[Admin]: {FFFFFF}%s (%d) has reported %s (%d). (Reason: %s)", GetName(playerid), playerid, GetName(targetid), targetid,reason);
		SendClientMessageToAdmins(Error_FARBE, stringtu,1);
		format(stringtu, sizeof(stringtu), "[Report]: {FFFFFF}Your report about %s has been sent to the admins.", GetName(targetid));
		SendClientMessage(playerid, Error_FARBE, stringtu);
	}
	else
	{
		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}/Report [Playername/id] [Reason]");
	}
	return 1;
}

CMD:stats(playerid, params[])
{
	ShowStats(playerid);
	return 1;
}

CMD:createhouse(playerid,params[])
{
	#pragma unused params
	if(PlayerInfo[playerid][Adminlevel] >= 5 || IsPlayerAdmin(playerid))
	{
		ShowPlayerDialog(playerid,Haustypdialog,2,"{FF0000}XFS: {FFFFFF}Housetype","Simple appartment\nGood appartment\nUnique appartment\nSmall appartment\nSmall house\nVilla","Choose","Cancel");
		currHaus++;
		dini_IntSet("hauser.txt","currHaus",currHaus);
	}
	return 1;
}

CMD:buyhouse(playerid,params[])
{
	#pragma unused params
	if(IsPlayerInRangeOfPoint(playerid,5.0,Haus[pTestID[playerid]][TuerX],Haus[pTestID[playerid]][TuerY],Haus[pTestID[playerid]][TuerZ]))
	{
 		if(Haus[pTestID[playerid]][Verkauft] == 0)
 		{
 			if(GetPlayerMoney(playerid) > Haus[pTestID[playerid]][Hauskosten])
 			{
 				if(GetPlayerScore(playerid) > Haus[pTestID[playerid]][HausScore])
 				{
 				    if(PlayerInfo[playerid][pHausID] == -1)
 				    {
	 					GivePlayerMoney(playerid,-Haus[pTestID[playerid]][Hauskosten]);
						strmid(Haus[pTestID[playerid]][HausBesitzer],GetName(playerid),0,MAX_PLAYER_NAME,MAX_PLAYER_NAME);
						SendClientMessage(playerid, TIKKI_FARBE, "[House]: {FFFFFF}You successfully bought this house! Use /Enter to enter it.");
						PlayerInfo[playerid][pHausID] = Haus[pTestID[playerid]][HausID];
						Haus[pTestID[playerid]][Verkauft] = 1;
						Speichern();
						Laden();
					}
					else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You already got a house.");
				}
				else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You do not have enough score.");
			}
			else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You do not have enough money.");
		}
		else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}This house is already sold.");
	}
	else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}There is no house next to you.");
	return 1;
}

CMD:sellhouse(playerid,params[])
{
	#pragma unused params
 	if(PlayerInfo[playerid][pHausID] != -1)
 	{
		if(IsPlayerInRangeOfPoint(playerid,5.0,Haus[PlayerInfo[playerid][pHausID]][TuerX],Haus[PlayerInfo[playerid][pHausID]][TuerY],Haus[PlayerInfo[playerid][pHausID]][TuerZ]))
		{
			GivePlayerMoney(playerid,Haus[pTestID[playerid]][Hauskosten]/2);
			strmid(Haus[pTestID[playerid]][HausBesitzer]," ",0,6,MAX_PLAYER_NAME);
			SendClientMessage(playerid, TIKKI_FARBE, "[House]: {FFFFFF}You successfully sold your house.");
			PlayerInfo[playerid][pHausID] = -1;
			Haus[pTestID[playerid]][Verkauft] = 0;
			Speichern();
			Laden();
		}
		else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}There is no house next to you.");
	}
	else SendClientMessage(playerid,Error_FARBE,"[Error]: {FFFFFF}You do not own a house.");
	return 1;
}

CMD:enter(playerid,params[])
{
	#pragma unused params
 	if(PlayerInfo[playerid][pHausID] != -1)
    {
        if(IsPlayerInRangeOfPoint(playerid,5.0,Haus[PlayerInfo[playerid][pHausID]][TuerX],Haus[PlayerInfo[playerid][pHausID]][TuerY],Haus[PlayerInfo[playerid][pHausID]][TuerZ]))
        {
			SetPlayerPos(playerid,Haus[PlayerInfo[playerid][pHausID]][AusgangX],Haus[PlayerInfo[playerid][pHausID]][AusgangY],Haus[PlayerInfo[playerid][pHausID]][AusgangZ]);
			SetPlayerInterior(playerid,Haus[PlayerInfo[playerid][pHausID]][HausInterior]);
			SetPlayerVirtualWorld(playerid,Haus[PlayerInfo[playerid][pHausID]][HausVw]);
			for(new i;i<MAX_PLAYERS;i++)
			{
			    if(IsPlayerInRangeOfPoint(i,5.0,Haus[PlayerInfo[playerid][pHausID]][TuerX],Haus[PlayerInfo[playerid][pHausID]][TuerY],Haus[PlayerInfo[playerid][pHausID]][TuerZ]))
			    {
			        pTHausID[i] = PlayerInfo[playerid][pHausID];
			        SetPlayerPos(i,Haus[pTHausID[i]][AusgangX],Haus[pTHausID[i]][AusgangY],Haus[pTHausID[i]][AusgangZ]);
                    SetPlayerInterior(i,Haus[pTHausID[i]][HausInterior]);
                    SetPlayerVirtualWorld(i,Haus[pTHausID[i]][HausVw]);
                    SendClientMessage(playerid, TIKKI_FARBE, "[House]: {FFFFFF}Use /Exit to leave the house.");
                    ShowPlayerDialog(playerid,Hausmenudialog,2,"{FF0000}XFS: {FFFFFF}Housemenu","Health\nArmour\nSawn-off\nUzi\nM4\nSniper","Select","Cancel");
				}
			}
		}
	}
	return 1;
}

CMD:exit(playerid,params[])
{
	#pragma unused params
 	if(PlayerInfo[playerid][pHausID] != -1)
    {
		SetPlayerPos(playerid,Haus[pTHausID[playerid]][TuerX],Haus[pTHausID[playerid]][TuerY],Haus[pTHausID[playerid]][TuerZ]);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		pTHausID[playerid] = -1;
	}
	return 1;
}

CMD:sellcar(playerid, params[])
{
	if(PlayerInfo[playerid][Hausauto] > 0)
	{
		DestroyVehicle(hausauto[playerid]);
		PlayerInfo[playerid][Hausauto] = 0;
		PlayerInfo[playerid][Nos] = 0;
		PlayerInfo[playerid][Hydraulik] = 0;
		PlayerInfo[playerid][Stereo] = 0;
		PlayerInfo[playerid][Motorhaube] = 0;
		PlayerInfo[playerid][Lampen] = 0;
		PlayerInfo[playerid][SeitenschwellerR] = 0;
		PlayerInfo[playerid][SeitenschwellerL] = 0;
		PlayerInfo[playerid][EckLuftR] = 0;
		PlayerInfo[playerid][EckLuftL] = 0;
		PlayerInfo[playerid][OvalLuftR] = 0;
		PlayerInfo[playerid][OvalLuftL] = 0;
		PlayerInfo[playerid][Auspuff] = 0;
		PlayerInfo[playerid][Dach] = 0;
		PlayerInfo[playerid][Heckstossstange] = 0;
		PlayerInfo[playerid][Frontstossstange] = 0;
		PlayerInfo[playerid][Spoiler] = 0;
		PlayerInfo[playerid][Felgen] = 0;
		PlayerInfo[playerid][Paintjob] = -1;
		PlayerInfo[playerid][Farbe1] = -1;
		PlayerInfo[playerid][Farbe2] = -1;
		GivePlayerMoney(playerid, 60000);
		GameTextForPlayer(playerid, "~g~+60000$", 2000, 1);
		SendClientMessage(playerid, AUTO_FARBE, "[Vehicle]: {FFFFFF}You successfully sold your vehicle.");
	}
	else
	{
		SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You do not own a vehicle.");
	}
 	return 1;
}

CMD:auto(playerid, params[])
{
	if(PlayerInfo[playerid][Hausauto] > 0)
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, Error_FARBE, "[Error}: {FFFFFF}You are already in a vehicle.");
	   	new Float:ax, Float:ay, Float:az, Float:aa;
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Nos]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Hydraulik]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Felgen]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Motorhaube]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Spoiler]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Stereo]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Lampen]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Dach]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][SeitenschwellerR]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][SeitenschwellerL]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][OvalLuftR]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][OvalLuftL]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][EckLuftR]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][EckLuftL]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Auspuff]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Heckstossstange]);
	    AddVehicleComponent(hausauto[playerid], PlayerInfo[playerid][Frontstossstange]);
	    ChangeVehiclePaintjob(hausauto[playerid], PlayerInfo[playerid][Paintjob]);
	    ChangeVehicleColor(hausauto[playerid], PlayerInfo[playerid][Farbe1], PlayerInfo[playerid][Farbe2]);
	    LinkVehicleToInterior(hausauto[playerid], GetPlayerInterior(playerid));
	    SetVehicleVirtualWorld(hausauto[playerid], GetPlayerVirtualWorld(playerid));
	   	GetPlayerPos(playerid, ax, ay, az);
	   	SetVehiclePos(hausauto[playerid], ax, ay, az);
		GetPlayerFacingAngle(playerid, aa);
		SetVehicleZAngle(hausauto[playerid], aa);
		PutPlayerInVehicle(playerid, hausauto[playerid], 0);
		SetCameraBehindPlayer(playerid);
		return 1;
	}
	else return SendClientMessage(playerid, Error_FARBE, "[Error]: {FFFFFF}You do not own a car.");
}


/*========================================== SCRIPT ENDE ==========================================*/
#else
#error "Du hast ''Owner'' nicht definiert! Siehe Zeile 105!"
#endif
