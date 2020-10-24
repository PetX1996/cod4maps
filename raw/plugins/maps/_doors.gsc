
















#include plugins\_include;






































Door( activatorName, axis, trace, velocity, startTime, text, doneText, preturn, pwait )
{
	if( !isDefined( activatorName ) || !isDefined( axis ) || !isDefined( trace ) || !isDefined( velocity ) )
	{
		PluginsError( "Door() - bad function call" );
		return;
	}
	
	if( !isDefined( startTime ) )
		startTime = 0;
		
	activator = GetEntArray( activatorName, "targetname" );
	if( !isDefined( activator ) || !activator.size )
	{
		PluginsError( "Door() - undefined entity ^1"+activatorName );
		return;		
	}
	
	for( i = 0;i < activator.size;i++ )
	{
		activator[i] thread Door_Move( activatorName, axis, trace, velocity, startTime, text, doneText, preturn, pwait );
	}
}

Door_Move( activatorName, axis, trace, velocity, startTime, text, doneText, preturn, pwait )
{
	if( !isDefined( self.target ) )
	{
		PluginsError( "Door() - undefined entity target ^1"+activatorName );
		return;			
	}
	
	entity = getEntArray( self.target, "targetname" );
	if( !isDefined( entity ) || !entity.size )
	{
		PluginsError( "Door() - undefined entity ^1"+self.target );
		return;			
	}
	
	c = 0;
	mainEnt = undefined;
	while( !isDefined( mainEnt ) )
	{
		classname = "script_origin";
		exit = false;
		switch( c )
		{
			case 0:
				classname = "script_brushmodel";
				break;
			case 1:
				classname = "script_model";
				break;
			default:
				mainEnt = entity[0];
				exit = true;
				break;
		}
		
		if( exit )
			break;
		
		for( i = 0;i < entity.size;i++ )
		{
			if( entity[i].classname == classname )
			{
				mainEnt = entity[i];
				break;
			}
		}
		
		c++;
	}
	
	startPos = mainEnt.origin;
	
	for( i = 0;i < entity.size;i++ )
	{
		if( entity[i].classname == mainEnt.classname )
			continue;
			
		if( entity[i].classname == "trigger_hurt" )
			entity[i] enableLinkTo();
			
		entity[i] linkTo( mainEnt );
	}
	
	if( !isDefined( self.script_looping ) )
		self.script_looping = 0;
		
	loop = self.script_looping + 1;
	
	time = 1;
	axis = ToLower( axis );
	type = 1;
	for( c = 0;c < loop;c++ )
	{
		if( c % 2 == 0 )
			type = 1;
		else
			type = (-1);
	
		self waittill( "trigger" );
		if( loop == 1 )
			self delete();
		
		if( isDefined( text ) )
			iprintlnbold( text );
			
		wait startTime;
		
		if( isDefined( doneText ) )
			iprintlnbold( doneText );
		
		traceT = trace;
		if( traceT < 0 )
			traceT *= -1;
		
		time = traceT/velocity;
		
		if( axis == "x" )
			mainEnt MoveX( trace * type, time );
		else if( axis == "y" )
			mainEnt MoveY( trace * type, time );
		else
			mainEnt MoveZ( trace * type, time );
	
		mainEnt waittill( "movedone" );
	
		if( loop == 1 )
			break;
	}
	
	if( IsDefined( preturn ) && preturn )
	{
		if( IsDefined( pwait ) )
			wait pwait;
			
		mainEnt MoveTo( startPos, time );
	}
	
	for( i = 0;i < entity.size;i++ )
	{
		if( entity[i] == mainEnt )
			continue;
			
		entity[i] unLink();
	}
}










































SlideDoors(trig, door1_t, door2_t, axis, s, t, time, text, done_text, preturn, pwait)
{
	if(!isdefined(trig))
		return;
		
	if(!isdefined(door1_t))
		return;
		
	if(!isdefined(door2_t))
		return;
		
	ent = getent(trig, "targetname");
	door1 = getent(door1_t, "targetname");
	door2 = getent(door2_t, "targetname");

	if(!isdefined(ent))
	{
		PluginsError("undefined object(trigger): "+trig);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		PluginsError("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+trig);
		return;
	}	
	
	if(!isdefined(door1))
	{
		PluginsError("undefined object(door1): "+door1_t);
		return;
	}		
	
	if(!isdefined(s))
	{
		PluginsError("undefined track, set to 100: "+trig);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		PluginsError("undefined time(velocity), set to 10: "+trig);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		PluginsError("undefined time to open, set to 0: "+trig);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		PluginsError("undefined axis, set to X: "+trig);
		axis = "X";
	}	
	
	PluginInfo("Moving slide doors", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;

	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
	{
		door1 movex(s,t);
		door2 movex(s*(-1),t);
	}	
	else if(axis == "y")
	{
		door1 movey(s,t);
		door2 movey(s*(-1),t);
	}	
	else
	{
		door1 movez(s,t);
		door2 movez(s*(-1),t);
	}
	
	if(isdefined(preturn) && preturn)
	{
		if(isdefined(pwait))
			wait pwait;
			
		if(axis == "x")
		{
			door1 movex(s*(-1),t);
			door2 movex(s,t);
		}	
		else if(axis == "y")
		{
			door1 movey(s*(-1),t);
			door2 movey(s,t);
		}	
		else
		{
			door1 movez(s*(-1),t);
			door2 movez(s,t);
		}		
	}
}








































RotateDoubleDoors(trig, door1_t, door2_t, axis, s, t, time, text, done_text)
{
	if(!isdefined(trig))
		return;
		
	if(!isdefined(door1_t))
		return;
		
	if(!isdefined(door2_t))
		return;
		
	ent = getent(trig, "targetname");
	door1 = getent(door1_t, "targetname");
	door2 = getent(door2_t, "targetname");

	if(!isdefined(ent))
	{
		PluginsError("undefined object(trigger): "+trig);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		PluginsError("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+trig);
		return;
	}	
	
	if(!isdefined(door1))
	{
		PluginsError("undefined object(door1): "+door1_t);
		return;
	}		
	
	if(!isdefined(s))
	{
		PluginsError("undefined angle, set to 100: "+trig);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		PluginsError("undefined time(velocity), set to 10: "+trig);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		PluginsError("undefined time to open, set to 0: "+trig);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		PluginsError("undefined axis, set to X: "+trig);
		axis = "X";
	}	
	
	PluginInfo("Rotating double doors", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;
	
	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
	{
		door1 RotatePitch(s,t);
		door2 RotatePitch(s*(-1),t);
	}	
	else if(axis == "y")
	{
		door1 RotateRoll(s,t);
		door2 RotateRoll(s*(-1),t);
	}	
	else
	{
		door1 RotateYaw(s,t);
		door2 RotateYaw(s*(-1),t);
	}
}



































RotateDoor(targetname, axis, s, t, time, text, done_text)
{
	if(!isdefined(targetname))
		return;
		
	brush = undefined;	
	ent = getent(targetname, "targetname");

	if(!isdefined(ent))
	{
		PluginsError("undefined object(trigger): "+targetname);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		PluginsError("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+targetname);
		return;
	}
	
	if(isdefined(ent.target))
	{
		brush = getent(ent.target, "targetname");
		
		if(!isdefined(brush))
		{
			PluginsError("undefined object(brush): "+targetname);
			return;			
		}
	}
	else
	{
		PluginsError("undefined object(brush): "+targetname);
		return;
	}	
	
	if(!isdefined(s))
	{
		PluginsError("undefined angle, set to 100: "+targetname);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		PluginsError("undefined time(velocity), set to 10: "+targetname);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		PluginsError("undefined time to open, set to 0: "+targetname);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		PluginsError("undefined axis, set to X: "+targetname);
		axis = "X";
	}	
	
	PluginInfo("Rotating door", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;

	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
		brush RotatePitch(s,t);	
	else if(axis == "y")
		brush RotateRoll(s,t);	
	else
		brush RotateYaw(s,t);
}
