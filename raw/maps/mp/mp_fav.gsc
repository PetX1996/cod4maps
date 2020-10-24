main()
{
	maps\mp\_load::main();
      maps\mp\mp_fav_struct::main();
      maps\mp\mp_fav_rotate::main();
	
      maps\mp\_compass::setupMiniMap("compass_map_mp_fav");
	
      ambientPlay("ambient_backlot_ext");
	setExpFog(0, 13000, 0.33, 0.39, 0.545313, 1);
	game["allies"] = "marines";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";
	
	setdvar( "r_specularcolorscale", "1" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");

      level.airstrikeHeightScale = 1.8;
	  
	thread CollisionTrigger( (1917, 169, 161), 20, 80 ); //PetX :)
}

CollisionTrigger( origin, radius, height )
{
	wait 1;

	trigger = Spawn( "trigger_radius", origin, 0, radius, height );
	trigger SetContents( 1 );
}