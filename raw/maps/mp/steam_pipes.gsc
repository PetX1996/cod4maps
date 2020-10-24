main()
{
	thread steam_pipes();
}

steam_pipes()
{
	level.fx_pipe_steam = loadFx("smoke/steam_jet_med");

	pipes = getentarray("steam_pipe","targetname");
	for(i=0; i<pipes.size; i++)
	{
		pipes[i] thread pipe_steam();
	}
}

pipe_steam()
{
	self setCanDamage(1);
	while(1)
	{
		self waittill("damage", iDamage, attacker, vDir, vPoint, sMeansOfDeath, modelName, tagName, partName, iDFlags);
		if(sMeansOfDeath == "MOD_RIFLE_BULLET" || sMeansOfDeath == "MOD_PISTOL_BULLET")
		{
			vDir += ((-5 + randomInt(15),-5 + randomInt(15),0));
//			playfx(level.fx_pipe_steam,vPoint,vDir);		//Effects that play DOWN
			playfx(level.fx_pipe_steam,vPoint,vDir * -1);	//Effects that play UP (must invert)
			//thread playsoundatlocation("steam", vPoint);
			self radiusDamage(vPoint, 100, 100, 10);	//origin,dosah,maxdamage,mindamage 
		}
	}
}

vector_scale(vec, scale)
{
	vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
	return vec;
}

playsoundatlocation(sound, where)
{
	if(!isDefined(sound))
	{
		sound = "null";
	}
	if(!isDefined(where))
	{
		where = (0,0,0);
	}

	sounder = spawn("script_origin", where);
	wait (0.05);
	sounder playSound(sound);
	wait (0.05);
	sounder delete();
}

//Might have to change "anglestoup" to "anglestoright" or "anglestoforward"
//			vDir += anglestoup((-30 + randomInt(60),-5 + randomInt(60),0));			//Z Axis
//			vDir += anglestoright((-30 + randomInt(60),-30 + randomInt(60),0));		//Y Axis
//			vDir += anglestoforward((-30 + randomInt(60),-30 + randomInt(60),0));	//X Axis