/*
##############################################################################
##|       |##\  \####/  /##|        |##|        |##|        |##|   \####|  |##
##|   _   |###\  \##/  /###|  ______|##|   __   |##|   __   |##|    \###|  |##
##|  |_|  |####\  \/  /####|  |########|  |  |  |##|  |  |  |##|  \  \##|  |##
##|       |#####\    /#####|  |########|  |  |  |##|  |  |  |##|  |\  \#|  |##
##|       |######|  |######|  |########|  |  |  |##|  |  |  |##|  |#\  \|  |##
##|  |\  \#######|  |######|  |########|  |__|  |##|  |__|  |##|  |##\  |  |##
##|  |#\  \######|  |######|        |##|        |##|        |##|  |###\    |##
##|__|##\__\#####|__|######|________|##|________|##|________|##|__|####\___|##
##############################################################################

	Scripts and map made by Rycoon!
|*************************************|
	Xfire: phaedrean
*/

main()
{
  	maps\mp\_load::main();
	maps\mp\mp_deathrun_azteca_rotate::main();
	maps\mp\mp_deathrun_azteca_slider::main();
	maps\mp\mp_deathrun_azteca_slite::main();
	maps\mp\_compass::setupMiniMap ("compass_map_mp_deathrun_fnrp_azteca");

	game["allies"] = "sas";
	game["axis"] = "russian";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".1");
	setdvar("r_glowbloomintensity1",".1");
	setdvar("r_glowskybleedintensity0",".1");
	setdvar("compassmaxrange","1400");
	
	thread gorocks();
	thread controlbigdoor();
	thread MakeTriggers();
	thread onConnected();
	thread WatchGame();
	thread AddTestClients();

}

onConnected()
{
	while(1)
	{
		level waittill("connected", player );
		player.isSliding = false;
		player.glitching = false;
	}
}
MakeTriggers()
{
	wait 0.5;
	level.trapTriggers[0] = getent("trigger1", "targetname");
	level.trapTriggers[1] = getent("trigger2", "targetname");
	level.trapTriggers[2] = getent("trigger3", "targetname");
	level.trapTriggers[3] = getent("trigger4", "targetname");
	level.trapTriggers[4] = getent("trigger5", "targetname");
	level.trapTriggers[5] = getent("trigger6", "targetname");
	level.trapTriggers[6] = getent("trigger7", "targetname");
	level.trapTriggers[7] = getent("trigger8", "targetname");
	
	
	level.trapTriggers[0] thread Watchespinas1();
	level.trapTriggers[1] thread Watchrools1();
	level.trapTriggers[2] thread Watchrools2();
	level.trapTriggers[3] thread Watchrools3();
	level.trapTriggers[4] thread Watchespinas2();
	level.trapTriggers[5] thread Watchrools4();
	level.trapTriggers[6] thread Watchrools5();
	level.trapTriggers[7] thread Watchrools6();
}


Watchespinas1()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread goespinas1();
		wait (3);
	}
}
Watchrools1()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread gorools1();
		wait (3);
	}
}
Watchrools2()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread gorools2();
		wait (3);
	}
}

Watchrools3()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread gorools3();
		wait (3);
	}
}

Watchespinas2()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread goespinas2();
		wait (3);
	}
}
Watchrools4()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread gorools4();
		wait (3);
	}
}
Watchrools5()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread gorools5();
		wait (3);
	}
}

Watchrools6()
{
	while(1)
	{
		self waittill("trigger");
		iprintln( "^2"+ self.name + " ^2Activated a trap" );
		thread gorools6();
		wait (3);
	}
}

controlbigdoor()
{
	ctrldoor = getent("openbigdoor", "targetname");	
	
	while(1)
	{
		ctrldoor waittill("trigger", player);
		
		player deathrun\include\_mapper::CFinishMap();
		
		iprintln( "^2"+ player.name + " ^2opened the big door" );
		thread opendoor();
		break;
	}
}

goespinas1()
{
	espinas1_obj = getent("espinas1","targetname");
		espinas1_obj playsound ("blade_slice");
		espinas1_obj movez (106,3,0,0.6); 
		espinas1_obj waittill ("movedone"); 
		wait (1);
		espinas1_obj playsound ("blade_slice"); 
		espinas1_obj movez (-106,3,0,0.6);  
		espinas1_obj waittill ("movedone"); 
		wait (3); 
}
goespinas2()
{
	espinas2_obj =getent ("espinas2","targetname");
		
		espinas2_obj playsound ("blade_slice");
		espinas2_obj  movez (106,3,0,0.6); 
		espinas2_obj waittill ("movedone"); 
		wait (1); 
		espinas2_obj playsound ("blade_slice");
		espinas2_obj  movez (-106,3,0,0.6);  
		espinas2_obj waittill ("movedone"); 
		wait (2); 
}

gorools1()
{
	rools1_obj = getent ("rools1","targetname");
		rools1_obj playsound ("blade_slice");
		rools1_obj rotatePitch(-360,5);
		rools1_obj waittill ("movedone"); 
		wait (3); 
}
gorools2()
{
	rools2_obj = getent ("rools2","targetname");
		rools2_obj playsound ("blade_slice");
		rools2_obj rotatePitch(-360,7);
		rools2_obj waittill ("movedone"); 
		wait (3); 

}

gorools3()
{
	rools3_obj = getent ("rools3","targetname");
		rools3_obj playsound ("blade_slice");
		rools3_obj rotateYaw(-360,7);
		rools3_obj waittill ("movedone"); 
		wait (3); 
}

gorools4()
{
	rools4_obj = getent ("rools4","targetname");
		rools4_obj playsound ("blade_slice");
		rools4_obj rotatePitch(-360,20);
		rools4_obj waittill ("movedone"); 
		wait (3); 
}
gorools5()
{
	rools5_obj = getent ("rools5","targetname");
		rools5_obj playsound ("blade_slice");
		rools5_obj rotatePitch(360,20);
		rools5_obj waittill ("movedone"); 
		wait (3); 
}
gorools6()
{
	rools6_obj = getent ("rools6","targetname");
		rools6_obj playsound ("blade_slice");
		rools6_obj rotateYaw(-360,7);
		rools6_obj waittill ("movedone"); 
		wait (3); 
}


gorocks()
{
	rocks1_obj = getent("rocks1","targetname");
	rocks2_obj = getent("rocks2","targetname");

	while(1)
	{
		rocks1_obj playsound ("blade_slice");
		rocks1_obj movex (-106,2,0,0.6);
		wait (1);
		rocks2_obj movex (-106,2,0,0.6); 
		rocks1_obj waittill ("movedone"); 
		wait (2);
		rocks1_obj playsound ("blade_slice");
		rocks1_obj movex (106,2,0,0.6);
		wait (1);
		rocks2_obj movex (106,2,0,0.6); 
		rocks1_obj waittill ("movedone"); 
		wait (2); 
	}
}



opendoor()
{
	
	door1_obj = getent("bigdoor1","targetname");
	door2_obj = getent("bigdoor2","targetname");
		
		door1_obj playsound ("blade_slice");
		door2_obj playsound ("blade_slice");
		door1_obj movez (-150,2,0,0.6);
		door2_obj movez (-150,2,0,0.6); 		
}
WatchGame()
{
	level.finalfight = false;
	
	while(1)
	{
		level waittill("activator", who );
		thread GetGlitchTriggers();
		thread DoAmbient();
		who thread AntiFreeTraps();
	}
}

AntiFreeTraps()
{
	if( getDvarInt("scr_activator_freerun") != 1 )
		return;
	
	self FreezeControls(1);
	wait getDvarInt("scr_activator_freerun_wait");
	self FreezeControls(0);
}

GetGlitchTriggers()
{
	triggers = getentarray("glitch_trigger", "targetname");
	for(i=0;i<triggers.size;i++)
		triggers[i] thread WatchGlitchTrigger();
}

WatchGlitchTrigger()
{
	while(1)
	{
		self waittill("trigger", who );
		if( !level.freeRun && !who.glitching )
			who thread DoAntiGlitcher();
	}
}

DoAntiGlitcher()
{
	self.glitching = true;
	self FreezeControls(1);
	self iprintlnbold("^1HAHAHAHA! CAUGHT YOU GLITCHER! >:)");
	self PlayLocalSound("laughing");
	wait 4;
	self iprintlnbold("^3Wanna see something cool, hmm? >:)");
	self SetClientDvar("cg_thirdperson", 1 );
	wait 4;
	self iprintlnbold("^1BUUUUUUUUUUUUUUUUURN! HAHAHA!!!");
	wait 2;
	iprintlnbold("^1LOOK! ^7" + self.name + " ^1is BURNING due to glitching!");
	iprintlnbold("^1HUAHAHAHA!");
	self SetClientDvar("cg_thirdperson", 0 );
	wait 8;
	self.glitching = false;
}

DoAmbient()
{
	AmbientStop(0);
	MusicStop(0);
	wait 0.1;
	allies = GetTeamPlayersAlive("allies");
	AmbientPlay("ambient"+(1+RandomInt(2)));
	thread WatchIfAllDead();
	if( allies == 1 )		//when only 1 jumper left at start then dont play last jumper music
		return;
	
	while(1)
	{
		if( getTeamPlayersAlive("allies") == 1 && !level.finalfight)
		{
			AmbientStop(1);
			MusicStop(1);
			wait 1;
			AmbientPlay("lastjumper"+(1+RandomInt(2)));
			players = getentarray("player", "classname");
			for(i=0;i<players.size;i++)
			{
				if( players[i].pers["team"] == "allies" && isAlive(players[i]) )
				{
					iprintln( players[i].name + " is the last alive jumper!");
					break;
				}
			}
			break;
		}
		wait 0.1;
	}
}
WatchIfAllDead()
{
	while(1)
	{
		if( getTeamPlayersAlive("allies") < 1 || getTeamPlayersAlive("axis") < 1 )
		{
			AmbientStop(1);
			break;
		}
		wait 0.2;
	}
}

WatchEndTrigger()
{
	level.acti_enemy = undefined;
	while(1)
	{
		self waittill("trigger", who );
		if( getTeamPlayersAlive("axis") < 1 )
			return;
		if( getTeamPlayersAlive("allies") == 1 )
		{
			thread StartFinalFight();
			self delete();
			break;
		}
		else if( getTeamPlayersAlive("allies") > 1 )
		{
			if( isDefined( level.acti_enemy ) && isAlive(level.acti_enemy) && level.acti_enemy != who )
			{
				who suicide();
				who iprintlnbold("^11 VS 1 Noob! ^2You wasnt first, get a life!");
			}
			if( !isDefined(level.acti_enemy) || !isAlive(level.acti_enemy))
			{
				level.acti_enemy = who;
				iprintlnbold( who.name + " ^1reached as first the end hall!");
				iprintlnbold("^11 VS 1 Fight!");
				acti = undefined;
				players = getentarray("player", "classname");
				for(i=0;i<players.size;i++)
				{
					if( players[i].pers["team"] == "axis" )
					{
						acti = players[i];
						break;
					}
				}
				starta = getent("finalfight_activator", "targetname");
				acti SetPlayerAngles( starta.angles );
				acti SetOrigin( starta.origin );
			}
		}
	}
}

StartFinalFight()
{
	acti = undefined;
	jumper = undefined;
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( players[i].pers["team"] == "axis" && isAlive(players[i]) )
		{
			acti = players[i];
			break;
		}
	}
	for(i=0;i<players.size;i++)
	{
		if( players[i].pers["team"] == "allies" && isAlive(players[i]) )
		{
			jumper = players[i];
			break;
		}
	}
	
	startj = getent("finalfight_jumper", "targetname");
	starta = getent("finalfight_activator", "targetname");
	
	jumper SetPlayerAngles( startj.angles );
	jumper SetOrigin( startj.origin );
	jumper TakeAllWeapons();
	jumper GiveWeapon("knife_mp");
	jumper SetSpawnWeapon("knife_mp");
	jumper FreezeControls(1);
	acti SetPlayerAngles( starta.angles );
	acti SetOrigin( starta.origin );
	acti TakeAllWeapons();
	acti GiveWeapon("knife_mp");
	acti SetSpawnWeapon("knife_mp");
	acti FreezeControls(1);
	
	VisionSetNaked( "finalfight_intro_mp", 2 );
	wait 2;
	
	fire = getentarray("finalfight_fire", "targetname");
	for(i=0;i<fire.size;i++)
	{
		fire[i].origin += (0,0,50);
		PlayFXOnTag( level.finalfight_fire, fire[i], "tag_origin" );
	}
	wait 0.2;
	embers = getent("finalfight_embers", "targetname");
	for(i=0;i<5;i++)
		PlayFX( level.finalfight_embers, embers.origin+(RandomIntRange(-256,256),RandomIntRange(-256,256),0) );
	wait 0.2;
	distortion = getentarray("finalfight_distortion", "targetname");
	for(i=0;i<distortion.size;i++)
		PlayFXOnTag( level.finalfight_distortion, distortion[i], "tag_origin" );
	wait 0.2;
	
	AmbientPlay("finalfight"+(1+RandomInt(2)));
	
	noti = SpawnStruct();
	noti.titleText = "=|FINAL FIGHT|=";
	noti.notifyText = "1 VS 1 Knife!";
	noti.duration = 5;
	noti.glowcolor = (1,0,0);
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	
	wait 5;
	
	noti = SpawnStruct();
	noti.titleText = acti.name + " ^1VS ^7" + jumper.name;
	noti.notifyText = "GET READY!";
	noti.duration = 5;
	noti.glowcolor = (1,0,0);
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
		players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
	
	wait 5;
	
	VisionSetNaked( "finalfight_mp", 2 );
	jumper FreezeControls(0);
	acti FreezeControls(0);
	
	iprintlnbold("^1F  I  G  H  T !");
}

addTestClients()
{
	setDvar("scr_testclients", "");
	wait 1;
	for(;;)
	{
		if(getdvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}
	testclients = getdvarInt("scr_testclients");
	setDvar( "scr_testclients", 0 );
	for(i=0;i<testclients;i++)
	{
		ent[i] = addtestclient();

		if (!isdefined(ent[i]))
		{
			println("Could not add test client");
			wait 1;
			continue;
		}
		ent[i].pers["isBot"] = true;
		ent[i] thread TestClient("autoassign");
	}
	thread addTestClients();
}

TestClient(team)
{
	self endon( "disconnect" );

	while(!isdefined(self.pers["team"]))
		wait .05;
		
	self notify("menuresponse", game["menu_team"], team);
	wait 0.5;
}
 