main()
{
	maps\mp\_load::main();	 

	//maps\mp\_compass::setupMiniMap("nazov_mapy"); 
	
	//parametry: <názov entity v mape>, <rýchlos otáèania>, <os otáèania>
	thread FanRotate("fan_1", 3, "z");
	thread FanRotate("fan_2", 20, "y");
	
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

FanRotate(targetname, speed, axis)
{
	fans = getentarray(targetname, "targetname");
	
	for(i = 0;i < fans.size;i++)
		fans[i] thread StartFanRotate(speed, axis);
}

StartFanRotate(speed, axis)
{
	while(1)
	{
		if(axis == "x")
			self RotatePitch( 360, speed );
		else if(axis == "y")
			self RotateRoll( 360, speed );
		else
			self RotateYaw( 360, speed );
			
		wait speed;
	}
}