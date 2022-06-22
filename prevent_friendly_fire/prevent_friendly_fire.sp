#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

public Plugin:myinfo = {
	name = "prevent_friendly_fire",
	author = "Samana",
	description = ".",
	version = ".",
	url = "."
};

public OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, onTakeDamage);
}

public OnClientDisconnect(int client)
{
	SDKUnhook(client, SDKHook_OnTakeDamage, onTakeDamage);
}

public Action onTakeDamage(int victim, int& attacker, int& inflictor, float& damage, int& damagetype)
{
	if(victim != attacker)
	{
		if(isClient(victim) && isClient(attacker))
			return Plugin_Handled;
	}
	return Plugin_Continue;
}

bool isClient(int entity)
{
	if(entity >=1 && entity <=8)
		return true;
	else
		return false;
}

