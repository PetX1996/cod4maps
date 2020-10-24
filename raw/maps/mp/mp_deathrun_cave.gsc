main()
{
	maps\mp\_load::main();
	game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";
	
	level.wall_explosion = LoadFX("explosions/wall_explosion_small");
	level.wall_cinderblock = LoadFX("breakables/exp_wall_cinderblock_96");
	level.wall_vehicle = LoadFX("explosions/large_vehicle_explosion");
	PreCacheShellShock( "frag_grenade_mp" );
	PreCacheItem("deserteagle_mp");
	
	thread wallbreach();
	thread findharry();
	thread secret();
	thread finaldoor();
	thread glitch();
	thread CheckLastMan();
	thread findFearz();
	thread secret2();
	thread secret3();
	thread text();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread trap9();
	thread trap10();
	
    addTriggerToList( "trap1_trigger" );
    addTriggerToList( "trap2_trigger" );
    addTriggerToList( "trap3_trigger" );
    addTriggerToList( "trap4_trigger" ); 
    addTriggerToList( "trap5_trigger" );
    addTriggerToList( "trap6_trigger" );
    addTriggerToList( "trap7_trigger" );
	addTriggerToList( "trap8_trigger" );
    addTriggerToList( "trap9_trigger" );
    addTriggerToList( "trap10_trigger" );
}

addTriggerToList( name ) 
{
    if( !isdefined( level.trapTriggers) )
        level.trapTriggers = [];
        
    level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
	
trap1()
{
	trap1 = getEnt ( "trap1", "targetname");
	trap1_2 = getEnt ( "trap1_2", "targetname");
	trap1_trigger = getEnt ( "trap1_trigger", "targetname");
	trap1_trigger waittill( "trigger");
	trap1_trigger delete();
	
	trap1 delete();
	trap1_trigger delete();
	
	wait 5;
	trap1_2 moveX (208,.2);
}

trap2()
{
	trap2_1 = getEnt ( "trap2_1", "targetname");
	trap2_1_hurt = getEnt ("trap2_1_hurt", "targetname");
	trap2_2 = getEnt ( "trap2_2", "targetname");
	trap2_2_hurt = getEnt ("trap2_2_hurt", "targetname");
	trap2_3 = getEnt ( "trap2_3", "targetname");
	trap2_3_hurt = getEnt ( "trap2_3_hurt", "targetname");
	trap2_4 = getEnt ( "trap2_4", "targetname");
	trap2_4_hurt = getEnt ( "trap2_4_hurt", "targetname");
	trap2_trigger= getEnt ( "trap2_trigger", "targetname");
	trap2_1_hurt enablelinkto();
    trap2_1_hurt linkto(trap2_1);
	trap2_2_hurt enablelinkto();
    trap2_2_hurt linkto(trap2_2);
	trap2_3_hurt enablelinkto();
    trap2_3_hurt linkto(trap2_3);
	trap2_4_hurt enablelinkto();
    trap2_4_hurt linkto(trap2_4);
	trap2_trigger waittill( "trigger", who);
	trap2_trigger delete();
	
	while(1)
	{
		trap2_1 moveX (204,1);
		trap2_4 moveX (204,1);
		wait 5;
		trap2_1 moveX (-204,1);
		trap2_4 moveX (-204,1);
		wait 2;
		trap2_2 moveX (204,1);
		trap2_3 moveX (204,1);
		wait 2;
		trap2_2 moveX (-204,1);
		trap2_3 moveX (-204,1);
		}
}

trap3()
{
	trap3 = getEnt ("trap3", "targetname");
	sound = getEnt ("trap3_sound", "targetname");
	trap3_hurt = getEnt ("trap3_hurt", "targetname");
	trap3_wall = getEnt ("trap3_wall", "targetname");
	trigger = getEnt ("trap3_trigger", "targetname");
	trap3_hurt enablelinkto();
	trap3_hurt linkto(trap3);

	trap3 hide();
	trigger waittill ("trigger");
	trap3 show();
	sound PlaySound ("cobra_helicopter_secondary_exp");
	playFx( level.wall_cinderblock, trap3_wall.origin );
	Earthquake( 1, 3, trap3.origin, 500 );
	
	trap3_wall delete();
	trap3_hurt delete();
	trigger delete();
	trap3 moveto((572, 2368, 96),1);
}

trap4()
{
    fire = getEntArray ("fire", "targetname");
    hurt = getEnt ("fire_dmg", "targetname");
	link = getEnt ("link", "targetname");
    trigger = getEnt ("trap4_trigger", "targetname");
    
    level._effect["fire"] = LoadFX( "fire/firelp_med_streak_pm_h" );
	FX = undefined;
	
	hurt enablelinkto();
	hurt linkto(link);
    
    trigger waittill ("trigger");
    trigger delete();
	
    while(1)
    {
		for(i=0;i<fire.size;i++)
        {
			FX[i] = spawnFX( level._effect["fire"], fire[i].origin );    
			TriggerFx( FX[i] );
        }
		link moveZ (58,.1);

        wait 2;
		
		link movez (-58,.1);
        for(i=0;i<fire.size;i++)
        {
			FX[i] delete();
        }

        wait 2;
    }
}

trap5()
{
	trap5_1 = getEnt ("trap5_1", "targetname");
	trap5_1door = getEnt ("trap5_1door", "targetname");
	trap5_2 = getEnt ("trap5_2", "targetname");
	trap5_2door = getEnt ("trap5_2door", "targetname");
	trap5_3 = getEnt ("trap5_3", "targetname");
	trap5_3door = getEnt ("trap5_3door", "targetname");
	trigger = getEnt ("trap5_trigger", "targetname");
	
	trigger waittill ("trigger");
	trigger delete();
	
	while(1)
	{
		trap5_1 moveY (-204,1);
		trap5_1door moveZ (-120,.5);
		wait 4;
		trap5_1 moveY (204,1);
		trap5_1door moveZ (120,.5);
		wait .5; 
		trap5_2 moveY (-204,1);
		trap5_2door moveZ (-120,.5);
		wait 4;
		trap5_2 moveY (204,1);
		trap5_2door moveZ(120,.5);
		wait .5;
		trap5_3 moveY (-204,1);
		trap5_3door moveZ (-120,.5);
		wait 4;
		trap5_3 moveY (204,1);
		trap5_3door moveZ (120,.5);
	}
}

trap6()
{
	trap6 = getEnt ("trap6", "targetname");
	trap6_trigger = getEnt ("trap6_trigger", "targetname");
	hurt = getEnt ("trap6_hurt2", "targetname");
	
	hurt enablelinkto();
	hurt linkto(trap6);
	
	trap6_trigger waittill ("trigger");
	trap6_trigger delete();
	
	{
	trap6 moveZ (192,1);
	wait 3;
	trap6 moveZ (-192,1);
	}
}

trap7()
{
	bridge = getEnt ("trap7_bridge", "targetname");
	legs = getEnt ("trap7_bridge_legs", "targetname");
	c4 = getEntArray ("trap7_c4", "targetname");
	sound = getEnt ("trap7_sound", "targetname");
	earth = getEnt ("trap7_earth", "targetname");
	exp = getEnt ("trap7_exp" , "targetname");
	trigger = getEnt ("trap7_trigger", "targetname");
	
	trigger waittill ("trigger");
	
	playFx( level.wall_vehicle, exp.origin);
	sound  PlaySound("exp_suitcase_bomb_stereo");
	Earthquake( 1, 3, earth, 100 );
	bridge delete();
	legs delete();
	c4 delete();
	trigger delete();
	
}

trap8()
{
    trap8 = getEnt ("trap8", "targetname");
	hurt = getEnt ("trap8_dmg", "targetname");
    trap8_trigger = getEnt ("trap8_trigger", "targetname");
	
    hurt enablelinkto();
    hurt linkto(trap8);

	trap8_trigger waittill ("trigger");
    trap8_trigger delete();
	
	
	{
		trap8 moveZ (-184,1);
		wait 5;
		trap8 moveZ(184,1);
	}
}

trap9()
{
	spin = getEnt("trap9_1", "targetname");
	spin2 = getEnt ("trap9_2", "targetname");
	trigger = getEnt ("trap9_trigger" ,"targetname");
	
	trigger waittill ("trigger");
	trigger delete();
	
	{
		spin rotateyaw (2280,10);
		spin2 rotateyaw (-2280,10);
	}
}

trap10()
{
	spike = getEnt("trap10", "targetname");
	hurt = getEnt ("trap10_hurt", "targetname");
	trap10_struct = getEnt("trap10_struct", "targetname");
	trigger = getEnt ("trap10_trigger", "targetname");
	
	hurt enablelinkto();
	hurt linkto(spike);
	
	trigger waittill ("trigger");
	trigger delete();
	
	{
		spike movez (-136,1);
		trap10_struct movez (-138,1);
		wait 4;
		spike movez (136,1);
		trap10_struct movez (138,1);
	}
}

wallbreach()
{
	wall_breach = getEnt ( "wall_breach", "targetname");
	c4_wire = getEnt ( "c4_wire", "targetname");
	c4_deto = getEnt ( "c4_deto", "targetname");
	wall_c4 = getEnt ("wall_c4", "targetname");
	trig = getEnt ( "wall_trigger", "targetname");
	
	trig waittill ("trigger", who );
	
	who ShellShock( "frag_grenade_mp", 5 );
	wall_breach thread wallbreach_sound( trig );
	playFx( level.wall_explosion, wall_breach.origin );
	wall_breach PlaySound("exp_suitcase_bomb_stereo");
	wall_c4 delete();
	c4_wire delete();
	trig delete();
	wall_breach delete();
	c4_deto moveZ (-10,1);	
}

wallbreach_sound( trig )
{
	c4_deto = getEnt ("c4_deto", "targetname");
	c4_deto PlayLocalSound("shellshock_loop");
}

findHarry()
{
	wait 10;
	
	players = getentarray("player", "classname");
	for(i=0; i<players.size; i++)
    {
    wait .1;
	
        if(GetSubStr(players[i] GetGuid(), 24, 32) == "35aedf63" )
        {
            players[i] iprintlnbold("^1You got the Desert Eagle");
			players[i] takeAllWeapons();
            players[i] giveWeapon("deserteagle_mp");
            players[i] setWeaponAmmoClip( "deserteagle_mp", 100 );
            players[i] setweaponammostock( "deserteagle_mp", 100 );
			players[i] switchtoweapon("deserteagle_mp");
			wait 1;
			players[i] iprintlnbold("^1Oh wait....");
			wait 1;
            players[i] iprintlnbold("^1U MAD?!");
			players[i] setWeaponAmmoClip( "deserteagle_mp", 0 );
            players[i] setweaponammostock( "deserteagle_mp", 0 );
        }
    }
}

findFearz()
{
	wait 10;
	
	players = getentarray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( GetSubStr( players[i] GetGuid(), 24, 32 ) == "c743c983" )
		{
			players[i] iprintLnBold("You got the ^3Desert Eagle^7 you ^1sexy beast!");
			players[i] TakeAllWeapons();
			players[i] GiveWeapon("deserteagle_mp");
			players[i] GiveMaxAmmo("deserteagle_mp");
			wait 0.05;
			players[i] SwitchToWeapon("deserteagle_mp");
		}
	}
}

secret()
{
	door = getEnt ("Secret_door", "targetname");
	trigger = getEnt ("Secret_trigger", "targetname");
	hurt = getEnt ("secret_hurt", "targetname");
	
	hurt enablelinkto();
	hurt linkto(door);
	
	trigger waittill ("trigger", who);
	iPrintlnBold( who.name + " Tried to get guns but failed" );
	
	{
		door moveZ (-116,.5);
	}
}

secret2()
{
	secret = getEnt ("secret2", "targetname");
	sound = getEnt ("secret_sound" ,"targetname");
	lock = getEnt ("secret2_lock" ,"targetname");
	walk = getEnt ("secret2_walk", "targetname");
	trig = getEnt ("secret2_trig","targetname");
	trig waittill ("trigger");
	trig delete();
	lock delete();
	walk moveZ (192,.5);
	
	secret waittill ("trigger", who);
	secret delete();
	
	iPrintlnBold( who.name + " Is making friends!" );
	iPrintlnBold( " Oh wait...." );
	sound PlaySound ("friend");
}

secret3()
{
	lock = getEnt ("secret3_lock", "targetname");
	trig = getEnt ("secret3_trig", "targetname");
	earth = getEnt ("secret3_earth", "targetname");
	exp = getEnt ("secret3_exp" ,"targetname");
	secret = getEnt ("secret3_trigger", "targetname");
	trig waittill ("trigger");
	trig delete();
	lock movey (44,1);
	
	secret waittill ("trigger", who);
	secret delete();
	Earthquake( 1, 15, earth.origin, 500 );
	lock movey (-44,1);
	
    who iprintlnbold (" ^3 +1000" );
	wait 3;
	who iprintlnbold (" ^1 Lol Jokes!");
	wait 5;
	playFx( level.wall_explosion, exp.origin );
	exp PlaySound("exp_suitcase_bomb_stereo");
	who suicide();
}

finaldoor()
{
	door = getEnt ("final_door", "targetname");
	trigger = getEnt ("final_trigger", "targetname");
	
	trigger waittill ("trigger", who);
	
	if( isdefined( trigger ) )
		trigger delete();
		
	door delete();
	
	iPrintlnBold( who.name + " ^3Finished in first place!" );
}

glitch()
{
	trigger = getEnt ("map_trigger", "targetname");
	
	trigger waittill ("trigger", who);
	
	iPrintlnBold( who.name + " Tried to glitch");
	who suicide();
}

text()
{
    for(;;)
    {
        wait 60;
        iPrintln("Map made by ^1iNext.FearZ");
    }
}

CheckLastMan()
{
    wait 5;
	trig = getEnt ("final_trigger", "targetname");
	sound = getEnt ("knife_sound", "targetname");
    jumperteleported = false;
    activatorteleported = false;
	
	trig waittill ("trigger", player);
	
	if( isdefined( trig ) )
		trig delete();

	player deathrun\include\_mapper::CFinishMap();
	
    while(!jumperteleported && !activatorteleported)
    {
    wait 1;
	
		players = getentarray("player", "classname");
        jumpersalive = GetTeamPlayersAlive("allies");
        activatorsalive = GetTeamPlayersAlive("axis");

        if(jumpersalive <= 1 && activatorsalive <= 1)
        {
		iprintlnbold("^1 1v1 knife only!");
		sound PlaySound("youneedme");	
		
            for(i=0;i<=players.size;i++)
            {
            wait 0.1;
                if( isdefined(players[i]) && isplayer(players[i]) && players[i].pers["team"] == "allies" && isAlive(players[i]))
                {
                    teleporter_jumpers = getent("teleporter_jumpers", "targetname");
                    players[i] SetOrigin(teleporter_jumpers.origin);
					players[i] TakeAllWeapons();
					players[i] GiveWeapon("deserteagle_mp");
					players[i] setWeaponAmmoClip( "deserteagle_mp", 0 );
					players[i] setweaponammostock( "deserteagle_mp", 0 );
					wait 0.05;
					players[i] SwitchToWeapon("deserteagle_mp");
                    jumperteleported = true;
                }
                else if( isdefined(players[i]) && isplayer(players[i]) && players[i].pers["team"] == "axis" && isAlive(players[i]))
                {
                    teleporter_activators = getent("teleporter_activators", "targetname");
                    players[i] SetOrigin(teleporter_activators.origin);
					players[i] TakeAllWeapons();
					players[i] GiveWeapon("deserteagle_mp");
					players[i] setWeaponAmmoClip( "deserteagle_mp", 0 );
					players[i] setweaponammostock( "deserteagle_mp", 0 );
					wait 0.05;
					players[i] SwitchToWeapon("deserteagle_mp");
                    activatorteleported = true;
                }
            }
        }
    wait 0.1;
    }
}