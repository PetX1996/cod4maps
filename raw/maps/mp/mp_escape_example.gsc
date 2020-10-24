main()
{
	maps\mp\_load::main();
	
	// ================== MAP SETTINGS ====================== //
	
	level.MapSettings["TimeLimit"] = 120; 							//minutes
	level.MapSettings["SpawnsFX"] = "misc/flashlight"; 				//the path to FX, Loop FX recommended
	level.MapSettings["BigSpawnsFX"] = "explosions/aa_explosion"; 	//the path to FX, Loop FX recommended
	level.MapSettings["AmbientTrack"] = "ambient_example"; 			//ambient track
	
	// ==================== Map End ========================= //
	
	thread plugins\ends\_nuke::init( "escape_endmap_nuke_activator", "escape_endmap_nuke_bomb", "escape_endmap_nuke_alive" );
	
	// ====================================================== //
	
	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","2200");
}