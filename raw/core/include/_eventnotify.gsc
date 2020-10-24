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
/// Adds a func call for notify event on self.
/// Func()
///  - Self: sender
/// </summary>
/// <param name="name">String</param>
/// <param name="func">Func()</param>
 AddEvent(name, func)
{
	if (!IsDefined(self.NotifyEvents))
		self.NotifyEvents = [];
		
	if (!IsDefined(self.NotifyEvents[name]))
		self.NotifyEvents[name] = [];

	size = self.NotifyEvents[name].size;
	self.NotifyEvents[name][size] = func;
	
	if (size == 0)
		self thread WatchNotify(name);
}

/// <summary>
/// Deletes a func call for notify event on self.
/// </summary>
/// <param name="name">String - Deletes all notifies for self if it is undefined</param>
/// <param name="func">Func() - Deletes the notify specified by name if it is undefined</param>
 DeleteEvent(name, func)
{
	if (IsDefined(name) && IsDefined(func))
	{
		if (!IsDefined(self.NotifyEvents) || !IsDefined(self.NotifyEvents[name]))
			return;
		
		self.NotifyEvents[name] = core\include\array\_array::Remove(self.NotifyEvents[name], func);
		
		if (self.NotifyEvents[name].size == 0)
			self notify("notifyDead_" + name);
	}
	else if (IsDefined(name))
	{
		if (!IsDefined(self.NotifyEvents))
			return;		
			
		self.NotifyEvents[name] = undefined;
		self notify("notifyDead_" + name);
	}
	else
	{
		namesList = GetArrayKeys(self.NotifyEvents);
		for (i = 0; i < namesList.size; i++)
			self notify("notifyDead_" + namesList[i]);
	
		self.NotifyEvents = undefined;
	}
}

 WatchNotify(name)
{
	self endon("notifyDead_" + name);
	
	while (true)
	{
		while (IsDefined(core\include\_notify::WaittillTime(1, name))) // loop for alive check
		{
			if (!IsDefined(self))
				return;
		}
		
		for (i = 0; i < self.NotifyEvents[name].size; i++)
			self thread [[self.NotifyEvents[name][i]]]();
	}
}