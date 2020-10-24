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

/// <summary>
/// Returns -1 if a < b
/// Returns 0 if a == b
/// Returns 1 if a > b
/// </summary>
/// <returns></returns>
/// <param name="a"></param>
/// <param name="b"></param>
GreaterInt(a, b)
{
	if (a < b)
		return -1;
	else if (a > b)
		return 1;
	
	return 0;
}

/// <summary>
/// Returns -1 if a > b
/// Returns 0 if a == b
/// Returns 1 if a < b
/// </summary>
/// <returns></returns>
/// <param name="a"></param>
/// <param name="b"></param>
LessInt(a, b)
{
	if (a > b)
		return -1;
	else if (a < b)
		return 1;
	
	return 0;
}