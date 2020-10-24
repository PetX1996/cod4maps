
















#include plugins\_include;
#include scripts\include\_main;
#include scripts\include\_look;

init( targetname )
{
	trig = GetEntArray( targetname, "targetname" );
	
	if( !trig.size || !isDefined( trig[0] ) )
		return;
		
	PluginInfo( "EndMap Default", "Escape", "0.1" );	
		
	trig = trig[0];
	
	MonitorEndMapTrig( trig );
}

MonitorEndMapTrig( trig )
{
	c = 0;
	while(1)
	{		
		trig waittill("trigger", player );
		
		if( !isDefined( player ) || !isPlayer( player ) || !isAlive( player ) )
			continue;
		
		if( player.pers["team"] == "axis" )
		{
			iprintln( "Player ^1"+player.name+"^7 finished map!" );
			player [[level.giveScore]]( "endmap_first" );	
			
			KillAllPlayersOnTime( trig, 0, "axis" );
			return;
		}
		
		if( !isDefined( trig.Players ) )
			trig.Players = [];
			
		exit = false;
		for( i = 0;i < trig.Players.size;i++ )
		{
			if( trig.Players[i] == player )
			{	
				exit = true;
				break;
			}
		}
		if( exit )
			continue;
			
		trig.Players[trig.Players.size] = player;	
		
		
		c++;
		
		iprintln( "Player ^1"+player.name+"^7 finished map!" );
		player thread PlayFXLoop( level.escape_fx["visual/endround_player"], 0.5, (0,0,30) );
		player thread ApplyShield();
		
		if(c == 1)
		{
			player iprintlnbold("First place!");
			player [[level.giveScore]]( "endmap_first" );	
		}
		else if(c == 2)
		{
			player iprintlnbold("Second place!");
			player [[level.giveScore]]( "endmap_second" );	
		}
		else if(c == 3)
		{
			player iprintlnbold("Third place!");
			player [[level.giveScore]]( "endmap_third" );
		}	
		else
			player [[level.giveScore]]( "endmap_other" );
	
		thread KillAllPlayersOnTime( trig, 5, "allies", player );
			
		wait 0.001;
	}
}

PlayFXLoop( FXid, time, origin )
{
	self endon("disconnect");
	self endon("death");
	
	while(1)
	{
		PlayFX( FXid, self.origin+origin );
		wait time;
	}
}

ApplyShield()
{
	self endon("death");
	self endon("disconnect");
	
	while( true )
	{
		for( i = 0;i < level.players.size;i++ )
		{
			player = level.players[i];
			
			if( !isDefined( player ) || !isAlive( player ) || player.pers["team"] != "axis" )
				continue;
				
			if( !isDefined( distance( self LOOK_GetPlayerCenterPos(), player LOOK_GetPlayerCenterPos() ) ) || distance( self LOOK_GetPlayerCenterPos(), player LOOK_GetPlayerCenterPos() ) > 200 )	
				continue;
				
			player BouncePlayer( 1, VectorNormalize( player LOOK_GetPlayerCenterPos() - self LOOK_GetPlayerCenterPos() ) );
		}
		
		wait 0.05;
	}
}

KillAllPlayersOnTime( trig, time, team, winner )
{
	level notify( "KillAllPlayersOnTime" );
	level endon( "KillAllPlayersOnTime" );

	wait time;
	
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		
		if( !isAlive( player ) || ( player.pers["team"] == team && player IsTouching(trig) ) )
			continue;
		
		player.skipDeathLogic = true;
		player suicide();
	}
	
	wait time;
	
	thread [[level.EndRound]]( team, winner );  
}

