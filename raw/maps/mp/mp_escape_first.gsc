main()
{
	thread door();
	thread platform();
	
	setdvar( "r_specularcolorscale", "1" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");	
}

door()
{
	trig = getent("map_door_brush", "targetname");
	brush = getent(trig.target, "targetname");
	
	trig waittill("trigger");
	iprintln("Doors will open at 5 seconds.");
	wait 5;
	
	brush movez(-241 , 5);
}

platform()
{
	trig = getent("map_end_brush", "targetname");
	brush = getent(trig.target, "targetname");
	
	trig waittill("trigger");
	iprintln("The platform was launched.");
	
	brush movey(-1008 , 30);
	brush waittill("movedone");
	brush movey(1008 , 30);
}
