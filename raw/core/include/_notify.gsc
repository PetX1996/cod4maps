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
/// Waittills for any of these notifies.
/// </summary>
WaittillAny(n1, n2, n3, n4, n5, n6, n7, n8, n9)
{
	if (IsDefined(n9)) self endon(n9);
	if (IsDefined(n8)) self endon(n8);
	if (IsDefined(n7)) self endon(n7);
	if (IsDefined(n6)) self endon(n6);
	if (IsDefined(n5)) self endon(n5);
	if (IsDefined(n4)) self endon(n4);
	if (IsDefined(n3)) self endon(n3);
	if (IsDefined(n2)) self endon(n2);
	
	self waittill(n1);
}

WaittillAll(n1, n2, n3, n4, n5, n6, n7, n8, n9)
{
	core\include\_exception::NotImplemented();
}

/// <summary>
/// Waittills for a notify or ends after time.
/// </summary>
/// <returns>Returns TRUE if time elapses, otherwise returns UNDEFINED</returns>
/// <param name="time">Int - seconds</param>
/// <param name="n">String</param>
WaittillTime(time, n)
{
	self endon(n);
	
	wait time;
	return true;
}

/// <summary>
/// Waittills for any notify or ends after time.
/// </summary>
/// <returns>Returns TRUE if time elapses, otherwise returns UNDEFINED</returns>
/// <param name="time">Int - seconds</param>
WaittillAnyTime(time, n1, n2, n3, n4, n5, n6, n7, n8, n9)
{
	if (IsDefined(n9)) self endon(n9);
	if (IsDefined(n8)) self endon(n8);
	if (IsDefined(n7)) self endon(n7);
	if (IsDefined(n6)) self endon(n6);
	if (IsDefined(n5)) self endon(n5);
	if (IsDefined(n4)) self endon(n4);
	if (IsDefined(n3)) self endon(n3);
	if (IsDefined(n2)) self endon(n2);
	self endon(n1);
	
	wait time;
	return true;
}

WaittillAllTime(time, n2, n3, n4, n5, n6, n7, n8, n9)
{
	core\include\_exception::NotImplemented();
}