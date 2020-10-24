main()
{
	level.allowdebug = true;
	thread rope();
	thread doors();
	thread spice();
	thread pady();
}

DebugIPrintLn(text)
{
	if(!isdefined(text))
		return;

	if(!level.allowdebug)	
		return;
		
	thread waittill_connect_spawn(text);
}

waittill_connect_spawn(text)
{
	level waittill("connected", player);
	player waittill("spawned_player");
	
	iprintln(text);
}

doors()
{
	doors = getentarray("doors_use", "targetname");
	
	if(!isdefined(doors))
		return;

	//debugiprintln("return 1 false");
	
	for(i = 0;i < doors.size;i++)
	{
		doors[i] thread door_use();
	}
}

door_use()
{
	//trig = self
	//trig > door > killtrigger
	
	door = getent(self.target , "targetname");
	
	if(!isdefined(door))
		return;
	
	//debugiprintln("debug 2 false");
	
	kill_trig = undefined;
	if(isdefined(door.target))
		kill_trig = getent(door.target , "targetname");
	
	s = self.count;
	t = self.delay;
	
	//if(!isdefined(t))
		t = 5;
	
	//if(!isdefined(s))
		s = 120;
	
	self waittill("trigger", player);
	self delete();
	
	//iprintln("use_door");
	
	door movez(s, t);
	door waittill("movedone");
	wait 3;
	
	if(isdefined(kill_trig))
	{
		kill_trig.origin += (0,0,s);
		kill_trig enablelinkto();
		kill_trig linkto(door);
	}
	
	door movez(s*(-1), t);
	door waittill("movedone");
	
	if(isdefined(kill_trig))
	{
		kill_trig unlink();
		kill_trig delete();
	}	
}

rope_kill()
{
	if(isdefined(level.rope_factory))
		return;
	
	level.rope_factory = true;
	
	trig = getent("rope_kill", "targetname");
	wait 20;
	
	while(1)
	{
		trig waittill("trigger", player);
		
		player suicide();
	}
}

rope()
{
	trig = getent("lano_trig", "targetname");
	origin1 = getent("lano_orig", "targetname");
	origin2 = getent(origin1.target , "targetname");
	
	startorigin = origin1.origin;
	endorigin = origin2.origin;
	
	while(1)
	{
		trig waittill("trigger", player);
		
		player DisableWeapons();
		wait 1;
		
		origin1.origin = player.origin;
		player linkto(origin1);
		origin1 moveto(startorigin+(0,0,15), 2);
		wait 3;
		
		origin1 moveto(endorigin+(0,0,15), 10);
		wait 11;
		
		player unlink();
		
		wait 1;		
		player EnableWeapons();
		
		origin1.origin = startorigin;
		origin2.origin = endorigin;
		
		thread rope_kill();
	}
}

spice()
{
	for(i = 0;i < 3;i++)
	{
		brush = getentarray("spic_brush"+i, "targetname");
		
		for(a = 0;a < brush.size;a++)
		{
			brush[a] thread hide_brush(getent(brush[a].target, "targetname"));
		}
		
		trig = getent("spic_trig"+i, "targetname");
		trig thread brush_waittill_active(brush);
	}
}

brush_waittill_active(brush)
{
	self waittill("trigger");
	
	for(i = 0;i < brush.size;i++)
	{
		if(randomint(2))
			continue;
		
		trig = getent(brush[i].target , "targetname");
	
		brush[i] thread brush_show(trig);	
	}
}

brush_show(trig)
{
	self movez(100, 1);	
	wait 1;
	trig unlink();
	trig delete();	
}

hide_brush(trig)
{
	trig enablelinkto();
	trig linkto(self);
	
	self movez(-100, 0.01);
}

pady()
{
	pady = getentarray("pady", "targetname");
	
	for(i = 0;i < pady.size;i++)
	{
		pady[i] thread pady_move();
	}
}

pady_move()
{
	while(1)
	{
		wait RandomFloat(5);
		
		self movez(-34, RandomFloat(3));
		self waittill("movedone");
		
		wait RandomFloat(5);
		
		self movez(34, RandomFloat(3));
		self waittill("movedone");		
	}
}
