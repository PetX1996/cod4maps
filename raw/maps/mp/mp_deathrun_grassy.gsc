main()
{
	maps\mp\_load::main();
	maps\mp\_effectsounds::main();
	maps\mp\mp_deathrun_grassy_sound_fx::main();
	maps\mp\_dynamic_foliage2::initdfs();
	maps\mp\_secret_grassy::main();
	maps\mp\_secret_grassy_2::main();
	maps\mp\_secret_grassy_3::main();
	maps\mp\_tankmoving::main();
	maps\mp\_tankmoving2::main();
	maps\mp\_ac130_moving::main();


	
	ambientPlay("ambient_backlot_ext");
	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "1" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setDvar( "compassmaxrange", "1024" );

	// total traps: 8
	// activated by user: 7
	// allways active (and, or hidden): 2
	thread trap_1();
	thread trap_2();
	thread trap_3();
	thread trap_4();
	thread trap_5();
	thread trap_6();
	thread trap_7();
	thread trap_8();
	thread finalDoor();
}




trap_1()
{
	trig = getEnt( "trigger1", "targetname" );

	brush1 = getEnt( "trap4_1", "targetname" );
	brush2 = getEnt( "trap4_2", "targetname" );

	oldOrigin1 = brush1.origin;
	oldOrigin2 = brush2.origin;

	trig waittill( "trigger", who );

	moveTo = getEnt( brush1.target, "targetname" );
	brush1 moveTo( moveTo.origin, 1.2 );
	moveTo = getEnt( brush2.target, "targetname" );
	brush2 moveTo( moveTo.origin, 1.2 );

	wait 1.2;

	trig waittill( "trigger", who );
	trig delete();

	brush1 moveTo( oldOrigin1, 1.2 );
	brush2 moveTo( oldOrigin2, 1.2 );
}

trap_2()
{
	trig = getEnt( "trigger2", "targetname" );
	brush = getEnt( "trap1", "targetname" );

	trig waittill( "trigger", who );
	trig delete();

	while( isDefined( brush ) )
	{
		brush rotateRoll( 180, 8 );
		wait 4;
	}
}

trap_3()
{
	trig = getEnt( "trigger3", "targetname" );
	brush = getEnt( "trap2", "targetname" );

	trig waittill( "trigger", who );
	trig delete();

	for( i = 0; i < 4; i++ )
	{
		brush rotatePitch( 180, 2 );
		wait 2;
	}
	brush.angles = (0,0,0);
}

trap_4()
{
	trig = getEnt( "trigger4", "targetname" );
	brush = getEnt( "trap8", "targetname" );

	trig waittill( "trigger", who );
	trig delete();

	brush moveZ( 250, 1 );
	wait 5;
	brush moveZ( -250, 1 );
}

trap_5()
{
	trig = getEnt( "trigger5", "targetname" );
	brush = getEnt( "trap9", "targetname" );

	trig waittill( "trigger", who );
	trig delete();

	for( i = 0; i < 8; i++ )
	{
		brush rotateYaw( 360, 1 );
		wait 1;
	}
}

trap_6()
{
	trig = getEnt( "trigger6", "targetname" );
	brushGroup1 = getEntArray( "trap11_1", "targetname" );
	brushGroup2 = getEntArray( "trap11_2", "targetname" );

	trig waittill( "trigger", who );
	trig delete();
	
	brushGroup1[randomInt(brushGroup1.size)] notSolid();
	brushGroup2[randomInt(brushGroup2.size)] notSolid();
}

trap_7()
{
	trig = getEnt( "trigger7", "targetname" );
	brush = getEnt( "trap13", "targetname" );

	trig waittill( "trigger", who );
	trig delete();
	brush delete();
}

trap_8()
{
	trig = getEnt( "trigger8", "targetname" );
	brush = getEnt( "trap12", "targetname" );

	trig waittill( "trigger", who );
	trig delete();
	
	for( i = 0; i < 2; i++ )
	{
		brush rotateYaw( 512, 3 );
		wait 3;
		brush rotateYaw( -512, 3 );
		wait 3;
	}
}


finalDoor()
{
	trig = getEnt( "doors_trig", "targetname" );
	brush = getEnt( "door", "targetname" );

	trig waittill( "trigger", who );
	who deathrun\include\_mapper::CFinishMap();
	trig delete();
	brush moveZ( -300, 15 );
}

trigger_init()
{
	soundtriggers = getentarray( "sound_trigger", "targetname" );

	for( i = 0; i < soundtriggers.size; i++ )
		soundtriggers[i] thread trigger_sound();
}

trigger_sound()
{
	self.wait_for_retrigger = false;
	soundpos = getent( self.target, "targetname" );

	while( 1 )
	{
		if( !self.wait_for_retrigger )
		{
			self waittill( "trigger" );
			self.wait_for_retrigger = true;
			soundpos thread play_the_sound( self, soundpos.script_noteworthy );
		}
		wait 0.1;
	}
}

play_the_sound( used_trigger, sound )
{
		self playsound( sound );
		wait 30;
		used_trigger.wait_for_retrigger = false;
}


