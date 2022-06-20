#include <sourcemod>

public Plugin:myinfo =
{
	name 		= "can run object",
	author 		= "Samana",
	description 	= ".",
	version 		= ".",
	url 			= "."
}


public OnMapStart() 
{
	CreateTimer(0.5, changePlayerStatePerTime, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
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