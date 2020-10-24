#include petx\_include;

init()
{
	thread destroy_brush_init();
}

destroy_brush_init()
{
	ent = getentarray("ze_destroy_brush", "targetname");
	if(!isdefined(level.escape_fx))
		level.escape_fx = [];
	
	if(!isdefined(ent))
	{
		//SpawnDebug("^1trigger undefined!!!");
		return;
	}
	
	fxlist = [];
	newfxlist = [];
	
	for(i = 0;i < ent.size;i++)
	{
		if(!isdefined(ent[i].script_noteworthy))
			continue;
			
		fxlist[fxlist.size] = ent[i].script_noteworthy;
	}
	
	if(isdefined(fxlist))
	{
		for(i = 0;i < fxlist.size;i++)
		{
			if(!isdefined(fxlist[i]))
				continue;
				
			for(c = 0;c < fxlist.size;c++)	
			{
				if(!isdefined(fxlist[c]))
					continue;
					
				if(fxlist[i] == fxlist[c] && i != c)	
				{
					fxlist[i] = undefined;
					break;
				}
			}
			
			if(isdefined(fxlist[i]))
				newfxlist[newfxlist.size] = fxlist[i];
		}
		
		if(isdefined(newfxlist))
		{
			//SpawnDebug("newfxlist defined");
			for(i = 0;i < newfxlist.size;i++)
			{
				level.escape_fx[newfxlist[i]] = LoadFX( newfxlist[i] );
			}
		}
	}
	
	for(i = 0;i < ent.size;i++)
	{
		if(isdefined(ent[i].script_noteworthy))
		{
			ent[i] thread destroy_brush(ent[i].script_noteworthy);
		}
		else
			ent[i] thread destroy_brush(undefined);
			
		wait 0.01;	
	}
	
}

destroy_brush(fx)
{
	if(!isdefined(self.target))
	{
		//SpawnDebug("^1Brush undefined!!!");
		return;
	}
	
	//SpawnDebug("^1"+fx);
	
	brush = getent(self.target, "targetname");	
		
	if(isdefined(self.count))
		dmg = self.count;
	else
	{
		dmg = 1;
	}
	
	if(isdefined(fx))	
	{
		fx = level.escape_fx[fx];
	}
	
	origin = brush.origin;
	currentdmg = 0;
	
	
	if(!isdefined(self.count) || !isdefined(fx))
	{
		//SpawnDebug("=======");
		if(!isdefined(self.count))
			SpawnDebug("^1Damage set to 1!");
		//if(!isdefined(fx))
			//SpawnDebug("^1Effect undefined!!");		
		//SpawnDebug("=======");
	}
	
	while(1)
	{
		self waittill( "damage", damage, other, direction_vec, P, type );
		
		iprintln("celkovy damage: "+damagebyplayers(dmg)+" obdrzany damage: "+currentdmg);
		currentdmg += damage;
		
		if(currentdmg >= damagebyplayers(dmg))
		{	
			self delete();
			brush delete();
			
			if(isdefined(fx))
				PlayFX( fx, origin);
				
			return;
		}
	}
}

damagebyplayers(damage)
{
	p = 10; //+10 percent pre kazdeho hraca
	player = GetAllPlayers(true, "allies");
	
	dmg = (damage*((p*player)+100))/100;
	
	return dmg;
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