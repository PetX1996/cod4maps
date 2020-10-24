main()
{
	maps\mp\_load::main();
	//maps\mp\_teleport::main();
	//maps\mp\mp_dr_ssc_nothing_soundfx::main();

	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";


	// total traps: 4
	// activated by user: 4
	// allways active (and, or hidden): 0
	thread trap_1();
	thread trap_2();
	thread trap_3();
	thread trap_4();
	thread finalDoor();
	thread End();
}

trap_1()
{
	trig = getEnt( "trigger1", "targetname" );

	brush1 = getEnt( "trap1_1", "targetname" );
	brush2 = getEnt( "trap1_2", "targetname" );

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
	brush = getEnt( "trap2", "targetname" );

	trig waittill( "trigger", who );
	trig delete();

	brush moveZ( 200, 1 );
	wait 5;
	brush moveZ( -200, 1 );
}

trap_3()
{
	trig = getEnt( "trigger3", "targetname" );
	brushGroup1 = getEntArray( "trap3_1", "targetname" );
	brushGroup2 = getEntArray( "trap3_2", "targetname" );

	trig waittill( "trigger", who );
	trig delete();
	
	brushGroup1[randomInt(brushGroup1.size)] notSolid();
	brushGroup2[randomInt(brushGroup2.size)] notSolid();
}

trap_4()
{
	trig = getEnt( "trigger4", "targetname" );
	brush = getEnt( "trap4", "targetname" );

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
	trig delete();
	brush moveZ( 200, 2 );
}

End()
{
	enter = [];
	enter["allies"] = GetEntArray( "enter", "targetname" )[0];
	enter["axis"] = GetEntArray( "enter", "targetname" )[0];
	
	exit = [];
	exit["allies"] = SpawnStruct();
	exit["allies"].origin = ( -12,-771,420 );
	exit["allies"].angles = ( 0,-90,0 );
	
	exit["axis"] = SpawnStruct();
	exit["axis"].origin = ( -35,-1243,420 );
	exit["axis"].angles = ( 0,90,0 );
	
	thread MonitorAxisTeleport( enter["axis"], exit["axis"] );
	thread MonitorAlliesTeleport( enter, exit );
}

MonitorAxisTeleport( enter, exit )
{
	while( true )
	{
		enter waittill( "trigger", player );

		if( player.pers["team"] != "axis" )
			continue;
		
		Teleport( player, exit );
		return;
	}
}

MonitorAlliesTeleport( enter, exit )
{
	while( true )
	{
		enter["allies"] waittill( "trigger", player );
	
		if( player.pers["team"] != "allies" )
			continue;
	
		thread Teleport( player, exit["allies"] );
		
		activator = GetActivator();
		if( isDefined( activator ) )
			thread Teleport( activator, exit["axis"] );
			
		WaitDeathOrDisconnect( player, activator );
	}
}

WaitDeathOrDisconnect( player, player2 )
{
	player endon( "disconnect" );
	player endon( "death" );
	if( isDefined( player2 ) )
	player2 endon( "disconnect" );
	player2 waittill( "death" );
}

Teleport( player, exit )
{
	player notify( "teleported" );
	
	player SetOrigin( exit.origin );
	player SetPlayerAngles( exit.angles );
	
	player TakeAllWeapons();
	player giveWeapon( "tomahawk_mp" );
	wait 0.01;
	player switchToWeapon( "tomahawk_mp" );
	
	player FreezeControls( true );
	player iprintlnbold( "Preparing for the match." );
	
	player endon( "disconnect" );
	player endon( "teleported" );
	wait 3;
	
	player iprintlnbold( "MATCH!" );
	player FreezeControls( false );
}

GetActivator()
{
	players = getEntArray( "player", "classname" );
	
	for( i = 0;i < players.size;i++ )
	{
		player = players[i];
		
		if( isDefined( player ) && isPlayer( player ) && isAlive( player ) && player.pers["team"] == "axis" )
			return player;
	}
	
	return undefined;
}
