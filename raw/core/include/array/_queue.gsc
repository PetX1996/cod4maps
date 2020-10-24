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
/// Adds a value to the end of the queue.
/// </summary>
/// <returns>T[]</returns>
/// <param name="queue">T[]</param>
/// <param name="value">T</param>
 Enqueue(queue, value)
{
	core\include\_exception::Undefined(queue, "queue");
	core\include\_exception::Undefined(value, "value");
	
	queue[queue.size] = value;
	return queue;
}

/// <summary>
/// Removes a value at the start of the queue.
/// RETURNS QUEUE
/// </summary>
/// <returns>T[]</returns>
/// <param name="queue">T[]</param>
 Dequeue(queue)
{
	core\include\_exception::Undefined(queue, "queue");
	
	if (queue.size == 0)
		return queue;
	
	queue = core\include\array\_array::RemoveAt(queue, 0);
	return queue;
}

/// <summary>
/// Returns a value at the start of the queue.
/// </summary>
/// <returns>T</returns>
/// <param name="queue">T[]</param>
 Peek(queue)
{
	core\include\_exception::Undefined(queue, "queue");
	
	if (queue.size == 0)
		return undefined;
	
	return queue[0];
}