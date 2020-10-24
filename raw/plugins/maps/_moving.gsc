
















#include plugins\_include;








































MovingAndRotate( triggerName, brushName, velocityMin, velocityMax, time, loop, rotateType, rotateTime, text, sound )
{
	if( !isDefined( triggerName ) && !isDefined( brushName ) )
	{
		PluginsError( "MovingAndRotate() - bad function call" );
		return;
	}
	
	trigger = undefined;
	info = brushName;
	if( isDefined( triggerName ) )
	{
		info = triggerName;
	
		trigger = getEnt( triggerName, "targetname" );
		
		if( !isDefined( trigger ) )
		{
			PluginsError( "MovingAndRotate() - undefined trigger, "+info );
			return;
		}
	}
	
	if( !isDefined( brushName ) )
	{
		PluginsError( "MovingAndRotate() - undefined brush targetname" );		
		return;
	}
	
	ents = GetEntArray( brushName, "targetname" );
	if( !isDefined( ents ) || !ents.size )
	{
		PluginsError( "MovingAndRotate() - undefined brush "+brushName );		
		return;		
	}

	if( !isDefined( velocityMin ) )
		velocityMin = 100;

	if( !isDefined( velocityMax ) )
		velocityMax = 200;
		
	if( !isDefined( time ) )
		time = 0;
	
	if( !isDefined( loop ) )
		loop = false;
	
	if( !isDefined( rotateType ) )
		rotateType = 0;
	
	PluginInfo("Universal Moving System", "Escape", "0.3");
	
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
				mainEnt = ents[0];
				exit = true;
				break;
		}
		
		if( exit )
			break;
		
		for( i = 0;i < ents.size;i++ )
		{
			if( ents[i].classname == classname )
			{
				mainEnt = ents[i];
				break;
			}
		}
		
		c++;
	}

	for( i = 0;i < ents.size;i++ )
	{
		if( ents[i] != mainEnt )
		{
			if( ents[i].classname == "trigger_hurt" )
				ents[i] EnableLinkTo();
		
			ents[i] linkTo( mainEnt );
		}
	}
	
	startEnt = ents[0];
	for( i = 0;i < ents.size;i++ )
	{
		if( isDefined( ents[i].target ) )
			startEnt = ents[i];
	}

	ent = startEnt;
	startOrigin = startEnt.origin;
	startAngles = startEnt.angles;
	origins = [];
	for( i = 0;;i++ )
	{
		if( !isDefined( ent.target ) )
			break;
			
		ent = getEntArray( ent.target, "targetname" )[0];
		
		if( !isDefined( ent ) )
			break;
			
		if( ent == startEnt )
			break;
			
		origins[origins.size] = ent;
	}
	
	if( isDefined( trigger ) )
	{
		trigger waittill( "trigger" );
		trigger delete();
	}
	
	if( isDefined( text ) )
		iprintlnbold( text );
	
	if( isDefined( sound ) )
		mainEnt PlaySound( sound );
	
	wait time;
	
	addAngles = undefined;
	if( mainEnt.classname != "script_model" && mainEnt.classname != "script_origin" && mainEnt.classname != "script_struct" )
	{
		for( i = 0;i < ents.size;i++ )
		{
			ent = ents[i];
			
			if( ent == mainEnt )
				continue;
			
			if( ent.classname == "script_model" || ent.classname == "script_origin" || ent.classname == "script_struct" )
			{
				addAngles = ent.angles;
				break;
			}
		}
	}
	
	angles = undefined;
	c = 1;
	for( c = 0;;c++ )
	{
		if( loop )
			max = origins.size+1;
		else
			max = origins.size;
			
		for( i = 0;i < max;i++ )
		{
			if( i != origins.size )
			{
				origin = origins[i].origin;
				
				if( isDefined( origins[i].angles ) )
					angles = origins[i].angles;
				else
					angles = mainEnt.angles;
			}
			else
			{
				origin = startOrigin;
				angles = startAngles;
			}
			
			if( isDefined( addAngles ) )
				angles = ( angles[0] - addAngles[0], angles[1] - addAngles[1], angles[2] - addAngles[2] );
			
			velocity = undefined;
			if( velocityMin != velocityMax )
				velocity = RandomFloatRange( velocityMin, velocityMax );
			else
				velocity = velocityMin;
				
			t = distance( mainEnt.origin, origin )/velocity;
			
			mainEnt moveto(origin, t);

			if( rotateType == 1 )
			{
				wait (t/4)*3;
				mainEnt rotateto(angles, (t/3));
			}
			mainEnt waittill("movedone");
			
			if( rotateType == 0 )
			{
				time = undefined;
				if( isDefined( rotateTime ) )
					time = rotateTime;
				else
					time = t/3;
					
				mainEnt rotateto(angles, time);
				mainEnt waittill( "rotatedone" );
			}
		}
		
		if( !loop )
			break;
	}
	
	mainEnt.angles = angles;
	
	for( i = 0;i < origins.size;i++ )
		origins[i] delete();
		
	for( i = 0;i < ents.size;i++ )
	{
		if( ents[i] == mainEnt )
			continue;
			
		ents[i] unLink();
	}
}
