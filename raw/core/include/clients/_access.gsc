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
// Mod      : Deathrun
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include core\include\_usings;










/// <summary>
/// Gets player's access level.
/// </summary>
/// <self>Player</self>
/// <returns>Int</returns>
GetLevel()
{
	return self.iAccessLevel;
}

/// <summary>
/// Sets player's access level.
/// </summary>
/// <self>Player</self>
/// <param name="value">Int</param>
SetLevel(value)
{
	self.iAccessLevel = value;
}

ToString(value)
{
	switch (value)
	{
		case 0:
			return "Guest";
		case 1:
			return "Member";
		case 6:
			return "Donator";
		case 10:
			return "VIP";
		case 40:
			return "Junior Admin";
		case 60:
			return "Admin";
		case 80:
			return "Super Admin";
		case 100:
			return "Server Admin";
		default:
			core\include\_exception::ArgumentMsg("Unknown AccessLevel '" + value + "'");
			return undefined;
	}
}