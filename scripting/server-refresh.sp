ConVar
	cvRestartMessage,
	cvRestartMapMessage,
	cvEmptyRestart,
	cvEmptyRestartWait,
	cvEmptyRestartType,
	cvHourlyRestart,
	cvHourlyRestartWait,
	cvHourlyRestartTime,
	cvHourlyRestartType,
	cvHourlyRestartIgnorePlayers,
	cvDailyRestart,
	cvDailyRestartWait,
	cvDailyRestartTime,
	cvDailyRestartType,
	cvDailyRestartIgnorePlayers,
	cvWeeklyRestart,
	cvWeeklyRestartWait,
	cvWeeklyRestartTime,
	cvWeeklyRestartType,
	cvWeeklyRestartIgnorePlayers;
	
int
	g_iEmptyRestart,
	g_iEmptyRestartWait,
	g_iEmptyRestartType,
	g_iHourlyRestart,
	g_iHourlyRestartWait,
	g_iHourlyRestartType,
	g_iHourlyRestartIgnorePlayers,
	g_iDailyRestart,
	g_iDailyRestartWait,
	g_iDailyRestartType,
	g_iDailyRestartIgnorePlayers,
	g_iWeeklyRestart,
	g_iWeeklyRestartWait,
	g_iWeeklyRestartType,
	g_iWeeklyRestartIgnorePlayers;
	
char
	g_sHourlyRestartTime[32],
	g_sDailyRestartTime[32],
	g_sWeeklyRestartTime[32],
	g_sRestartMessage[128],
	g_sRestartMapMessage[128];
	
	
// runs when the plugin is started
public void OnPluginStart()
{
	// cvar initializations
	cvRestartMessage = CreateConVar("sm_restart_message", "The server will be restarting in {0} seconds.", "Change the message that appears before the server is restarted");
	cvRestartMessage.GetString(g_sRestartMessage, sizeof(g_sRestartMessage));
	
	cvRestartMapMessage = CreateConVar("sm_restart_map_message", "The map will be refresh in {0} seconds.", "Change the message that appears before the map is restarted");
	cvRestartMapMessage.GetString(g_sRestartMapMessage, sizeof(g_sRestartMapMessage));
	
	cvEmptyRestart = CreateConVar("sm_restart_empty", "1", "Enable restart when empty (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iEmptyRestart = cvEmptyRestart.IntValue;
	
	cvEmptyRestartWait = CreateConVar("sm_restart_empty_wait", "30", "The amount of time to wait after a server is emptied before restarting in seconds (Default = 30)");
	g_iEmptyRestartWait = cvEmptyRestartWait.IntValue;
	
	cvEmptyRestartType = CreateConVar("sm_restart_empty_type", "0", "The type of restart when empty (0 = Map, 1 = Server, Default = 1)", _, true, 0.0, true, 1.0);
	g_iEmptyRestartType = cvEmptyRestartType.IntValue;
	
	cvHourlyRestart = CreateConVar("sm_restart_hourly", "1", "Enable hourly restart (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iHourlyRestart = cvHourlyRestart.IntValue;
	
	cvHourlyRestartWait = CreateConVar("sm_restart_hourly_wait", "30", "The amount of time to wait after an hourly restart is here in seconds (Default = 30)");
	g_iHourlyRestartWait = cvHourlyRestartWait.IntValue;
	
	cvHourlyRestartTime = CreateConVar("sm_restart_hourly_time", "00", "At what minute should the restart happen in 2 digits (Minimum = 00, Maximum = 60, Default = 00)");
	cvHourlyRestartTime.GetString(g_sHourlyRestartTime, sizeof(g_sHourlyRestartTime));
	
	cvHourlyRestartType = CreateConVar("sm_restart_hourly_type", "0", "The type of restart done hourly (0 = Map, 1 = Server, Default = 1)", _, true, 0.0, true, 1.0);
	g_iHourlyRestartType = cvHourlyRestartType.IntValue;
	
	cvHourlyRestartIgnorePlayers = CreateConVar("sm_restart_hourly_ignoreplayers", "0", "Ignore players on hourly restart (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iHourlyRestartIgnorePlayers = cvHourlyRestartIgnorePlayers.IntValue;
	
	cvDailyRestart = CreateConVar("sm_restart_daily", "1", "Enable daily restart (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iDailyRestart = cvDailyRestart.IntValue;
	
	cvDailyRestartWait = CreateConVar("sm_restart_daily_wait", "30", "The amount of time to wait after an daily restart is here in seconds (Default = 30)");
	g_iDailyRestartWait = cvDailyRestartWait.IntValue;
	
	cvDailyRestartTime = CreateConVar("sm_restart_daily_time", "0500", "At what hour and minute should the restart happen in 4 digits (Minimum = 0000, Maximum = 2459, Default = 0500)");
	cvDailyRestartTime.GetString(g_sDailyRestartTime, sizeof(g_sDailyRestartTime));
	
	cvDailyRestartType = CreateConVar("sm_restart_daily_type", "0", "The type of restart done daily (0 = Map, 1 = Server, Default = 1)", _, true, 0.0, true, 1.0);
	g_iDailyRestartType = cvDailyRestartType.IntValue;
	
	cvDailyRestartIgnorePlayers = CreateConVar("sm_restart_daily_ignoreplayers", "0", "Ignore players on daily restart (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iDailyRestartIgnorePlayers = cvDailyRestartIgnorePlayers.IntValue;
	
	cvWeeklyRestart = CreateConVar("sm_restart_weekly", "1", "Enable weekly restart (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iWeeklyRestart = cvWeeklyRestart.IntValue;
	
	cvWeeklyRestartWait = CreateConVar("sm_restart_weekly_wait", "30", "The amount of time to wait after an weekly restart is here in seconds (Default = 30)");
	g_iWeeklyRestartWait = cvWeeklyRestartWait.IntValue;
	
	cvWeeklyRestartTime = CreateConVar("sm_restart_weekly_time", "Sun", "On which day should the restart happen in 3 letters (Default = Sun)");
	cvWeeklyRestartTime.GetString(g_sWeeklyRestartTime, sizeof(g_sWeeklyRestartTime));
	strcopy(g_sWeeklyRestartTime, sizeof(g_sWeeklyRestartTime), StringToLower(g_sWeeklyRestartTime));
	
	cvWeeklyRestartType = CreateConVar("sm_restart_weekly_type", "0", "The type of restart done weekly (0 = Map, 1 = Server, Default = 1)", _, true, 0.0, true, 1.0);
	g_iWeeklyRestartType = cvWeeklyRestartType.IntValue;
	
	cvWeeklyRestartIgnorePlayers = CreateConVar("sm_restart_weekly_ignoreplayers", "0", "Ignore players on weekly restart (0 = No, 1 = Yes, Default = 1)", _, true, 0.0, true, 1.0);
	g_iWeeklyRestartIgnorePlayers = cvWeeklyRestartIgnorePlayers.IntValue;
	
	// hooking cvar changes
	cvRestartMessage.AddChangeHook(OnCvarChanged);
	cvRestartMapMessage.AddChangeHook(OnCvarChanged);
	cvEmptyRestart.AddChangeHook(OnCvarChanged);
	cvEmptyRestartWait.AddChangeHook(OnCvarChanged);
	cvEmptyRestartType.AddChangeHook(OnCvarChanged);
	cvHourlyRestart.AddChangeHook(OnCvarChanged);
	cvHourlyRestartWait.AddChangeHook(OnCvarChanged);
	cvHourlyRestartTime.AddChangeHook(OnCvarChanged);
	cvHourlyRestartType.AddChangeHook(OnCvarChanged);
	cvHourlyRestartIgnorePlayers.AddChangeHook(OnCvarChanged);
	cvDailyRestart.AddChangeHook(OnCvarChanged);
	cvDailyRestartWait.AddChangeHook(OnCvarChanged);
	cvDailyRestartTime.AddChangeHook(OnCvarChanged);
	cvDailyRestartType.AddChangeHook(OnCvarChanged);
	cvDailyRestartIgnorePlayers.AddChangeHook(OnCvarChanged);
	cvWeeklyRestart.AddChangeHook(OnCvarChanged);
	cvWeeklyRestartWait.AddChangeHook(OnCvarChanged);
	cvWeeklyRestartTime.AddChangeHook(OnCvarChanged);
	cvWeeklyRestartType.AddChangeHook(OnCvarChanged);
	cvWeeklyRestartIgnorePlayers.AddChangeHook(OnCvarChanged);
}

// called when a cvar is changed
public int OnCvarChanged(ConVar cvar, const char[] oldValue, const char[] newValue)
{
	// updating cvar values when they change
	if (cvar == cvRestartMessage)
		cvRestartMessage.GetString(g_sRestartMessage, sizeof(g_sRestartMessage));
	
	if (cvar == cvRestartMapMessage)
		cvRestartMapMessage.GetString(g_sRestartMapMessage, sizeof(g_sRestartMapMessage));
	
	if (cvar == cvEmptyRestart)
		g_iEmptyRestart = cvEmptyRestart.IntValue;
	
	if (cvar == cvEmptyRestartWait)
		g_iEmptyRestartWait = cvEmptyRestartWait.IntValue;
	
	if (cvar == cvEmptyRestartType)
		g_iEmptyRestartType = cvEmptyRestartType.IntValue;
	
	if (cvar == cvHourlyRestart)
		g_iHourlyRestart = cvHourlyRestart.IntValue;
	
	if (cvar == cvHourlyRestartWait)
		g_iHourlyRestartWait = cvHourlyRestartWait.IntValue;
	
	if (cvar == cvHourlyRestartTime)
		cvHourlyRestartTime.GetString(g_sHourlyRestartTime, sizeof(g_sHourlyRestartTime));
	
	if (cvar == cvHourlyRestartType)
		g_iHourlyRestartType = cvHourlyRestartType.IntValue;
	
	if (cvar == cvHourlyRestartIgnorePlayers)
		g_iHourlyRestartIgnorePlayers = cvHourlyRestartIgnorePlayers.IntValue;
	
	if (cvar == cvDailyRestart)
		g_iDailyRestart = cvDailyRestart.IntValue;
	
	if (cvar == cvDailyRestartWait)
		g_iDailyRestartWait = cvDailyRestartWait.IntValue;
	
	if (cvar == cvDailyRestartTime)
		cvDailyRestartTime.GetString(g_sDailyRestartTime, sizeof(g_sDailyRestartTime));
	
	if (cvar == cvDailyRestartType)
		g_iDailyRestartType = cvDailyRestartType.IntValue;
	
	if (cvar == cvDailyRestartIgnorePlayers)
		g_iDailyRestartIgnorePlayers = cvDailyRestartIgnorePlayers.IntValue;
	
	if (cvar == cvWeeklyRestart)
		g_iWeeklyRestart = cvWeeklyRestart.IntValue;
	
	if (cvar == cvWeeklyRestartWait)
		g_iWeeklyRestartWait = cvWeeklyRestartWait.IntValue;
	
	if (cvar == cvWeeklyRestartTime)
	{
		cvWeeklyRestartTime.GetString(g_sWeeklyRestartTime, sizeof(g_sWeeklyRestartTime));
		strcopy(g_sWeeklyRestartTime, sizeof(g_sWeeklyRestartTime), StringToLower(g_sWeeklyRestartTime));
	}
	
	if (cvar == cvWeeklyRestartType)
		g_iWeeklyRestartType = cvWeeklyRestartType.IntValue;
	
	if (cvar == cvWeeklyRestartIgnorePlayers)
		g_iWeeklyRestartIgnorePlayers = cvWeeklyRestartIgnorePlayers.IntValue;
}

// called on map load
public void OnMapStart()
{
	// timer functions that run every second
	CreateTimer(1.0, Timer_HourlyRestart, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(1.0, Timer_DailyRestart, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
	CreateTimer(1.0, Timer_WeeklyRestart, _, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
}

// called when a player disconnects
public void OnClientDisconnect(int iClient)
{
	// check if this feature is enabled
	if (g_iEmptyRestart == 1)
	{
		// check if anybody is on the server or is connecting
		if (GetConnectedPlayerCount() == 0)
		{
			// restart
			ExecuteRestart(g_iEmptyRestartType, g_iEmptyRestartWait);
		}
	}
}

// timer function for restarting hourly
public Action Timer_HourlyRestart(Handle hTimer)
{
	// check if this feature is enabled
	if (g_iHourlyRestart == 1)
	{
		// get the current time
		char sTime[8];
		FormatTime(sTime, sizeof(sTime), "%M");
		
		// check the hourly restart time
		if (StrEqual(sTime, g_sHourlyRestartTime))
		{
			// if there is nobody in the server or it should be ignored
			if (GetConnectedPlayerCount() == 0 || g_iHourlyRestartIgnorePlayers == 1)
			{
				// restart
				ExecuteRestart(g_iHourlyRestartType, g_iHourlyRestartWait);
			}
		}
	}
}

// timer function for restarting daily
public Action Timer_DailyRestart(Handle hTimer)
{
	// check if this feature is enabled
	if (g_iDailyRestart == 1)
	{
		// get the current time
		char sTime[8];
		FormatTime(sTime, sizeof(sTime), "%H%M");
		
		// check the daily restart time
		if (StrEqual(sTime, g_sDailyRestartTime))
		{
			// if there is nobody in the server or it should be ignored
			if (GetConnectedPlayerCount() == 0 || g_iDailyRestartIgnorePlayers == 1)
			{
				ExecuteRestart(g_iDailyRestartType, g_iDailyRestartWait);
			}
		}
	}
}

// timer function for restarting weekly
public Action Timer_WeeklyRestart(Handle hTimer)
{
	// check if this feature is enabled
	if (g_iWeeklyRestart == 1)
	{
		// get the current day of the week
		char sTime[6];
		FormatTime(sTime, sizeof(sTime), "%w");
		
		int iTime;
		
		// convert the convar string into int for comparison
		if (StrEqual(g_sWeeklyRestartTime, "sun"))
			iTime = 0;
			
		if (StrEqual(g_sWeeklyRestartTime, "mon"))
			iTime = 1;
			
		if (StrEqual(g_sWeeklyRestartTime, "tue"))
			iTime = 2;
			
		if (StrEqual(g_sWeeklyRestartTime, "wed"))
			iTime = 3;
			
		if (StrEqual(g_sWeeklyRestartTime, "thu"))
			iTime = 4;
			
		if (StrEqual(g_sWeeklyRestartTime, "fri"))
			iTime = 5;
			
		if (StrEqual(g_sWeeklyRestartTime, "sat"))
			iTime = 6;
			
		// check the weekly restart time
		if (StringToInt(sTime) == iTime)
		{
			// if there is nobody in the server or it should be ignored
			if (GetConnectedPlayerCount() == 0 || g_iWeeklyRestartIgnorePlayers == 1)
			{
				// restart
				ExecuteRestart(g_iWeeklyRestartType, g_iWeeklyRestartWait);
			}
		}
	}
}

// function for restarting
// used to notify the server before a restart
// only useful if the plugin ignores player count and there are players in the server
// then they would know a server restart is coming
public void ExecuteRestart(int iType, int iTime)
{
	char sTime[32];
	IntToString(iTime, sTime, sizeof(sTime));
	Format(sTime, sizeof(sTime), "%s seconds", sTime);
	
	char sFormat[256];
	// if it is a map restart then print map restart message
	if (iType == 0)
	{
		// replace {0} with the time left to restart
		strcopy(sFormat, sizeof(sFormat), g_sRestartMapMessage);
		ReplaceString(sFormat, sizeof(sFormat), "{0}", sTime);
		
		// notify the server
		PrintCenterTextAll(sFormat);
		PrintToChatAll(sFormat);
	}
	
	// if it is a server restart then print server restart message
	else
	{
		// replace {0} with the time left to restart
		strcopy(sFormat, sizeof(sFormat), g_sRestartMessage);
		ReplaceString(sFormat, sizeof(sFormat), "{0}", sTime);
		
		// notify the server
		PrintCenterTextAll(sFormat);
		PrintToChatAll(sFormat);
	}
	
	// execute the restart function after wait time
	CreateTimer(view_as<float>(iTime), Timer_Restart, iType, TIMER_FLAG_NO_MAPCHANGE);
}

// timer function for restart
public Action Timer_Restart(Handle hTimer, int iType)
{
	// if it is a map restart
	if (iType == 0)
	{
		// get the next map name
		char sMap[128];
		GetNextMap(sMap, sizeof(sMap));
		
		// if the map is valid
		if (IsMapValid(sMap))
		{
			// change the server to the next map
			ServerCommand("changelevel %s", sMap);
		}
		
		// otherwise - probably if the server is a single map server
		else
		{
			// restart the map
			GetCurrentMap(sMap, sizeof(sMap));
			ServerCommand("changelevel %s", sMap);
		}
	}
	
	// then it is a server restart
	else
	{
		// attempt to reconnect every client
		for (int i = 1; i <= MaxClients; i++)
			if (IsValidClient(i) && !IsFakeClient(i))
				FakeClientCommand(i, "retry");
				
		ServerCommand("_restart");
	}
	
	return Plugin_Handled;
}

// stock for converting a string to lower case
stock char StringToLower(char[] sFormat)
{
	for (int i = 0; i < strlen(sFormat); i++)
	{
		if (sFormat[i] != '\0') {
			sFormat[i] = CharToLower(sFormat[i]);
		}
	}
	
	return sFormat;
}

// stock for getting the number of players connected in the server
stock int GetConnectedPlayerCount()
{
	int iCount;
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientConnected(i) && !IsFakeClient(i))
			iCount++;
	}
	return iCount;
}

// stock for checking if a client is valid
stock bool IsValidClient(int iClient, bool bReplay = true)
{
	if (iClient <= 0 || iClient > MaxClients || !IsClientInGame(iClient))
		return false;
	if (bReplay && (IsClientSourceTV(iClient) || IsClientReplay(iClient)))
		return false;
	return true;
}


// plugin information
public Plugin myinfo = 
{
	name 			= 	"Titan 2 - Server Refresh",
	description 	= 	"All inclusive server restart features in one plugin, ensures your server is always refreshed and prepared for the next load.",
	author 			= 	"myst",
	version 		= 	"2.0",
}