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

CreateFullName(sClassName, sTargetName, vOrigin)
{
	if (!IsDefined(sTargetName))
		sTargetName = "";
		
	return sClassName + ";" + sTargetName + ";" + vOrigin;
}

GetFullName()
{
	return CreateFullName(self.classname, self.targetname, self.origin);
}

GetValueByKey(sKeyName)
{
	switch (sKeyName)
	{
		case "ambience_inner":
			return self.ambience_inner;
		case "ambience_outer":
			return self.ambience_outer;
		case "ambient":
			return self.ambient;
		case "angles":
			return self.angles;
		case "classname":
			return self.classname;
		case "count":
			return self.count;
		case "delay":
			return self.delay;
		case "destructible_type":
			return self.destructible_type;
		case "dontdrawoncompass":
			return self.dontdrawoncompass;
		case "dontdropweapon":
			return self.dontdropweapon;
		case "export":
			return self.export;
		case "fixednodesaferadius":
			return self.fixednodesaferadius;
		case "groupname":
			return self.groupname;
		case "height":
			return self.height;
		case "name":
			return self.name;
		case "origin":
			return self.origin;
		case "radius":
			return self.radius;
		case "script_accel":
			return self.script_accel;
		case "script_accel_fraction":
			return self.script_accel_fraction;
		case "script_accumulate":
			return self.script_accumulate;
		case "script_aigroup":
			return self.script_aigroup;
		case "script_airspeed":
			return self.script_airspeed;
		case "script_allowdeath":
			return self.script_allowdeath;
		case "script_angles":
			return self.script_angles;
		case "script_anglevehicle":
			return self.script_anglevehicle;
		case "script_animation":
			return self.script_animation;
		case "script_area":
			return self.script_area;
		case "script_assaultnode":
			return self.script_assaultnode;
		case "script_attackmetype":
			return self.script_attackmetype;
		case "script_attackPattern":
			return self.script_attackPattern;
		case "script_attackspeed":
			return self.script_attackspeed;
		case "script_autosave":
			return self.script_autosave;
		case "script_autosavename":
			return self.script_autosavename;
		case "script_avoidplayer":
			return self.script_avoidplayer;
		case "script_avoidvehicles":
			return self.script_avoidvehicles;
		case "script_badplace":
			return self.script_badplace;
		case "script_balcony":
			return self.script_balcony;
		case "script_battlechatter":
			return self.script_battlechatter;
		case "script_bctrigger":
			return self.script_bctrigger;
		case "script_bg_offset":
			return self.script_bg_offset;
		case "script_bombmode_dual":
			return self.script_bombmode_dual;
		case "script_bombmode_original":
			return self.script_bombmode_original;
		case "script_bombmode_single":
			return self.script_bombmode_single;
		case "script_breach_id":
			return self.script_breach_id;
		case "script_bulletshield":
			return self.script_bulletshield;
		case "script_burst":
			return self.script_burst;
		case "script_burst_max":
			return self.script_burst_max;
		case "script_burst_min":
			return self.script_burst_min;
		case "script_cleartargetyaw":
			return self.script_cleartargetyaw;
		case "script_cobratarget":
			return self.script_cobratarget;
		case "script_color_allies":
			return self.script_color_allies;
		case "script_color_axis":
			return self.script_color_axis;
		case "script_crashtype":
			return self.script_crashtype;
		case "script_crashtypeoverride":
			return self.script_crashtypeoverride;
		case "script_damage":
			return self.script_damage;
		case "script_death":
			return self.script_death;
		case "script_death_max":
			return self.script_death_max;
		case "script_death_min":
			return self.script_death_min;
		case "script_deathflag":
			return self.script_deathflag;
		case "script_deathchain":
			return self.script_deathchain;
		case "script_deathroll":
			return self.script_deathroll;
		case "script_decel":
			return self.script_decel;
		case "script_decel_fraction":
			return self.script_decel_fraction;
		case "script_delay":
			return self.script_delay;
		case "script_delay_goto_goalmax":
			return self.script_delay_goto_goalmax;
		case "script_delay_goto_goalmin":
			return self.script_delay_goto_goalmin;
		case "script_delay_max":
			return self.script_delay_max;
		case "script_delay_min":
			return self.script_delay_min;
		case "script_delete":
			return self.script_delete;
		case "script_deleteai":
			return self.script_deleteai;
		case "script_destructable_area":
			return self.script_destructable_area;
		case "script_disconnectpaths":
			return self.script_disconnectpaths;
		case "script_displaceable":
			return self.script_displaceable;
		case "script_dont_link_turret":
			return self.script_dont_link_turret;
		case "script_dontshootwhilemoving":
			return self.script_dontshootwhilemoving;
		case "script_dot":
			return self.script_dot;
		case "script_drone":
			return self.script_drone;
		case "script_dronelag":
			return self.script_dronelag;
		case "script_drones_max":
			return self.script_drones_max;
		case "script_drones_min":
			return self.script_drones_min;
		case "script_droneStartMove":
			return self.script_droneStartMove;
		case "script_earthquake":
			return self.script_earthquake;
		case "script_emptyspawner":
			return self.script_emptyspawner;
		case "script_ender":
			return self.script_ender;
		case "script_engage":
			return self.script_engage;
		case "script_engageDelay":
			return self.script_engageDelay;
		case "script_explode":
			return self.script_explode;
		case "script_exploder":
			return self.script_exploder;
		case "script_fallback":
			return self.script_fallback;
		case "script_fallback_group":
			return self.script_fallback_group;
		case "script_falldirection":
			return self.script_falldirection;
		case "script_fightdist":
			return self.script_fightdist;
		case "script_firefx":
			return self.script_firefx;
		case "script_firefxdelay":
			return self.script_firefxdelay;
		case "script_firefxsound":
			return self.script_firefxsound;
		case "script_firefxtimeout":
			return self.script_firefxtimeout;
		case "script_fireondrones":
			return self.script_fireondrones;
		case "script_fixednode":
			return self.script_fixednode;
		case "script_flag":
			return self.script_flag;
		case "script_flag_false":
			return self.script_flag_false;
		case "script_flag_set":
			return self.script_flag_set;
		case "script_flag_true":
			return self.script_flag_true;
		case "script_flag_wait":
			return self.script_flag_wait;
		case "script_flakaicount":
			return self.script_flakaicount;
		case "script_flashbangs":
			return self.script_flashbangs;
		case "script_followmax":
			return self.script_followmax;
		case "script_followmin":
			return self.script_followmin;
		case "script_followmode":
			return self.script_followmode;
		case "script_forcecolor":
			return self.script_forcecolor;
		case "script_forcegoal":
			return self.script_forcegoal;
		case "script_forcegrenade":
			return self.script_forcegrenade;
		case "script_forcespawn":
			return self.script_forcespawn;
		case "script_forceyaw":
			return self.script_forceyaw;
		case "script_friendname":
			return self.script_friendname;
		case "script_fxcommand":
			return self.script_fxcommand;
		case "script_fxid":
			return self.script_fxid;
		case "script_fxstart":
			return self.script_fxstart;
		case "script_fxstop":
			return self.script_fxstop;
		case "script_gameobjectname":
			return self.script_gameobjectname;
		case "script_gametype_ctf":
			return self.script_gametype_ctf;
		case "script_gametype_dm":
			return self.script_gametype_dm;
		case "script_gametype_hq":
			return self.script_gametype_hq;
		case "script_gametype_sd":
			return self.script_gametype_sd;
		case "script_gametype_tdm":
			return self.script_gametype_tdm;
		case "script_gatetrigger":
			return self.script_gatetrigger;
		case "script_ghettotag":
			return self.script_ghettotag;
		case "script_goalvolume":
			return self.script_goalvolume;
		case "script_goalyaw":
			return self.script_goalyaw;
		case "script_grenades":
			return self.script_grenades;
		case "script_grenadespeed":
			return self.script_grenadespeed;
		case "script_growl":
			return self.script_growl;
		case "script_health":
			return self.script_health;
		case "script_hidden":
			return self.script_hidden;
		case "script_hint":
			return self.script_hint;
		case "script_hoverwait":
			return self.script_hoverwait;
		case "script_chance":
			return self.script_chance;
		case "script_cheap":
			return self.script_cheap;
		case "script_ignore_suppression":
			return self.script_ignore_suppression;
		case "script_ignoreme":
			return self.script_ignoreme;
		case "script_immunetoflash":
			return self.script_immunetoflash;
		case "script_increment":
			return self.script_increment;
		case "script_index":
			return self.script_index;
		case "script_keepdriver":
			return self.script_keepdriver;
		case "script_killspawner":
			return self.script_killspawner;
		case "script_killspawner_group":
			return self.script_killspawner_group;
		case "script_label":
			return self.script_label;
		case "script_landmark":
			return self.script_landmark;
		case "script_layer":
			return self.script_layer;
		case "script_light_toggle":
			return self.script_light_toggle;
		case "script_linkName":
			return self.script_linkName;
		case "script_linkTo":
			return self.script_linkTo;
		case "script_location":
			return self.script_location;
		case "script_longdeath":
			return self.script_longdeath;
		case "script_looping":
			return self.script_looping;
		case "script_mapsize_08":
			return self.script_mapsize_08;
		case "script_mapsize_16":
			return self.script_mapsize_16;
		case "script_mapsize_32":
			return self.script_mapsize_32;
		case "script_mapsize_64":
			return self.script_mapsize_64;
		case "script_maxdist":
			return self.script_maxdist;
		case "script_maxspawn":
			return self.script_maxspawn;
		case "script_mg_angle":
			return self.script_mg_angle;
		case "script_mg42auto":
			return self.script_mg42auto;
		case "script_mgturret":
			return self.script_mgturret;
		case "script_minspec_hooks_level":
			return self.script_minspec_hooks_level;
		case "script_minspec_level":
			return self.script_minspec_level;
		case "script_mortargroup":
			return self.script_mortargroup;
		case "script_moveoverride":
			return self.script_moveoverride;
		case "script_nodestate":
			return self.script_nodestate;
		case "script_noenemyinfo":
			return self.script_noenemyinfo;
		case "script_nofriendlywave":
			return self.script_nofriendlywave;
		case "script_nohealth":
			return self.script_nohealth;
		case "script_nomg":
			return self.script_nomg;
		case "script_noteworthy":
			return self.script_noteworthy;
		case "script_nowall":
			return self.script_nowall;
		case "script_objective":
			return self.script_objective;
		case "script_objective_active":
			return self.script_objective_active;
		case "script_objective_inactive":
			return self.script_objective_inactive;
		case "script_offradius":
			return self.script_offradius;
		case "script_offtime":
			return self.script_offtime;
		case "script_pacifist":
			return self.script_pacifist;
		case "script_parameters":
			return self.script_parameters;
		case "script_patroller":
			return self.script_patroller;
		case "script_personality":
			return self.script_personality;
		case "script_physics":
			return self.script_physics;
		case "script_physicsjolt":
			return self.script_physicsjolt;
		case "script_pilottalk":
			return self.script_pilottalk;
		case "script_plane":
			return self.script_plane;
		case "script_playerconeradius":
			return self.script_playerconeradius;
		case "script_playerseek":
			return self.script_playerseek;
		case "script_prefab_exploder":
			return self.script_prefab_exploder;
		case "script_presound":
			return self.script_presound;
		case "script_radius":
			return self.script_radius;
		case "script_random_killspawner":
			return self.script_random_killspawner;
		case "script_randomspawn":
			return self.script_randomspawn;
		case "script_repeat":
			return self.script_repeat;
		case "script_requires_player":
			return self.script_requires_player;
		case "script_reuse":
			return self.script_reuse;
		case "script_reuse_max":
			return self.script_reuse_max;
		case "script_reuse_min":
			return self.script_reuse_min;
		case "script_seekgoal":
			return self.script_seekgoal;
		case "script_shotcount":
			return self.script_shotcount;
		case "script_sightrange":
			return self.script_sightrange;
		case "script_skilloverride":
			return self.script_skilloverride;
		case "script_smokegroup":
			return self.script_smokegroup;
		case "script_sound":
			return self.script_sound;
		case "script_spawn_here":
			return self.script_spawn_here;
		case "script_squad":
			return self.script_squad;
		case "script_squadname":
			return self.script_squadname;
		case "script_stack":
			return self.script_stack;
		case "script_stance":
			return self.script_stance;
		case "script_start":
			return self.script_start;
		case "script_startinghealth":
			return self.script_startinghealth;
		case "script_startingposition":
			return self.script_startingposition;
		case "script_stealth_dontseek":
			return self.script_stealth_dontseek;
		case "script_stopnode":
			return self.script_stopnode;
		case "script_stoptoshoot":
			return self.script_stoptoshoot;
		case "script_suppression":
			return self.script_suppression;
		case "script_tankgroup":
			return self.script_tankgroup;
		case "script_targetoffset_z":
			return self.script_targetoffset_z;
		case "script_targettype":
			return self.script_targettype;
		case "script_team":
			return self.script_team;
		case "script_threatbiasgroup":
			return self.script_threatbiasgroup;
		case "script_threshold":
			return self.script_threshold;
		case "script_timeout":
			return self.script_timeout;
		case "script_timer":
			return self.script_timer;
		case "script_trace":
			return self.script_trace;
		case "script_trigger_group":
			return self.script_trigger_group;
		case "script_triggered_playerseek":
			return self.script_triggered_playerseek;
		case "script_triggername":
			return self.script_triggername;
		case "script_turningdir":
			return self.script_turningdir;
		case "script_turret":
			return self.script_turret;
		case "script_turret_ambush":
			return self.script_turret_ambush;
		case "script_turret_share":
			return self.script_turret_share;
		case "script_turretmg":
			return self.script_turretmg;
		case "script_unload":
			return self.script_unload;
		case "script_unloaddelay":
			return self.script_unloaddelay;
		case "script_unloadmgguy":
			return self.script_unloadmgguy;
		case "script_usemg42":
			return self.script_usemg42;
		case "script_vehicle_lights_off":
			return self.script_vehicle_lights_off;
		case "script_vehicle_lights_on":
			return self.script_vehicle_lights_on;
		case "script_vehicle_selfremove":
			return self.script_vehicle_selfremove;
		case "script_vehicleaianim":
			return self.script_vehicleaianim;
		case "script_vehicledetour":
			return self.script_vehicledetour;
		case "script_vehicledetourgroup":
			return self.script_vehicledetourgroup;
		case "script_vehicledetourtype":
			return self.script_vehicledetourtype;
		case "script_vehiclegroup":
			return self.script_vehiclegroup;
		case "script_vehicleGroupDelete":
			return self.script_vehicleGroupDelete;
		case "script_vehiclenodegroup":
			return self.script_vehiclenodegroup;
		case "script_vehicleride":
			return self.script_vehicleride;
		case "script_VehicleSpawngroup":
			return self.script_VehicleSpawngroup;
		case "script_VehicleStartMove":
			return self.script_VehicleStartMove;
		case "script_vehicletriggergroup":
			return self.script_vehicletriggergroup;
		case "script_vehiclewalk":
			return self.script_vehiclewalk;
		case "script_wait":
			return self.script_wait;
		case "script_wait_add":
			return self.script_wait_add;
		case "script_wait_max":
			return self.script_wait_max;
		case "script_wait_min":
			return self.script_wait_min;
		case "script_wheeldirection":
			return self.script_wheeldirection;
		case "script_wingman":
			return self.script_wingman;
		case "script_wtf":
			return self.script_wtf;
		case "script_yawspeed":
			return self.script_yawspeed;
		case "spawner_id":
			return self.spawner_id;
		case "spawnflags":
			return self.spawnflags;
		case "speed":
			return self.speed;
		case "squadnum":
			return self.squadnum;
		case "target":
			return self.target;
		case "targetname":
			return self.targetname;
		case "vehicletype":
			return self.vehicletype;
		case "weaponinfo":
			return self.weaponinfo;
		default:
			return undefined;
	}
}

SetValueByKey(sKeyName, value)
{
	switch (sKeyName)
	{
		case "ambience_inner":
			self.ambience_inner = value;
			break;
		case "ambience_outer":
			self.ambience_outer = value;
			break;
		case "ambient":
			self.ambient = value;
			break;
		case "angles":
			if (IsString(value))
				value = core\include\_type::StrToVec(value);
			self.angles = value;
			break;
		case "classname":
			self.classname = value;
			break;
		case "count":
			if (IsString(value))
				value = core\include\_type::StrToInt(value);
			self.count = value;
			break;
		case "delay":
			self.delay = value;
			break;
		case "destructible_type":
			self.destructible_type = value;
			break;
		case "dmg":
			if (IsString(value))
				value = core\include\_type::StrToInt(value);
			self.dmg = value;
			break;
		case "dontdrawoncompass":
			self.dontdrawoncompass = value;
			break;
		case "dontdropweapon":
			self.dontdropweapon = value;
			break;
		case "export":
			self.export = value;
			break;
		case "fixednodesaferadius":
			self.fixednodesaferadius = value;
			break;
		case "groupname":
			self.groupname = value;
			break;
		case "height":
			if (IsString(value))
				value = core\include\_type::StrToInt(value);
			self.height = value;
			break;
		case "name":
			self.name = value;
			break;
		case "origin":
			if (IsString(value))
				value = core\include\_type::StrToVec(value);
			self.origin = value;
			break;
		case "radius":
			if (IsString(value))
				value = core\include\_type::StrToInt(value);
			self.radius = value;
			break;
		case "script_accel":
			self.script_accel = value;
			break;
		case "script_accel_fraction":
			self.script_accel_fraction = value;
			break;
		case "script_accumulate":
			self.script_accumulate = value;
			break;
		case "script_aigroup":
			self.script_aigroup = value;
			break;
		case "script_airspeed":
			self.script_airspeed = value;
			break;
		case "script_allowdeath":
			self.script_allowdeath = value;
			break;
		case "script_angles":
			self.script_angles = value;
			break;
		case "script_anglevehicle":
			self.script_anglevehicle = value;
			break;
		case "script_animation":
			self.script_animation = value;
			break;
		case "script_area":
			self.script_area = value;
			break;
		case "script_assaultnode":
			self.script_assaultnode = value;
			break;
		case "script_attackmetype":
			self.script_attackmetype = value;
			break;
		case "script_attackPattern":
			self.script_attackPattern = value;
			break;
		case "script_attackspeed":
			self.script_attackspeed = value;
			break;
		case "script_autosave":
			self.script_autosave = value;
			break;
		case "script_autosavename":
			self.script_autosavename = value;
			break;
		case "script_avoidplayer":
			self.script_avoidplayer = value;
			break;
		case "script_avoidvehicles":
			self.script_avoidvehicles = value;
			break;
		case "script_badplace":
			self.script_badplace = value;
			break;
		case "script_balcony":
			self.script_balcony = value;
			break;
		case "script_battlechatter":
			self.script_battlechatter = value;
			break;
		case "script_bctrigger":
			self.script_bctrigger = value;
			break;
		case "script_bg_offset":
			self.script_bg_offset = value;
			break;
		case "script_bombmode_dual":
			self.script_bombmode_dual = value;
			break;
		case "script_bombmode_original":
			self.script_bombmode_original = value;
			break;
		case "script_bombmode_single":
			self.script_bombmode_single = value;
			break;
		case "script_breach_id":
			self.script_breach_id = value;
			break;
		case "script_bulletshield":
			self.script_bulletshield = value;
			break;
		case "script_burst":
			self.script_burst = value;
			break;
		case "script_burst_max":
			self.script_burst_max = value;
			break;
		case "script_burst_min":
			self.script_burst_min = value;
			break;
		case "script_cleartargetyaw":
			self.script_cleartargetyaw = value;
			break;
		case "script_cobratarget":
			self.script_cobratarget = value;
			break;
		case "script_color_allies":
			self.script_color_allies = value;
			break;
		case "script_color_axis":
			self.script_color_axis = value;
			break;
		case "script_crashtype":
			self.script_crashtype = value;
			break;
		case "script_crashtypeoverride":
			self.script_crashtypeoverride = value;
			break;
		case "script_damage":
			self.script_damage = value;
			break;
		case "script_death":
			self.script_death = value;
			break;
		case "script_death_max":
			self.script_death_max = value;
			break;
		case "script_death_min":
			self.script_death_min = value;
			break;
		case "script_deathflag":
			self.script_deathflag = value;
			break;
		case "script_deathchain":
			self.script_deathchain = value;
			break;
		case "script_deathroll":
			self.script_deathroll = value;
			break;
		case "script_decel":
			self.script_decel = value;
			break;
		case "script_decel_fraction":
			self.script_decel_fraction = value;
			break;
		case "script_delay":
			self.script_delay = value;
			break;
		case "script_delay_goto_goalmax":
			self.script_delay_goto_goalmax = value;
			break;
		case "script_delay_goto_goalmin":
			self.script_delay_goto_goalmin = value;
			break;
		case "script_delay_max":
			self.script_delay_max = value;
			break;
		case "script_delay_min":
			self.script_delay_min = value;
			break;
		case "script_delete":
			self.script_delete = value;
			break;
		case "script_deleteai":
			self.script_deleteai = value;
			break;
		case "script_destructable_area":
			self.script_destructable_area = value;
			break;
		case "script_disconnectpaths":
			self.script_disconnectpaths = value;
			break;
		case "script_displaceable":
			self.script_displaceable = value;
			break;
		case "script_dont_link_turret":
			self.script_dont_link_turret = value;
			break;
		case "script_dontshootwhilemoving":
			self.script_dontshootwhilemoving = value;
			break;
		case "script_dot":
			self.script_dot = value;
			break;
		case "script_drone":
			self.script_drone = value;
			break;
		case "script_dronelag":
			self.script_dronelag = value;
			break;
		case "script_drones_max":
			self.script_drones_max = value;
			break;
		case "script_drones_min":
			self.script_drones_min = value;
			break;
		case "script_droneStartMove":
			self.script_droneStartMove = value;
			break;
		case "script_earthquake":
			self.script_earthquake = value;
			break;
		case "script_emptyspawner":
			self.script_emptyspawner = value;
			break;
		case "script_ender":
			self.script_ender = value;
			break;
		case "script_engage":
			self.script_engage = value;
			break;
		case "script_engageDelay":
			self.script_engageDelay = value;
			break;
		case "script_explode":
			self.script_explode = value;
			break;
		case "script_exploder":
			self.script_exploder = value;
			break;
		case "script_fallback":
			self.script_fallback = value;
			break;
		case "script_fallback_group":
			self.script_fallback_group = value;
			break;
		case "script_falldirection":
			self.script_falldirection = value;
			break;
		case "script_fightdist":
			self.script_fightdist = value;
			break;
		case "script_firefx":
			self.script_firefx = value;
			break;
		case "script_firefxdelay":
			self.script_firefxdelay = value;
			break;
		case "script_firefxsound":
			self.script_firefxsound = value;
			break;
		case "script_firefxtimeout":
			self.script_firefxtimeout = value;
			break;
		case "script_fireondrones":
			self.script_fireondrones = value;
			break;
		case "script_fixednode":
			self.script_fixednode = value;
			break;
		case "script_flag":
			self.script_flag = value;
			break;
		case "script_flag_false":
			self.script_flag_false = value;
			break;
		case "script_flag_set":
			self.script_flag_set = value;
			break;
		case "script_flag_true":
			self.script_flag_true = value;
			break;
		case "script_flag_wait":
			self.script_flag_wait = value;
			break;
		case "script_flakaicount":
			self.script_flakaicount = value;
			break;
		case "script_flashbangs":
			self.script_flashbangs = value;
			break;
		case "script_followmax":
			self.script_followmax = value;
			break;
		case "script_followmin":
			self.script_followmin = value;
			break;
		case "script_followmode":
			self.script_followmode = value;
			break;
		case "script_forcecolor":
			self.script_forcecolor = value;
			break;
		case "script_forcegoal":
			self.script_forcegoal = value;
			break;
		case "script_forcegrenade":
			self.script_forcegrenade = value;
			break;
		case "script_forcespawn":
			self.script_forcespawn = value;
			break;
		case "script_forceyaw":
			self.script_forceyaw = value;
			break;
		case "script_friendname":
			self.script_friendname = value;
			break;
		case "script_fxcommand":
			self.script_fxcommand = value;
			break;
		case "script_fxid":
			self.script_fxid = value;
			break;
		case "script_fxstart":
			self.script_fxstart = value;
			break;
		case "script_fxstop":
			self.script_fxstop = value;
			break;
		case "script_gameobjectname":
			self.script_gameobjectname = value;
			break;
		case "script_gametype_ctf":
			self.script_gametype_ctf = value;
			break;
		case "script_gametype_dm":
			self.script_gametype_dm = value;
			break;
		case "script_gametype_hq":
			self.script_gametype_hq = value;
			break;
		case "script_gametype_sd":
			self.script_gametype_sd = value;
			break;
		case "script_gametype_tdm":
			self.script_gametype_tdm = value;
			break;
		case "script_gatetrigger":
			self.script_gatetrigger = value;
			break;
		case "script_ghettotag":
			self.script_ghettotag = value;
			break;
		case "script_goalvolume":
			self.script_goalvolume = value;
			break;
		case "script_goalyaw":
			self.script_goalyaw = value;
			break;
		case "script_grenades":
			self.script_grenades = value;
			break;
		case "script_grenadespeed":
			self.script_grenadespeed = value;
			break;
		case "script_growl":
			self.script_growl = value;
			break;
		case "script_health":
			self.script_health = value;
			break;
		case "script_hidden":
			self.script_hidden = value;
			break;
		case "script_hint":
			self.script_hint = value;
			break;
		case "script_hoverwait":
			self.script_hoverwait = value;
			break;
		case "script_chance":
			self.script_chance = value;
			break;
		case "script_cheap":
			self.script_cheap = value;
			break;
		case "script_ignore_suppression":
			self.script_ignore_suppression = value;
			break;
		case "script_ignoreme":
			self.script_ignoreme = value;
			break;
		case "script_immunetoflash":
			self.script_immunetoflash = value;
			break;
		case "script_increment":
			self.script_increment = value;
			break;
		case "script_index":
			self.script_index = value;
			break;
		case "script_keepdriver":
			self.script_keepdriver = value;
			break;
		case "script_killspawner":
			self.script_killspawner = value;
			break;
		case "script_killspawner_group":
			self.script_killspawner_group = value;
			break;
		case "script_label":
			self.script_label = value;
			break;
		case "script_landmark":
			self.script_landmark = value;
			break;
		case "script_layer":
			self.script_layer = value;
			break;
		case "script_light_toggle":
			self.script_light_toggle = value;
			break;
		case "script_linkName":
			self.script_linkName = value;
			break;
		case "script_linkTo":
			self.script_linkTo = value;
			break;
		case "script_location":
			self.script_location = value;
			break;
		case "script_longdeath":
			self.script_longdeath = value;
			break;
		case "script_looping":
			self.script_looping = value;
			break;
		case "script_mapsize_08":
			self.script_mapsize_08 = value;
			break;
		case "script_mapsize_16":
			self.script_mapsize_16 = value;
			break;
		case "script_mapsize_32":
			self.script_mapsize_32 = value;
			break;
		case "script_mapsize_64":
			self.script_mapsize_64 = value;
			break;
		case "script_maxdist":
			self.script_maxdist = value;
			break;
		case "script_maxspawn":
			self.script_maxspawn = value;
			break;
		case "script_mg_angle":
			self.script_mg_angle = value;
			break;
		case "script_mg42auto":
			self.script_mg42auto = value;
			break;
		case "script_mgturret":
			self.script_mgturret = value;
			break;
		case "script_minspec_hooks_level":
			self.script_minspec_hooks_level = value;
			break;
		case "script_minspec_level":
			self.script_minspec_level = value;
			break;
		case "script_mortargroup":
			self.script_mortargroup = value;
			break;
		case "script_moveoverride":
			self.script_moveoverride = value;
			break;
		case "script_nodestate":
			self.script_nodestate = value;
			break;
		case "script_noenemyinfo":
			self.script_noenemyinfo = value;
			break;
		case "script_nofriendlywave":
			self.script_nofriendlywave = value;
			break;
		case "script_nohealth":
			self.script_nohealth = value;
			break;
		case "script_nomg":
			self.script_nomg = value;
			break;
		case "script_noteworthy":
			self.script_noteworthy = value;
			break;
		case "script_nowall":
			self.script_nowall = value;
			break;
		case "script_objective":
			self.script_objective = value;
			break;
		case "script_objective_active":
			self.script_objective_active = value;
			break;
		case "script_objective_inactive":
			self.script_objective_inactive = value;
			break;
		case "script_offradius":
			self.script_offradius = value;
			break;
		case "script_offtime":
			self.script_offtime = value;
			break;
		case "script_pacifist":
			self.script_pacifist = value;
			break;
		case "script_parameters":
			self.script_parameters = value;
			break;
		case "script_patroller":
			self.script_patroller = value;
			break;
		case "script_personality":
			self.script_personality = value;
			break;
		case "script_physics":
			self.script_physics = value;
			break;
		case "script_physicsjolt":
			self.script_physicsjolt = value;
			break;
		case "script_pilottalk":
			self.script_pilottalk = value;
			break;
		case "script_plane":
			self.script_plane = value;
			break;
		case "script_playerconeradius":
			self.script_playerconeradius = value;
			break;
		case "script_playerseek":
			self.script_playerseek = value;
			break;
		case "script_prefab_exploder":
			self.script_prefab_exploder = value;
			break;
		case "script_presound":
			self.script_presound = value;
			break;
		case "script_radius":
			self.script_radius = value;
			break;
		case "script_random_killspawner":
			self.script_random_killspawner = value;
			break;
		case "script_randomspawn":
			self.script_randomspawn = value;
			break;
		case "script_repeat":
			self.script_repeat = value;
			break;
		case "script_requires_player":
			self.script_requires_player = value;
			break;
		case "script_reuse":
			self.script_reuse = value;
			break;
		case "script_reuse_max":
			self.script_reuse_max = value;
			break;
		case "script_reuse_min":
			self.script_reuse_min = value;
			break;
		case "script_seekgoal":
			self.script_seekgoal = value;
			break;
		case "script_shotcount":
			self.script_shotcount = value;
			break;
		case "script_sightrange":
			self.script_sightrange = value;
			break;
		case "script_skilloverride":
			self.script_skilloverride = value;
			break;
		case "script_smokegroup":
			self.script_smokegroup = value;
			break;
		case "script_sound":
			self.script_sound = value;
			break;
		case "script_spawn_here":
			self.script_spawn_here = value;
			break;
		case "script_squad":
			self.script_squad = value;
			break;
		case "script_squadname":
			self.script_squadname = value;
			break;
		case "script_stack":
			self.script_stack = value;
			break;
		case "script_stance":
			self.script_stance = value;
			break;
		case "script_start":
			self.script_start = value;
			break;
		case "script_startinghealth":
			self.script_startinghealth = value;
			break;
		case "script_startingposition":
			self.script_startingposition = value;
			break;
		case "script_stealth_dontseek":
			self.script_stealth_dontseek = value;
			break;
		case "script_stopnode":
			self.script_stopnode = value;
			break;
		case "script_stoptoshoot":
			self.script_stoptoshoot = value;
			break;
		case "script_suppression":
			self.script_suppression = value;
			break;
		case "script_tankgroup":
			self.script_tankgroup = value;
			break;
		case "script_targetoffset_z":
			self.script_targetoffset_z = value;
			break;
		case "script_targettype":
			self.script_targettype = value;
			break;
		case "script_team":
			self.script_team = value;
			break;
		case "script_threatbiasgroup":
			self.script_threatbiasgroup = value;
			break;
		case "script_threshold":
			self.script_threshold = value;
			break;
		case "script_timeout":
			self.script_timeout = value;
			break;
		case "script_timer":
			self.script_timer = value;
			break;
		case "script_trace":
			self.script_trace = value;
			break;
		case "script_trigger_group":
			self.script_trigger_group = value;
			break;
		case "script_triggered_playerseek":
			self.script_triggered_playerseek = value;
			break;
		case "script_triggername":
			self.script_triggername = value;
			break;
		case "script_turningdir":
			self.script_turningdir = value;
			break;
		case "script_turret":
			self.script_turret = value;
			break;
		case "script_turret_ambush":
			self.script_turret_ambush = value;
			break;
		case "script_turret_share":
			self.script_turret_share = value;
			break;
		case "script_turretmg":
			self.script_turretmg = value;
			break;
		case "script_unload":
			self.script_unload = value;
			break;
		case "script_unloaddelay":
			self.script_unloaddelay = value;
			break;
		case "script_unloadmgguy":
			self.script_unloadmgguy = value;
			break;
		case "script_usemg42":
			self.script_usemg42 = value;
			break;
		case "script_vehicle_lights_off":
			self.script_vehicle_lights_off = value;
			break;
		case "script_vehicle_lights_on":
			self.script_vehicle_lights_on = value;
			break;
		case "script_vehicle_selfremove":
			self.script_vehicle_selfremove = value;
			break;
		case "script_vehicleaianim":
			self.script_vehicleaianim = value;
			break;
		case "script_vehicledetour":
			self.script_vehicledetour = value;
			break;
		case "script_vehicledetourgroup":
			self.script_vehicledetourgroup = value;
			break;
		case "script_vehicledetourtype":
			self.script_vehicledetourtype = value;
			break;
		case "script_vehiclegroup":
			self.script_vehiclegroup = value;
			break;
		case "script_vehicleGroupDelete":
			self.script_vehicleGroupDelete = value;
			break;
		case "script_vehiclenodegroup":
			self.script_vehiclenodegroup = value;
			break;
		case "script_vehicleride":
			self.script_vehicleride = value;
			break;
		case "script_VehicleSpawngroup":
			self.script_VehicleSpawngroup = value;
			break;
		case "script_VehicleStartMove":
			self.script_VehicleStartMove = value;
			break;
		case "script_vehicletriggergroup":
			self.script_vehicletriggergroup = value;
			break;
		case "script_vehiclewalk":
			self.script_vehiclewalk = value;
			break;
		case "script_wait":
			self.script_wait = value;
			break;
		case "script_wait_add":
			self.script_wait_add = value;
			break;
		case "script_wait_max":
			self.script_wait_max = value;
			break;
		case "script_wait_min":
			self.script_wait_min = value;
			break;
		case "script_wheeldirection":
			self.script_wheeldirection = value;
			break;
		case "script_wingman":
			self.script_wingman = value;
			break;
		case "script_wtf":
			self.script_wtf = value;
			break;
		case "script_yawspeed":
			self.script_yawspeed = value;
			break;
		case "spawner_id":
			self.spawner_id = value;
			break;
		//case "spawnflags":
			//self.spawnflags = value;
			//break;
		case "speed":
			self.speed = value;
			break;
		case "squadnum":
			self.squadnum = value;
			break;
		case "target":
			self.target = value;
			break;
		case "targetname":
			self.targetname = value;
			break;
		case "vehicletype":
			self.vehicletype = value;
			break;
		case "weaponinfo":
			self.weaponinfo = value;
			break;
		default:
			break;
	}
}