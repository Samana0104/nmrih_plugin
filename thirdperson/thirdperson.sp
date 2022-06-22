#include <sourcemod>

public Plugin:myinfo =
{
	name = "third person",
	author = "사마나",
	description = ".",
	version = ".",
	url = "."	
};

const int NMRIH_MAX_PLAYERS = 8;
bool isPlayerThirdPerson[NMRIH_MAX_PLAYERS+1] = {false, ...};

public OnPluginStart()
{
	RegConsoleCmd("sm_tp", thirdPersonCommand);
	HookEvent("player_death", playerDeathEvent);
}                                                 

public Action:thirdPersonCommand(client, args)
{
	if(isClient(client) && IsPlayerAlive(client))
	{
		if(isPlayerThirdPerson[client])
			turnOffThirdPerson(client);
		else
			turnOnThirdPerson(client);
	} 
	
	return Plugin_Continue;
}

public turnOffThirdPerson(int client)
{
	SetEntProp(client, Prop_Send, "m_iObserverMode", 0);
	isPlayerThirdPerson[client] = false;	
}

public turnOnThirdPerson(int client)
{
	SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", client)
	SetEntProp(client, Prop_Send, "m_iObserverMode", 1);

	isPlayerThirdPerson[client] = true;	
}

public Action:playerDeathEvent(Handle:event, const String:name[], bool:dontBroadcast) {
	int client = GetClientOfUserId(GetEventInt(event, "userid"));

	isPlayerThirdPerson[client] = false;	
}

public OnClientPutInServer(int client)
{
	isPlayerThirdPerson[client] = false;
}

public bool:isClient(int client)
{
	if(!IsFakeClient(client) && IsClientInGame(client))
		return true;
	else
		return false;
}