main()
{
	maps\mp\_load::main();

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");	
	
	level.MapSettings["TimeLimit"] = 10;
	level.MapSettings["AmbientTrack"] = "ambient_backlot";
	
	thread plugins\maps\_des_obj::DestructibleObjects("ze_destroy_brush");
	
	thread plugins\maps\_delete::DeleteAfterTime("map_trap_delete_0", 0, "", "");
	thread plugins\maps\_delete::DeleteAfterTime("map_trap_delete_1", 0, "", "");
	thread plugins\maps\_delete::DeleteAfterTime("map_trap_delete_2", 0, "", "");
	
	//Door( activatorName, axis, trace, velocity, startTime, text, doneText )
	thread plugins\maps\_doors::Door("map_trap_spcial", "z", -100, 100, 0, "", "", true, 5);
	
	thread plugins\maps\_doors::Door("map_door_brush1", "z", -180, 18, 10, "^2Door open in ^710 ^2seconds.", "^2!!! Door open !!!");
	thread plugins\maps\_doors::Door("map_door_brush2", "z", -180, 18, 15, "^3Door open in ^715 ^3seconds.", "^3!!! Door open !!!");
	thread plugins\maps\_doors::Door("map_door_brush3", "z", -180, 18, 20, "^1Door open in ^720 ^1seconds.", "^1!!! Door open !!!");
	thread plugins\maps\_doors::Door("map_door_brush4", "z", -180, 18, 30, "^4Door open in ^730 ^4seconds.", "^4!!! Final Door open !!!");
	
	// TELEPORTY	


	portals = getentarray("teleport", "targetname");
	
	for(inx = 0; inx < portals.size; inx++)
	{
		thread TransporterRandom(portals, inx);
	}
}

TransporterRandom(portals, inx)
{
	trigger = spawn( "trigger_radius", portals[inx].origin, 0, 40, 40);
	
	while(true)
	{
		trigger waittill("trigger",player);

		if (getdvarint("scr_teleport_disabled") == 1)
		{
			wait(0.10);
			continue;
		}

		if(!isDefined(player) || isDefined(player.mp_escape_tutorial_teleport_time) && player.mp_escape_tutorial_teleport_time + 1500 > GetTime())
			continue;

		endInx = randomint(portals.size);
		while(endInx == inx)
			endInx = randomint(portals.size);

		player linkTo(portals[endInx]);
		player setorigin(portals[endInx].origin);
		player SetPlayerAngles(portals[endInx].angles);
		player unlink();
		player.mp_escape_tutorial_teleport_time = GetTime();
		//player setplayerangles(entTarget.angles);
		//iprintlnbold ("^1teleport");
		wait(0.10);
	}
}