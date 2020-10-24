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

 GetPlayerViewPos()
{
	if (self.pers["team"] == "spectator")
		return self.Origin;
	else
	{
		stance = self GetStance();
		if (stance == "stand") 			return self.Origin + (0,0,60);
		else if (stance == "crouch") 	return self.Origin + (0,0,40);
		else 							return self.Origin + (0,0,11);
	}
}

 GetPlayerHeight()
{
	if (self.pers["team"] == "spectator")
		return 0;
	else
	{
		stance = self GetStance();
		if (stance == "stand") 			return 70.125;
		else if (stance == "crouch") 	return 50.125;
		else 							return 30.125;
	}
}

 GetPlayerCenterPos()
{
	if (self.pers["team"] == "spectator")
		return self.Origin;
	else
		return self.Origin + (0, 0, self GetPlayerHeight() * 0.5);
}

 GetPlayerLookVector()
{
	angles = self GetPlayerAngles();
	return AnglesToForward(angles);
}


/*public IsPlayerLookingAtPoint(point)
{
IEXCEPTION::NotImplemented();
}

public IsPlayerLookingAtSphere(origin, radius)
{
IEXCEPTION::NotImplemented();
}

public IsPlayerLookingAtCylinder(origin, radius, height)
{
IEXCEPTION::NotImplemented();
}

public IsPlayerLookingAtCuboid(origin, measurement)
{
IEXCEPTION::NotImplemented();
}


public IsLookingAtPoint(eOrigin, eAngles, point)
{
IEXCEPTION::NotImplemented();
}

public IsLookingAtSphere(eOrigin, eAngles, origin, radius)
{
IEXCEPTION::NotImplemented();
}

public IsLookingAtCylinder(eOrigin, eAngles, origin, radius, height)
{
IEXCEPTION::NotImplemented();
}

public IsLookingAtCuboid(eOrigin, eAngles, origin, measurement)
{
IEXCEPTION::NotImplemented();
}*/