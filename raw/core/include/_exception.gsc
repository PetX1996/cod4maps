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

 ThrowScripts()
{
	array = [];
	for (i = 0; ; i++)
		array[i] = 0;
}

 PrintToOutputs(message)
{
	PrintLn(message);
	IPrintLnBold(message);
	LogPrint(message + "\n");
}

/// <summary>
/// Throws script with the given message
/// </summary>
/// <param name="msg"></param>
/// <param name="optionalMsg"></param>
 ScrAssertMsg(msg, optionalMsg)
{
	if (IsDefined(optionalMsg))
		msg += " -> " + optionalMsg;
	
	// developer-only
	AssertMsg(msg);
	
	// server and developer
	PrintToOutputs("=================");
	PrintToOutputs("=================");
	PrintToOutputs("ASSERT");
	PrintToOutputs("=================");
	PrintToOutputs(msg);
	PrintToOutputs("=================");
	PrintToOutputs("=================");
	
	ThrowScripts();
}

/// <summary>
/// Throws script if a condition is false.
/// </summary>
/// <param name="condition"></param>
 ScrAssert(condition)
{
	if (!condition)
		ScrAssertMsg("");
}

/// <summary>
/// Throws script with the given message if a condition is false.
/// </summary>
/// <param name="condition"></param>
/// <param name="msg"></param>
/// <param name="optionalMsg"></param>
 ScrAssertEx(condition, msg, optionalMsg)
{
	if (!condition)
		ScrAssertMsg(msg, optionalMsg);
}

/// <summary>
/// Throws script if an index is lower than zero, higher or equal to array.size - 1.
/// </summary>
/// <param name="size"></param>
/// <param name="index"></param>
/// <param name="msg"></param>
 OutOfRange(size, index, msg)
{
	ScrAssertEx(index >= 0 && index < size, "OutOfRangeException", msg);
}

 OutOfRangeMsg(msg)
{
	ScrAssertMsg("OutOfRangeException", msg);
}

/// <summary>
/// Throws script if a size is zero.
/// </summary>
/// <param name="size"></param>
/// <param name="msg"></param>
 EmptyArray(size, msg)
{
	ScrAssertEx(size > 0, msg);
}

/// <summary>
/// Throws script if a size is zero.
/// </summary>
/// <param name="size"></param>
/// <param name="msg"></param>
 EmptyString(size, msg)
{
	ScrAssertEx(size > 0, msg);
}

/// <summary>
/// Throws script if a var is undefined.
/// </summary>
/// <param name="var"></param>
/// <param name="msg"></param>
 Undefined(var, msg)
{
	ScrAssertEx(IsDefined(var), "UndefinedException", msg);
}

/// <summary>
/// Throws script if condition is defined and it is false, or if it is undefined.
/// </summary>
/// <param name="condition"></param>
/// <param name="msg"></param>
 Argument(condition, msg)
{
	ScrAssertEx(condition, "ArgumentException", msg);
}

/// <summary>
/// Always throw script with ArgumentException exception.
/// </summary>
/// <param name="msg"></param>
 ArgumentMsg(msg)
{
	ScrAssertMsg("ArgumentException", msg);
}

/// <summary>
/// Always throw script with NotImplemented exception.
/// </summary>
/// <param name="msg"></param>
 NotImplemented(msg)
{
	ScrAssertMsg("NotImplementedException", msg);
}

/// <summary>
/// Throws script if condition is defined and it is false.
/// </summary>
/// <param name="condition"></param>
/// <param name="msg"></param>
 InvalidOperation(condition, msg)
{
	ScrAssertEx(condition, "InvalidOperationException", msg);
}

/// <summary>
/// Always throw script with InvalidOperation exception.
/// </summary>
/// <param name="msg"></param>
 InvalidOperationMsg(msg)
{
	ScrAssertMsg("InvalidOperationException", msg);
}

/// <summary>
/// Throws script if entity does not exist.
/// </summary>
/// <param name="ent">Entity</param>
/// <param name="msg"></param>
 EntityExist(ent, msg)
{
	ScrAssertEx(IsDefined(ent), "EntityExist", msg);
}

 DevOnly(msg)
{
	ScrAssertEx(core\include\_game::IsDev(), msg);
}