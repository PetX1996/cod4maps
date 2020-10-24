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

InSVPreCache()
{
	PreCacheShader("damage_feedback");
	//precacheShader("damage_feedback_j");

	//level thread onPlayerConnect();
}

OnCConnected()
{
	self.HUD_DamageFeedback = NewClientHudElem(self);
	self.HUD_DamageFeedback.horzAlign = "center";
	self.HUD_DamageFeedback.vertAlign = "middle";
	self.HUD_DamageFeedback.x = -12;
	self.HUD_DamageFeedback.y = -12;
	self.HUD_DamageFeedback.alpha = 0;
	self.HUD_DamageFeedback.archived = true;
	self.HUD_DamageFeedback SetShader("damage_feedback", 24, 48);
}

OnCDamaged(args)
{
	if (!IsDefined(args.eAttacker) || !IsPlayer(args.eAttacker) || args.eAttacker == self)
		return;

	args.eAttacker.HUD_DamageFeedback SetShader("damage_feedback", 24, 48);
	args.eAttacker PlayLocalSound("MP_hit_alert");
	
	args.eAttacker.HUD_DamageFeedback.alpha = 1;
	args.eAttacker.HUD_DamageFeedback FadeOverTime(1);
	args.eAttacker.HUD_DamageFeedback.alpha = 0;
}