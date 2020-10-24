init( triggerName )
{
	trigger = GetEntArray( triggerName, "targetname" )[0];
	
	if( isDefined( trigger ) )
	{
		trigger waittill( "trigger", player );
		thread [[level.EndRound]]( "allies", player );  
	}
}
