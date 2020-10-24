//I========================================================================I
//I                    ___  _____  _____                                   I
//I                   /   !!  __ \!  ___!                                  I
//I                  / /! !! !  \/! !_          ___  ____                  I
//I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//I                     !_/ \____/\_!     (_)  \___!/___!                  I
//I                                                                        I
//I========================================================================I
// Call of Duty 4: Modern Warfare
//I========================================================================I
// Mod      : Core
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include core\include\_usings;







 IsEnabled()
{
	return core\include\_svar::GetAsBool("LEnable");
}

 WaitForMorePlayers(playersNeeded)
{
	while (true)
	{
		wait 1;

		if (IsEnoughPlayers(playersNeeded))
			return true;

		UpdatePlayersHud("Waiting for more players");
	}
}

 IsEnoughPlayers(playersNeeded)
{
	return core\include\clients\_list::GetAllPlayingPlayers(true).size >= playersNeeded;
}

 CreatePlayersTimer(timeInSeconds, team, message, timerBarSize)
{
	endTime = GetTime() + (timeInSeconds * 1000);
	while (GetTime() < endTime)
	{
		UpdatePlayersHud(message, team, (endTime - GetTime()) / 1000, timerBarSize);
		wait 0.1;
	}
}

 UpdatePlayersHud(text, team, timeInSeconds, timerBarSize)
{
	players = core\include\clients\_list::GetAllPlayingPlayers(true, team);
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < players.size; foreachg45e74f_0++)
	{ player = players[foreachg45e74f_0]; player UpdatePlayerHud(text, timeInSeconds, timerBarSize); }
}

 UpdatePlayerHud(text, timeInSeconds, timerBarSize)
{
	if (IsDefined(self._gameLogicHud) && self._gameLogicHud == text)
		return;
		
	self._gameLogicHud = text;
	
	if (IsDefined(timeInSeconds))
		self core\include\clients\_hud::SetLowerTextAndTimer(text, timeInSeconds, timerBarSize);
	else
		self core\include\clients\_hud::SetLowerText(text);
}

 FreezeTeam(state, team)
{
	if (state)
	{
		if (!IsDefined(team) || team == "allies")
			level._isAlliesFreezed = true;
		
		if (!IsDefined(team) || team == "axis")
			level._isAxisFreezed = true;
	}
	else
	{
		if (!IsDefined(team) || team == "allies")
			level._isAlliesFreezed = undefined;
		
		if (!IsDefined(team) || team == "axis")
			level._isAxisFreezed = undefined;
	}

	players = core\include\clients\_list::GetAllPlayingPlayers(true, team);
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < players.size; foreachg45e74f_1++)
	{ player = players[foreachg45e74f_1];
		player core\include\clients\_player::FreezeMove(state);
		
		if (state)
			player DisableWeapons();
		else
			player EnableWeapons();
	}
}

 IsTeamFreezed(team)
{
	return (team == "allies" && IsDefined(level._isAlliesFreezed))
		|| (team == "axis" && IsDefined(level._isAxisFreezed));
}

/// <summary>
/// Resets the game timer.
/// </summary>
 TimerReset()
{
	TimerSet(0);
}

/// <summary>
/// Sets the game timer to a specified time in seconds.
/// </summary>
/// <param name="timeInSeconds">Int - seconds</param>
 TimerSet(iTimeInSeconds)
{	
	iTimeInSeconds = Int(iTimeInSeconds);
	
	level.GameTimerStart = GetTime();
	level.GameTimerTimeLimit = Int(iTimeInSeconds);
	level.GameTimerEnd = Int(GetTime() + (iTimeInSeconds * 1000));
	
	if (iTimeInSeconds == 0)
		SetGameEndTime(0);
	else
		SetGameEndTime(level.GameTimerEnd);
}

/// <summary>
/// Returns remaining time in seconds.
/// Returns 0 if timer has done.
/// </summary>
/// <returns>Int - seconds</returns>
 GetTimerRemainingTime()
{
	remainingMs = level.GameTimerEnd - GetTime();
	if (remainingMs < 0)
		return 0;
		
	return Int(remainingMs / 1000);
}

 PreMatchGame()
{
	SetGameState(15);
	core\include\_logic::TimerReset();
	
	game["state"] = "playing";
}

 StartGame(timeLimit)
{
	//level.roundStarted = true;
	level notify("start_round");
	//scripts\_events::RunCallback( level, "onStartRound", 1 );
	level.LStartGameTime = GetTime();
	
	//SetGameState(STATE_STARTED_MASK);
	core\include\_logic::TimerReset();
	if (IsDefined(timeLimit))
		core\include\_logic::TimerSet(timeLimit);
	
	core\_init::RunOnLGameStarted();
}

 GetStartGameTime()
{
	return level.LStartGameTime;
}

 EndGame(iType, sWinningTeam, pWinner)
{
	SetGameState(3840);
	core\include\_logic::TimerReset();
	
	game["state"] = "postgame";
	level notify("game_ended");
	
	args = core\include\_eventCallback::Args_Create();
	args.iType = iType;
	args.sWinningTeam = sWinningTeam;
	args.pWinner = pWinner;
	core\_init::RunOnLGameEnded(args);
}

 FinishRound()
{
	core\_init::RunInLRoundFinished();
	
	Map_Restart(true);
}

 FinishMap()
{
	core\_init::RunInLRoundFinished();
	core\_init::RunInLMapFinished();
	
	core\include\_rotatemap::RunNextMap();
}



















/// <summary>
/// Sets the current game state. 
/// </summary>
/// <param name="state">STATE</param>
/// <param name="team">String</param>
 SetGameState(state, team)
{
	if (!IsDefined(level._gameState))
		level._gameState = [];
	
	if (!IsDefined(team))
	{
		SetGameState(state, "allies");
		SetGameState(state, "axis");
	}
	else
	{
		level._gameState[team] = state;
	}
}

/// <summary>
/// Gets the current game state. You can compare its with specific STATE
/// or use BIT AND to compare its with the masks for group of states.
/// </summary>
/// <returns>STATE</returns>
/// <param name="team">String</param>
 GetGameState(team)
{
	if (!IsDefined(level._gameState))
		level._gameState = [];

	if (!IsDefined(team)) team = "allies";
	return level._gameState[team];
}

/// <summary>
/// Determines whether current game state is PREMATCH.
/// </summary>
/// <returns>Bool</returns>
/// <param name="team">String</param>
 IsGameStatePreMatch(team)
{
	if (!IsDefined(team))
		return (GetGameState("allies") & 15)
			|| (GetGameState("axis") & 15);
	else
		return GetGameState(team) & 15;
}

/// <summary>
/// Determines whether current game state is STARTED.
/// </summary>
/// <returns>Bool</returns>
/// <param name="team">String</param>
 IsGameStateStarted(team)
{
	if (!IsDefined(team))
		return (GetGameState("allies") & 240)
			|| (GetGameState("axis") & 240);
	else
		return GetGameState(team) & 240;
}

/// <summary>
/// Determines whether current game state is ENDED.
/// </summary>
/// <returns>Bool</returns>
/// <param name="team">String</param>
 IsGameStateEnded(team)
{
	if (!IsDefined(team))
		return (GetGameState("allies") & 3840)
			|| (GetGameState("axis") & 3840);
	else
		return GetGameState(team) & 3840;
}
