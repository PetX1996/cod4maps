main()
{
	
        thread teleport();
		thread tonsmrti();

        maps\mp\_load::main();


        ///rat////

        maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_otrava::main();  
		maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_otrava_b::main();
        maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_script::main();
        maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_fire::main();
        maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_special::main();	
        maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_weapons::main();		
        maps\mp\mp_deathrun_crazy\rat\mp_deathrun_crazy_door::main();

        ///Collar///


    //ambientPlay("dirt");
	
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

        level.trapTriggers = [];
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t1", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t2", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t3", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t4", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t5", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t6", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t7", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t8", "targetname" );
        level.trapTriggers[level.trapTriggers.size] = getEnt( "t9", "targetname" );
}


teleport()
{
	entTransporter = getentarray( "enter", "targetname" );
 
	if(isdefined(entTransporter))
	{
		for( i = 0; i < entTransporter.size; i++ )
			entTransporter[i] thread transporter();
	}
}
 
transporter()
{
	while(true)
	{
		self waittill( "trigger", player );
		entTarget = getEnt( self.target, "targetname" );
		wait 0.1;
		player setOrigin( entTarget.origin );
		player setplayerangles( entTarget.angles );
		wait 0.1;
	}
}

tonsmrti()
{
	while(1)
	{
		level waittill("connected", player);
		player thread smrt();
	}
}

smrt()
{
	self endon("disconnect");
	
	while(1)
	{
		self waittill("death");
		self playsound("smrt_rat");
	}
}