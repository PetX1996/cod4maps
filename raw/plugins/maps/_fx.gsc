
















#include common_scripts\utility;
#include plugins\_include;


































AddFX( targetname, fx, type, delay, sound, start, end )
{
	if(!isdefined(targetname))
		return;
		
	if(!isdefined(fx))
	{
		PluginsError("undefined effect name: "+targetname);
		return;
	}
	
	ent = getstructarray(targetname, "targetname");
	
	if(!isdefined(ent) || ent.size == 0)
	{
		PluginsError("undefined object(script_struct): "+targetname);
		return;
	}	

	PluginInfo("FX system", "PetX", "0.1");
	
	fx = AddFXtoList(fx);
	
	wait 1;
	
	if(isdefined(start))
		wait start;
		
	for(i = 0;i < ent.size;i++)
	{
		ent[i] thread StartFX(fx, type, delay, sound, end);
	}
}

StartFX(fx, type, delay, sound, end)
{
	if(!isdefined(self.angles))
		self.angles = (0,0,0);

	if(type == "oneshot")
	{
		effect = spawnfx(fx, self.origin, AnglesToForward( self.angles ), AnglesToUp( self.angles ));
		triggerFX(effect);
		
		if(isdefined(sound))
			effect playsound(sound);
		
		if(isdefined(end))
		{
			wait end;		
			effect delete();
		}
	}
	else
	{
		self thread LoopFX(fx, delay, sound);
		
		if(isdefined(end))
		{
			wait end;
			self notify("done");
		}
	}
}

LoopFX(fx, delay, sound)
{
	self endon("done");
	
	while(1)
	{
		effect = spawnfx(fx, self.origin, AnglesToForward( self.angles ), AnglesToUp( self.angles ));
		triggerFX(effect);
		
		if(isdefined(sound))
			effect playsound(sound);
		
		if(isdefined(delay))
			wait delay;
		else
			wait 1;
			
		effect delete();
	}
}
