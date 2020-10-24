main()
{
	thread plosina();
	thread boats();
	thread pokus();
	
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

pokus()
{
	level waittill("connected", player);
	player waittill("spawned_player");
	
	while(1)
	{
		//v = player GetVelocity();
		//iprintln("v = "+v);
		
		player SetVelocity( 0, 0, 0 );
		
		wait 5;
		
		player SetVelocity( -400, 0, 100 );
	}
}

plosina()
{
	trig = getent("plosina_trig", "targetname");
	brush = getent("plosina_brush", "targetname");
	
	orig = [];
	ent = brush;
	
	for(;;)
	{
		if(!isdefined(ent.target))
			break;
	
		ent = getent(ent.target, "targetname");
		
		if(!isdefined(ent))
			break;
			
		orig[orig.size] = ent;	
		
		wait 0.1;
	}
	
	trig waittill("trigger");
	trig delete();
	
	iprintln("Platform leaves for 5 seconds.");
	wait 5;
	
	for(i = 0;i < orig.size;i++)
	{
		brush moveto(orig[i].origin, distance(brush.origin, orig[i].origin)/300);
		brush waittill("movedone");
		
		orig[i] delete();
	}
}

boats()
{
	for(i = 0;i < 2;i++)
	{
		boat = getent("boat_"+i, "targetname");
		trig = getent("boat_trig_"+i, "targetname");
		boat thread boat_start(i, trig);
		wait 0.01;
	}
	
}

boat_start(num, trig)
{
	name = "";
	time = 0;

	switch(num)
	{
		case 0:
			name = "Right boat";
			time = 5;
			break;
		case 1:
			name = "Left boat";
			time = 10;
			break;
	}
	
	orig = [];
	ent = self;
	
	for(;;)
	{
		if(!isdefined(ent.target))
			break;
			
		ent = getent(ent.target, "targetname");
		
		if(!isdefined(ent))
			break;
			
		orig[orig.size] = ent;
		wait 0.01;		
	}
	
	trig waittill("trigger");
	trig delete();
	
	iprintln(name+" starts for "+time+" seconds.");
	wait time;
	
	for(i = 0;i < orig.size;i++)
	{
		if(isdefined(orig[i].angles))
			angles = orig[i].angles;
		else
			angles = self.angles;
		
		t = distance(self.origin, orig[i].origin)/300;
		
		self moveto(orig[i].origin, t);
		wait (t/4)*3;
		self rotateto(angles, (t/3));
		self waittill("movedone");
		
		orig[i] delete();
	}
}

SpawnDebug(text)
{
	thread SpawnDebugPrint(text);
}

SpawnDebugPrint(text)
{
	level waittill("connected", player);
	player waittill("spawned_player");
	
	player iprintln(text);
}