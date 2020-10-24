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

 SetWeapon(weaponName)
{
	self GiveWeapon(weaponName);
}

 SetForcedWeapon(weaponName)
{
	self.sForcedWeapon = weaponName;
	self GiveWeapon(weaponName);
}

 SetOffhandWeapon(weaponName)
{
	self GiveWeapon(weaponName);
}

 SetSecondaryOffhandWeapon(weaponName)
{
	self GiveWeapon(weaponName);

	if (weaponName == "flash_grenade_mp")
		self SetOffhandSecondaryClass("flash");
	else if (weaponName == "smoke_grenade_mp")
		self SetOffhandSecondaryClass("smoke");
}

 PreCacheActionSlotWeapon(weaponName)
{
	if (weaponName != "altmode" && weaponName != "nightvision")
		PreCacheItem(weaponName);
}

 SetActionSlotWeapon(slotId, arg)
{
	if (arg == "altmode" || arg == "nightvision")
		self SetActionSlot(slotId, arg);
	else
	{
		self GiveWeapon(arg);
		self SetActionSlot(slotId, "weapon", arg);
	}
}