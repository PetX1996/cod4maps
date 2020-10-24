main()
{
	thread doors();
}

doors()
{
	doors = getentarray("door", "targetname");
	
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
	door = self;
	kill_trig = getent(door.target , "targetname");
	kill_trig enablelinkto();	
	
	t = 3;
	s = 184;
	
	for(;;)
	{
		wait (randomfloatrange(1,10));
	
		//if(randomint(5))
			//continue;
	
		door movez(s, t);
		door waittill("movedone");
		
		wait (randomfloatrange(5,10));
		
		kill_trig.origin += (0,0,s);
		kill_trig linkto(door);
		door movez(s*(-1), t);
		door waittill("movedone");	
		kill_trig unlink();
	}
}
