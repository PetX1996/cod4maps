// original script na minove pole-minefields
// pridej brush s texturou trigger
// premen ho na trigger_multiple
// pridej "targetname" "smrt" v entity okne 
// pridej odkaz na script do hlavniho scriptu mapy, do zone file

main()
{
	smrt1 = getentarray("smrt", "targetname");
	if (smrt1.size > 0)
	                 
	for(i = 0; i < smrt1.size; i++)
	{
		smrt1[i] thread smrt_think();
	}	
}

smrt_think()
{
	while (1)
	{
		self waittill ("trigger",other);
		
		if(isPlayer(other))
			other thread smrt_kill(self);
	}
}

smrt_kill(trigger)
{
	if(isDefined(self.smrt))
		return;
		
	self.smrt = true;

	if(isdefined(self) && self istouching(trigger))
	{
		origin = self getorigin();
		range = 300;
		maxdamage = 2000;
		mindamage = 50;

		radiusDamage(origin, range, maxdamage, mindamage);
	}
	
	self.smrt = undefined;
}
