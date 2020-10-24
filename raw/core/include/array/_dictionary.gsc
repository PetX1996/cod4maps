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

 Create()
{
	dic = SpawnStruct();
	
	dic.Elems = [];
	
	return dic;
}

 CreateCopy()
{
	dic = Create();
	dic.Elems = self.Elems;
	
	return dic;
}

 ToDicArray()
{
	return self.Elems;
}

/// <summary>
/// Adds a value with a specified key to the dictionary.
/// </summary>
/// <param name="key">Int/String</param>
/// <param name="value">T</param>
 Add(key, value)
{
	//IEXCEPTION::Undefined(key, "key");

	self.Elems[key] = value;
}

/// <summary>
/// Adds a range of values with specified keys to the dictionary.
/// </summary>
/// <param name="dicArray">T[]</param>
 AddRange(dicArray)
{
	core\include\_exception::Undefined(dicArray, "dicArray");
	
	keys = GetArrayKeys(dicArray);
	for (i = 0; i < keys.size; i++)
		self.Elems[keys[i]] = dicArray[keys[i]];
}

/// <summary>
/// Adds a range of values with specified keys to the dictionary.
/// </summary>
/// <param name="dic">Dictionary</param>
 AddDic(dic)
{
	core\include\_exception::Undefined(dic, "dic");
	
	keys = GetArrayKeys(dic.Elems);
	for (i = 0; i < keys.size; i++)
		self.Elems[keys[i]] = dic.Elems[keys[i]];
}

/// <summary>
/// Gets dictionary's keys.
/// </summary>
/// <returns>Int[]/String[]</returns>
 GetKeys()
{
	return GetArrayKeys(self.Elems);
}

/// <summary>
/// Gets dictionary's values indexed from zero.
/// </summary>
/// <returns>T[]</returns>
 GetValues()
{
	keys = GetArrayKeys(self.Elems);
	values = [];
	for (i = 0; i < keys.size; i++)
		values[values.size] = self.Elems[keys[i]];
		
	return values;
}

/// <summary>
/// Returns key corresponding to specified value.
/// Returns undefined if dictionary does not contain specified value.
/// </summary>
/// <returns>Int/String</returns>
/// <param name="value">T</param>
 KeyOf(value)
{
	core\include\_exception::Undefined(value, "value");

	keys = GetArrayKeys(self.Elems);
	for (i = 0; i < keys.size; i++)
		if (self.Elems[keys[i]] == value)
			return keys[i];
			
	return undefined;
}

/// <summary>
/// Determines whether dictionary contains specified key.
/// </summary>
/// <returns>Bool</returns>
/// <param name="key">Int/String</param>
 ContainsKey(key)
{
	core\include\_exception::Undefined(key, "key");
	
	return IsDefined(self.Elems[key]);
}

/// <summary>
/// Determines whether dictionary contains specified value.
/// </summary>
/// <returns>Bool</returns>
/// <param name="value">T</param>
 ContainsValue(value)
{
	core\include\_exception::Undefined(value, "value");
	
	return IsDefined(self KeyOf(value));
}

 Get(key)
{
	return self.Elems[key];
}

/// <summary>
/// Returns a value for specified index.
/// Throws an exception if dictionary does not contain the key.
/// </summary>
/// <returns>T</returns>
/// <param name="key">Int/String</param>
 GetValue(key)
{
	core\include\_exception::Undefined(key, "key");
	core\include\_exception::Argument(IsDefined(self.Elems[key]), "key");
	
	return self.Elems[key];
}

/// <summary>
/// Returns a value for specified index.
/// Returns defaultValue if dictionary does not contain the key.
/// </summary>
/// <returns>T</returns>
/// <param name="key">Int/String</param>
/// <param name="defaultValue">T</param>
 GetValueOrDefault(key, defaultValue)
{
	core\include\_exception::Undefined(key, "key");
	
	value = self.Elems[key];
	if (IsDefined(value))
		return value;
		
	return defaultValue;
}