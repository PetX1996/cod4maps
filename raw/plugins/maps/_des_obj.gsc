
















#include plugins\_include;
#include scripts\include\_main;
#include scripts\include\_event;
#include scripts\include\_health;





























DestructibleObjects( targetname, health, personality, team, effect, sound )
{
	DestructibleEntity( targetname, health, personality, team, effect, sound );
}












DestructibleEntity( targetname, health, personality, team, effect, sound )
{
	if( !isDefined( targetname ) )
	{
		PluginsError( "DestructibleEntity() - bad function call" );
		return;
	}
	
	entity = getEntArray( targetname, "targetname" );
	if( !isDefined( entity ) || !entity.size )
	{
		PluginsError( "DestructibleEntity() - undefined entity "+targetname );
		return;
	}
	
	squadEntity = [];
	
	for( i = 0;i < entity.size;i++ )
	{
		ent = entity[i];
		
		
		if( !isDefined( ent.script_health ) )
		{
			if( isDefined( health ) )
				ent.script_health = health;
			else
				ent.script_health = 100;
		}
		
		if( !isDefined( ent.script_personality ) )
		{
			if( isDefined( personality ) )
				ent.script_personality = personality;
			else
				ent.script_personality = 0;
		}
		
		if( !isDefined( ent.script_team ) )
		{
			if( isDefined( team ) )
				ent.script_team = team;
			else
				ent.script_team = undefined;
		}
		
		if( isDefined( ent.script_team ) )
		{
			switch( ent.script_team )
			{
				case "allies":
				case "axis":
					break;
				default:
					PluginsError( "DestructibleEntity() - script_team must be 'allies' or 'axis'" );
					ent.script_team = undefined;
					break;
			}
		}
		
		if( !isDefined( ent.script_fxid ) )
		{
			if( isDefined( effect ) )
				ent.script_fxid = effect;
			else
				ent.script_fxid = undefined;
		}
		
		if( isDefined( ent.script_fxid ) )
			AddFXToList( ent.script_fxid );
		
		if( !isDefined( ent.script_sound ) )
		{
			if( isDefined( sound ) )
				ent.script_sound = sound;
			else
				ent.script_sound = undefined;
		}		
		
		
		if( isDefined( ent.script_squad ) )
		{
			if( !isDefined( squadEntity[ent.script_squad] ) )
				squadEntity[ent.script_squad] = [];
		
			size = squadEntity[ent.script_squad].size;
			squadEntity[ent.script_squad][size] = ent;		
		}
		else
		{
			ent HEALTH( ent.script_health );
			ent HEALTH_Start();
			AddCallback( ent, "entityHealthDamage", ::DestructibleEntity_OnDamage );
			AddCallback( ent, "entityHealthDelete", ::DestructibleEntity_OnDestroy );
		}
	}
	
	
	
	
	if( squadEntity.size <= 0 )
		return;
	
	squads = GetArrayKeys( squadEntity );
	for( i = 0;i < squads.size;i++ )
	{
		squad = squadEntity[squads[i]];
		
		mainEnt = undefined;
		for( j = 0;j < squad.size;j++ )
		{
			ent = squad[j];
			
			if( isDefined( ent.script_start ) )
			{
				if( !isDefined( mainEnt ) )
				{
					ent HEALTH( ent.script_health );
					ent HEALTH_Start();
					AddCallback( ent, "entityHealthDamage", ::DestructibleEntity_OnDamage );
					AddCallback( ent, "entityHealthDelete", ::DestructibleEntity_OnDestroy );
					
					mainEnt = ent;
					break;
				}
			}
		}
		
		for( c = 0;!isDefined( mainEnt );c++ )
		{
			for( j = 0;j < squad.size;j++ )
			{
				ent = squad[j];
		
				validEnt = false;
				if( c == 0 && ent.classname == "trigger_damage" )
					validEnt = true;
				else if( c == 1 && ent.classname == "script_model" )
					validEnt = true;
				else if( c == 2 && ent.classname == "script_brushmodel" )
					validEnt = true;
				else if( c == 3 )
					validEnt = true;
		
				if( validEnt )
				{
					ent HEALTH( ent.script_health );
					ent HEALTH_Start();
					AddCallback( ent, "entityHealthDamage", ::DestructibleEntity_OnDamage );
					AddCallback( ent, "entityHealthDelete", ::DestructibleEntity_OnDestroy );
					
					mainEnt = ent;
					break;
				}
			}
		}
		
		if( !isDefined( mainEnt ) )
			mainEnt = squad[0];
		
		for( j = 0;j < squad.size;j++ )
		{
			ent = squad[j];
			
			if( ent == mainEnt )
				continue;
				
			if( !isDefined( mainEnt.subEnts ) )
				mainEnt.subEnts = [];
				
			mainEnt.subEnts[mainEnt.subEnts.size] = ent;
		}
	}
}

DestructibleEntity_OnDamage( iDamage, attacker, vDir, vPoint, sMeansOfDeath, modelName, tagName, partName, iDFlags )
{
	if( isDefined( self.script_team ) && isDefined( attacker ) && isPlayer( attacker ) && attacker.pers["team"] != self.script_team )
	{
		self.EntityDamage.iDamage = 0;
		return;
	}
	
	if( !isDefined( self.script_personality ) )
		return;
		
	team = "allies";
	if( isDefined( self.script_team ) )
		team = self.script_team;
		
	oldHealth = self.maxHealth;
		
	players = GetAllPlayers(true, team);
	
	percentagePerPlayer = self.script_health * ( int( self.script_personality ) / 100 );
	self.maxHealth = int( percentagePerPlayer * players.size + self.script_health );
	
	self.health = int((self.health * int(self.maxHealth/oldHealth * 100) )/ 100);
}

DestructibleEntity_OnDestroy( iDamage, attacker, vDir, vPoint, sMeansOfDeath, modelName, tagName, partName, iDFlags )
{
	if( isDefined( self.script_squad ) ) 
	{
		for( i = 0;i < self.subEnts.size;i++ )
			self.subEnts[i] delete();

		if( isDefined( self.script_fxid ) )
			PlayFX( AddFXToList( self.script_fxid ), self.origin );
			
		if( isDefined( self.script_sound ) )
			thread PlaySoundOnTempEnt( self.script_sound, self.origin );			
	}
	else if( isDefined( self.target ) ) 
	{
		target = getEnt( self.target, "targetname" );
	
		if( isDefined( target ) )
		{
			if( isDefined( target.script_fxid ) )
				PlayFX( AddFXToList( target.script_fxid ), target.origin );
			
			if( isDefined( target.script_sound ) )
				thread PlaySoundOnTempEnt( target.script_sound, target.origin );	
				
			target delete();
		}
	}
	else 
	{
		if( isDefined( self.script_fxid ) )
			PlayFX( AddFXToList( self.script_fxid ), self.origin );
			
		if( isDefined( self.script_sound ) )
			thread PlaySoundOnTempEnt( self.script_sound, self.origin );			
	}
}
