#include <sourcemod>

public Plugin:myinfo = 
{
    name = "automessage",
    author = "samana",
    description = ".",
    version = ".",
    url = "."
};

const int MESSAGE_MAX_COUNT = 4;
const int MESSAGE_MAX_LENGTH = 256;
char g_serverPrefix[] = "\x07B3FFAA[Server]\x01"; // prefix
char g_serverMessage[MESSAGE_MAX_COUNT][MESSAGE_MAX_LENGTH] =
{
	"A\nB",
	"C",
	"D",
	"E"
};

Handle g_serverMessageHandle;

public OnPluginStart() 
{
    g_serverMessageHandle = CreateTimer(120.0, showMessagePerTime, _, TIMER_REPEAT); // if you want to revise the autommesage time, you revise this line 
}

public OnPluginEnd()
{
	CloseHandle(g_serverMessageHandle);
}

public Action showMessagePerTime(Handle timer) 
{	
	static int g_messageIndex;
	g_messageIndex %= MESSAGE_MAX_COUNT; // round-robin
	PrintToChatAll("%s%s", g_serverPrefix, g_serverMessage[g_messageIndex]);
	g_messageIndex++;
	return Plugin_Continue;
}