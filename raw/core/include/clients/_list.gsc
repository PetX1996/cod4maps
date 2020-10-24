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

/// <summary>
/// Gets all players in the game.
/// </summary>
/// <returns>Player[]</returns>
/// <param name="isAlive">Bool</param>
/// <param name="team">String</param>
 GetAllPlayers(isAlive, team)
{
	players = undefined;
	if (IsDefined(team))
	{
		if (team == "allies")
			players = level._alliesPlayers;
		else if (team == "axis")
			players = level._axisPlayers;
		else if (team == "spectator")
			players = level._spectatorPlayers;
		else
			core\include\_exception::ArgumentMsg("team");
	}
	else
		players = level.players;

	if (IsDefined(isAlive) && isAlive)
		return FilterAlivePlayers(players);
	
	return players;
}

/// <summary>
/// Gets all players in any playing team.
/// </summary>
/// <returns>Player[]</returns>
/// <param name="isAlive">Bool</param>
/// <param name="team">String</param>
 GetAllPlayingPlayers(isAlive, team)
{
	players = undefined;
	if (IsDefined(team))
	{
		if (team == "allies")
			players = level._alliesPlayers;
		else if (team == "axis")
			players = level._axisPlayers;
		else
			core\include\_exception::ArgumentMsg("team");
	}
	else
		players = core\include\array\_array::AddRange(level._alliesPlayers, level._axisPlayers);
		
	if (IsDefined(isAlive) && isAlive)
		return FilterAlivePlayers(players);
	
	return players;
}

/// <summary>
/// Gets all players in team ALLIES.
/// </summary>
/// <returns>Player[]</returns>
/// <param name="isAlive">Bool</param>
 GetAllAllies(isAlive)
{
	if (IsDefined(isAlive) && isAlive)
		return FilterAlivePlayers(level._alliesPlayers);
	
	return level._alliesPlayers;
}

/// <summary>
/// Gets all players in team AXIS.
/// </summary>
/// <returns>Player[]</returns>
/// <param name="isAlive">Bool</param>
 GetAllAxis(isAlive)
{
	if (IsDefined(isAlive) && isAlive)
		return FilterAlivePlayers(level._axisPlayers);
	
	return level._axisPlayers;
}

/// <summary>
/// Gets all players in team SPECTATOR.
/// </summary>
/// <returns>Player[]</returns>
 GetAllSpectators()
{
	return level._spectatorPlayers;
}

 FilterAlivePlayers(players)
{
	alives = [];
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < players.size; foreachg45e74f_0++)
	{ player = players[foreachg45e74f_0]; if (IsAlive(player))
			alives[alives.size] = player; }
		
	return alives;
}