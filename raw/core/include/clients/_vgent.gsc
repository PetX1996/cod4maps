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



 Create()
{
	self.Ents = SpawnStruct();
	
	// public
	self.Ents.dBeginMoving = undefined;
	self.Ents.dMoving = undefined;
	self.Ents.dFinishMoving = undefined;
		self.Ents.vMovingStartOrigin = undefined;
	
	self.Ents.dBeginRotating = undefined;
	self.Ents.dRotating = undefined;
	self.Ents.dFinishRotating = undefined;
		self.Ents.vRotatingStartAngles = undefined;
	
	self.Ents.dChooseEntsBegin = undefined;
		self.Ents.EntsListSource = undefined;
		
	self.Ents.dChooseEntSwitch = undefined; // bool VG func(eEnt)
	self.Ents.dChooseEntsFinish = undefined;
	
	self.Ents.dShowingEnt = undefined;
		self.Ents.eShowingEnt = undefined;
		self.Ents.vShowingEntColor = undefined;
		self.Ents.sShowingEntTextA = undefined;
		self.Ents.sShowingEntTextB = undefined;
	
	self.Ents.dSpawnEntBegin = undefined;
	self.Ents.dSpawnEntFinish = undefined;
		self.Ents.sSpawnEntClassName = undefined;
		self.Ents.sSpawnEntTargetName = undefined;
		self.Ents.vSpawnEntOrigin = undefined;
		self.Ents.fSpawnEntRadius = undefined;
		self.Ents.fSpawnEntHeight = undefined;
	
	self.Ents.dDeleteEntBegin = undefined;
	
	// private
	self.Ents.vEntsListPos = undefined;
	self.Ents.iEntsListSourceCount = undefined;
	self.Ents.EntsList = undefined;
	
	self.Ents.eLastSelectedEnt = undefined;
	self.Ents.eSelectedEnt = undefined;
	self.Ents.eHoldingEnt = undefined;
	
	self.Ents.PropsList = undefined;
	self.Ents.iPropSelected = undefined;
	self.Ents.sPropSelectedKey = undefined;
	
	self.Ents.fMovingDist = undefined;
	self.Ents.vMovingDiff = undefined;
	
	self.Ents.fRotatingDist = undefined;
	
	self thread EntsThread();
}

 Close()
{
	self notify("entsClose");
	
	self.Ents = undefined;
}

 EntsThread()
{
	self.pOwner endon("disconnect");
	self endon("close");
	self endon("entsClose");

	while (true)
	{
		self ChooseForShow();
		
		if (!IsDefined(self.Ents.eHoldingEnt))
		{
			self.Ents.eLastSelectedEnt = self.Ents.eSelectedEnt;
			self.Ents.eSelectedEnt = self FindSelected();
		}
		else if (IsDefined(self.Ents.fMovingDist))
			self MovingUpdate();
		else if (IsDefined(self.Ents.fRotatingDist))
			self RotatingUpdate();
		
		self PropsUpdate();
		
		self ShowOnMap();
		
		wait 0.05;
	}
}



 // 256 ^ 2

 ChooseForShow()
{
	if (IsDefined(self.Ents.dChooseEntsBegin))
		self [[self.Ents.dChooseEntsBegin]]();
	
	if (!IsDefined(self.Ents.EntsListSource))
		self.Ents.EntsListSource = GetEntArray();

	if (IsDefined(self.Ents.vEntsListPos) 
		&& IsDefined(self.Ents.iEntsListSourceCount)
		&& self.Ents.EntsListSource.size == self.Ents.iEntsListSourceCount
		&& DistanceSquared(self.Ents.vEntsListPos, self.pOwner.origin) < 65536)
	{
		self.Ents.EntsListSource = undefined;
		return;
	}
	
	self.Ents.vEntsListPos = self.pOwner.origin;
	self.Ents.iEntsListSourceCount = self.Ents.EntsListSource.size;
		
	iRange = 0;
	iRangeSteps = 0;
	if (self.Ents.EntsListSource.size >= 128 / 2)
		iRangeSteps = GetAverageEntsDist(self.pOwner.origin, self.Ents.EntsListSource) / 4;
	else
		iRange = 10000;
		
	leftEnts = core\include\array\_list::Create();
	leftEnts core\include\array\_list::AddRange(self.Ents.EntsListSource);
	ents = [];
	
	while (ents.size < 128 / 2)
	{
		iRange += iRangeSteps;
		
		if (leftEnts.iCount <= 0)
			break;
		
		for (i = 0; i < leftEnts.iCount; i++)
		{
			ent = leftEnts core\include\array\_list::Get(i);
			
			if (IsDefined(self.Ents.dChooseEntSwitch) && !self [[self.Ents.dChooseEntSwitch]](ent))
			{
				leftEnts core\include\array\_list::RemoveAt(i);
				i--;
			}
			else if (iRange >= 10000 || Distance(ent.origin, self.pOwner.origin) < iRange)
			{
				ents[ents.size] = ent;
				leftEnts core\include\array\_list::RemoveAt(i);
				i--;
			}	
			
			if (ents.size >= 128 / 2)
				break;
		}
	}
	
	self.Ents.EntsList = ents;
	
	if (IsDefined(self.Ents.dChooseEntsFinish))
		self [[self.Ents.dChooseEntsFinish]]();
	
	self UpdateShownStats();
	
	self.Ents.EntsListSource = undefined;
}

 GetAverageEntsDist(vPoint, ents)
{
	fSum = 0;
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < ents.size; foreachg45e74f_0++)
	{ eEnt = ents[foreachg45e74f_0]; fSum += Distance(eEnt.origin, vPoint); }

	return fSum / ents.size;
}

 UpdateShownStats()
{
	self core\include\clients\_vg::AddTextSet(0, "Shown: " + self.Ents.EntsList.size + "/" + self.Ents.EntsListSource.size);
}

 FindSelected()
{
	pVec = self.pOwner core\include\_look::GetPlayerLookVector();
	fLastDot = 0.85;
	eEnt = undefined;
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < self.Ents.EntsList.size; foreachg45e74f_1++)
	{ ent = self.Ents.EntsList[foreachg45e74f_1];
		fDot = VectorDot(pVec, VectorNormalize(ent.origin - self.pOwner core\include\_look::GetPlayerViewPos()));
		if (fDot > fLastDot)
		{
			fLastDot = fDot;
			eEnt = ent;
		}
	}
	return eEnt;
}

 ShowOnMap()
{
	for (foreachg45e74f_2 = 0; foreachg45e74f_2 < self.Ents.EntsList.size; foreachg45e74f_2++)
	{ eEnt = self.Ents.EntsList[foreachg45e74f_2];
		self.Ents.eShowingEnt = eEnt;
		self.Ents.vShowingEntColor = (1, 1, 1);
		self.Ents.sShowingEntTextA = eEnt.classname;
		self.Ents.sShowingEntTextB = eEnt.targetname;
		
		if (IsDefined(eEnt.MF) && IsDefined(eEnt.MF.bIsSpawned))
			self.Ents.vShowingEntColor = (0, 1, 0);
		else if (IsDefined(eEnt.MF))
			self.Ents.vShowingEntColor = (1, 1, 0);
	
		if (IsDefined(self.Ents.dShowingEnt))
			self [[self.Ents.dShowingEnt]]();
	
		if (IsDefined(self.Ents.eSelectedEnt) && eEnt == self.Ents.eSelectedEnt)
			self.Ents.vShowingEntColor = (1, 0, 0);
		else if (IsDefined(eEnt.MF) && IsDefined(eEnt.MF.bIsDeleted))
			self.Ents.vShowingEntColor = (0, 0, 1);
	
		if (IsDefined(eEnt.radius) && IsDefined(eEnt.height))
		{
			cylinder = core\include\_shape::Cylinder_Create(eEnt.origin, eEnt.radius, eEnt.height);
			cylinder core\include\_shape::Cylinder_Draw(self.Ents.vShowingEntColor);
		}
		else
		{
			core\include\_shape::DrawPivot(eEnt.origin, undefined, eEnt.angles, self.Ents.vShowingEntColor);
		}
		
		if (IsDefined(self.Ents.sShowingEntTextB))
			core\include\_shape::DrawText(eEnt.origin + (0, 0, 15), self.Ents.sShowingEntTextB, self.Ents.vShowingEntColor);
		if (IsDefined(self.Ents.sShowingEntTextA))
			core\include\_shape::DrawText(eEnt.origin, self.Ents.sShowingEntTextA, self.Ents.vShowingEntColor);
		else
			core\include\_shape::DrawText(eEnt.origin, "Unknown ent", self.Ents.vShowingEntColor);
	}
}

 PropsUpdate()
{
	if (!IsDefined(self.Ents.eSelectedEnt))
	{
		self PropsReset();
		self core\include\clients\_vg::TextClear();
	}
	else
	{
		self PropsShow();
	}
}

 PropsReset()
{
	self.Ents.PropsList = undefined;
}

 PropsShow()
{
	if (!core\include\_type::IsEqual(self.Ents.eLastSelectedEnt, self.Ents.eSelectedEnt) 
		|| !IsDefined(self.Ents.PropsList))
	{
		if (IsDefined(self.Ents.iPropSelected))
			self.Ents.iPropSelected = 0;
			
		self.Ents.PropsList = [];
		ent = self.Ents.eSelectedEnt;
		
		PropRegister("classname", ent.classname);
		PropRegister("ambience_inner", ent.ambience_inner);
		PropRegister("ambience_outer", ent.ambience_outer);
		PropRegister("ambient", ent.ambient);
		PropRegister("angles", ent.angles);
		PropRegister("count", ent.count);
		PropRegister("delay", ent.delay);
		PropRegister("destructible_type", ent.destructible_type);
		PropRegister("dontdrawoncompass", ent.dontdrawoncompass);
		PropRegister("dontdropweapon", ent.dontdropweapon);
		PropRegister("export", ent.export);
		PropRegister("fixednodesaferadius", ent.fixednodesaferadius);
		PropRegister("groupname", ent.groupname);
		PropRegister("height", ent.height);
		PropRegister("name", ent.name);
		PropRegister("origin", ent.origin);
		PropRegister("radius", ent.radius);
		PropRegister("script_accel", ent.script_accel);
		PropRegister("script_accel_fraction", ent.script_accel_fraction);
		PropRegister("script_accumulate", ent.script_accumulate);
		PropRegister("script_aigroup", ent.script_aigroup);
		PropRegister("script_airspeed", ent.script_airspeed);
		PropRegister("script_allowdeath", ent.script_allowdeath);
		PropRegister("script_angles", ent.script_angles);
		PropRegister("script_anglevehicle", ent.script_anglevehicle);
		PropRegister("script_animation", ent.script_animation);
		PropRegister("script_area", ent.script_area);
		PropRegister("script_assaultnode", ent.script_assaultnode);
		PropRegister("script_attackmetype", ent.script_attackmetype);
		PropRegister("script_attackPattern", ent.script_attackPattern);
		PropRegister("script_attackspeed", ent.script_attackspeed);
		PropRegister("script_autosave", ent.script_autosave);
		PropRegister("script_autosavename", ent.script_autosavename);
		PropRegister("script_avoidplayer", ent.script_avoidplayer);
		PropRegister("script_avoidvehicles", ent.script_avoidvehicles);
		PropRegister("script_badplace", ent.script_badplace);
		PropRegister("script_balcony", ent.script_balcony);
		PropRegister("script_battlechatter", ent.script_battlechatter);
		PropRegister("script_bctrigger", ent.script_bctrigger);
		PropRegister("script_bg_offset", ent.script_bg_offset);
		PropRegister("script_bombmode_dual", ent.script_bombmode_dual);
		PropRegister("script_bombmode_original", ent.script_bombmode_original);
		PropRegister("script_bombmode_single", ent.script_bombmode_single);
		PropRegister("script_breach_id", ent.script_breach_id);
		PropRegister("script_bulletshield", ent.script_bulletshield);
		PropRegister("script_burst", ent.script_burst);
		PropRegister("script_burst_max", ent.script_burst_max);
		PropRegister("script_burst_min", ent.script_burst_min);
		PropRegister("script_chance", ent.script_chance);
		PropRegister("script_cheap", ent.script_cheap);
		PropRegister("script_cleartargetyaw", ent.script_cleartargetyaw);
		PropRegister("script_cobratarget", ent.script_cobratarget);
		PropRegister("script_color_allies", ent.script_color_allies);
		PropRegister("script_color_axis", ent.script_color_axis);
		PropRegister("script_crashtype", ent.script_crashtype);
		PropRegister("script_crashtypeoverride", ent.script_crashtypeoverride);
		PropRegister("script_damage", ent.script_damage);
		PropRegister("script_death", ent.script_death);
		PropRegister("script_death_max", ent.script_death_max);
		PropRegister("script_death_min", ent.script_death_min);
		PropRegister("script_deathchain", ent.script_deathchain);
		PropRegister("script_deathflag", ent.script_deathflag);
		PropRegister("script_deathroll", ent.script_deathroll);
		PropRegister("script_decel", ent.script_decel);
		PropRegister("script_decel_fraction", ent.script_decel_fraction);
		PropRegister("script_delay", ent.script_delay);
		PropRegister("script_delay_goto_goalmax", ent.script_delay_goto_goalmax);
		PropRegister("script_delay_goto_goalmin", ent.script_delay_goto_goalmin);
		PropRegister("script_delay_max", ent.script_delay_max);
		PropRegister("script_delay_min", ent.script_delay_min);
		PropRegister("script_delete", ent.script_delete);
		PropRegister("script_deleteai", ent.script_deleteai);
		PropRegister("script_destructable_area", ent.script_destructable_area);
		PropRegister("script_disconnectpaths", ent.script_disconnectpaths);
		PropRegister("script_displaceable", ent.script_displaceable);
		PropRegister("script_dont_link_turret", ent.script_dont_link_turret);
		PropRegister("script_dontshootwhilemoving", ent.script_dontshootwhilemoving);
		PropRegister("script_dot", ent.script_dot);
		PropRegister("script_drone", ent.script_drone);
		PropRegister("script_dronelag", ent.script_dronelag);
		PropRegister("script_drones_max", ent.script_drones_max);
		PropRegister("script_drones_min", ent.script_drones_min);
		PropRegister("script_droneStartMove", ent.script_droneStartMove);
		PropRegister("script_earthquake", ent.script_earthquake);
		PropRegister("script_emptyspawner", ent.script_emptyspawner);
		PropRegister("script_ender", ent.script_ender);
		PropRegister("script_engage", ent.script_engage);
		PropRegister("script_engageDelay", ent.script_engageDelay);
		PropRegister("script_explode", ent.script_explode);
		PropRegister("script_exploder", ent.script_exploder);
		PropRegister("script_fallback", ent.script_fallback);
		PropRegister("script_fallback_group", ent.script_fallback_group);
		PropRegister("script_falldirection", ent.script_falldirection);
		PropRegister("script_fightdist", ent.script_fightdist);
		PropRegister("script_firefx", ent.script_firefx);
		PropRegister("script_firefxdelay", ent.script_firefxdelay);
		PropRegister("script_firefxsound", ent.script_firefxsound);
		PropRegister("script_firefxtimeout", ent.script_firefxtimeout);
		PropRegister("script_fireondrones", ent.script_fireondrones);
		PropRegister("script_fixednode", ent.script_fixednode);
		PropRegister("script_flag", ent.script_flag);
		PropRegister("script_flag_false", ent.script_flag_false);
		PropRegister("script_flag_set", ent.script_flag_set);
		PropRegister("script_flag_true", ent.script_flag_true);
		PropRegister("script_flag_wait", ent.script_flag_wait);
		PropRegister("script_flakaicount", ent.script_flakaicount);
		PropRegister("script_flashbangs", ent.script_flashbangs);
		PropRegister("script_followmax", ent.script_followmax);
		PropRegister("script_followmin", ent.script_followmin);
		PropRegister("script_followmode", ent.script_followmode);
		PropRegister("script_forcecolor", ent.script_forcecolor);
		PropRegister("script_forcegoal", ent.script_forcegoal);
		PropRegister("script_forcegrenade", ent.script_forcegrenade);
		PropRegister("script_forcespawn", ent.script_forcespawn);
		PropRegister("script_forceyaw", ent.script_forceyaw);
		PropRegister("script_friendname", ent.script_friendname);
		PropRegister("script_fxcommand", ent.script_fxcommand);
		PropRegister("script_fxid", ent.script_fxid);
		PropRegister("script_fxstart", ent.script_fxstart);
		PropRegister("script_fxstop", ent.script_fxstop);
		PropRegister("script_gameobjectname", ent.script_gameobjectname);
		PropRegister("script_gametype_ctf", ent.script_gametype_ctf);
		PropRegister("script_gametype_dm", ent.script_gametype_dm);
		PropRegister("script_gametype_hq", ent.script_gametype_hq);
		PropRegister("script_gametype_sd", ent.script_gametype_sd);
		PropRegister("script_gametype_tdm", ent.script_gametype_tdm);
		PropRegister("script_gatetrigger", ent.script_gatetrigger);
		PropRegister("script_ghettotag", ent.script_ghettotag);
		PropRegister("script_goalvolume", ent.script_goalvolume);
		PropRegister("script_goalyaw", ent.script_goalyaw);
		PropRegister("script_grenades", ent.script_grenades);
		PropRegister("script_grenadespeed", ent.script_grenadespeed);
		PropRegister("script_growl", ent.script_growl);
		PropRegister("script_health", ent.script_health);
		PropRegister("script_hidden", ent.script_hidden);
		PropRegister("script_hint", ent.script_hint);
		PropRegister("script_hoverwait", ent.script_hoverwait);
		PropRegister("script_ignore_suppression", ent.script_ignore_suppression);
		PropRegister("script_ignoreme", ent.script_ignoreme);
		PropRegister("script_immunetoflash", ent.script_immunetoflash);
		PropRegister("script_increment", ent.script_increment);
		PropRegister("script_index", ent.script_index);
		PropRegister("script_keepdriver", ent.script_keepdriver);
		PropRegister("script_killspawner", ent.script_killspawner);
		PropRegister("script_killspawner_group", ent.script_killspawner_group);
		PropRegister("script_label", ent.script_label);
		PropRegister("script_landmark", ent.script_landmark);
		PropRegister("script_layer", ent.script_layer);
		PropRegister("script_light_toggle", ent.script_light_toggle);
		PropRegister("script_linkName", ent.script_linkName);
		PropRegister("script_linkTo", ent.script_linkTo);
		PropRegister("script_location", ent.script_location);
		PropRegister("script_longdeath", ent.script_longdeath);
		PropRegister("script_looping", ent.script_looping);
		PropRegister("script_mapsize_08", ent.script_mapsize_08);
		PropRegister("script_mapsize_16", ent.script_mapsize_16);
		PropRegister("script_mapsize_32", ent.script_mapsize_32);
		PropRegister("script_mapsize_64", ent.script_mapsize_64);
		PropRegister("script_maxdist", ent.script_maxdist);
		PropRegister("script_maxspawn", ent.script_maxspawn);
		PropRegister("script_mg42auto", ent.script_mg42auto);
		PropRegister("script_mg_angle", ent.script_mg_angle);
		PropRegister("script_mgturret", ent.script_mgturret);
		PropRegister("script_minspec_hooks_level", ent.script_minspec_hooks_level);
		PropRegister("script_minspec_level", ent.script_minspec_level);
		PropRegister("script_mortargroup", ent.script_mortargroup);
		PropRegister("script_moveoverride", ent.script_moveoverride);
		PropRegister("script_nodestate", ent.script_nodestate);
		PropRegister("script_noenemyinfo", ent.script_noenemyinfo);
		PropRegister("script_nofriendlywave", ent.script_nofriendlywave);
		PropRegister("script_nohealth", ent.script_nohealth);
		PropRegister("script_nomg", ent.script_nomg);
		PropRegister("script_noteworthy", ent.script_noteworthy);
		PropRegister("script_nowall", ent.script_nowall);
		PropRegister("script_objective", ent.script_objective);
		PropRegister("script_objective_active", ent.script_objective_active);
		PropRegister("script_objective_inactive", ent.script_objective_inactive);
		PropRegister("script_offradius", ent.script_offradius);
		PropRegister("script_offtime", ent.script_offtime);
		PropRegister("script_pacifist", ent.script_pacifist);
		PropRegister("script_parameters", ent.script_parameters);
		PropRegister("script_patroller", ent.script_patroller);
		PropRegister("script_personality", ent.script_personality);
		PropRegister("script_physics", ent.script_physics);
		PropRegister("script_physicsjolt", ent.script_physicsjolt);
		PropRegister("script_pilottalk", ent.script_pilottalk);
		PropRegister("script_plane", ent.script_plane);
		PropRegister("script_playerconeradius", ent.script_playerconeradius);
		PropRegister("script_playerseek", ent.script_playerseek);
		PropRegister("script_prefab_exploder", ent.script_prefab_exploder);
		PropRegister("script_presound", ent.script_presound);
		PropRegister("script_radius", ent.script_radius);
		PropRegister("script_random_killspawner", ent.script_random_killspawner);
		PropRegister("script_randomspawn", ent.script_randomspawn);
		PropRegister("script_repeat", ent.script_repeat);
		PropRegister("script_requires_player", ent.script_requires_player);
		PropRegister("script_reuse", ent.script_reuse);
		PropRegister("script_reuse_max", ent.script_reuse_max);
		PropRegister("script_reuse_min", ent.script_reuse_min);
		PropRegister("script_seekgoal", ent.script_seekgoal);
		PropRegister("script_shotcount", ent.script_shotcount);
		PropRegister("script_sightrange", ent.script_sightrange);
		PropRegister("script_skilloverride", ent.script_skilloverride);
		PropRegister("script_smokegroup", ent.script_smokegroup);
		PropRegister("script_sound", ent.script_sound);
		PropRegister("script_spawn_here", ent.script_spawn_here);
		PropRegister("script_squad", ent.script_squad);
		PropRegister("script_squadname", ent.script_squadname);
		PropRegister("script_stack", ent.script_stack);
		PropRegister("script_stance", ent.script_stance);
		PropRegister("script_start", ent.script_start);
		PropRegister("script_startinghealth", ent.script_startinghealth);
		PropRegister("script_startingposition", ent.script_startingposition);
		PropRegister("script_stealth_dontseek", ent.script_stealth_dontseek);
		PropRegister("script_stopnode", ent.script_stopnode);
		PropRegister("script_stoptoshoot", ent.script_stoptoshoot);
		PropRegister("script_suppression", ent.script_suppression);
		PropRegister("script_tankgroup", ent.script_tankgroup);
		PropRegister("script_targetoffset_z", ent.script_targetoffset_z);
		PropRegister("script_targettype", ent.script_targettype);
		PropRegister("script_team", ent.script_team);
		PropRegister("script_threatbiasgroup", ent.script_threatbiasgroup);
		PropRegister("script_threshold", ent.script_threshold);
		PropRegister("script_timeout", ent.script_timeout);
		PropRegister("script_timer", ent.script_timer);
		PropRegister("script_trace", ent.script_trace);
		PropRegister("script_trigger_group", ent.script_trigger_group);
		PropRegister("script_triggered_playerseek", ent.script_triggered_playerseek);
		PropRegister("script_triggername", ent.script_triggername);
		PropRegister("script_turningdir", ent.script_turningdir);
		PropRegister("script_turret", ent.script_turret);
		PropRegister("script_turret_ambush", ent.script_turret_ambush);
		PropRegister("script_turret_share", ent.script_turret_share);
		PropRegister("script_turretmg", ent.script_turretmg);
		PropRegister("script_unload", ent.script_unload);
		PropRegister("script_unloaddelay", ent.script_unloaddelay);
		PropRegister("script_unloadmgguy", ent.script_unloadmgguy);
		PropRegister("script_usemg42", ent.script_usemg42);
		PropRegister("script_vehicle_lights_off", ent.script_vehicle_lights_off);
		PropRegister("script_vehicle_lights_on", ent.script_vehicle_lights_on);
		PropRegister("script_vehicle_selfremove", ent.script_vehicle_selfremove);
		PropRegister("script_vehicleaianim", ent.script_vehicleaianim);
		PropRegister("script_vehicledetour", ent.script_vehicledetour);
		PropRegister("script_vehicledetourgroup", ent.script_vehicledetourgroup);
		PropRegister("script_vehicledetourtype", ent.script_vehicledetourtype);
		PropRegister("script_vehiclegroup", ent.script_vehiclegroup);
		PropRegister("script_vehicleGroupDelete", ent.script_vehicleGroupDelete);
		PropRegister("script_vehiclenodegroup", ent.script_vehiclenodegroup);
		PropRegister("script_vehicleride", ent.script_vehicleride);
		PropRegister("script_VehicleSpawngroup", ent.script_VehicleSpawngroup);
		PropRegister("script_VehicleStartMove", ent.script_VehicleStartMove);
		PropRegister("script_vehicletriggergroup", ent.script_vehicletriggergroup);
		PropRegister("script_vehiclewalk", ent.script_vehiclewalk);
		PropRegister("script_wait", ent.script_wait);
		PropRegister("script_wait_add", ent.script_wait_add);
		PropRegister("script_wait_max", ent.script_wait_max);
		PropRegister("script_wait_min", ent.script_wait_min);
		PropRegister("script_wheeldirection", ent.script_wheeldirection);
		PropRegister("script_wingman", ent.script_wingman);
		PropRegister("script_wtf", ent.script_wtf);
		PropRegister("script_yawspeed", ent.script_yawspeed);
		PropRegister("spawner_id", ent.spawner_id);
		PropRegister("spawnflags", ent.spawnflags);
		PropRegister("speed", ent.speed);
		PropRegister("squadnum", ent.squadnum);
		PropRegister("target", ent.target);
		PropRegister("targetname", ent.targetname);
		PropRegister("vehicletype", ent.vehicletype);
		PropRegister("weaponinfo", ent.weaponinfo);
	}

	keys = GetArrayKeys(self.Ents.PropsList);
	for (i = 0; i < keys.size; i++)
		self PropShow(i, keys[i], self.Ents.PropsList[keys[i]]);
	
	self core\include\clients\_vg::TextClear(self.Ents.PropsList.size);
}

 PropRegister(sName, value)
{
	if (IsDefined(value))
	{
		self.Ents.PropsList[sName] = value;
	}
}

 PropShow(iIndex, sName, value)
{
	if (IsDefined(self.Ents.iPropSelected) && self.Ents.iPropSelected == iIndex)
		self core\include\clients\_vg::TextSet(iIndex, "^1" + sName + ": " + value);
	else
		self core\include\clients\_vg::TextSet(iIndex, sName + ": " + value);
}

// ============================================================================== //


 MenuMove()
{
	if (IsDefined(self.Ents.fMovingDist))
	{
		if (IsDefined(self.Ents.dFinishMoving))
			self [[self.Ents.dFinishMoving]]();
	
		eEnt = self.Ents.eHoldingEnt;
		eEnt core\include\_mapfixer::Entity_Property("origin", eEnt.origin);
	
		self core\include\clients\_vg::Menu_TurnBtnOff(0);
		self.Ents.eHoldingEnt = undefined;
		self.Ents.fMovingDist = undefined;
		self.Ents.vMovingDiff = undefined;
		self.Ents.vMovingStartOrigin = undefined;
		return;
	}
	else if (!IsDefined(self.Ents.eSelectedEnt) 
		|| self.Ents.eSelectedEnt == self.pOwner
		|| IsDefined(self.Ents.eHoldingEnt))
	{
		self core\include\clients\_vg::Menu_TurnBtnOff(0);
		return;
	}
	
	if (IsDefined(self.Ents.dBeginMoving))
		self [[self.Ents.dBeginMoving]]();
	
	self.Ents.eHoldingEnt = self.Ents.eSelectedEnt;
	
	eEnt = self.Ents.eHoldingEnt;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = Distance(pPos, eEnt.origin);
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = (eEnt.origin - pPos) - vLook;
	
	self.Ents.fMovingDist = fDist;
	self.Ents.vMovingDiff = vDiff;
	
	self.Ents.vMovingStartOrigin = eEnt.origin;
}

 MovingUpdate()
{
	eEnt = self.Ents.eHoldingEnt;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = self.Ents.fMovingDist;
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = self.Ents.vMovingDiff;
	
	eEnt.origin = pPos + vLook + vDiff;
	
	if (IsDefined(self.Ents.dMoving))
		self [[self.Ents.dMoving]]();
		
	self PropsReset();
}


// ============================================================================== //


 MenuRotate()
{
	if (IsDefined(self.Ents.fRotatingDist))
	{
		if (IsDefined(self.Ents.dFinishRotating))
			self [[self.Ents.dFinishRotating]]();
	
		eEnt = self.Ents.eHoldingEnt;
		eEnt core\include\_mapfixer::Entity_Property("angles", eEnt.angles);
	
		self core\include\clients\_vg::Menu_TurnBtnOff(1);
		self.Ents.eHoldingEnt = undefined;
		self.Ents.fRotatingDist = undefined;
		self.Ents.vRotatingStartAngles = undefined;
		return;
	}
	else if (!IsDefined(self.Ents.eSelectedEnt) 
		|| self.Ents.eSelectedEnt == self.pOwner
		|| IsDefined(self.Ents.eHoldingEnt))
	{
		self core\include\clients\_vg::Menu_TurnBtnOff(1);
		return;
	}
	
	if (IsDefined(self.Ents.dBeginRotating))
		self [[self.Ents.dBeginRotating]]();
	
	self.Ents.eHoldingEnt = self.Ents.eSelectedEnt;

	eEnt = self.Ents.eHoldingEnt;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	
	fDist = Distance(pPos, eEnt.origin);
	
	self.Ents.fRotatingDist = fDist;
	
	self.Ents.vRotatingStartAngles = eEnt.angles;
}

 RotatingUpdate()
{
	eEnt = self.Ents.eHoldingEnt;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = self.Ents.fRotatingDist;
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = vLook - (eEnt.origin - pPos);
	
	eEnt.angles = VectorToAngles(vDiff);

	if (IsDefined(self.Ents.dRotating))
		self [[self.Ents.dRotating]]();
		
	self PropsReset();
}


// ============================================================================== //


 MenuProps()
{
	if (!IsDefined(self.Ents.eSelectedEnt) 
		|| self.Ents.eSelectedEnt == self.pOwner
		|| IsDefined(self.Ents.eHoldingEnt))
	{
		return;
	}

	self core\include\clients\_vg::Menu_Clear(true, ::MenuProp_OnClose);
	self core\include\clients\_vg::Menu_RegisterBtn(0, "Prev", ::MenuProp_OnPrev);
	self core\include\clients\_vg::Menu_RegisterBtn(1, "Next", ::MenuProp_OnNext);
	self core\include\clients\_vg::Menu_RegisterBtn(2, "Select", ::MenuProp_OnSel);
	self core\include\clients\_vg::Menu_RegisterBtn(3, "Delete", ::MenuProp_OnDel);
	self core\include\clients\_vg::Menu_RegisterBtn(4, "Add", ::MenuProp_OnAdd);
	self core\include\clients\_vg::Menu_Show();
	
	self.Ents.iPropSelected = 0;
	self.Ents.eHoldingEnt = self.Ents.eSelectedEnt;
	
}

 MenuProp_OnClose()
{
	self.Ents.iPropSelected = undefined;
	self.Ents.eHoldingEnt = undefined;
}

 MenuProp_OnPrev()
{
	if (self.Ents.iPropSelected <= 0)
		self.Ents.iPropSelected = self.Ents.PropsList.size - 1;
	else
		self.Ents.iPropSelected--;
}

 MenuProp_OnNext()
{
	self.Ents.iPropSelected = (self.Ents.iPropSelected + 1) % self.Ents.PropsList.size;
}

 MenuProp_OnSel()
{
	keys = GetArrayKeys(self.Ents.PropsList);
	sKey = keys[self.Ents.iPropSelected];
	value = self.Ents.PropsList[sKey];
	
	self.Ents.sPropSelectedKey = sKey;
	self core\include\clients\_vg::TextBox_Show(sKey, ::MenuProp_OnSel_OnTextBoxOK, undefined, value);
}

 MenuProp_OnSel_OnTextBoxOK(sA, sB, sC)
{
	eEnt = self.Ents.eHoldingEnt;
	eEnt core\include\_mapfixer::Entity_Property(self.Ents.sPropSelectedKey, sA);

	self core\include\clients\_vg::TextBox_Close();
	self PropsReset();
}

 MenuProp_OnDel()
{
	keys = GetArrayKeys(self.Ents.PropsList);
	sKey = keys[self.Ents.iPropSelected];
	
	eEnt = self.Ents.eHoldingEnt;
	eEnt core\include\_mapfixer::Entity_Property(sKey, undefined);
	
	self PropsReset();
}

 MenuProp_OnAdd()
{
	self core\include\clients\_vg::TextBox_Show("New Key", ::MenuProp_OnAdd_OnTextBoxOK, undefined, "keyName", "keyValue", "str | int | float | vec");
}

 MenuProp_OnAdd_OnTextBoxOK(sA, sB, sC)
{
	if (sC == "int")
		sB = core\include\_type::StrToInt(sB);
	else if (sC == "float")
		sB = core\include\_type::StrToFloat(sB);
	else if (sC == "vec")
		sB = core\include\_type::StrToVec(sB);

	eEnt = self.Ents.eHoldingEnt;
	eEnt core\include\_mapfixer::Entity_Property(sA, sB);

	self core\include\clients\_vg::TextBox_Close();
	self PropsReset();
}


// ============================================================================== //

 MenuDelete()
{
	eEnt = self.Ents.eSelectedEnt;
	if (IsDefined(eEnt))
	{
		if (IsDefined(self.Ents.dDeleteEntBegin))
			self [[self.Ents.dDeleteEntBegin]](eEnt);
	
		eEnt core\include\_mapfixer::Entity_Delete();
	}
}

 MenuRestore()
{
	eEnt = self.Ents.eSelectedEnt;
	if (IsDefined(eEnt))
	{
		eEnt core\include\_mapfixer::Entity_Restore();
		if (IsDefined(eEnt.MF) && !IsDefined(eEnt.MF.bIsSpawned))
			eEnt core\include\_mapfixer::Entity_UnRegister();
	}	
}

 MenuSpawn()
{
	self.Ents.sSpawnEntClassName = "script_origin";
	self.Ents.sSpawnEntTargetName = "targetname";
	self.Ents.vSpawnEntOrigin = self.pOwner.origin;
	self.Ents.fSpawnEntRadius = undefined;
	self.Ents.fSpawnEntHeight = undefined;
	
	if (IsDefined(self.Ents.dSpawnEntBegin))
		self [[self.Ents.dSpawnEntBegin]]();
	
	self core\include\clients\_vg::TextBox_Show("Spawn entity", ::MenuSpawn_OnTextBoxOK, undefined, self.Ents.sSpawnEntClassName, self.Ents.sSpawnEntTargetName, self.Ents.vSpawnEntOrigin);
}

 MenuSpawn_OnTextBoxOK(sA, sB, sC)
{
	if (sB == "" || sB == "targetname")
		sB = undefined;
		
	eEnt = core\include\_mapfixer::Entity_Spawn(sA, core\include\_type::StrToVec(sC), sB, self.Ents.fSpawnEntRadius, self.Ents.fSpawnEntHeight);
	self core\include\clients\_vg::TextBox_Close();
	
	if (IsDefined(self.Ents.dSpawnEntFinish))
		self [[self.Ents.dSpawnEntFinish]](eEnt);
}