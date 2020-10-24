
















#include plugins\_include;
































RandomPort(targetname, portfx, enterfx, exitfx, sound, playertext, globaltext)
{
	if(!isdefined(targetname))
		return;
		
	ent = getentarray(targetname, "targetname");

	if(!isdefined(ent) || ent.size < 2)
	{
		PluginsError("undefined object(trigger or origin): "+targetname);
		return;
	}	
	
	trig = [];
	origin = [];
	
	for(i = 0;i < ent.size;i++)
	{
		if(ent[i].classname == "trigger_multiple" || ent[i].classname == "trigger_use_touch")
			trig[trig.size] = ent[i];
		else
			origin[origin.size] = ent[i];
	}
	
	if(!isdefined(trig[0]))
	{
		PluginsError("undefined object(trigger): "+targetname);
		return;
	}
	
	if(!isdefined(origin[0]))
	{
		PluginsError("undefined object(script_origin): "+targetname);
		return;
	}	
	
	PluginInfo("RandomPort", "PetX", "0.1");
	
	if(isdefined(portfx))
		portfx = AddFXtoList(portfx);
	if(isdefined(enterfx))
		enterfx = AddFXtoList(enterfx);
	if(isdefined(exitfx))
		exitfx = AddFXtoList(exitfx);
	
	wait 1;
	
	for(i = 0;i < trig.size;i++)
	{
		if(isdefined(portfx))
			PlayFX( portfx, trig[i] );
			
		ent[i] thread RandomPortActive(origin, enterfx, exitfx, sound, playertext, globaltext);
	}
}

RandomPortActive(origin, enterfx, exitfx, sound, playertext, globaltext)
{
	while(1)
	{
		self waittill("trigger", player);
		
		if(!isdefined(player) || !isplayer(player) || !isalive(player))
			continue;
		
		if(isdefined(enterfx))
			PlayFX( enterfx, player.origin );
			
		if(isdefined(sound))
			self PlaySound( sound );
		
		final = origin[randomint(origin.size)];

		player linkto(self);
		player setorigin(final.origin);
		player setplayerangles(final.angles);
		player unlink();
		
		if(isdefined(exitfx))
			PlayFX( exitfx, player.origin );
			
		if(isdefined(playertext))
			player iprintlnbold(playertext);
			
		if(isdefined(globaltext))
			iprintlnbold(globaltext);
	}
}
