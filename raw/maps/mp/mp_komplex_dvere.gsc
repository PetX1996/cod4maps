main()
{
	thread self_closing_doors();
}

self_closing_doors()
{
	doors = getentarray("door_trig","targetname");
	for(i=0; i<doors.size; i++)
	{
		doors[i] thread door_think();
	}
}

door_think()
{
	self.doormoving = false;
	self.doormodel = getent(self.target, "targetname");

	while(1)
	{
		self waittill("trigger");
		if(!self.doormoving)
		{
			self thread door_move();
		}
	}
}

door_move()
{
	self maps\mp\_utility::triggerOff();
	self.doormoving = true;
	self.doormodel playsound("metal_open");
	self.doormodel rotateyaw(self.count, 2, 0.5, 0.5);
	self.doormodel waittill("rotatedone");
	wait (5);
	self.doormodel playsound("metal_close");
	self.doormodel rotateyaw((self.count * -1), 2, 0.5, 0.5);
	self.doormodel waittill("rotatedone");
	self maps\mp\_utility::triggerOn();
	self.doormoving = false;
}