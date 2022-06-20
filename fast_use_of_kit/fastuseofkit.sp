#include <sdktools>
#include <sdkhooks>
#include <sourcemod>

public Plugin:myinfo =
{
	name = "Fast use of kit",
	author = "Samana",
	description = ".",
	version = "1.0",
	url = "."
};

bool g_isCuring[9] = { false, ... }; // 9 is NMRIH_PLAYER

public OnMapStart() 
{
	CreateTimer(0.2, playerViewModelTimer, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public Action playerViewModelTimer(Handle timer) 
{	
	for(int i=1; i<=8; i++) // 8 is NMRIH_MAX_PLAYERS
	{
		if (IsClientInGame(i) && IsPlayerAlive(i))
			useFastItem(i);
	}

	return Plugin_Continue;
}

public void useFastItem(const int client)
{
	int playerEquipedItem = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");		
	char nameEquipedItem[64];
	GetEdictClassname(playerEquipedItem, nameEquipedItem, 64);
			
	if(StrEqual(nameEquipedItem, "item_first_aid", false))
	{
		int pushedButton = GetClientButtons(client);
		int viewModel = GetEntPropEnt(client, Prop_Send, "m_hViewModel");
				
		if(g_isCuring[client])
		{
			SetEntPropFloat(viewModel, Prop_Send, "m_flPlaybackRate", 8.0); // the view model speed does octuple
		}
				
		if((pushedButton & IN_ATTACK) == IN_ATTACK && GetClientHealth(client) < 100) // the normal health assumes 100
		{	
			if(!g_isCuring[client])
			{
				CreateTimer(2.5, playerStateNormalizationTimer, playerEquipedItem);
				g_isCuring[client] = true;
			}
		}
	}
	else
	{
		g_isCuring[client] = false;
	}	
}

public Action playerStateNormalizationTimer(Handle timer, any entity) 
{	
	SetEntPropFloat(entity, Prop_Send, "m_flNextPrimaryAttack", 0.0);
	SetEntPropFloat(entity, Prop_Send, "m_flNextSecondaryAttack", 0.0);
	SetEntPropFloat(entity, Prop_Send, "m_flNextBashAttack", 0.0)
	SetEntPropFloat(entity, Prop_Send, "m_flTimeWeaponIdle", 0.0);
}