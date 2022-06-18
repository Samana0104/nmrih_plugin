#include <sourcemod>

public Plugin:myinfo = 
{ 
	name = "auto join", 
	author = "samana", 
	description = "", 
	version = ".", 
	url = ""
};

public OnClientPostAdminCheck(int client)
{
	CreateTimer(1.0, timerForAutoJoin, client);
}

public Action timerForAutoJoin(Handle timer, any client)
{
	if (!IsClientInGame(client)) 
		return;

	FakeClientCommand(client, "joingame");
}
