
















#include plugins\_include;





























DeleteAfterTime(targetname, time, text, done_text)
{
	if(!isdefined(targetname))
		return;
	
	trig = getent(targetname, "targetname");

	if(!isdefined(trig))
	{
		PluginsError("undefined object(trigger): "+targetname);
		return;
	}	
	
	if(!isdefined(trig.target))
	{
		PluginsError("undefined object(brush): "+targetname);
		return;
	}	
	
	if(!(trig.classname == "trigger_multiple" || trig.classname == "trigger_use_touch"))
	{
		PluginsError("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+targetname);
		return;
	}
	
	brush = getent(trig.target, "targetname");
	
	if(!isdefined(brush))
	{
		PluginsError("undefined object(brush): "+targetname);
		return;
	}	
	
	if(!isdefined(time))
	{
		PluginsError("undefined time to open, set to 0: "+targetname);
		time = 0;
	}
	
	PluginInfo("Delete after time", "PetX", "0.1");
	
	trig waittill("trigger");
	trig delete();
	
	if(isdefined(text))
		iprintlnbold(text);
		
	wait time;
	
	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	brush delete();
}
