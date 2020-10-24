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

OnCConnected()
{
	self thread CheckButtons();
}

 CheckButtons()
{
	wait 0.05;

	attack = false;
	use = false;
	melee = false;
	frag = false;
	
	while (IsDefined(self))
	{
		if (self AttackButtonPressed())
		{
			if (!attack)
				self core\_init::RunOnCAttackButtonPressed();
			
			self core\_init::RunOnCAttackButtonHold();
			attack = true;
		}
		else
			attack = false;
			
		if (self UseButtonPressed())
		{
			if (!use)
				self core\_init::RunOnCUseButtonPressed();
			
			self core\_init::RunOnCUseButtonHold();
			use = true;
		}
		else
			use = false;
			
		if (self MeleeButtonPressed())
		{
			if (!melee)
				self core\_init::RunOnCMeleeButtonPressed();
			
			self core\_init::RunOnCMeleeButtonHold();
			melee = true;
		}
		else
			melee = false;
		
		if (self FragButtonPressed())
		{
			if (!frag)
				self core\_init::RunOnCFragButtonPressed();
			
			self core\_init::RunOnCFragButtonHold();
			frag = true;			
		}
		else
			frag = false;
		
		wait 0.05;
	}
}