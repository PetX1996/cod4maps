main()
{
	maps\mp\_load::main();	 
	maps\mp\_teleport::main();	        
        maps\mp\_explosive_barrels::main();

        maps\mp\_compass::setupMiniMap("compass_map_mp_gasworking"); 

        maps\mp\mp_gasworking_efekt::main();
        maps\mp\mp_gasworking_ele::main();
        maps\mp\mp_gasworking_dvere1::main();
     
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
	setdvar("compassmaxrange","500");
}