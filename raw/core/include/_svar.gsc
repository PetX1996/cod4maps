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

// moûnosù upravovaù z mapy + reset pri znovunaËÌtanÌ
// + moûnosù nastaviù hodnoty pre konkrÈtnu mapu

// vöetko uloûenÈ ako dvary -> nepouûÌvaù script premennÈ!!
// <dvarName> - s˙Ëasn· hodnota -> vracia a nastavuje sa cez Set()
// scr_<dvarName> - dvar v configu pre vöetky gametypes
// deathrun_<dvarName> - dvar v configu pre gametype DEATHRUN
// <mapName>_<dvarName> - dvar v configu pre s˙Ëasn˙ mapu
// all_<dvarName> - dvar v configu pre vöetky mapy

// PRIORITY
// ================================================
// scr_<dvarName>
// deathrun_<dvarName>
// <- HERE MAPPER MIGHT CHANGE VALUE FROM MAP GSC 
// <mapName>_<dvarName>
// all_<dvarName>
// ================================================

 GetAsStr(name)
{
	return GetDvar(name);
}

 GetAsInt(name)
{
	return GetDvarInt(name);
}

 GetAsBool(name)
{
	return GetDvarInt(name);
}

 GetAsFloat(name)
{
	return GetDvarFloat(name);
}

/// <summary>
/// Sets a value of existing SVAR. 
/// </summary>
/// <param name="name">String</param>
/// <param name="value">T</param>
 Set(name, value)
{
	SetDvar(name, value);
}

/// <summary>
/// Initiliazes a SVAR with specified name or update by current map.
/// isInit = True - Primary gets from dvar currentGameType + "_" + name, 
/// secondary gets from dvar "scr_" + name.
/// isInit = False - Updates existing SVAR from dvar currentMapName + "_" + name.
/// </summary>
/// <param name="isInit">Bool</param>
/// <param name="name">String</param>
/// <param name="type">TYPE::TYPE</param>
/// <param name="defaultValue">T</param>
/// <param name="minValue">T</param>
/// <param name="maxValue">T</param>
 Init(isInit, name, type, defaultValue, minValue, maxValue)
{
	if (isInit)
		InitFirst(name, type, defaultValue, minValue, maxValue);
	else
		UpdateByMap(name, type, minValue, maxValue);
}

/// <summary>
/// Initiliazes a SVAR with specified name.
/// Primary gets from dvar currentGameType + "_" + name, 
/// secondary gets from dvar "scr_" + name.
/// </summary>
/// <param name="name">String</param>
/// <param name="type">TYPE::TYPE</param>
/// <param name="defaultValue">T</param>
/// <param name="minValue">T</param>
/// <param name="maxValue">T</param>
 InitFirst(name, type, defaultValue, minValue, maxValue)
{
	dvarName = core\include\_game::GetGameType() + "_" + name;
	dvarValue = GetDvar(dvarName);
	if (dvarValue == "")
	{
		dvarName = "scr_" + name;
		dvarValue = GetDvar(dvarName);
	}
	
	dvarValue = GetRightValue(dvarName, dvarValue, type, defaultValue, minValue, maxValue);
	SetDvar(name, dvarValue);
}

/// <summary>
/// Updates existing SVAR from dvar currentMapName + "_" + name.
/// </summary>
/// <param name="name">String</param>
/// <param name="type">TYPE::TYPE</param>
/// <param name="minValue">T</param>
/// <param name="maxValue">T</param>
 UpdateByMap(name, type, minValue, maxValue)
{
	dvarName = "all_" + name;
	dvarValue = GetDvar(dvarName);
	if (dvarValue == "")
	{
		dvarName = core\include\_game::GetMap() + "_" + name;
		dvarValue = GetDvar(dvarName);
	}

	if (dvarValue != "")
	{
		dvarValue = GetRightValue(dvarName, dvarValue, type, undefined, minValue, maxValue);
		if (IsDefined(dvarValue))
			SetDvar(name, dvarValue);
	}
}

 GetRightValue(dvarName, strValue, type, defaultValue, minValue, maxValue)
{
	if (strValue == "")
		return defaultValue;

	value = strValue;
	if (type == 0)
	{
		value = GetDvarInt(dvarName);
		if (value != 0 && value != 1)
			value = defaultValue;
	}
	else if (type == 1 || type == 2)
	{
		value = GetDvarInt(dvarName);
		if ((IsDefined(minValue) && value < minValue) 
			|| (IsDefined(maxValue) && value > maxValue))
			value = defaultValue;
	}
	return value;
}