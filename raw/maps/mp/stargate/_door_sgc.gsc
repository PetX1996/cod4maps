init()
{
	thread door();
	thread main_door();
}

main_door()
{
	door1 = getent("main_door_1","targetname");
	door2 = getent("main_door_2","targetname");
	trig = getent("main_door_trig","targetname");
	
	while(1)
	{
		trig waittill("trigger");
		door1 movez(83,5);
		door2 movez(83,5);
		door1 waittill("movedone");
		door1 movez(83,5);
		
		trig waittill("trigger");
		door1 movez(-83,5);
		door1 waittill("movedone");
		door1 movez(-83,5);		
		door2 movez(-83,5);
	}
}

door()
{
	trig = getentarray( "door_trig_sgc", "targetname" );
	door = getentarray( "door_sgc", "targetname" );
	
	if(isdefined(trig) && isdefined(door) && door.size == trig.size)
	{
		for( i = 0; i < trig.size; i++ )
		{
			trig[i] Precache_door(door[i]);
			trig[i] thread door_move();
		}	
	}
	else
		thread log_on_spawn("return, undefined trig/door/bad size");

}

Precache_door(door)
{	
	self.door = door;
	
	if (!isdefined(self.door.count))
	{
		self.door.count = 100;
		thread log_on_spawn("distance set to 100");
	}	
}

door_move()
{
	while(1)
	{
		self waittill("trigger",player);
		self.door movez(self.door.count, self.door.count/10);
		self.door waittill("movedone");
		self waittill("trigger",player);
		self.door movez(0-self.door.count, self.door.count/10);
		self.door waittill("movedone");		
	}
}

log_on_spawn(text)
{
	level waittill("connected", player);
	player waittill("spawned");
	
	player iprintln("DEBUG: "+text);
}