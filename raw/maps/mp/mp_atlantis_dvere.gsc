main()
{
	thread slidedoor();
}

slidedoor()
{
	doortrig = getent("door_trigger", "targetname");
	doortrig.doorclosed = true;

	while (1)
	{
		doortrig waittill("trigger", other);
		if(doortrig.doorclosed)
		{
			doortrig thread slidedoor_move(other);
		}
	}
}

slidedoor_move(other)
{
	door_a = getent("door1","targetname");
	door_b = getent("door2","targetname");

	self.doorclosed = false;
	door_a playsound("door_open");
	door_a movey(40,1,0.2,0.2);
	door_b movey(-40,1,0.2,0.2);
	door_a waittill ("movedone");

	if(isDefined(other) && other isTouching(self))
	{
		while(isDefined(other) && other isTouching(self))
		{
			wait .05; // Wait until 'other/player' is no longer touching the trigger
		}
	}

	door_a playsound("door_close");
	door_a movey(-40,1,0.2,0.2);
	door_b movey(40,1,0.2,0.2);
	door_a waittill ("movedone");
	self.doorclosed = true;
}