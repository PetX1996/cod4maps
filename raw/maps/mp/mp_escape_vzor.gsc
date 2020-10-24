main()
{
	level.escape.spawnfx = LoadFX( "visual/item_dron_engine" );
	
	maps\mp\_load::main();

	//maps\mp\_compass::setupMiniMap("compass_map_mp_overgrown");

	//setExpFog(100, 3000, 0.613, 0.621, 0.609, 0);
	//VisionSetNaked( "mp_overgrown" );
	//ambientPlay("ambient_overgrown_day");

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","2200");
	
	thread plugins\_fx::AddFX( "effect", "dev/laser", "oneshot", undefined, undefined, 5, 50 );
	thread plugins\_moving::MovingAndRotate("trigger_moving", "trigger_moving_b", 300, 5, "start in 5 second", "start!");
}