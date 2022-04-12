#include <sourcemod>

const int MESSAGE_MAX_COUNT = 3;
const int MASSAGE_MAX_LENGTH = 256;

char g_serverPrefix[] = "\x07B3FFAA[Server]\x01";
char g_serverMessage[MESSAGE_MAX_COUNT][MASSAGE_MAX_LENGTH] =
{
	"A.",
	"B.",
	"C."
};

public Plugin:myinfo = 
{
    name = "auto message",
    author = "Samana",
    description = ".",
    version = "0000",
    url = ""
};

public OnPluginStart() 
{
    CreateTimer(120.0, showMessagePerTime, _, TIMER_REPEAT); // 시간은 여기서 120.0초 수정하시면 됩니다.
}

public Action showMessagePerTime(Handle timer) 
{
	static int g_messageIndex;
	
	g_messageIndex %= MESSAGE_MAX_COUNT; // 메세지 순서 순환
	PrintToChatAll("%s%s", g_serverPrefix, g_serverMessage[g_messageIndex]);

	g_messageIndex++;
	return Plugin_Continue
}
