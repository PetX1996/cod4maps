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

 SuicideSilent()
{
	self endon("disconnect");

	self.bSuicideSilent = true;
	self Suicide();
	self waittill("death_delay_finished");
}

 Repel(fStrength, vDir)
{
	if (fStrength > 1)
		fStrength = 1;
	
	dmg = Int(200 * fStrength);
	self.Health += dmg;
	self FinishPlayerDamage(self, self, dmg, 0, "MOD_PROJECTILE", "rpg_mp", self.origin, vDir, "none", 0);
}

 DoDamage(iDamage, sWeapon, sMeansOfDeath, vPoint, vDir, sHitLoc, eAttacker, eInflictor, iDFlags, psOffsetTime)
{
	if (!IsDefined(iDamage)) iDamage = 1;
	if (!IsDefined(iDFlags)) iDFlags = 0;
	if (!IsDefined(sMeansOfDeath)) sMeansOfDeath = "MOD_SUICIDE";
	if (!IsDefined(sWeapon)) sWeapon = "ak47_mp";
	if (!IsDefined(vPoint)) vPoint = self.origin;
	//if (!IsDefined(vDir)) vDir = (0, 0, 0);
	if (!IsDefined(sHitLoc)) sHitLoc = "none";
	if (!IsDefined(psOffsetTime)) psOffsetTime = 0;

	self core\_callbacks::Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}

// ================================================================================ //


/// <summary>
/// 
/// </summary>
/// <self>Player</self>
/// <returns>eBody</returns>
/// <param name="args">Args from 'PlayerKilled' callback</param>
 PlaceCorpse(killedArgs)
{
	// ============================================================================================================================================================================================= //	
	// callbacks and modify
	killedArgs core\include\_eventCallback::Args_Reset();
	killedArgs.fExplosionForce = 0.75;
	killedArgs.fExplosionRadius = 40;
	killedArgs.bCancel = undefined;
	
	self core\_init::RunInCCorpsePlacing(killedArgs);
	// ============================================================================================================================================================================================= //	
	
	if (IsDefined(killedArgs.bCancel))
		return undefined;
	
	body = self ClonePlayer(killedArgs.deathAnimDuration);
	if (self IsOnLadder() || self IsMantling())
		body StartRagdoll();
	
	body thread DelayStartRagdoll(killedArgs);

	killedArgs core\include\_eventCallback::Args_Reset();
	killedArgs.eBody = body;
	self core\_init::RunOnCCorpsePlaced(killedArgs);
	
	return body;
}

 DelayStartRagdoll(killedArgs)
{
	vDir = killedArgs.vDir;
	if (!IsDefined(vDir))
		vDir = (0, 0, 0);

	vExplosionPos = self.origin + (0, 0, GetHitLocHeight(killedArgs.sHitLoc));
	vExplosionPos -= vDir * 20;

	self StartRagdoll();

	wait 0.05;

	if (IsDefined(self))
		PhysicsExplosionSphere(vExplosionPos, killedArgs.fExplosionRadius, killedArgs.fExplosionRadius * 0.5, killedArgs.fExplosionForce);
}

 GetHitLocHeight(sHitLoc)
{
	switch (sHitLoc)
	{
		case "helmet":
		case "head":
		case "neck":
			return 60;
		case "torso_upper":
		case "right_arm_upper":
		case "left_arm_upper":
		case "right_arm_lower":
		case "left_arm_lower":
		case "right_hand":
		case "left_hand":
		case "gun":
			return 48;
		case "torso_lower":
			return 40;
		case "right_leg_upper":
		case "left_leg_upper":
			return 32;
		case "right_leg_lower":
		case "left_leg_lower":
			return 10;
		case "right_foot":
		case "left_foot":
			return 5;
		default:
			return 48;
	}
}


// ================================================================================ //