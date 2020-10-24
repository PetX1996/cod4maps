

main()
{
	trigger = GetEnt( "bot_active", "targetname" );
	trigger waittill( "trigger" );
	trigger delete();
	
	bots = GetEntArray( "bot", "targetname" );
	
	for( i = 0;i < bots.size;i++ )
		thread StartBot( bots[i], 50, 50 );
}

StartBot( ent, velocity, size )
{
	while( true )
	{
		coords = GetNewCoords( ent, size );
		MoveToCoords( ent, coords, velocity );
	}
}

GetNewCoords( ent, size )
{
	trace = BulletTrace( ent.origin, ent.origin + ( AnglesToForward( ent.angles ) * 10000 ), false, ent );
	
	impact = trace["position"];
	if( !IsDefined( impact ) )
		impact = ( 0,0,0 );
	
	dist = Distance( ent.origin, impact );
	
	if( dist > size )
		dist -= size; 
	
	vec = VectorNormalize( impact-ent.origin );
	vec *= dist;
	
	coords = [];
	coords[0] = ent.origin + vec;
	coords[1] = ent.angles * -1;
	
	for( i = 0;i < 2;i++ )
	{
		if( !IsDefined( coords[i] ) )
			coords[i] = ( 0,0,0 );
	}
	
	return coords;
}

MoveToCoords( ent, coords, velocity )
{
	origin = coords[0];
	angles = coords[1];
	
	time = Distance( ent.origin, origin ) / velocity;
	ent MoveTo( origin, time );
	
	wait time;
	ent.angles = angles;
}
