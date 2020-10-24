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

OnCSpawned(args)
{
	if (core\include\_logic::IsTeamFreezed(self.pers["team"]))
	{
		self core\include\clients\_player::FreezeMove(true);
		self DisableWeapons();
	}
}

OnLGameStarted()
{
	thread MonitorGameLogic();
}

 MonitorGameLogic()
{
	wait 1;

	while (true)
	{
		core\_init::RunOnLTimeElapsed();
	
		wait 1;
	}
}