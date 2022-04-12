#include <sourcemod>

const int MESSAGE_MAX_COUNT = 3;
const int MASSAGE_MAX_LENGTH = 256;

char g_serverPrefix[] = "\x07B3FFAA[Server]\x01";
char g_serverMessage[MESSAGE_MAX_COUNT][MASSAGE_MAX_LENGTH] =
{
	"해당 서버는 서버장의 사정에 따라 4~6월 사이에 열릴 에정입니다.",
	"모든 기획은 서버 그룹에 있으니 참조 바랍니다.",
	"서버 맵의 모든 테스트가 끝나면 더 이상의 사적 테스트는 래더 제작 기간이 아닌 이상 없습니다."
};

public Plugin:myinfo = 
{
    name = "내서버",
    author = "사마나",
    description = "이걸 아직도 안만들어?",
    version = "0000",
    url = "ㅇㅇㅇ"
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