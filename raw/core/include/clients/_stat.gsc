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

 GetById(id)
{
	return self GetStat(id);
}

 GetByName(name)
{
	return self GetStat(GetIdByName(name));
}

 SetById(id, value)
{
	self SetStat(id, value);
}

 SetByName(name, value)
{
	self SetById(GetIdByName(name), value);
}

 AddById(id, inc)
{
	self SetStat(id, self GetStat(id) + inc);
}

 AddByName(name, inc)
{
	self AddById(GetIdByName(name), inc);	
}

 GetIdByName(name)
{
	sStatId = TableLookup("mp/playerStatsTable.csv", 1, name, 0);
	core\include\_exception::EmptyString(sStatId.size, "Could not find '" + name + "' in playerStatsTable.csv");
	return Int(sStatId);
}