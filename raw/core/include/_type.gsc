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

 // b
 // i
 // f
 // d

 // v

 // s


 // e
 // p


StrToInt(str)
{
	if (!IsDefined(str))
		return;

	return Int(str);
}

StrToFloat(str)
{
	if (!IsDefined(str))
		return;

	SetDvar("StrToFloat", str);
	return GetDvarFloat("StrToFloat");
}

StrToVec(str)
{
	if (!IsDefined(str))
		return;

	defaultVal = (0,0,0);
	
	startI = core\include\_string::IndexOf(str, "(");
	if (startI == -1) return defaultVal;
	
	firstColumnI = core\include\_string::IndexOf(str, ",", startI + 1);
	if (firstColumnI == -1) return defaultVal;
	
	secondColumnI = core\include\_string::IndexOf(str, ",", firstColumnI + 1);
	if (secondColumnI == -1) return defaultVal;
	
	endI = core\include\_string::IndexOf(str, ")", secondColumnI + 1);
	if (endI == -1) return defaultVal;
	
	first = core\include\_string::Trim(GetSubStr(str, startI + 1, firstColumnI));
	second = core\include\_string::Trim(GetSubStr(str, firstColumnI + 1, secondColumnI));
	third = core\include\_string::Trim(GetSubStr(str, secondColumnI + 1, endI));
	return (StrToFloat(first), StrToFloat(second), StrToFloat(third));
}

IntToStr(int)
{
	if (!IsDefined(int))
		return;

	return "" + int;
}

FloatToStr(float)
{
	if (!IsDefined(float))
		return;

	return "" + float;
}

VecToStr(vec)
{
	if (!IsDefined(vec))
		return;

	return "(" + vec[0] + ", " + vec[1] + ", " + vec[2] + ")";
}

FloatToInt(float)
{
	if (!IsDefined(float))
		return;

	return Int(float);
}

 IsEqual(a, b)
{
	if (!IsDefined(a) && !IsDefined(b))
		return true;
	else if (IsDefined(a) && !IsDefined(b))
		return false;
	else if (!IsDefined(a) && IsDefined(b))
		return false;
	else
		return a == b;
}