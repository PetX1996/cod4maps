main()
{

	maps\mp\_load::main();
	maps\mp\_rings::main();

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
	setdvar("compassmaxrange","1800");

        thread fan ();

}

fan()
{
fan1 = getent( "fan1" , "targetname" );
fan2 = getent( "fan2" , "targetname" );
fan3 = getent( "fan3" , "targetname" );
fan4 = getent( "fan4" , "targetname" );

        while( 1 )
	{
		fan1 rotatePitch( 360, 2 );
		fan2 rotatePitch( 360, 2 );
		fan3 rotatePitch( 360, 2 );
		fan4 rotatePitch( 360, 2 );
                wait 2;
	}

}