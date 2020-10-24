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

 CSet(sPerkName)
{
	if (!IsDefined(self.Perks))
		self.Perks = [];
		
	self.Perks[self.Perks.size] = sPerkName;
	
	if (IsExePerk(sPerkName))
		self SetPerk(sPerkName);
}

 CHas(sPerkName)
{
	if (!IsDefined(self.Perks))
		self.Perks = [];

	return core\include\array\_array::Contains(self.Perks, sPerkName);
}

 CGetAll()
{
	if (!IsDefined(self.Perks))
		self.Perks = [];

	return self.Perks;
}

 CTake(sPerkName)
{
	if (!IsDefined(self.Perks))
		self.Perks = [];
		
	self.Perks = core\include\array\_array::Remove(self.Perks, sPerkName);
	
	self UnSetPerk(sPerkName);
}

 CTakeAll()
{
	self.Perks = [];
	
	self ClearPerks();
}

 IsExePerk(sPerkName)
{
	switch (sPerkName)
	{
		case "specialty_parabolic":
		case "specialty_gpsjammer":
		case "specialty_holdbreath":
		case "specialty_quieter":
		case "specialty_longersprint":
		case "specialty_detectexplosive":
		case "specialty_explosivedamage":
		case "specialty_pistoldeath":
		case "specialty_grenadepulldeath":
		case "specialty_bulletdamage":
		case "specialty_bulletpenetration":
		case "specialty_bulletaccuracy":
		case "specialty_rof":
		case "specialty_fastreload":
		case "specialty_extraammo":
		case "specialty_twoprimaries":
		case "specialty_armorvest":
		case "specialty_fraggrenade":
		case "specialty_specialgrenade":
		case "specialty_weapon_c4":
		case "specialty_weapon_claymore":
		case "specialty_weapon_rpg":
		case "specialty_null":
			return true;
		default:
			return false;
	}
}

// =================================================================================================== //




 CBtnPrepareNV(sColorCode)
{
	self CBtnSetColor(sColorCode);
	self SetActionSlot(1, "nightvision"); // N
}

 CBtnPrepareGL(sColorCode)
{
	self CBtnSetColor(sColorCode);
	self SetActionSlot(1, "altmode");
}

 CBtnPrepare(sColorCode)
{
	self GiveWeapon("radar_mp");
	self CBtnSetColor(sColorCode);
	self SetActionSlot(1, "weapon", "radar_mp");
}

 CBtnSetColor(sColorCode)
{
	if (!IsDefined(sColorCode))
		sColorCode = "^7";
		
	self SetClientDvar("ui_hudPerkC", sColorCode);
}

 CBtnRelease()
{
	self SetActionSlot(1, "");
	self TakeWeapon("radar_mp");
}


// =================================================================================================== //