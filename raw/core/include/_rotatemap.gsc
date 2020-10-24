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

 ForceNextMap(sMapName, iMapIndex)
{
	game["nextMap"] = sMapName;
	game["nextMapIndex"] = iMapIndex;
	game["isNextMapForced"] = true;
}

 ForceNextGameType(sMapName)
{
	game["nextGameType"] = sMapName;
	game["isNextGameTypeForced"] = true;
}

 SetNextMap(sMapName, iMapIndex)
{
	if (!IsDefined(game["isNextMapForced"]))
	{
		game["nextMap"] = sMapName;
		game["nextMapIndex"] = iMapIndex;
	}
}

 SetNextGameType(sMapName)
{
	if (!IsDefined(game["isNextGameTypeForced"]))
		game["nextGameType"] = sMapName;
}

 GetNextMap()
{
	return game["nextMap"];
}

/// <summary>
/// 
/// </summary>
/// <returns>Int - undefined if has not set</returns>
 GetCurMapIndex()
{
	sValue = GetDvar("curMapIndex");
	if (sValue != "")
		return Int(sValue);
		
	return undefined;
}

 GetNextMapIndex()
{
	return game["nextMapIndex"];
}

 GetNextGameType()
{
	return game["nextGameType"];
}

 RunNextMap()
{
	sMapName = GetNextMap();
	core\include\_exception::Undefined(sMapName, "Next map has not been set!");
	
	RunMap(sMapName, GetNextGameType(), GetNextMapIndex());
}

 RunMap(sMapName, sGameType, iMapIndex)
{
	if (!IsDefined(sGameType))
		sGameType = core\include\_game::GetGameType();

	SetDvar("sv_mapRotationCurrent", "gametype " + sGameType + " map " + sMapName); 
	
	sMapIndex = "";
	if (IsDefined(iMapIndex))
		sMapIndex = iMapIndex;
	
	SetDvar("curMapIndex", sMapIndex);
	
	ExitLevel(false);
}

// =================================================================================== //


 IgnoredMaps_Create()
{
	ignoredMaps = SpawnStruct();
	ignoredMaps.Indexes = [];
	
	ignoredMaps IgnoredMaps_LoadFromDvar();
	
	return ignoredMaps;
}

 IgnoredMaps_Add(iMapIndex)
{
	self.Indexes[self.Indexes.size] = iMapIndex;
}

 IgnoredMaps_Ensure(iCapacity)
{
	iRemoveCount = (self.Indexes.size - iCapacity);
	if (iRemoveCount > 0)
		self.Indexes = core\include\array\_array::RemoveRange(self.Indexes, 0, iRemoveCount);
}

 IgnoredMaps_GetIndexes()
{
	return self.Indexes;
}

 IgnoredMaps_Save()
{
	self IgnoredMaps_SaveToDvar();
}

 IgnoredMaps_LoadFromDvar()
{
	dvarValue = GetDvar("ignoredMaps");
	if (dvarValue == "")
		return;
		
	toks = StrTok(dvarValue, ";");
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < toks.size; foreachg45e74f_0++)
	{ tok = toks[foreachg45e74f_0];
		if (tok == "")
			continue;
	
		self IgnoredMaps_Add(Int(tok));
	}
}

 IgnoredMaps_SaveToDvar()
{
	value = "";
	if (self.Indexes.size > 0)
		value = core\include\_string::Join(";", self.Indexes);
		
	SetDvar("ignoredMaps", value);
}


// =================================================================================== //