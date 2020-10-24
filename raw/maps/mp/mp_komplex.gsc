main()
{
	maps\mp\_load::main();	 

        maps\mp\mp_komplex_ventilator::main();
   
        maps\mp\_compass::setupMiniMap("compass_map_mp_komplex");

        thread fanSpin();
      
        maps\mp\mp_komplex_tele::main();

        maps\mp\mp_komplex_dvere::main();

        maps\mp\mp_komplex_elevator::main();
        
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
}

fanSpin() {
fan1 = getEnt( "fan1" , "targetname" );
fan2 = getEnt( "fan2" , "targetname" );
fan3 = getEnt( "fan3" , "targetname" );
fan4 = getEnt( "fan4" , "targetname" );
fan5 = getEnt( "fan5" , "targetname" );
fan6 = getEnt( "fan6" , "targetname" );
//fan7 = getEnt( "fan7" , "targetname" );
//fan8 = getEnt( "fan8" , "targetname" );
//fan9 = getEnt( "fan9" , "targetname" );
//fan10 = getEnt( "fan10" , "targetname" );

//Code by AmishThunder
// www.kramerartanddesign.com
while (1)
{
fan1 rotateyaw( 360, 10, 0, 0 );
//fan1 rotateyaw( degrees, time in seconds, 0, 0 );

fan2 rotateyaw( 360, 10, 0, 0 );

fan3 rotateyaw( 360, 10, 0, 0 );

fan4 rotateyaw( 360, 10, 0, 0 );

fan5 rotateyaw( 360, 10, 0, 0 );

fan6 rotateyaw( 360, 10, 0, 0 );

//fan7 rotateyaw( 360, 10, 0, 0 );

//fan8 rotateyaw( 360, 10, 0, 0 );

//fan9 rotateyaw( 360, 10, 0, 0 );
wait 9.9;
}
}