#include	<activate_codes>
#pragma		semicolon	1
#pragma		newdecls	required
//#define		DEBUG

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)	{
	RegPluginLibrary("ActivateCodes");
	CreateNative("ActivateCodes_GetFlagFromCode", Native_GetFlagFromCode);
}

public	Plugin	myinfo	=	{
	name		=	"Activate Codes",
	author		=	"Tk /id/Teamkiller324",
	description	=	"Activate",
	version		=	"0.1",
	url			=	"https://steamcommunity.com/id/Teamkiller324"
}

char codes[64];

public void OnPluginStart()	{
	BuildPath(Path_SM, codes, sizeof(codes), "configs/activate_codes.txt");
	if(!FileExists(codes))	{
		PrintToServer("[Activate Codes] CODES_FILE_NOT_AVAILABLE 0xc000404 (\"%s\" was not found)", codes);
		return;
	}
	
	KeyValues kv = new KeyValues("Codes");
	kv.ImportFromFile(codes);
	
	if(!kv.GotoFirstSubKey())	{
		PrintToServer("[Activate Codes] KEYVALUES_CANNOT_INITIALIZE_SUBKEY (Unable to initialize first subkey, is it configured properly?)");
		return;
	}
	
	#if defined DEBUG
	do	{
		char section[64], flag[64];
		kv.GetSectionName(section, sizeof(section));
		kv.GetString("flag", flag, sizeof(flag));
		PrintToServer("[Activate Codes] Debug: \nCode \"%s\"\nFlag \"%s\"\n", section, flag);
	}
	while(kv.GotoNextKey());
	
	delete kv;
	#endif
}

/**
 *	Returns the flag if the code is correct.
 *
 *	@param	code	The code string.
 */
any Native_GetFlagFromCode(Handle plugin, int params)	{
	char code[64];
	GetNativeString(1, code, sizeof(code));
	
	KeyValues kv = new KeyValues("Codes");
	kv.ImportFromFile(codes);
	kv.GotoFirstSubKey();
	int flagbit = 0;
	do	{
		char section[64], flag[64];
		kv.GetSectionName(section, sizeof(section));
		kv.GetString("flag", flag, sizeof(flag));
		if(StrEqual(code, section))
			flagbit = ReadFlagString(flag);
	}
	while(kv.GotoNextKey());
	
	delete kv;
	return flagbit;
}