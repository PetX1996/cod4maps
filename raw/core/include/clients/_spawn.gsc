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

 RegisterSpawnPoints(team, keyValue, keyName, dropToGround)
{
	if(!IsDefined(level.Spawns))
		level.Spawns = [];

	if(!IsDefined(level.Spawns[team]))
		level.Spawns[team] = [];
		
	spawnPoints = GetEntArray(keyValue, keyName);
	for(foreachg45e74f_0 = 0; foreachg45e74f_0 < spawnPoints.size; foreachg45e74f_0++)
	{ spawnPoint = spawnPoints[foreachg45e74f_0];
		if(dropToGround)
			spawnPoint PlaceSpawnPoint();
			
		level.Spawns[team][level.Spawns[team].size] = spawnPoint;
	}
}

 CheckSpawnPoints(sTeam)
{
	if(GetSpawnPointsCount(sTeam, false) == 0)
	{
		level.Spawns[sTeam][0] = CreateFakeSpawnPoint((0, 0, 0), (0, 0, 0), false);
		//MapError( "Spawns - Could not load any spawnPoints for \'" + sTeam + "\', gameType \'" + level.gametype + "\'" );
	}
}

 CreateFakeSpawnPoint(sClassName, vOrigin, vAngles, bDropToGround)
{
	if (IsDefined(bDropToGround) && bDropToGround)
	{
		eOrigin = Spawn("script_origin", vOrigin);
		eOrigin PlaceSpawnPoint();
		vOrigin = eOrigin.origin;
		eOrigin Delete();
	}
	
	spawn = SpawnStruct();
	spawn.bIsFake = true;
	spawn.classname = sClassName;
	spawn.origin = vOrigin;
	spawn.angles = vAngles;
	return spawn;
}

 GetSpawnPoints(team)
{
	return level.Spawns[team];
}

 GetSpawnPointsCount(sTeam, bIgnoreFaked)
{
	if (IsDefined(bIgnoreFaked) && bIgnoreFaked)
		return level.Spawns[sTeam].size - level.MF.S_iLastSize[sTeam];
	else
		return level.Spawns[sTeam].size;
}


 IsSpawnPointFree(spawnPoint)
{
	for(foreachg45e74f_1 = 0; foreachg45e74f_1 < level.players.size; foreachg45e74f_1++)
	{ player = level.players[foreachg45e74f_1];
		if(!IsAlive(player) || player.pers["team"] == "spectator")
			continue;
		
		if(DistanceSquared(spawnPoint.origin, player.origin) < 4096)
			return false;
	}
	return true;
}

 GetRandomFreeSpawnPoint(spawnPoints)
{
	startIndex = RandomInt(spawnPoints.size);
	i = startIndex;
	doWhileJHS8G8AW9_2 = true; while (doWhileJHS8G8AW9_2 || i != startIndex)
	{ doWhileJHS8G8AW9_2 = false;
		if(IsSpawnPointFree(spawnPoints[i]))
			return spawnPoints[i];
		
		i = (i + spawnPoints.size + 1) % spawnPoints.size;
	}
	
	
	return spawnPoints[RandomInt(spawnPoints.size)];
}