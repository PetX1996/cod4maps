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
/// Adds a value to the end of the stack.
/// </summary>
/// <returns>T[]</returns>
/// <param name="stack">T[]</param>
/// <param name="value">T</param>
 Push(stack, value)
{
	core\include\_exception::Undefined(stack, "stack");
	core\include\_exception::Undefined(value, "value");
	
	stack[stack.size] = value;
	return stack;
}

/// <summary>
/// Only deletes value from the end of the stack.
/// RETURNS STACK
/// </summary>
/// <returns>T[]</returns>
/// <param name="stack">T[]</param>
 Pop(stack)
{
	core\include\_exception::Undefined(stack, "stack");
	
	if (stack.size == 0)
		return stack;
		
	stack[stack.size - 1] = undefined;
	return stack;
}

/// <summary>
/// Returns value from the end of the stack.
/// </summary>
/// <returns>T</returns>
/// <param name="stack">T[]</param>
 Peek(stack)
{
	core\include\_exception::Undefined(stack, "stack");
	
	if (stack.size == 0)
		return undefined;
	
	return stack[stack.size - 1];
}