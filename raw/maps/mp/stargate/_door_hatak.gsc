init()
{
thread door();
}

door()
{
	trig = getentarray( "door_trig", "targetname" );
	door1 = getentarray( "door1", "targetname" );
	door2 = getentarray( "door2", "targetname" );	
	
	if(isdefined(trig) && isdefined(door1) && isdefined(door2) && door1.size == door2.size && door1.size == trig.size)
	{
		for( i = 0; i < trig.size; i++ )
		{
			trig[i] Precache_door(door1[i], door2[i]);
			trig[i] thread door_move();
		}	
	}
	else
		thread log_on_spawn("return, undefined trig/door/bad size");

}

Precache_door(door1, door2)
{	
	self.door1 = door1;
	self.door2 = door2;
	
	if(!isdefined(self.script_noteworthy) || (self.script_noteworthy != "x" && self.script_noteworthy != "y"))
	{
		self.script_noteworthy = "x";
		thread log_on_spawn("axis set to X");
	}
	
	if (!isdefined(self.door1.count))
	{
		self.door1.count = 100;
		thread log_on_spawn("distance set to 100");
	}
	
	if (!isdefined(self.door2.count))
	{
		self.door2.count = 100;
		thread log_on_spawn("distance set to 100");
	}	
	
	self.axis = self.script_noteworthy;
	
	self.startorigin = [];
	self.endorigin = [];
	
	self.startorigin[1] = self.door1.origin;
	self.startorigin[2] = self.door2.origin;
	
	addorigin = 100;
	
	if(self.axis == "x")
		self.endorigin[1] = self.door1.origin + (self.door1.count , 0, 0);
	if(self.axis == "y")
		self.endorigin[1] = self.door1.origin + (0, self.door1.count, 0);
	
	if(self.axis == "x")
		self.endorigin[2] = self.door2.origin + (self.door2.count , 0, 0);
	if(self.axis == "y")
		self.endorigin[2] = self.door2.origin + (0, self.door2.count, 0);
}

door_move()
{
	while(1)
	{
		players = getentarray("player","classname");
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(isdefined(player) && isplayer(player) && isalive(player) && player IsTouching(self))
			{
				if(self.door1.origin != self.endorigin[1] && self.door2.origin != self.endorigin[2]) //otvorenie
				{
					self.door1 moveto(self.endorigin[1], distance(self.door1.origin,self.endorigin[1])/40);
					self.door2 moveto(self.endorigin[2], distance(self.door2.origin,self.endorigin[2])/40);
				}			
			}
			else
			{
				if(self.door1.origin != self.startorigin[1] && self.door2.origin != self.startorigin[2]) //zavretie
				{
					self.door1 moveto(self.startorigin[1], distance(self.door1.origin,self.startorigin[1])/40);
					self.door2 moveto(self.startorigin[2], distance(self.door2.origin,self.startorigin[2])/40);					
				}
			}
		}
		wait 1;
	}
}

log_on_spawn(text)
{
	level waittill("connected", player);
	player waittill("spawned");
	
	player iprintln("DEBUG: "+text);
}