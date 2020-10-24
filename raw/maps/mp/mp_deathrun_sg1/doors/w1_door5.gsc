main() 
{ 
	thread slidedoor5 (); 
} 

slidedoor5()
{
	doortrig = getent("w1_door5_t", "targetname");
	doortrig.doorclosed = true;

	while (1)
	{
		doortrig waittill("trigger", other);
		if(doortrig.doorclosed)
		{
			if( !isdefined( level.ds2_shieldfx ))
			{
				other deathrun\include\_mapper::CFinishMap();
			}
			
			doortrig thread move(other);
		}
	}
}

move(other)
{
	door_a = getent("w1_door_5a","targetname");
	door_b = getent("w1_door_5b","targetname");

	self notify("doortrig_finish");
	self.doorclosed = false;
	//door_a playsound("doorship");
	door_a movex(-100,3,0.2,0.2);
	//door_b playsound("doorship");
	door_b movex(100,3,0.2,0.2);
	door_a waittill ("movedone");

	if(isDefined(other) && other isTouching(self))
	{
		while(isDefined(other) && other isTouching(self))
		{
			wait 2; // Wait until 'other' is no longer touching the trigger
		}
	}

	//door_a playsound("doorship");
	door_a movex(100,3,0.2,0.2);
	//door_b playsound("doorship");
	door_b movex(-100,3,0.2,0.2);
	door_a waittill ("movedone");
	self.doorclosed = true;
}