#if defined _JB_included
	#endinput
#endif
#define _JB_included

#include <a_samp>
#include <dini>

#define CONFIG_FILE "Anticheat/Anticheat.cfg"
#define BAD_WORDS_FILE "Anticheat/BadWords.cfg"
#define FORBIDDEN_WEAPONS_FILE "Anticheat/ForbiddenWeapons.cfg"
#define BLACKLIST_FILE "Anticheat/Blacklist.txt"
#define WHITELIST_FILE "Anticheat/Whitelist.txt"
#define IP_BAN_FILE "Anticheat/IpBans.txt"
#define BAD_RCON_LOGIN_FILE "Anticheat/BadRconLogin.txt"

#define MAX_JB_VARIABLES 25
#define MAX_BAD_WORDS 50
#define MAX_FORBIDDEN_WEAPONS 10
#define MAX_PING_CHECKS 3
#define MAX_WEAPONS 47
#define MAX_CHECKS 3

#define WEAPON_HACK 0
#define MONEY_HACK 1
#define JETPACK 2
#define HEALTH_HACK 3
#define ARMOUR_HACK 4
#define DRIVE_BY 5
#define SPAM 6
#define COMMAND_SPAM 7
#define BAD_WORDS 8
#define CAR_JACK_HACK 9
#define TELEPORT_HACK 10
#define MAX_PING 11
#define SPECTATE_HACK 12
#define BLACKLIST 13
#define IP_BANS 14
#define SPAWNKILL 15
#define CAPS_LOCK 16
#define SPEED_3D 17
#define MAX_SPEED 18
#define ADMIN_IMMUNITY 19
#define ADVERTISEMENT 20
#define FREEZE_UPDATE 21
#define SPAWN_TIME 22
#define AIRBREAK 23
#define TANK_MODE 24

#define cc 0x00D799FF
#define rr 0xFB0000FF
#define ww 0xFFFFFFFF
#define ADMIN_FARBE 0xFFFF00FF
#pragma tabsize 0

#define DIALOG_CFG 28354
#define DIALOG_VARLIST 28355
#define DIALOG_SETVAR 28356

new FALSE=false;
new TRUE=true;
#pragma unused TRUE

#define SendFormattedMessage(%0,%1,%2,%3) do{new _string[128]; format(_string,sizeof(_string),%2,%3); SendClientMessage(%0,%1,_string);} while(FALSE)
#define SendFormattedMessageToAll(%0,%1,%2) do{new _string[128]; format(_string,sizeof(_string),%1,%2); SendClientMessageToAll(%0,_string);} while(FALSE)
#define SendLanguageMessageEx(%0,%1,%2,%3,%4) do { new msg_de[128],msg_en[128]; format(msg_de,sizeof(msg_de),%2,%4); format(msg_en,sizeof(msg_en),%3,%4); SendLanguageMessage(%0,%1,msg_de,msg_en); } while(FALSE)
#define SendLanguageMessageToAllEx(%0,%1,%2,%3) do { new msg_de[128],msg_en[128]; format(msg_de,sizeof(msg_de),%1,%3); format(msg_en,sizeof(msg_en),%2,%3); SendLanguageMessageToAll(%0,msg_de,msg_en); } while(FALSE)
#define GetVehicleName(%0) VehicleName[GetVehicleModel(%0)-400]
#define JB_Speed(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1))*%3*1.6)

#define SendRaceMessageToAllEx(%0,%1,%2,%3) do { new msg_de[128],msg_en[128]; format(msg_de,sizeof(msg_de),%1,%3); format(msg_en,sizeof(msg_en),%2,%3); SendRaceMessageToAll(%0,msg_de,msg_en); } while(FALSE)

new JB_Warnings[MAX_PLAYERS][MAX_JB_VARIABLES];
new JB_Variables[MAX_JB_VARIABLES]=
{
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	false,
	false,
	true,
	500,
	false,
	true,
	true,
	3,
	false,
	false,
	400,
	false,
	true,
	true,
	5,
	true,
	true
};

new JB_VariableNames[MAX_JB_VARIABLES][32]=
{
	"WaffenHack",
	"MoneyHack",
	"JetpackHack",
	"LebensHack",
	"RuestungsHack",
	"DriveBy",
	"Spam",
	"CommandSpam",
	"BadWords",
	"CarJackHack",
	"TeleportHack",
	"MaxPing",
	"SpecHack",
	"Blacklist",
	"IpBans",
	"SpawnKill",
	"CapsLock",
	"3DSpeed",
	"MaxSpeed",
	"AdminImmunitaet",
	"Werbung",
	"UnfreezeHack",
	"SpawnZeit",
	"Airbreak",
	"Cargodmode"
};

new JB_VarDescription[MAX_JB_VARIABLES][512]=
{
	"Anti Waffenhack\n0 = Aus 1 = An.",
	"Anti Moneyhack\n0 = Aus 1 = An.",
	"Anti Jetpackhack\n0 = Aus 1 = An.",
	"Anti Lebenhack\n0 = Aus 1 = An.",
	"Anti Ruestunghack\n0 = Aus 1 = An.",
	"Anti Drive-By\n0 = Aus 1 = An.",
	"Anti Spam\n0 = Aus 1 = An.",
	"Anti Command Spam\n0 = Aus 1 = An.",
	"Anti Beleidigung\n0 = Aus 1 = An.",
	"Anti Carjackhack\n0 = Aus 1 = An.",
	"Anti Teleporthack\n0 = Aus 1 = An.",
	"Anti Highping\n0 = Aus",
	"Anti Spechack\n0 = Aus 1 = An.",
	"Blacklist\n0 = Aus 1 = An.",
	"IPBan\n0 = Aus 1 = An.",
	"Anti Spawnkill\n0 = Aus.",
	"Anti Capslock\n0 = Aus 1 = An.",
	"3D Speed\n0 = Aus 1 = An.",
	"Anti Speedhack\n0 = Aus.",
	"Admin Immunitaet\n0 = Aus 1 = An.",
	"Anti Werbung\n0 = Aus 1 = An.",
	"Anti Unfreeze\n0 = Aus 1 = An.",
	"Spawnkill Zeit",
	"Anti Airbreak\n0 = Aus 1 = An.",
	"Anti Cargodmode\n0 = Aus 1 = An."
};

enum JB_pInfo
{
	JB_pMoney,
	JB_pLastMessage[128],
	JB_pMessageRepeated,
	JB_pMessages,
	JB_pCommands,
	JB_pMuted,
	JB_pJailed,
	JB_pFreezed,
	JB_pPing[MAX_PING_CHECKS],
	JB_pPingCheckProgress,
	JB_pVehicleEntered,
	JB_pSpawnKillProtected,
	JB_pSpeedhacking,
	JB_pAirbreaking,
	JB_pLastCheck,
	Float:JB_pSetPos[3]
}
new JB_PlayerInfo[MAX_PLAYERS][JB_pInfo];

new WeaponForbiddenForPlayer[MAX_PLAYERS][MAX_WEAPONS];
new KickBan[MAX_PLAYERS];
new FullyConnected[MAX_PLAYERS];

new Float:CurrentPos[MAX_PLAYERS][3];
new NoTeleportCheck[MAX_PLAYERS];

new BadWords[MAX_BAD_WORDS][32];
new BadWordsCount;
new ForbiddenWeapons[MAX_FORBIDDEN_WEAPONS];
new ForbiddenWeaponsCount;

new Blacklist[100][MAX_PLAYER_NAME];
new Whitelist[100][MAX_PLAYER_NAME];
new IpBans[50][4];
new IpBanned[50];
new jbstringa[200];

new Planes[]=
{
    592,577,511,512,593,520,553,476,519,460,513,548,425,417,487,488,497,563,447,469
};

new VehicleName[][] =
{
"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
"Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
"Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
"Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach",
"Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
"Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
"RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
"Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
"Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Maverick", "Rancher",
"FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring Racer", "Sandking", "Blista Compact", "Police Maverick",
"Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer", "Hotring Racer", "Bloodring Banger", "Rancher",
"Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
"Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Towtruck",
"Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine Harvester", "Feltzer", "Remington", "Slamvan",
"Blade", "Freight", "Brownstreak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck LA", "Hustler", "Intruder",
"Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility Van", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B",
"Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
"Freight Flat Trailer", "Streak Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
"Huntley", "Stafford", "BF-400", "News Van", "Tug", "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
"Freight Box Trailer", "Article Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)", "Police Car (LVPD)",
"Police Ranger", "Picador", "S.W.A.T.", "Alpha", "Phoenix", "Glendale", "Sadler", "Baggage Trailer A", "Baggage Trailer B", "Tug Stairs Trailer",
"Boxville", "Farm Trailer", "Utility Trailer"
};

new Float:CheatPositions[][3]=
{
	{403.58, 2486.33, 17.23},
	{1578.24, 1245.20, 11.57},
	{1641.14, -1526.87, 14.30},
	{1836.93, -1856.28, 14.13},
	{2645.61, -2029.15, 14.28},
	{-1787.25, 1202.00, 25.84},
	{1041.26, -1036.77, 32.48},
	{2387.55, 1035.70, 11.56},
	{-1935.77, 228.79, 34.16},
	{2006.11, 2292.87, 11.57},
	{-2707.48, 218.65, 4.93},
	{720.10, -470.93, 17.07},
	{-1420.21, 2599.45, 56.43},
	{-100.16, 1100.79, 20.34},
	{2078.44, -1831.44, 14.13},
	{-2426.89, 1036.61, 51.14},
	{1957.96, 2161.96, 11.56},
	{488.29, -1724.85, 12.01},
	{1025.08, -1037.28, 32.28},
	{2393.70, 1472.80, 11.42},
	{-1904.97, 268.51, 41.04},
	{-1617.58, 688.69, -4.50},
	{-2105.79, 905.11, 77.07},
	{423.69, 2545.99, 17.07},
	{785.79, -513.12, 17.44},
	{-2027.34, 141.02, 29.57},
	{1698.10, -2095.88, 14.29},
	{-361.10, 1185.23, 20.49},
	{-2463.27, -124.86, 26.41},
	{2505.64, -1683.72, 14.25},
	{1350.76, -615.56, 109.88},
	{2231.64, 156.93, 27.63},
	{-2695.51, 810.70, 50.57},
	{1293.61, 2529.54, 11.42},
	{1401.34, 1903.08, 11.99},
	{2436.50, 698.43, 11.60},
	{322.65, -1780.30, 5.55},
	{917.46, 2012.14, 11.65}
};

enum JB_SAZONE_MAIN {
		JB_SAZONE_NAME[28],
		Float:JB_SAZONE_AREA[6]
};

static const JB_gSAZones[][JB_SAZONE_MAIN] = {
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",              	{787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Men's Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",          	{1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",         	{1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

forward JunkBuster();
forward ConfigJunkBuster();
forward SaveJunkBusterVars();
forward LoadBadWords();
forward LoadForbiddenWeapons();
forward JB_Kick(playerid,reason[]);
forward JB_Ban(playerid,reason[]);
forward JB_GivePlayerMoney(playerid,amount);
forward JB_GetPlayerMoney(playerid);
forward JB_SetPlayerMoney(playerid,amount);
forward JB_ResetPlayerMoney(playerid);
forward JB_SetVehicleHealth(vehicleid,Float:health);
forward JB_PutPlayerInVehicle(playerid,vehicleid,seatid);
forward JB_GivePlayerWeapon(playerid,weaponid,ammo);
forward JB_SetPlayerPos(playerid,Float:x,Float:y,Float:z);
forward JB_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z);
forward JB_SetPlayerHealth(playerid,Float:health);
forward JB_SetPlayerArmour(playerid,Float:armour);
forward JB_TogglePlayerControllable(playerid,toggle);
forward JB_SetVehicleVelocity(vehicleid,Float:x,Float:y,Float:z);
forward JB_SetPlayerSpecialAction(playerid,actionid);
forward MutePlayer(playerid,time,reason[]);
forward JailPlayer(playerid,time,reason[]);
forward LoadBlacklist();
forward UpdateBlacklist();
forward AddNameToBlacklist(name[]);
forward RemoveNameFromBlacklist(name[]);
forward AddPlayerToBlacklist(playerid);
forward LoadWhitelist();
forward UpdateWhitelist();
forward AddNameToWhitelist(name[]);
forward RemoveNameFromWhitelist(name[]);
forward AddPlayerToWhitelist(playerid);
forward LoadIpBans();
forward SaveIpBans();
forward BanIp(ip_string[]);
forward UnbanIp(ip_string[]);
forward SetPlayerSpawnKillProtected(playerid,set);
forward GlobalUpdate();
forward SpamUpdate();
forward Banlist(string[]);
forward IsPlayerAdminCall(playerid);
forward IsPlayerPremiumCall(playerid);
forward IsPlayerAdminReport(playerid);
forward PnP_OnPlayerStateChange(playerid, newstate, oldstate);
forward PnP_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward PnP_OnPlayerCommandText(playerid, cmdtext[], success);
forward PnP_OnPlayerText(playerid, text[]);
forward PnP_OnPlayerConnect(playerid);
forward PnP_OnPlayerDisconnect(playerid,reason);
forward PnP_OnGameModeInit();
forward PnP_OnGameModeExit();
forward PnP_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid);
forward PnP_OnPlayerDeath(playerid,killerid,reason);
forward PnP_OnPlayerSpawn(playerid);
forward PnP_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
forward PnP_OnRconLoginAttempt( ip[], password[], success );

public JB_SetVehicleVelocity(vehicleid,Float:x,Float:y,Float:z)
{
	if(vehicleid!=INVALID_VEHICLE_ID)
	{
	    new tspeed=JB_Speed(x,y,z,110.0,JB_Variables[SPEED_3D]);
		if(JB_Variables[MAX_SPEED] && tspeed>JB_Variables[MAX_SPEED])
		{
		    return 0;
		}
		return SetVehicleVelocity(vehicleid,x,y,z);
	}
	return 0;
}

public JB_SetVehicleHealth(vehicleid,Float:health)
{
	new Float:tmp_health=health;
	if(tmp_health<0.0)
	    tmp_health=0.0;
	else if(tmp_health>1000.0 && JB_Variables[TANK_MODE])
	    tmp_health=1000.0;
	return SetVehicleHealth(vehicleid,tmp_health);
}

public JB_SetPlayerSpecialAction(playerid,actionid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(actionid==SPECIAL_ACTION_USEJETPACK && JB_Variables[JETPACK] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	    {
	        return 0;
	    }
	    return SetPlayerSpecialAction(playerid,actionid);
	}
	return 0;
}

public JB_PutPlayerInVehicle(playerid,vehicleid,seatid)
{
	if(IsPlayerConnected(playerid) && vehicleid!=INVALID_VEHICLE_ID)
	{
	    if(PutPlayerInVehicle(playerid,vehicleid,seatid))
	    {
	        NoTeleportCheck[playerid]=3;
	    	JB_PlayerInfo[playerid][JB_pVehicleEntered]=vehicleid;
  			return 1;
		}
	}
	return 0;
}

public JB_GivePlayerMoney(playerid,amount)
{
	if(IsPlayerConnected(playerid))
	{
	    GivePlayerMoney(playerid,amount);
	    JB_PlayerInfo[playerid][JB_pMoney]+=amount;
	    return 1;
	}
	return 0;
}

public JB_ResetPlayerMoney(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    ResetPlayerMoney(playerid);
	    JB_PlayerInfo[playerid][JB_pMoney]=0;
	    return 1;
	}
	return 0;
}

public JB_GetPlayerMoney(playerid)
{
	new amount;
	if(IsPlayerConnected(playerid))
	{
	    if(!JB_Variables[MONEY_HACK] || GetPlayerMoney(playerid)<JB_PlayerInfo[playerid][JB_pMoney])
	        amount=GetPlayerMoney(playerid);
		else
		    amount=JB_PlayerInfo[playerid][JB_pMoney];
	}
	return amount;
}

public JB_SetPlayerMoney(playerid,amount)
{
	if(IsPlayerConnected(playerid))
	{
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid,amount);
	    JB_PlayerInfo[playerid][JB_pMoney]=amount;
	    return 1;
	}
	return 0;
}

public JB_SetPlayerPos(playerid,Float:x,Float:y,Float:z)
{
	if(IsPlayerConnected(playerid))
	{
	    if(SetPlayerPos(playerid,x,y,z))
	    {
	        CurrentPos[playerid][0]=x;
	        CurrentPos[playerid][1]=y;
	        CurrentPos[playerid][2]=z;
	        NoTeleportCheck[playerid]=3;
	        return 1;
	    }
	}
	return 0;
}

public JB_SetVehiclePos(vehicleid,Float:x,Float:y,Float:z)
{
	if(vehicleid!=INVALID_VEHICLE_ID)
	{
	    if(SetVehiclePos(vehicleid,x,y,z))
	    {
			for(new i=0;i<MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i) && GetPlayerVehicleID(i)==vehicleid)
			    {
			        CurrentPos[i][0]=x;
			        CurrentPos[i][1]=y;
			        CurrentPos[i][2]=z;
			        NoTeleportCheck[i]=4;
			    }
			}
			return 1;
		}
	}
	return 0;
}

public JB_GivePlayerWeapon(playerid,weaponid,ammo)
{
	if(!IsForbiddenWeapon(weaponid) || (IsForbiddenWeapon(weaponid) && !WeaponForbiddenForPlayer[playerid][weaponid]) || (JB_IsPlayerAdmin(playerid) && JB_Variables[ADMIN_IMMUNITY]))
	{
	    GivePlayerWeapon(playerid,weaponid,ammo);
	    return 1;
	}
	new weapon[32];
	GetWeaponName(weaponid,weapon,sizeof(weapon));
	return 0;
}

public JB_SetPlayerHealth(playerid,Float:health)
{
	new Float:tmp_health=health;
	if(tmp_health<0)
	    tmp_health=0;
	else if(tmp_health>100 && JB_Variables[HEALTH_HACK])
	    tmp_health=100;
	return SetPlayerHealth(playerid,tmp_health);
}

public JB_SetPlayerArmour(playerid,Float:armour)
{
	new Float:tmp_armour=armour;
	if(tmp_armour<0)
	    tmp_armour=0;
	else if(tmp_armour>100 && JB_Variables[ARMOUR_HACK])
	    tmp_armour=100;
	return SetPlayerArmour(playerid,tmp_armour);
}

public JB_TogglePlayerControllable(playerid,toggle)
{
 	if(toggle)
	    JB_PlayerInfo[playerid][JB_pFreezed]=false;
	else
	    JB_PlayerInfo[playerid][JB_pFreezed]=true;
	return TogglePlayerControllable(playerid,toggle);
}

public SetPlayerSpawnKillProtected(playerid,set)
{
	if(IsPlayerConnected(playerid))
	{
	    if(set)
	    	JB_PlayerInfo[playerid][JB_pSpawnKillProtected]=JB_Variables[SPAWN_TIME];
		else
            JB_PlayerInfo[playerid][JB_pSpawnKillProtected]=0;
	    return 1;
	}
	return 0;
}

public MutePlayer(playerid,time,reason[])
{
	if(IsPlayerConnected(playerid) && time)
	{
	    JB_PlayerInfo[playerid][JB_pMuted]=time;
	    SendFormattedMessageToAll(ADMIN_FARBE,"[Admin]: {FFFFFF}The server has muted %s (%d). (Reason: %s)",ReturnPlayerName(playerid),playerid,reason);
	    return 1;
	}
	return 0;
}

public JailPlayer(playerid,time,reason[])
{
	if(IsPlayerConnected(playerid) && time)
	{
	    JB_PlayerInfo[playerid][JB_pJailed]=time;
	    SendFormattedMessageToAll(ADMIN_FARBE,"[Admin]: {FFFFFF}The server has jailed %s (%d). (Reason: %s)",ReturnPlayerName(playerid),playerid,reason);
	    return 1;
	}
	return 0;
}

public JB_Kick(playerid,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	TogglePlayerControllable(playerid,false);
	SendFormattedMessageToAll(ADMIN_FARBE,"[Admin]: {FFFFFF}The server has kicked %s (%d). (Reason: %s)",ReturnPlayerName(playerid),playerid,reason);
	new stringjb[126];
	for(new chat = 0; chat <= 100; chat++) SendClientMessage(playerid,ww, " ");
	SendClientMessage(playerid,rr,"You have been kicked!");
	format(stringjb, sizeof(stringjb), "Name: %s", GetName(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "IP: %s", GetIP(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "Time: %s | %s", ReturnDate(),ReturnTime());
	SendClientMessage(playerid,ww, stringjb);
	SendClientMessage(playerid,ww, "Admin: Server");
	format(stringjb, sizeof(stringjb), "Reason: %s", reason);
	SendClientMessage(playerid,ww, stringjb);
	SendClientMessage(playerid,ww, "Take a screenshot and complain at: www.Eagles-Clan.com");
	format(stringjb, sizeof(stringjb), "[KICK] The server has kicked %s (%s). (Reason: %s)", GetName(playerid), ReturnPlayerIp(playerid), reason);
	Banlist(stringjb);
	Kick(playerid);
	return 1;
	}
	return 0;
}

public JB_Ban(playerid,reason[])
{
	if(IsPlayerConnected(playerid))
	{
	TogglePlayerControllable(playerid,false);
	SendFormattedMessageToAll(ADMIN_FARBE,"[Admin]: {FFFFFF}The server has banned %s (%d). (Reason: %s)",ReturnPlayerName(playerid),playerid,reason);
	new stringjb[126];
	for(new chat = 0; chat <= 100; chat++) SendClientMessage(playerid,ww, " ");
	SendClientMessage(playerid,rr,"You have been banned!");
	format(stringjb, sizeof(stringjb), "Name: %s", GetName(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "IP: %s", GetIP(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "Time: %s | %s", ReturnDate(),ReturnTime());
	SendClientMessage(playerid,ww, stringjb);
	SendClientMessage(playerid,ww, "Admin: Server");
	format(stringjb, sizeof(stringjb), "Reason: %s", reason);
	SendClientMessage(playerid,ww, stringjb);
        SendClientMessage(playerid,ww, "Take a screenshot and complain at: www.Eagles-Clan.com");
	format(stringjb, sizeof(stringjb), "[BAN] The server has banned %s (%s). (Reason: %s)", GetName(playerid), ReturnPlayerIp(playerid), reason);
	Banlist(stringjb);
	BanEx(playerid,reason);
	return 1;
	}
	return 0;
}

stock IsCheatPosition(Float:x,Float:y,Float:z)
{
	for(new i=0;i<sizeof(CheatPositions);i++)
	    if(JB_GetSquareDistance(x,y,z,CheatPositions[i][0],CheatPositions[i][1],CheatPositions[i][2])<1.5)
	        return true;
	return false;
}

stock IsPlayerInPlane(playerid)
{
	new m=GetVehicleModel(GetPlayerVehicleID(playerid));
	for(new i=0;i<sizeof(Planes);i++)
	    if(m==Planes[i])
	        return true;
	return false;
}

stock IsPlayerInValidState(playerid)
{
	new pstate=GetPlayerState(playerid);
    if(pstate>0 && pstate<=6)
		return true;
	return false;
}

stock AdvertisementCheck(string[])
{
	if(JB_Variables[ADVERTISEMENT] && string[0])
	{
		if(!strfind(string,"www.",false) || !strfind(string,"http://",false) || !strfind(string,".com",false) || !strfind(string,".net",false)
			|| !strfind(string,".de",false) || !strfind(string,".org",false))
		    return true;
		new c=1,idx,tmp[64],ip[4];
		for(new i=0;i<strlen(string);i++)
		    if(string[i]==' ')
		        c++;
		for(new i=0;i<c;i++)
		{
		    idx=0;
		    tmp=JB_strtok(string,idx);
		    idx=0;
		    tmp=JB_strtok(tmp,idx,':');
			ip=Split(tmp);
			if(ip[0] && ip[1] && ip[2] && ip[3])
			    return true;
		}
	}
	return false;
}

stock BadWordsCheck(text[])
{
	new c,string[128];
	for(new i=0;i<strlen(text);i++)
	{
	    if((text[i]>='a' && text[i]<='z') || (text[i]>='A' && text[i]<='Z'))
		{
		    if(!c || (c && string[c-1]!=text[i]))
		    {
				string[c]=text[i];
				c++;
			}
		}
		if(c>=sizeof(string))
			break;
	}

	for(new i=0;i<BadWordsCount;i++)
	    if(strfind(string,BadWords[i],true)!=-1)
	        return true;
	return false;
}

stock CapsLockCheck(text[])
{
	new len=strlen(text);
	if(len>3)
	{
	    new c;
	    for(new i=0;i<len;i++)
	        if(text[i]>='A' && text[i]<='Z')
	c++;
		if(c)
			if(c>=len/4*3)
		    	return true;
	}
	return false;
}

stock IsForbiddenWeapon(weaponid)
{
	if(weaponid && JB_Variables[WEAPON_HACK])
	{
	    for(new i=0;i<ForbiddenWeaponsCount;i++)
	        if(ForbiddenWeapons[i]==weaponid)
	            return true;
	}
	return false;
}

stock ForbidWeaponForPlayer(playerid,weaponid,forbid)
{
	if(IsPlayerConnected(playerid))
	{
	    WeaponForbiddenForPlayer[playerid][weaponid]=forbid;
		return 1;
	}
	return 0;
}

stock ResetForbiddenWeaponsForPlayer(playerid)
{
	if(IsPlayerConnected(playerid))
	{
    	for(new i=0;i<MAX_WEAPONS;i++)
			ForbidWeaponForPlayer(playerid,i,false);

		for(new i=0;i<MAX_FORBIDDEN_WEAPONS;i++)
			ForbidWeaponForPlayer(playerid,ForbiddenWeapons[i],true);
		return 1;
	}
	return 0;
}

stock JunkBusterReport(playerid,report[],details[])
{
	if(IsPlayerConnected(playerid))
	{
		new string[150];
		format(string,sizeof(string),"[Anticheat]: {FFFFFF}Report for %s: %s (%d), %s.",report,ReturnPlayerName(playerid),playerid,details);
		for(new i=0;i<MAX_PLAYERS;i++)
		    if(IsPlayerConnected(i))
			    if(JB_IsPlayerAdminReport(i))
			        SendClientMessage(i,rr,string);

		return 1;
	}
	return 0;
}

stock JB_IsPlayerAdmin(playerid)
	return (IsPlayerAdmin(playerid) || CallRemoteFunction("IsPlayerAdminCall","i",playerid));

stock JB_IsPlayerPremium(playerid)
	return (IsPlayerAdmin(playerid) || CallRemoteFunction("IsPlayerPremiumCall","i",playerid));

stock JB_IsPlayerAdminReport(playerid)
	return (IsPlayerAdmin(playerid) || CallRemoteFunction("IsPlayerAdminReport","i",playerid));

public GlobalUpdate()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
		if(!IsPlayerNPC(i))
	{
	        if(JB_Warnings[i][TELEPORT_HACK])
	            JB_Warnings[i][TELEPORT_HACK]--;

			if(JB_Warnings[i][MAX_SPEED])
			    JB_Warnings[i][MAX_SPEED]--;

			if(JB_Warnings[i][AIRBREAK])
			    JB_Warnings[i][AIRBREAK]--;
	    }
	}
	}
	return 1;
}

public SpamUpdate()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
		if(!IsPlayerNPC(i))
	{
			if(JB_PlayerInfo[i][JB_pMessages])
				JB_PlayerInfo[i][JB_pMessages]--;

            if(JB_PlayerInfo[i][JB_pCommands])
			    JB_PlayerInfo[i][JB_pCommands]--;
		}
	}
}
	return 1;
}

public JunkBuster()
{
	new Float:health,Float:armour,var,reason[64],stringjb[126];
	new Float:x, Float:y, Float:z;
	new pstate,vehicleid;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(!IsPlayerNPC(i) && FullyConnected[i] && GetPlayerPos(i,x,y,z))
	    {
		pstate=GetPlayerState(i);
	        vehicleid=GetPlayerVehicleID(i);
	        if(JB_PlayerInfo[i][JB_pMuted])
	            JB_PlayerInfo[i][JB_pMuted]--;
		if(JB_PlayerInfo[i][JB_pMuted] == 1)
		{
		format(stringjb, sizeof(stringjb), "[Admin]: {FFFFFF}The server has unmuted %s (%d).", GetName(i), i);
		SendClientMessageToAll(ADMIN_FARBE, stringjb);
		}

 		if(JB_PlayerInfo[i][JB_pJailed])
	            	JB_PlayerInfo[i][JB_pJailed]--;
		if(JB_PlayerInfo[i][JB_pJailed] == 1)
		{
		format(stringjb, sizeof(stringjb), "[Admin]: {FFFFFF}The server has removed %s (%d) from the jail.", GetName(i), i);
		SendClientMessageToAll(ADMIN_FARBE, stringjb);
		SpawnPlayer(i);
		SetPlayerInterior(i, 0);
		}

			if(JB_PlayerInfo[i][JB_pSpawnKillProtected])
			    JB_PlayerInfo[i][JB_pSpawnKillProtected]--;

			if(JB_Variables[MONEY_HACK])
			    if(GetPlayerMoney(i)>JB_PlayerInfo[i][JB_pMoney])
			        JB_SetPlayerMoney(i,JB_PlayerInfo[i][JB_pMoney]);

            if(JB_PlayerInfo[i][JB_pSpeedhacking]>=3)
			{
			    TogglePlayerControllable(i,true);
			    JB_PlayerInfo[i][JB_pSpeedhacking]=0;
			}
			
			if(JB_PlayerInfo[i][JB_pAirbreaking]>=MAX_CHECKS)
                JB_PlayerInfo[i][JB_pAirbreaking]=0;

			if(JB_PlayerInfo[i][JB_pFreezed] && JB_Variables[FREEZE_UPDATE])
			    TogglePlayerControllable(i,false);
			
			if(IsPlayerInValidState(i) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
				if(JB_Variables[TANK_MODE] && pstate==PLAYER_STATE_DRIVER)
				{
				    GetVehicleHealth(vehicleid,health);
				    if(health>1000.0)
				    {
				        SetVehicleToRespawn(vehicleid);
				        JB_Ban(i,"Car Godmode");
				        continue;
				    }
				}
				}

			if(IsPlayerInValidState(i) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
			    if(!NoTeleportCheck[i])
			    {
			        if(JB_Variables[TELEPORT_HACK] && z<900 && CurrentPos[i][2]<900)
			        {
						if(JB_GetSquareDistance(x,y,z,CurrentPos[i][0],CurrentPos[i][1],CurrentPos[i][2])>(500*500) && GetPlayerState(i)!=PLAYER_STATE_PASSENGER && GetPlayerSurfingVehicleID(i)==INVALID_VEHICLE_ID)
						{
						    JB_Warnings[i][TELEPORT_HACK]++;
					        if(JB_Warnings[i][TELEPORT_HACK]>=3)
					        {
								JB_Kick(i,"Teleporthack");
								continue;
							}
							else if(JB_Variables[TELEPORT_HACK] && IsCheatPosition(x,y,z) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
							{
							    JB_Ban(i,"Teleporthack");
								continue;
							}
							else
							{
							    JB_GetPlayer2DZone(i,reason,sizeof(reason));
							    JunkBusterReport(i,"Teleporthack",reason);
							}
						}
					}

					if(JB_Variables[AIRBREAK] && (pstate==PLAYER_STATE_ONFOOT || (pstate==PLAYER_STATE_DRIVER && JB_GetPlayerSpeed(i,true)<10)) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
					{
					    var=(floatround(floatsqroot(JB_GetSquareDistance(x,y,z,CurrentPos[i][0],CurrentPos[i][1],CurrentPos[i][2]))*3600)/(GetTickCount()-JB_PlayerInfo[i][JB_pLastCheck]));
						if(var>=500 && var<=1500)
                        {
                            JB_PlayerInfo[i][JB_pAirbreaking]++;
						    if(JB_PlayerInfo[i][JB_pAirbreaking]==MAX_CHECKS)
							{
							    JB_Warnings[i][AIRBREAK]++;
							    if(JB_Warnings[i][AIRBREAK]<MAX_CHECKS)
							    {
								    format(reason,sizeof(reason),"Height: %.2f, %d KM/H with a(n) %s",z,var,GetVehicleName(vehicleid));
								    JunkBusterReport(i,"Airbreak",reason);
							    }
							    else
							    {
							        JB_Ban(i,"Airbreak");
							        continue;
							    }
							}
                        }
						else
						    JB_PlayerInfo[i][JB_pAirbreaking]=0;
					}

					if(GetPlayerState(i)==PLAYER_STATE_DRIVER && JB_Variables[MAX_SPEED] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
					{
					    var=JB_GetPlayerSpeed(i,JB_Variables[SPEED_3D]);
						if(var>JB_Variables[MAX_SPEED] && !IsPlayerInPlane(i))
						{
						    JB_PlayerInfo[i][JB_pSpeedhacking]++;
						    if(JB_PlayerInfo[i][JB_pSpeedhacking]==3)
							{
							    JB_Warnings[i][MAX_SPEED]++;
							    TogglePlayerControllable(i,false);
							    if(JB_Warnings[i][MAX_SPEED]<3)
							    {
								    format(reason,sizeof(reason),"%d KM/H with a(n) %s",var,GetVehicleName(GetPlayerVehicleID(i)));
								    JunkBusterReport(i,"Speedhack",reason);
							    }
							    else
							    {
							        JB_Ban(i,"Speedhack");
							        continue;
							    }
							}
						}
						else
						    JB_PlayerInfo[i][JB_pSpeedhacking]=0;
					}
			    }
  				else
			  		NoTeleportCheck[i]--;

			    var=GetPlayerWeapon(i);
			    if(IsForbiddenWeapon(var) && WeaponForbiddenForPlayer[i][var] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			    {
					JB_Ban(i,"Weaponshack");
			        continue;
			    }

			    if(GetPlayerSpecialAction(i)==SPECIAL_ACTION_USEJETPACK && JB_Variables[JETPACK] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			    {
					JB_Ban(i,"Jetpack");
			        continue;
			    }

				if(JB_Variables[HEALTH_HACK] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
				{
				    GetPlayerHealth(i,health);
				    if(health>100)
				    {
				        JB_Ban(i,"Healthhack");
				        continue;
				    }
				}

				if(JB_Variables[ARMOUR_HACK] && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
				{
				    GetPlayerArmour(i,armour);
				    if(armour>100)
				    {
				        JB_Ban(i,"Armourhack");
				        continue;
				    }
				}
			}
			
			if(!JB_IsPlayerPremium(i))
			{
			if(GetPlayerState(i) && (!JB_IsPlayerAdmin(i) || !JB_Variables[ADMIN_IMMUNITY]))
			{
				JB_PlayerInfo[i][JB_pPing][JB_PlayerInfo[i][JB_pPingCheckProgress]]=GetPlayerPing(i);
				JB_PlayerInfo[i][JB_pPingCheckProgress]++;
				if(JB_PlayerInfo[i][JB_pPingCheckProgress]==MAX_PING_CHECKS)
				{
				    if(JB_Variables[MAX_PING])
				    {
						var=0;
						for(new j=0;j<MAX_PING_CHECKS;j++)
						    var+=JB_PlayerInfo[i][JB_pPing][j];
						var/=MAX_PING_CHECKS;
						if(var>JB_Variables[MAX_PING])
						{
							format(reason,sizeof(reason),"Too high ping. (max. Ping: %d)",JB_Variables[MAX_PING]);
							JB_Kick(i,reason);
							continue;
						}
				    }
				    JB_PlayerInfo[i][JB_pPingCheckProgress]=0;
				}
			}
			}

			GetPlayerPos(i,CurrentPos[i][0],CurrentPos[i][1],CurrentPos[i][2]);
			JB_PlayerInfo[i][JB_pLastCheck]=GetTickCount();
	    }
	}
	return 1;
}

stock Split(ip_string[])
{
	new ip[4],string[16];
	format(string,sizeof(string),ip_string);

	for(new i=0;i<strlen(string);i++)
		if(string[i]=='.')
		    string[i]=' ';

	new idx,tmp[32];
	for(new i=0;i<4;i++)
	{
	    tmp=JB_strtok(string,idx);
	    if(tmp[0]=='*')
	        ip[i]=-1;
		else
			ip[i]=strval(tmp);
	}
	return ip;
}

stock IpBanCheck(playerid)
{
	new ip[4];
	ip=Split(ReturnPlayerIp(playerid));
	for(new i=0;i<sizeof(IpBans);i++)
	    if(IpBanned[i])
			if(IsSameIpEx(IpBans[i],ip))
			    return 1;
	return 0;
}

stock IsSameIp(ip1[4],ip2[4])
{
 	for(new i=0;i<4;i++)
		if(ip1[i]!=ip2[i])
		    return 0;
	return 1;
}

stock IsSameIpEx(ip1[4],ip2[4])
{
	for(new i=0;i<4;i++)
		if(ip1[i]!=ip2[i] && ip1[i]!=-1 && ip2[i]!=-1)
		    return 0;
	return 1;
}

public BanIp(ip_string[])
{
    new ip[4];
	ip=Split(ip_string);
	for(new i=0;i<sizeof(IpBans);i++)
	{
	    if(!IpBanned[i])
	    {
			IpBanned[i]=true;
			IpBans[i]=ip;

			for(new j=0;j<MAX_PLAYERS;j++)
			    if(IsPlayerConnected(j))
			        if(IsSameIpEx(ip,Split(ReturnPlayerIp(j))))
			            JB_Kick(j,"IP-Ban");
			return 1;
	    }
	}
	return 0;
}

public UnbanIp(ip_string[])
{
	new ip[4];
	ip=Split(ip_string);
	for(new i=0;i<sizeof(IpBans);i++)
	{
	    if(IsSameIp(IpBans[i],ip))
	    {
			IpBanned[i]=false;
			return 1;
	    }
	}
	return 0;
}

public SaveIpBans()
{
 	fremove(IP_BAN_FILE);
	new File:f=fopen(IP_BAN_FILE, io_append),string[32];
	for(new i=0;i<sizeof(IpBans);i++)
	{
		if(IpBanned[i])
		{
		    string[0]=0;
			for(new j=0;j<4;j++)
			{
			    if(IpBans[i][j]==-1)
			        format(string,sizeof(string),"%s.*",string);
				else
				    format(string,sizeof(string),"%s.%d",string,IpBans[i][j]);
			}
			format(string,sizeof(string),"%s\r\n",string[1]);
			fwrite(f,string);
		}
	}
	fclose(f);
	return 1;
}

public LoadIpBans()
{
    if(dini_Exists(IP_BAN_FILE))
	{
	    for(new i=0;i<sizeof(IpBans);i++)
	        IpBanned[i]=false;

	    new File:f=fopen(IP_BAN_FILE, io_read),c,string[16];
	    while(fread(f,string,sizeof(string)) && c<sizeof(IpBans))
	    {
	        JB_StripNewLine(string);
	        if(strlen(string))
	        {
				IpBans[c]=Split(string);
				IpBanned[c]=true;
				c++;
			}
	    }
	    fclose(f);
	    return 1;
	}
	return 0;
}

public LoadBlacklist()
{
	if(dini_Exists(BLACKLIST_FILE))
	{
	    for(new i=0;i<sizeof(Blacklist);i++)
	        Blacklist[i][0]=0;

	    new File:f=fopen(BLACKLIST_FILE, io_read),c,string[MAX_PLAYER_NAME];
	    while(fread(f,string,sizeof(string)) && c<sizeof(Blacklist))
	    {
	        JB_StripNewLine(string);
	        if(strlen(string))
	        {
	            Blacklist[c]=string;
	            c++;
	        }
	    }
	    fclose(f);
	    return 1;
	}
	return 0;
}

public UpdateBlacklist()
{
	fremove(BLACKLIST_FILE);
	new string[MAX_PLAYER_NAME+2];
	new File:f=fopen(BLACKLIST_FILE,io_append);
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(Blacklist[i][0])
	    {
			format(string,sizeof(string),"%s\r\n",Blacklist[i]);
			fwrite(f,string);
		}
	}
	return fclose(f);
}

public AddNameToBlacklist(name[])
{
	new success;
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(!Blacklist[i][0])
	    {
			format(Blacklist[i],MAX_PLAYER_NAME,name);
			success=true;
			break;
	    }
	}

	if(success)
	{
		if(UpdateBlacklist())
		{
		    return 1;
		}
	}
	return 0;
}

public RemoveNameFromBlacklist(name[])
{
	new success;
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(Blacklist[i][0])
	    {
			if(!strcmp(Blacklist[i],name,false))
			{
			    Blacklist[i][0]=0;
				success=true;
				break;
			}
	    }
	}

	if(success)
	{
		if(UpdateBlacklist())
		{
		    return 1;
		}
	}
	return 0;
}

public AddPlayerToBlacklist(playerid)
{
	if(AddNameToBlacklist(ReturnPlayerName(playerid)))
		return JB_Ban(playerid,"Blacklist");
	return 0;
}

stock IsPlayerOnBlacklist(playerid)
{
	new name[MAX_PLAYER_NAME];
	name=ReturnPlayerName(playerid);
	for(new i=0;i<sizeof(Blacklist);i++)
	{
	    if(Blacklist[i][0])
	        if(!strcmp(name,Blacklist[i],false))
	            return true;
	}
	return false;
}

public LoadWhitelist()
{
	if(dini_Exists(WHITELIST_FILE))
	{
	    for(new i=0;i<sizeof(Whitelist);i++)
	        Whitelist[i][0]=0;

	    new File:f=fopen(WHITELIST_FILE, io_read),c,string[MAX_PLAYER_NAME];
	    while(fread(f,string,sizeof(string)) && c<sizeof(Whitelist))
	    {
	        JB_StripNewLine(string);
	        if(strlen(string))
	        {
	            Whitelist[c]=string;
	            c++;
	        }
	    }
	    fclose(f);
	    return 1;
	}
	return 0;
}

public UpdateWhitelist()
{
	fremove(WHITELIST_FILE);
	new string[MAX_PLAYER_NAME+2];
	new File:f=fopen(WHITELIST_FILE,io_append);
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(Whitelist[i][0])
	    {
			format(string,sizeof(string),"%s\r\n",Whitelist[i]);
			fwrite(f,string);
		}
	}
	return fclose(f);
}

public AddNameToWhitelist(name[])
{
	new success;
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(!Whitelist[i][0])
	    {
			format(Whitelist[i],MAX_PLAYER_NAME,name);
			success=true;
			break;
	    }
	}

	if(success)
	{
		if(UpdateWhitelist())
		{
		    return 1;
		}
	}
	return 0;
}

public RemoveNameFromWhitelist(name[])
{
	new success;
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(Whitelist[i][0])
	    {
			if(!strcmp(Whitelist[i],name,false))
			{
			    Whitelist[i][0]=0;
				success=true;
				break;
			}
	    }
	}

	if(success)
	{
		if(UpdateWhitelist())
		{
		    return 1;
		}
	}
	return 0;
}

public AddPlayerToWhitelist(playerid)
{
	return AddNameToWhitelist(ReturnPlayerName(playerid));
}

stock IsPlayerOnWhitelist(playerid)
{
	new name[MAX_PLAYER_NAME];
	name=ReturnPlayerName(playerid);
	for(new i=0;i<sizeof(Whitelist);i++)
	{
	    if(Whitelist[i][0])
	        if(!strcmp(name,Whitelist[i],false))
	            return true;
	}
	return false;
}

public LoadBadWords()
{
	if(dini_Exists(BAD_WORDS_FILE))
	{
	    new File:f=fopen(BAD_WORDS_FILE, io_read),c,string[32];
	    while(fread(f,string,sizeof(string)) && c<MAX_BAD_WORDS)
	    {
	        JB_StripNewLine(string);
	        if(strlen(string))
	        {
	            BadWords[c]=string;
	            c++;
	        }
	    }
	    fclose(f);
	    BadWordsCount=c;
	    return 1;
	}
	return 0;
}

public LoadForbiddenWeapons()
{
	if(dini_Exists(FORBIDDEN_WEAPONS_FILE))
	{
	    new File:f=fopen(FORBIDDEN_WEAPONS_FILE, io_read),c,string[32];
	    while(fread(f,string,sizeof(string)) && c<MAX_FORBIDDEN_WEAPONS)
	    {
	        JB_StripNewLine(string);
	        if(strlen(string))
	        {
	            ForbiddenWeapons[c]=strval(string);
	            c++;
	        }
	    }
	    fclose(f);
	    ForbiddenWeaponsCount=c;
	    return 1;
	}
	return 0;
}

public ConfigJunkBuster()
{
	if(!dini_Exists(CONFIG_FILE))
	    dini_Create(CONFIG_FILE);

    for(new i=0;i<MAX_JB_VARIABLES;i++)
    {
        if(dini_Isset(CONFIG_FILE,JB_VariableNames[i]))
            JB_Variables[i]=dini_Int(CONFIG_FILE,JB_VariableNames[i]);
		else
		    dini_IntSet(CONFIG_FILE,JB_VariableNames[i],JB_Variables[i]);
	}
	LoadIpBans();
	LoadWhitelist();
	LoadBlacklist();
    LoadBadWords();
    LoadForbiddenWeapons();
	return 1;
}

public SaveJunkBusterVars()
{
    if(!dini_Exists(CONFIG_FILE))
	    dini_Create(CONFIG_FILE);

    for(new i=0;i<MAX_JB_VARIABLES;i++)
    	dini_IntSet(CONFIG_FILE,JB_VariableNames[i],JB_Variables[i]);
	return 1;
}

stock ReturnTime()
{
	new jb_time[20],jb_h,jb_m,jb_s;
	gettime(jb_h,jb_m,jb_s);
	format(jb_time,sizeof(jb_time),"%02d:%02d:%02d",jb_h,jb_m,jb_s);
	return jb_time;
}

stock ReturnDate()
{
	new jb_date[40],jb_day,jb_month,jb_year;
	getdate(jb_year,jb_month,jb_day);
	format(jb_date,sizeof(jb_date),"%d. %s %d",jb_day,GetMonth(jb_month),jb_year);
	return jb_date;
}

stock GetMonth(month)
{
	new string[40];
	string="Unbekannter Monat";
	switch(month)
	{
	    case 1:
	        string="January";
		case 2:
		    string="February";
        case 3:
		    string="March";
        case 4:
		    string="April";
        case 5:
		    string="May";
		case 6:
		    string="June";
		case 7:
		    string="July";
		case 8:
		    string="August";
		case 9:
		    string="September";
		case 10:
		    string="October";
		case 11:
		    string="November";
		case 12:
		    string="December";
	}
	return string;
}

stock ReturnPlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

stock ReturnPlayerIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid,ip,sizeof(ip));
	return ip;
}

stock JB_strtok(const string[], &index,seperator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[32];
	while ((index < length) && (string[index] != seperator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	if ((index < length) && (string[index] == seperator))
	{
		index++;
	}
	return result;
}

stock JB_IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
		if ((string[i] > '9' || string[i] < '0') && string[i]!='-' ) return 0;
	return 1;
}

stock JB_StripNewLine(string[])
{
	new len = strlen(string);
	if (string[0]==0) return ;
	if ((string[len - 1] == '\n') || (string[len - 1] == '\r')) {
		string[len - 1] = 0;
		if (string[0]==0) return ;
		if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
	}
}

stock JB_GetPlayerSpeed(playerid,get3d)
{
	new Float:x,Float:y,Float:z;
	if(IsPlayerInAnyVehicle(playerid))
	    GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z);
	else
	    GetPlayerVelocity(playerid,x,y,z);

	return JB_Speed(x,y,z,100.0,get3d);
}

stock JB_GetSquareDistance(Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2)
{
	x1-=x2;
	y1-=y2;
	z1-=z2;
	x1*=x1;
	y1*=y1;
	z1*=z1;
	return floatround(x1+y1+z1);
}

stock JB_GetPlayer2DZone(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(JB_gSAZones); i++ )
 	{
		if(x >= JB_gSAZones[i][JB_SAZONE_AREA][0] && x <= JB_gSAZones[i][JB_SAZONE_AREA][3] && y >= JB_gSAZones[i][JB_SAZONE_AREA][1] && y <= JB_gSAZones[i][JB_SAZONE_AREA][4])
		{
		    format(zone, len, JB_gSAZones[i][JB_SAZONE_NAME], 0);
		    return i;

		}
	}
	return 0;
}

ShowPlayerConfigDialog(playerid)
{
	ShowPlayerDialog(playerid,DIALOG_CFG,DIALOG_STYLE_LIST,"Anticheat","Set a Variable\nLoad configuration\nSave configuration","Select","Close");
}

ShowPlayerVarlistDialog(playerid)
{
    new string[512];
    for(new i=0;i<MAX_JB_VARIABLES;i++)
		format(string,sizeof(string),"%s%s: %d\n",string,JB_VariableNames[i],JB_Variables[i]);

    ShowPlayerDialog(playerid,DIALOG_VARLIST,DIALOG_STYLE_LIST,"Anticheat Variables",string,"Select","Back");
}

ShowPlayerSetvarDialog(playerid,var)
{
	new string[64];
	format(string,sizeof(string),"Anticheat Variable- %s: %d",JB_VariableNames[var],JB_Variables[var]);
	ShowPlayerDialog(playerid,DIALOG_SETVAR+var,DIALOG_STYLE_INPUT,string,JB_VarDescription[var],"Set variable","Back");
}

public OnPlayerSpawn(playerid)
{
    FullyConnected[playerid]=true;
    NoTeleportCheck[playerid]=3;
    JB_PlayerInfo[playerid][JB_pFreezed]=false;
    return CallLocalFunction("PnP_OnPlayerSpawn","i",playerid);
}

public OnPlayerDeath(playerid,killerid,reason)
{
	if(killerid!=INVALID_PLAYER_ID)
	{
	    new Float:x1,Float:y1,Float:z1;
	    new Float:x2,Float:y2,Float:z2;
		new Float:distance=floatsqroot(JB_GetSquareDistance(x1,y1,z1,x2,y2,z2));
	    if(JB_Variables[DRIVE_BY] && (!JB_IsPlayerAdmin(killerid) || !JB_Variables[ADMIN_IMMUNITY]))
	    {
			if(distance<25.0 && !IsPlayerNPC(killerid) && GetPlayerState(killerid)==PLAYER_STATE_DRIVER && (reason==WEAPON_UZI || reason==WEAPON_MP5 || reason==WEAPON_TEC9 || reason==WEAPON_VEHICLE || reason==50))
			{
			    JailPlayer(killerid,180,"Drive-By");
			    SetPlayerInterior(killerid, 6);
			    SetPlayerPos(killerid, 264.3700,77.5700,1001.0391);
			    SetPlayerFacingAngle(killerid, 272.6900);
			    TogglePlayerControllable(killerid, 0);
			    SetCameraBehindPlayer(killerid);
			    ResetPlayerMoney(killerid);
			}
		}

		if(JB_Variables[SPAWNKILL] && (!JB_IsPlayerAdmin(killerid) || !JB_Variables[ADMIN_IMMUNITY]))
		{
		    if(distance<30.0)
		    {
		        if(JB_PlayerInfo[playerid][JB_pSpawnKillProtected])
		        {
		            JB_Warnings[killerid][SPAWNKILL]++;
		            if(JB_Warnings[killerid][SPAWNKILL]>=JB_Variables[SPAWNKILL])
						JB_Kick(killerid,"Spawnkill");
					else
						SendFormattedMessage(killerid,rr,"Don't Spawnkill. (Warning: %d/%d)",JB_Warnings[killerid][SPAWNKILL],JB_Variables[SPAWNKILL]);
				}
			}
	 	}
 	}
	return CallLocalFunction("PnP_OnPlayerDeath","iii",playerid,killerid,reason);
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	NoTeleportCheck[playerid]=3;
	return CallLocalFunction("PnP_OnPlayerInteriorChange","iii",playerid, newinteriorid, oldinteriorid);
}

public OnGameModeInit()
{
	if(!CallLocalFunction("PnP_OnGameModeInit",""))
	{
	}
	dini_Remove(BAD_RCON_LOGIN_FILE);
	dini_Create(BAD_RCON_LOGIN_FILE);
	ConfigJunkBuster();
	SetTimer("JunkBuster",1000,true);
	SetTimer("GlobalUpdate",60*1000*4,true);
	SetTimer("SpamUpdate",3500,true);
	return 1;
}

public OnGameModeExit()
{
	SaveIpBans();
    return CallLocalFunction("PnP_OnGameModeExit","");
}

public OnPlayerConnect(playerid)
{
	KickBan[playerid]=false;
	FullyConnected[playerid]=false;

	if(IpBanCheck(playerid) && !IsPlayerOnWhitelist(playerid) && JB_Variables[IP_BANS])
	{
	format(jbstringa, sizeof(jbstringa), "[Admin]: {FFFFFF}The Server has banned %s (%d). (Reason: IP-Ban)", ReturnPlayerName(playerid), playerid);
	SendClientMessageToAll(ADMIN_FARBE, jbstringa);
	KickBan[playerid]=true;
	new stringjb[126];
	for(new chat = 0; chat <= 100; chat++) SendClientMessage(playerid,ww, " ");
	SendClientMessage(playerid,rr,"You have been banned!");
	format(stringjb, sizeof(stringjb), "Name: %s", GetName(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "IP: %s", GetIP(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "Time: %s | %s", ReturnDate(),ReturnTime());
	SendClientMessage(playerid,ww, stringjb);
	SendClientMessage(playerid,ww, "Admin: Server");
	SendClientMessage(playerid,ww, "Reason: IP-Ban");
	SendClientMessage(playerid,ww, "Take a screenshot and complain at: www.Eagles-Clan.com");
	format(stringjb, sizeof(stringjb), "[KICK] The server has kicked %s (%s). (Reason: IP-Ban)", GetName(playerid), ReturnPlayerIp(playerid));
	Banlist(stringjb);
	Kick(playerid);
	return 0;
	}

	if(IsPlayerOnBlacklist(playerid) && JB_Variables[BLACKLIST])
	{
	format(jbstringa, sizeof(jbstringa), "[Admin]: {FFFFFF}The Server has banned %s (%d). (Reason: Blacklist)", ReturnPlayerName(playerid), playerid);
	SendClientMessageToAll(ADMIN_FARBE, jbstringa);
	KickBan[playerid]=true;
	new stringjb[126];
	for(new chat = 0; chat <= 100; chat++) SendClientMessage(playerid,ww, " ");
	SendClientMessage(playerid,rr,"You have been banned!");
	format(stringjb, sizeof(stringjb), "Name: %s", GetName(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "IP: %s", GetIP(playerid));
	SendClientMessage(playerid,ww, stringjb);
	format(stringjb, sizeof(stringjb), "Time: %s | %s", ReturnDate(),ReturnTime());
	SendClientMessage(playerid,ww, stringjb);
	SendClientMessage(playerid,ww, "Admin: Server");
	SendClientMessage(playerid,ww, "Reason: Blacklist");
	SendClientMessage(playerid,ww, "Take a screenshot and complain at: www.Eagles-Clan.com");
	format(stringjb, sizeof(stringjb), "[KICK] The server has kicked %s (%s). (Reason: Blacklist)", GetName(playerid), ReturnPlayerIp(playerid));
	Banlist(stringjb);
	    BanEx(playerid,"Blacklist");
	    return 0;
	}

	for(new i=0;i<MAX_JB_VARIABLES;i++)
	    JB_Warnings[playerid][i]=0;

	ResetForbiddenWeaponsForPlayer(playerid);
	JB_PlayerInfo[playerid][JB_pLastMessage][0]=0;
	JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;
	JB_PlayerInfo[playerid][JB_pMessages]=0;
	JB_PlayerInfo[playerid][JB_pCommands]=0;
    NoTeleportCheck[playerid]=0;
    JB_PlayerInfo[playerid][JB_pPingCheckProgress]=0;
	JB_PlayerInfo[playerid][JB_pVehicleEntered]=INVALID_VEHICLE_ID;
	JB_PlayerInfo[playerid][JB_pMuted]=0;
	JB_PlayerInfo[playerid][JB_pJailed]=0;
	JB_PlayerInfo[playerid][JB_pFreezed]=false;
	return CallLocalFunction("PnP_OnPlayerConnect","i",playerid);
}

public OnPlayerDisconnect(playerid,reason)
{
    FullyConnected[playerid]=false;
	if(KickBan[playerid])
	    return 0;
	return CallLocalFunction("PnP_OnPlayerDisconnect","ii",playerid,reason);
}

public OnPlayerText(playerid, text[])
{
	if(!IsPlayerNPC(playerid) && JB_PlayerInfo[playerid][JB_pMuted] && JB_Variables[SPAM])
	{
	    SendFormattedMessage(playerid,rr,"[Error]: {FFFFFF}You are muted and can't chat for the next %d seconds.",JB_PlayerInfo[playerid][JB_pMuted]);
	    return 0;
	}

	if(JB_PlayerInfo[playerid][JB_pLastMessage][0])
	{
	    if(!strcmp(text,JB_PlayerInfo[playerid][JB_pLastMessage],false))
	        JB_PlayerInfo[playerid][JB_pMessageRepeated]++;
		else
		    JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;
	}
	else
	    JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;

	format(JB_PlayerInfo[playerid][JB_pLastMessage],128,text);
    JB_PlayerInfo[playerid][JB_pMessages]++;
    if(!IsPlayerNPC(playerid) && !JB_PlayerInfo[playerid][JB_pMuted] && JB_Variables[SPAM] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
    {
        if(JB_PlayerInfo[playerid][JB_pMessages]>25)
	    {
	        MutePlayer(playerid,300,"Spam");
	        return 0;
	    }
	    else if(JB_PlayerInfo[playerid][JB_pMessages]>15)
	    {
	        MutePlayer(playerid,250,"Spam");
	        return 0;
	    }
	    else if(JB_PlayerInfo[playerid][JB_pMessages]>4 || JB_PlayerInfo[playerid][JB_pMessageRepeated]>=3)
	    {
	        JB_PlayerInfo[playerid][JB_pMessageRepeated]=0;
	        MutePlayer(playerid,180,"Spam");
		    return 0;
		}
	}

    if(!IsPlayerNPC(playerid) && CapsLockCheck(text) && JB_Variables[CAPS_LOCK] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
	    SendClientMessage(playerid,rr,"[Anticheat]: {FFFFFF}Don't use Capslock!");
	    return 0;
	}

	if(!IsPlayerNPC(playerid) && AdvertisementCheck(text) && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
	    JB_Kick(playerid,"Advertisement");
	    return 0;
	}

	if(!IsPlayerNPC(playerid) && BadWordsCheck(text) && JB_Variables[BAD_WORDS] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
	    SendClientMessage(playerid,rr,"[Error]: {FFFFFF}Don't insult other players!");
	    return 0;
	}
	return CallLocalFunction("PnP_OnPlayerText","is",playerid,text);
}

/*
public OnPlayerCommandPerformed(playerid, cmdtext[],success)
{
	JB_PlayerInfo[playerid][JB_pCommands]++;
	if(!IsPlayerNPC(playerid) && JB_Variables[COMMAND_SPAM] && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
    {
        if(JB_PlayerInfo[playerid][JB_pCommands]>20)
	    {
	        JB_Kick(playerid,"Commandspam");
	        return 1;
	    }
	    else if(JB_PlayerInfo[playerid][JB_pCommands]>8)
	    {
	        JB_Kick(playerid,"Commandspam");
	        return 1;
	    }
    }

	return CallLocalFunction("PnP_OnPlayerCommandText","is",playerid,cmdtext);
}
*/

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new Float:x,Float:y,Float:z;
    new Float:vx,Float:vy,Float:vz;
    GetPlayerPos(playerid,x,y,z);
    GetVehiclePos(vehicleid,vx,vy,vz);
    if(JB_GetSquareDistance(x,y,z,vx,vy,vz)>(350*350))
        JunkBusterReport(playerid,"Vehiclespawn",GetVehicleName(vehicleid));

	JB_PlayerInfo[playerid][JB_pVehicleEntered]=vehicleid;
	return CallLocalFunction("PnP_OnPlayerEnterVehicle","iii",playerid, vehicleid, ispassenger);
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(JB_Variables[SPECTATE_HACK] && newstate==PLAYER_STATE_SPECTATING && !JB_IsPlayerAdmin(playerid))
	    JB_Ban(playerid,"Spectate Hack");

	new vehicleid=GetPlayerVehicleID(playerid);
	if(newstate==PLAYER_STATE_DRIVER && JB_PlayerInfo[playerid][JB_pVehicleEntered]!=vehicleid && (!JB_IsPlayerAdmin(playerid) || !JB_Variables[ADMIN_IMMUNITY]))
	{
		new used;
		for(new i=0;i<MAX_PLAYERS;i++)
		{
		    if(IsPlayerConnected(i) && i!=playerid)
		    {
		        if(GetPlayerState(i)==PLAYER_STATE_DRIVER)
		        {
		            if(GetPlayerVehicleID(i)==vehicleid)
		            {
		                used=true;
		                break;
		            }
		        }
			}
		}

		if(used)
		{
			JB_Warnings[playerid][CAR_JACK_HACK]++;
			if(JB_Variables[CAR_JACK_HACK])
			{
			    if(JB_Warnings[playerid][CAR_JACK_HACK]>=3)
		    		JB_Kick(playerid,"Carjack hack");
			}
			else
			    JunkBusterReport(playerid,"Carjack Hack","Keine Details");
		}
	}

	if(oldstate==PLAYER_STATE_PASSENGER)
	    NoTeleportCheck[playerid]=3;
	JB_PlayerInfo[playerid][JB_pAirbreaking]=0;
	JB_PlayerInfo[playerid][JB_pSpeedhacking]=0;
	JB_PlayerInfo[playerid][JB_pVehicleEntered]=INVALID_VEHICLE_ID;
	return CallLocalFunction("PnP_OnPlayerStateChange","iii",playerid, newstate, oldstate);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	for(new i=0;i<strlen(inputtext);i++)
	    if(inputtext[i]=='%')
	        inputtext[i]='#';

	if(IsPlayerAdmin(playerid))
	{
		if(dialogid==DIALOG_CFG)
		{
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			            ShowPlayerVarlistDialog(playerid);

			        case 1:
			        {
			            ConfigJunkBuster();
			    		SendClientMessageToAdmins(cc,"[Admin] Configuration has been loaded.", 1);
			    		ShowPlayerConfigDialog(playerid);
			        }

			        case 2:
			        {
			            SaveJunkBusterVars();
			    		SendClientMessageToAdmins(cc,"[Admin] Configuration has been saved.", 1);
			    		ShowPlayerConfigDialog(playerid);
			        }
			    }
			}
			return 1;
		}

		if(dialogid==DIALOG_VARLIST)
		{
		    if(response)
		    	ShowPlayerSetvarDialog(playerid,listitem);
		    else
		        ShowPlayerConfigDialog(playerid);
			return 1;
		}

		if(dialogid>=DIALOG_SETVAR && dialogid<(DIALOG_SETVAR+MAX_JB_VARIABLES-1))
		{
		    if(response)
		    {
		        new var=dialogid-DIALOG_SETVAR,setvar=strval(inputtext);
		        if(!inputtext[0] || !JB_IsNumeric(inputtext) || setvar<0)
			        ShowPlayerSetvarDialog(playerid,var);
				else
				{
                    JB_Variables[var]=setvar;
					format(jbstringa, sizeof(jbstringa), "[Admin] Admin %s has changed the variable %s to %d.",ReturnPlayerName(playerid),JB_VariableNames[var],JB_Variables[var]);
					SendClientMessageToAdmins(cc, jbstringa, 1);
					ShowPlayerVarlistDialog(playerid);
				}
		    }
		    else
			    ShowPlayerVarlistDialog(playerid);
		    return 1;
		}
	}
	if(!inputtext[0])
	inputtext[0]='#';
	return CallLocalFunction("PnP_OnDialogResponse","iiiis",playerid, dialogid, response, listitem, inputtext);
}

public OnRconLoginAttempt( ip[], password[], success)
{
	if(!success)
	{
	    new attempts=dini_Int(BAD_RCON_LOGIN_FILE,ip);
		attempts++;
		if(attempts>=3)
		{
		    new cmd[32];
		    format(cmd,sizeof(cmd),"banip %s",ip);
		    SendRconCommand(cmd);
		    format(jbstringa, sizeof(jbstringa), "[Admin]: {FFFFFF}Der Server has banned the IP %s. (Reason: Tried to hack RCON password)",ip);
		    SendClientMessageToAll(ADMIN_FARBE, jbstringa);
		}
		dini_IntSet(BAD_RCON_LOGIN_FILE,ip,attempts);
	}
	return CallLocalFunction("PnP_OnRconLoginAttempt","ssi",ip,password,success);
}

public Banlist(string[])
{
	new stringer[300];
	format(stringer, sizeof(stringer), "(%s | %s) %s\r\n",ReturnDate(),ReturnTime(),string);
	new File:hFile;
	hFile = fopen("/Anticheat/Banlist.txt", io_append);
	if(hFile)
	{
	fwrite(hFile, stringer);
	fclose(hFile);
	}
	hFile = fopen("/Anticheat/Banlist.txt", io_append);
	if(hFile)
	{
	fwrite(hFile, stringer);
	fclose(hFile);
	}
	return 1;
}

#define GetPlayerMoney JB_GetPlayerMoney
#define ResetPlayerMoney JB_ResetPlayerMoney
#define GivePlayerMoney JB_GivePlayerMoney
#define SetPlayerMoney JB_SetPlayerMoney
#define PutPlayerInVehicle JB_PutPlayerInVehicle
#define GivePlayerWeapon JB_GivePlayerWeapon
#define SetVehicleHealth JB_SetVehicleHealth
#define SetPlayerPos JB_SetPlayerPos
#define SetVehiclePos JB_SetVehiclePos
#define SetPlayerHealth JB_SetPlayerHealth
#define SetPlayerArmour JB_SetPlayerArmour
#define TogglePlayerControllable JB_TogglePlayerControllable
#define SetVehicleVelocity JB_SetVehicleVelocity
#define SetPlayerSpecialAction JB_SetPlayerSpecialAction
#define OnPlayerStateChange PnP_OnPlayerStateChange
#define OnPlayerEnterVehicle PnP_OnPlayerEnterVehicle
//#define OnPlayerCommandPerformed PnP_OnPlayerCommandText
#define OnPlayerText PnP_OnPlayerText
#define OnGameModeExit PnP_OnGameModeExit
#define OnPlayerInteriorChange PnP_OnPlayerInteriorChange
#define OnPlayerDeath PnP_OnPlayerDeath
#define OnPlayerSpawn PnP_OnPlayerSpawn
#define OnDialogResponse PnP_OnDialogResponse
#define OnRconLoginAttempt PnP_OnRconLoginAttempt