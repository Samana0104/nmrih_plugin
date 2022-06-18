#include <sourcemod>

public Plugin:myinfo =
{
	name 		= "can run object",
	author 		= "Samana",
	description 	= ".",
	version 		= ".",
	url 			= "."
}

Handle g_serverTimer = INVALID_HANDLE;

public OnPluginStart() 
{
    g_serverTimer = CreateTimer(1.0, changePlayerStatePerTime, _, TIMER_REPEAT); 
}

public Action changePlayerStatePerTime(Handle timer) 
{	
	for(int i=1; i<=8; i++)
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
			SetEntProp(i, Prop_Send, "m_bSprintEnabled", 1);			
	}

	return Plugin_Continue;
}

public OnPluginEnd()
{
	CloseHandle(g_serverTimer);
}