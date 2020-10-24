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

// =========================================== //
// ======= Callback_StartGameType() ========== //
// =========================================== //

 Callback_StartGameType()
{
	if (!IsDefined(game["state"]))
	{	
		game["state"] = "playing";
		
		PreCacheModel("tag_origin");	
		PreCacheModel("projectile_tag");
		
		PreCacheRumble("damage_heavy");

		PreCacheShader("damage_feedback");
		PreCacheShader("white");
		PreCacheShader("black");
		
		//PreCacheItem("radar_mp"); // AS 1 - PERK
		//PreCacheItem("airstrike_mp"); // AS 3 - EQUIPMENT
		//PreCacheItem("helicopter_mp"); // AS 4 - GEAR
		
		// ============= STATUSICONS ================ //
		PreCacheStatusIcon("hud_status_dead");
		PreCacheStatusIcon("hud_status_connecting");
		/*PreCacheStatusIcon("hud_status_marshal");
		PreCacheStatusIcon("hud_status_marshal2");
		PreCacheStatusIcon("hud_status_marshal3");
		PreCacheStatusIcon("hud_status_dev");
		PreCacheStatusIcon("hud_status_vip2");
		PreCacheStatusIcon("hud_status_sponzor");*/
		// ========================================== //		
		
		MakeDvarServerInfo("scr_allies", "usmc");
		MakeDvarServerInfo("scr_axis", "arab");
		
		//PreCacheModel( "4gf_sgc_rings" );
		//PreCacheModel( "4gf_sgc_ring" );
		//PreCacheModel( "4gf_sgc_gate" );
		//PreCacheModel( "4gf_sgc_dhd" );
		//PreCacheModel( "zat" );
		//PreCacheModel( "zat_model" );
		//PreCacheModel( "staff" );
		//PreCacheModel( "staff_obracene_1" );
		
		PreCacheItem("radar_mp"); // PERK BUTTON
		
		//scripts\class\_spawn::PreCacheFromTable();
		//scripts\clients\_inventory::PreCacheItems();
		
		//scripts\shop\_equipment::PreCacheEquipment();
		//scripts\shop\_gear::PreCacheGear();
		
		level core\_init::RunInSVPreCache();
	}
	
	if (GetDvar("r_reflectionProbeGenerate") == "1")
		level waittill("eternity");
	
	SetClientNameMode("auto_change");
	
	// linux bug
	level.spawnMins = (0, 0, 0);
	level.spawnMaxs = (0, 0, 0);
	level.mapCenter = maps\mp\gametypes\_spawnlogic::FindBoxCenter(level.spawnMins, level.spawnMaxs);
	SetMapCenter(level.mapCenter);
	
	level core\_init::RunInSVStartGameType();
}

// =========================================== //
// ======= Callback_PlayerConnect() ========== //
// =========================================== //

 Callback_PlayerConnect()
{
	self thread NotifyConnecting();

	self.StatusIcon = "hud_status_connecting";
	self waittill("begin");
	waittillframeend;
	
	//DEV
	if (GetDvar("r_reflectionProbeGenerate") == "1")
		level waittill("eternity");
	
	spawnPoints = core\include\clients\_spawn::GetSpawnPoints("spectator");
	self SetOrigin(spawnPoints[RandomInt(spawnPoints.size)].Origin);

	if (!IsDefined(self.pers["score"]))
		IPrintLn(&"MP_CONNECTED", self);
	
	self core\include\clients\_pers::InitPersStat("score");
	self core\include\clients\_pers::InitPersStat("kills");
	self core\include\clients\_pers::InitPersStat("assists");
	self core\include\clients\_pers::InitPersStat("deaths");
	
	if (!IsDefined(self.pers["team"]))
		self.pers["team"] = "spectator";
	
	self.Team = self.pers["team"];
	
	self core\include\clients\_access::SetLevel(0);
	
	/*if (!IsDefined(self.pers["RoundsPlayed"]))
	{
		self.pers["RoundsPlayed"] = 1;
		self.FirstConnect = true;
	}
	else
		self.pers["RoundsPlayed"]++;
	*/
	
	self core\include\clients\_hud::DisableHud();
	
	self UpdateScores();
	
	if (!core\include\_game::IsDev())
		wait 0.1;
	
	
	// ranks, cvars, stats, etc.
	args = core\include\_eventCallback::Args_Create();
	args.DvarDic = core\include\array\_dictionary::Create();
	self core\_init::RunInCPreConnecting(args);

	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCPostConnecting(args);
	
	self core\include\clients\_cmd::SendDvars(args.DvarDic core\include\array\_dictionary::ToDicArray());
	
	
	if (!core\include\_game::IsDev())
		wait 0.1;
	
	lpselfnum = self GetEntityNumber();
	lpGuid = self GetGuid();
	LogPrint("J;" + lpGuid + ";" + lpselfnum + ";" + self.Name + "\n");
	
	level.players[level.players.size] = self;
	
	self SetClientDvar("g_scriptMainMenu", core\include\clients\_menu::GetMenu("team"));
	
	level notify("connected", self);
	self core\_init::RunOnCConnected();
	
	//level endon("game_ended");
	
	//if (IsDefined(self.pers["isBot"]))
		//return;
	
	//scripts\_maps::MapErrors();

	wait 1;
	self core\_init::RunOnLCConnected();
}

 NotifyConnecting()
{
	waittillframeend;

	if (IsDefined(self))
	{
		level notify("connecting", self);
		self core\_init::RunOnCBeginConnecting();
	}	
}

// =========================================== //
// ====== Callback_PlayerDisconnect() ======== //
// =========================================== //

 Callback_PlayerDisconnect()
{
	level notify("disconnected", self);

	level.players = core\include\array\_array::Remove(level.players, self);
	level._alliesPlayers = core\include\array\_array::Remove(level._alliesPlayers, self);
	level._axisPlayers = core\include\array\_array::Remove(level._axisPlayers, self);
	level._spectatorPlayers = core\include\array\_array::Remove(level._spectatorPlayers, self);
	
	lpselfnum = self GetEntityNumber();
	lpGuid = self GetGuid();
	LogPrint("Q;" + lpGuid + ";" + lpselfnum + ";" + self.Name + "\n");
	
	self core\_init::RunInCDisconnecting();
}

// =========================================== //
// ========= Callback_PlayerDamage =========== //
// =========================================== //

 Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	core\include\_exception::InvalidOperation(self.pers["team"] != "spectator" && self.SessionTeam != "spectator", "Cannot damage spectator");

	// Don't do knockback if the damage direction was not specified
	if (!IsDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	if (IsHeadShot(sHitLoc, sMeansOfDeath))
		sMeansOfDeath = "MOD_HEAD_SHOT";
	
	// explosive barrel/car detection
	if (sWeapon == "none" && IsDefined(eInflictor))
	{
		if (IsDefined(eInflictor.TargetName) && eInflictor.TargetName == "explodable_barrel")
			sWeapon = "explodable_barrel";
		else if (IsDefined(eInflictor.destructible_type ) && IsSubStr(eInflictor.destructible_type, "vehicle_"))
			sWeapon = "destructible_car";
	}
	
	// ======================================================================================================== //
	// callbacks and modify
	args = core\include\_eventCallback::Args_Create();
	args.eInflictor 	= eInflictor;
	args.eAttacker 		= eAttacker;
	args.iDamage 		= iDamage;
	args.iDFlags 		= iDFlags;
	args.sMeansOfDeath 	= sMeansOfDeath;
	args.sWeapon 		= sWeapon;
	args.vPoint 		= vPoint;
	args.vDir 			= vDir;
	args.sHitLoc 		= sHitLoc;
	args.psOffsetTime 	= psOffsetTime;
	args.bCancel		= undefined;
	
	self core\_init::RunInCPreDamaging(args);
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCPostDamaging(args);
	// ======================================================================================================== //
	
	// check for completely getting out of the damage
	if (!(iDFlags & level.iDFLAGS_NO_PROTECTION) && !IsDefined(args.bCancel))
	{
		// Make sure at least one point of damage is done
		args.iDamage = Int(args.iDamage);
		if (args.iDamage < 1)
			return;
		
		self CDebugDmg(args.eInflictor, args.eAttacker, args.iDamage, args.iDFlags, args.sMeansOfDeath, 
			args.sWeapon, args.vPoint, args.vDir, args.sHitLoc, args.psOffsetTime);
		
		self FinishPlayerDamage(args.eInflictor, args.eAttacker, args.iDamage, args.iDFlags, args.sMeansOfDeath, 
			args.sWeapon, args.vPoint, args.vDir, args.sHitLoc, args.psOffsetTime);
		//self thread maps\mp\gametypes\_weapons::onWeaponDamage( eInflictor, sWeapon, sMeansOfDeath, iDamage );
		self PlayRumbleOnEntity("damage_heavy");
		self core\include\clients\_hud::SetHealthBar(self.Health);
		
		args core\include\_eventCallback::Args_Reset();
		self core\_init::RunOnCDamaged(args);
	}
	//iprintln("Callback_PlayerDamage");
}

 CDebugDmg(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
	sText = "self:^1" + self.name + "^7;";
	if (IsDefined(eInflictor))
		sText += "eInflictor:^1" + eInflictor.classname + "^7;";
	if (IsDefined(eAttacker))
	{
		if (IsPlayer(eAttacker))
			sText += "eAttacker:^1" + eAttacker.name + "^7;";
		else
			sText += "eAttacker:^1" + eAttacker.classname + "^7;";
	}
	if (IsDefined(iDamage))
		sText += "iDamage:^1" + iDamage + "^7;";
	if (IsDefined(iDFlags))
	{
		sText += "iDFlags:^1";

		if (iDFlags & level.iDFLAGS_RADIUS)
			sText += "iDFLAGS_RADIUS,";
		if (iDFlags & level.iDFLAGS_NO_ARMOR)
			sText += "iDFLAGS_NO_ARMOR,";
		if (iDFlags & level.iDFLAGS_NO_KNOCKBACK)
			sText += "iDFLAGS_NO_KNOCKBACK,";
		if (iDFlags & level.iDFLAGS_PENETRATION)
			sText += "iDFLAGS_PENETRATION,";
		if (iDFlags & level.iDFLAGS_NO_TEAM_PROTECTION)
			sText += "iDFLAGS_NO_TEAM_PROTECTION,";
		if (iDFlags & level.iDFLAGS_NO_PROTECTION)
			sText += "iDFLAGS_NO_PROTECTION,";
		if (iDFlags & level.iDFLAGS_PASSTHRU)
			sText += "iDFLAGS_PASSTHRU,";
			
		sText += "^7;";
	}
	if (IsDefined(sMeansOfDeath))
		sText += "sMeansOfDeath:^1" + sMeansOfDeath + "^7;";
	if (IsDefined(sWeapon))
		sText += "sWeapon:^1" + sWeapon + "^7;";
	if (IsDefined(vPoint))
		sText += "vPoint:^1" + vPoint + "^7;";
	if (IsDefined(vDir))
		sText += "vDir:^1" + vDir + "^7;";	
	if (IsDefined(sHitLoc))
		sText += "sHitLoc:^1" + sHitLoc + "^7;";	
	if (IsDefined(psOffsetTime))
		sText += "psOffsetTime:^1" + psOffsetTime + "^7;";	

	level core\include\_debug::Debug(sText);
}

 IsHeadShot(sHitLoc, sMeansOfDeath)
{
	return (sHitLoc == "head" || sHitLoc == "helmet") && sMeansOfDeath != "MOD_MELEE" && sMeansOfDeath != "MOD_IMPACT";
}

// =========================================== //
// ========= Callback_PlayerKilled =========== //
// =========================================== //

 Callback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{	
	self endon("spawned");
	self notify("killed_player");

	core\include\_exception::InvalidOperation(self.pers["team"] != "spectator" && self.SessionTeam != "spectator", "Cannot kill spectator");
	
	self.SessionState = "dead";
	
	//iprintln("Callback_PlayerKilled");
	
	if (IsHeadShot(sHitLoc, sMeansOfDeath))
		sMeansOfDeath = "MOD_HEAD_SHOT";
	
	if (eAttacker.ClassName == "script_vehicle" && IsDefined(eAttacker.Owner))
		eAttacker = eAttacker.Owner;
	
	// ============================================================================================================================================================================================= //	
	// callbacks and modify
	args = core\include\_eventCallback::Args_Create();
	args.eInflictor 		= eInflictor;
	args.eAttacker 			= eAttacker;
	args.iDamage 			= iDamage;
	args.sMeansOfDeath 		= sMeansOfDeath;
	args.sWeapon 			= sWeapon;
	args.vDir 				= vDir;
	args.sHitLoc 			= sHitLoc;
	args.psOffsetTime 		= psOffsetTime;
	args.deathAnimDuration	= deathAnimDuration;
	args.bSuicideSilent		= self.bSuicideSilent;
	self.bSuicideSilent = undefined;
	
	self core\_init::RunInCKilling(args);
	// ============================================================================================================================================================================================= //	
	
	//self incPersStat( "deaths", 1 );
	
	lpselfnum = self GetEntityNumber();
	lpselfname = self.Name;
	lpattackGuid = "";
	lpattackname = "";
	lpselfteam = self.pers["team"];
	lpselfguid = self GetGuid();
	lpattackerteam = "";

	lpattacknum = -1;

	if (IsPlayer(eAttacker))
	{
		lpattackGuid = eAttacker GetGuid();
		lpattackname = eAttacker.Name;
		lpattackerteam = eAttacker.pers["team"];

		if (eAttacker != self) // killed by enemy
		{
			lpattacknum = eAttacker GetEntityNumber();

			/*if( IsDefined( self.takenDamage ) )
			{
				guids = GetArrayKeys( self.takenDamage );
				for( i = 0; i < level.players.size; i++ )
				{
					player = level.players[i];
					if( IsDefined( player ) && IsPlayer( player ) && player.pers["team"] != "spectator" && player.pers["team"] != self.pers["team"] )
					{
						guid = player GetGuid();
						if( ARRAY_Contains( guids, guid ) )
						{
							damage = self.takenDamage[guid];
							player [[level.giveScore]]( "score_damage", level.dvars["score_damage_"+self.pers["team"]]*damage );
						}
					}
				}
				self.takenDamage = undefined;
			}*/
			
			//attacker IncPersStat( "kills", 1 );
			//attacker.kills = attacker GetPersStat( "kills" );
			
			//if( self.pers["team"] == "allies" )
				//attacker IncPersStat( "kills_humans", 1 );
			//else
				//attacker IncPersStat( "kills_monsters", 1 );
		}
	}
	else
	{
		lpattacknum = -1;
		lpattackguid = "";
		lpattackname = "";
		lpattackerteam = "world";
	}			

	LogPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" 
		+ lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" 
		+ sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	self core\include\clients\_player::ClearPlayerState();
	self core\include\clients\_hud::DisableSpawnInfo();
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunOnCKilled(args);
	
	//self SetClientDvar("hud_bottom_bar", 0);
		
	// let the player watch themselves die
	wait 1;
	
	//self scripts\clients\_inventory::DeleteInventoryOnDeath();
	
	self notify ("death_delay_finished");
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunOnCDelayKilled(args);
	
	
	//self [[level.GT_OnDeath]]( eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );
	
	//scripts\_events::RunCallback( level, "onPlayerKilled", 1, self, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );
	//scripts\_events::RunCallback( self, "onPlayerKilled", 1, eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration );
}

// =========================================== //
// ======== Callback_PlayerLastStand ========= //
// =========================================== //

 Callback_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration)
{
}