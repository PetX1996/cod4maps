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

 IsFirstConnectEver()
{
	core\include\_exception::NotImplemented();
}

 IsFirstConnectOnMap()
{
	core\include\_exception::NotImplemented();
}

 GetHealth()
{
	return self.Health;
}

 GetMaxHealth()
{
	return self.MaxHealth;
}

 GetMoveSpeed()
{
	return self.Speed; // TODO
}

 GetBodyModel()
{
	return self.Model; // TODO
}

 GetBodyHeadModel()
{
	return self.HeadModel; // TODO
}

 GetBodyViewModel()
{
	self GetViewModel();
}

 GetDefaultSpawnArgs()
{
	return core\include\_eventCallback::Args_Create();
}

 SetDefaultSpawnArgs(args, spawnPoint, bodyModel, headModel, viewModel, 
		health, speed, forcedWeapon, spawnWeapon, weapons, offHand, secondaryOffHand, 
		actionSlot1, actionSlot2, actionSlot3, actionSlot4, perks)
{
	if (!IsDefined(spawnPoint))
	{
		spawnPoint = SpawnStruct();
		spawnPoint.Origin = (0, 0, 0); // vector
		spawnPoint.Angles	= (0, 0, 0); // vector
	}
	
	if (!IsDefined(bodyModel))			bodyModel = "Tourrette";
	//if (!IsDefined(headModel))		headModel = undefined;
	if (!IsDefined(viewModel))			viewModel = "viewmodel_hands_zombie";
	
	if (!IsDefined(health))				health = 100;
	if (!IsDefined(speed))				speed = 1;
	
	//if (!IsDefined(forcedWeapon))		forcedWeapon = undefined;
	if (!IsDefined(spawnWeapon))		spawnWeapon = "weapon_ak47";
	if (!IsDefined(weapons))			weapons = [];
	//if (!IsDefined(offHand))			offHand = undefined;
	//if (!IsDefined(secondaryOffHand))	secondaryOffHand = undefined;
	
	//if (!IsDefined(actionSlot1))		actionSlot1 = undefined;
	//if (!IsDefined(actionSlot2))		actionSlot2 = undefined;
	//if (!IsDefined(actionSlot3))		actionSlot3 = undefined;
	//if (!IsDefined(actionSlot4))		actionSlot4 = undefined;
	
	if (!IsDefined(perks))				perks = [];
	
	
	args.SpawnPoint = spawnPoint; // struct
	
	args.sBodyModel = bodyModel; // string
	args.sHeadModel = headModel; // string
	args.sViewModel = viewModel; // string
	
	args.iHealth = health; // int
	args.fSpeed = speed; // float
	
	args.sForcedWeapon = forcedWeapon;
	args.sSpawnWeapon = spawnWeapon; // string
	args.Weapons = weapons; // string[]
	args.sOffHand = offHand; // string
	args.sSecondaryOffHand = secondaryOffHand; // string
	
	// "altmode" "nightvision" or weaponName
	args.sActionSlot1 = actionSlot1; // string NightVision (N)
	args.sActionSlot2 = actionSlot2; // string ? (7)
	args.sActionSlot3 = actionSlot3; // string ClayMore, C4, RPG, ... (5)
	args.sActionSlot4 = actionSlot4; // string Airstrike, Helicopter, ... (6)
	
	args.Perks = perks; // string[]
}

 SpawnPlayer(spawnArgs)
{
	self endon("disconnect");

	core\include\_exception::InvalidOperation((self.pers["team"] == "allies" || self.pers["team"] == "axis") && !IsAlive(self), 
		"Cannot spawn alive player or spectator");

	// ======================================================================== //
	// modify args
	args = GetDefaultSpawnArgs();
	args.DvarDic = core\include\array\_dictionary::Create();
	args.bCancel = undefined;
	
	if (IsDefined(spawnArgs))
		SetDefaultSpawnArgs(args, spawnArgs.SpawnPoint, spawnArgs.sBodyModel, spawnArgs.sHeadModel, spawnArgs.sViewModel, spawnArgs.iHealth, spawnArgs.fSpeed, 
			spawnArgs.sForcedWeapon, spawnArgs.sSpawnWeapon, spawnArgs.Weapons, spawnArgs.sOffHand, spawnArgs.sSecondaryOffHand, 
			spawnArgs.sActionSlot1, spawnArgs.sActionSlot2, spawnArgs.sActionSlot3, spawnArgs.sActionSlot4, spawnArgs.Perks);
	else
		SetDefaultSpawnArgs(args);
	
	
	// callbacks
	self core\_init::RunInCPreSpawning(args);
	
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCPostSpawning(args);
	if (IsDefined(args.bCancel))
		return;
	
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCFinalSpawning(args);	
	
	
	// dev
	self core\clients\_dev::ModifyPlayerSpawning(args);
	
	
	self notify("spawned");

	// ======================================================================== //
	// reset settings...
	self ClearPlayerState();
	
	self.Voice = "british";
	self.SessionState = "playing";
	self.SpectatorClient = -1;
	self.KillCamEntity = -1;
	self.ArchiveTime = 0;
	self.PSOffsetTime = 0;
	self.StatusIcon = "";

	self TakeAllWeapons();
	self core\include\clients\_perk::CTakeAll();
	self core\include\clients\_perk::CBtnRelease();
	
	// ======================================================================== //	
	// main spawn settings...
	self Spawn(args.SpawnPoint.Origin, args.SpawnPoint.Angles);
	
	self SetHealth(args.iHealth, args.iHealth);
	
	self SetModel(args.sBodyModel);
	self SetViewModel(args.sViewModel);
	if(IsDefined(args.sHeadModel))
		self Attach(args.sHeadModel, "", true);
	
	self SetMoveSpeedScale(args.fSpeed);
	//self.Speed = args.Speed;

	//self SetClientDvars( "bg_fallDamageMinHeight", minFallDmg, "bg_fallDamageMaxHeight", maxFallDmg );

	// ======================================================================== //	
	// WEAPONS
	if (IsDefined(args.sForcedWeapon))
	{
		self core\include\clients\_weapon::SetForcedWeapon(args.sForcedWeapon);
		self SetSpawnWeapon(args.sForcedWeapon);
	}
	else
	{
		for (foreachg45e74f_0 = 0; foreachg45e74f_0 < args.Weapons.size; foreachg45e74f_0++)
		{ weaponName = args.Weapons[foreachg45e74f_0]; self core\include\clients\_weapon::SetWeapon(weaponName); }
		
		if (IsDefined(args.sSpawnWeapon))
		{
			self core\include\clients\_weapon::SetWeapon(args.sSpawnWeapon);
			self SetSpawnWeapon(args.sSpawnWeapon);
		}
		
		if (IsDefined(args.sOffHand))
			self core\include\clients\_weapon::SetOffhandWeapon(args.sOffHand);

		if (IsDefined(args.sSecondaryOffHand))
			self core\include\clients\_weapon::SetSecondaryOffhandWeapon(args.sSecondaryOffHand);
			
		if (IsDefined(args.sActionSlot1))
			self core\include\clients\_weapon::SetActionSlotWeapon(1, args.sActionSlot1);
		if (IsDefined(args.sActionSlot2))
			self core\include\clients\_weapon::SetActionSlotWeapon(2, args.sActionSlot2);
		if (IsDefined(args.sActionSlot3))
			self core\include\clients\_weapon::SetActionSlotWeapon(3, args.sActionSlot3);
		if (IsDefined(args.sActionSlot4))
			self core\include\clients\_weapon::SetActionSlotWeapon(4, args.sActionSlot4);
	}
		
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < args.Perks.size; foreachg45e74f_1++)
	{ perkName = args.Perks[foreachg45e74f_1]; self core\include\clients\_perk::CSet(perkName); }

	
	self core\include\clients\_cmd::SendDvars(args.DvarDic core\include\array\_dictionary::ToDicArray());
	
	self core\include\clients\_hud::EnableSpawnInfo();
	// ======================================================================== //	
	// END
	wait 0.05;
	
	self notify("spawned_player");
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunOnCSpawned(args);
}

 ClearPlayerState()
{
	self StopShellshock();
	self StopRumble("damage_heavy");

	//self CloseMenu();
	//self CloseInGameMenu();

	self UnLink();
	self EnableWeapons();
	self FreezeControls(false);
	
	self SetClientDvars("cg_thirdPerson", false, 
						"cg_laserForceOn", false);
	
	self core\include\clients\_hud::ResetLower();
}

 FreezeMove(status)
{
	if (!IsDefined(level._tempEntity))
		level._tempEntity = Spawn("script_origin", (0,0,0));

	if (status)
		self LinkTo(level._tempEntity);
	else
		self UnLink();
}

 SetHealth(health, maxHealth)
{
	self.Health = health;
	if (IsDefined(maxHealth))
		self.MaxHealth = maxHealth;
		
	self core\include\clients\_hud::SetHealthBar(self.Health, self.MaxHealth);
}

// ======================================================================================== //


 SetThirdPersonFromSave()
{
	settings = GetThirdPersonSettings();
	self SetThirdPerson(settings["bEnabled"], settings["iAngle"]);
}

 SetThirdPerson(bEnabled, iAngle)
{
	if (!IsDefined(iAngle))
	{
		settings = self GetThirdPersonSettings();
		iAngle = settings["iAngle"];
	}
	
	self SetThirdPersonSettings(bEnabled, iAngle);
	
	if (IsAlive(self))
		self SetClientDvars("cg_thirdPerson", bEnabled, "cg_thirdPersonAngle", iAngle);
}

 ToggleThirdPerson(iAngle)
{
	settings = self GetThirdPersonSettings();
	if (IsDefined(iAngle))
	{
		iAngle = core\include\_math::AngleToPositive(Int(iAngle));
		if (iAngle != settings["iAngle"])
			return;
	}
	
	self SetThirdPerson(!settings["bEnabled"], settings["iAngle"]);
}

 ChangeOrToggleThirdPerson(iAngle)
{
	iAngle = core\include\_math::AngleToPositive(Int(iAngle));
	
	settings = self GetThirdPersonSettings();
	if (settings["iAngle"] == iAngle) // toggle
		self SetThirdPerson(!settings["bEnabled"], settings["iAngle"]);
	else
		self SetThirdPerson(true, iAngle);
}

 SetThirdPersonSettings(bEnabled, iAngle)
{
	iAngle = core\include\_math::AngleToPositive(iAngle);

	// 1 bit	9 bits
	// bEnabled	angle
	iSettings = bEnabled;
	iSettings <<= 9;
	core\include\_exception::Argument(iAngle >= 0 && iAngle <= 360, "iAngle is invalid");
	iSettings |= Int(iAngle);

	self core\include\clients\_stat::SetById(3497, iSettings);	
}

/// <summary>
/// Gets saved 3rd person's settings.
/// </summary>
/// <returns>r["bEnabled"] r["iAngle"]</returns>
 GetThirdPersonSettings()
{
	iSettings = self core\include\clients\_stat::GetById(3497);
	iAngle = iSettings & 511;
	iSettings >>= 9;
	bEnabled = iSettings & 1;
	
	{ output["bEnabled"] = bEnabled; output["iAngle"] = iAngle ; }
	return output;
}


// ======================================================================================== //

 CLaserTurnOn()
{
	self SetClientDvars("cg_laserEndOffset", 0.5,
		"cg_laserFlarePct", 0.2,
		"cg_laserLight", 1,
		"cg_laserLightBeginOffset", 13,
		"cg_laserLightBodyTweak", 15,
		"cg_laserLightEndOffset", -3,
		"cg_laserLightRadius", 1.7,
		"cg_laserRadius", 0.5,
		"cg_laserRange", 500,
		"cg_laserRangePlayer", 500,
		"cg_laserLight", 0,
		"cg_laserForceOn", true);
}

 CLaserTurnOff()
{
	self SetClientDvar("cg_laserForceOn", false);
}