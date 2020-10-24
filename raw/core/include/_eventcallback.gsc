//I========================================================================I
//I                    ___  _____  _____                                   I
//I                   /   !!  __ \!  ___!                                  I
//I                  / /! !! !  \/! !_          ___  ____                  I
//I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//I                     !_/ \____/\_!     (_)  \___!/___!                  I
//I                                                                        I
//I========================================================================I
// Call of Duty 4: Modern Warfare
//I========================================================================I
// Mod      : Core
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include core\include\_usings;

// ================================================================================================================================================================================================= //
// CALLBACK LIST
// ================================================================================================================================================================================================= //
// <name>						<sender> <parameters>
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// InSVPreCache					level			
// InSVStartGameType			level			
// 
// OnCBeginConnecting			p
// InCPreConnecting				p				DvarDic
// InCPostConnecting			p				DvarDic
// OnCConnected					p
//
// InCLeaving					p		bCancel
// InCDisconnecting				p
//
// OnCPreJoiningTeam			p		bCancel	{OnCJoinedTeam}
// OnCPostJoiningTeam			p		bCancel	{OnCJoinedTeam}
// OnCJoinedTeam				p				sOldTeam, sNewTeam

// InCPreSpawning				p		bCancel	{OnCSpawned}, DvarDic
// InCPostSpawning				p		bCancel	{OnCSpawned}, DvarDic
// InCFinalSpawning				p				{OnCSpawned}, DvarDic
// OnCSpawned					p				SpawnPoint, sBodyModel, sHeadModel, sViewModel, iHealth, fSpeed, sForcedWeapon, sSpawnWeapon, Weapons, sOffHand, sSecondaryOffHand, sActionSlot1, sActionSlot2, sActionSlot3, sActionSlot4, Perks
//
// InCPreDamaging				p		bCancel	{OnCDamaged}
// InCPostDamaging				p		bCancel	{OnCDamaged}
// OnCDamaged					p				eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime
//
// InCKilling					p				{OnCKilled}
// OnCKilled					p				eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, bSuicideSilent
// OnCDelayKilled				p				{OnCKilled}
//
// InCCorpsePlacing				p		bCancel {OnCKilled}, fExplosionForce, fExplosionRadius
// OnCCorpsePlaced				p				{OnCKilled}, fExplosionForce, fExplosionRadius, eBody
//
// OnCMenuOpened				p				{OnCMenuResponse}
// OnCMenuResponse				p				sMenuName, sResponse, ResponseArgs
//
// OnLGameStarted				level
// OnLTimeElapsed				level
// OnLGameEnded					level			iType, [sWinningTeam], [pWinner]
// InLRoundFinished				level
// InLMapFinished				level

// OnLCConnected				p
// OnLCJoinedAllies				p
// OnLCJoinedAxis				p
// OnLCJoinedAny				p
// OnLCJoinedSpectators			p
//
// OnAttackButtonPressed		p	
// OnAttackButtonHold			p	
// OnUseButtonPressed			p	
// OnUseButtonHold				p	
// OnMeleeButtonPressed			p	
// OnMeleeButtonHold			p	
//
// DEATHRUN
// InCSpraying					p		bCancel {OnCSprayed}
// OnCSprayed					p				sFX, vPos, vForward, vUp

// OnLJumpersStarted			level
// OnLActivatorsStarted			level
// OnLCActivatorPicked			p

// InLVictoryMusicPicking		level			Music
// InLEOGMusicPicking			level			Music

// InMLCTouchTT					p		bCancel	{OnMLCTouchTT}
// OnMLCTouchTT					p				eTrig

// InMLCTouchTJ					p		bCancel	{OnMLCTouchTJ}
// OnMLCTouchTJ					p				eTrig

// InMLCFinishedMap				p		bCancel	{OnMLCFinishedMap}
// OnMLCFinishedMap				p				iPlace, [eTrig]

// ================================================================================================================================================================================================= //
// On - threaded
// In - executes continuously, functions does not have to contain any WAIT!

/// <summary>
/// Adds a callback function for level.
/// Func(args)
///  - Self: sender
///  - args: struct of callbackEvent args
/// </summary>
/// <self>Struct</self>
/// <param name="name">String</param>
/// <param name="func">Func(args)</param>
 AddEvent(name, func)
{
	if (!IsDefined(level.CallbackEvents))
		level.CallbackEvents = [];
		
	if (!IsDefined(level.CallbackEvents[name]))
		level.CallbackEvents[name] = [];

	size = level.CallbackEvents[name].size;
	level.CallbackEvents[name][size] = func;
}

/// <summary>
/// Deletes a callback function for level.
/// </summary>
/// <self>Struct</self>
/// <param name="name">String - Deletes all callbacks for self if it is undefined</param>
/// <param name="func">Func(args) - Deletes all callbacks for specified name if it is undefined</param>
 DeleteEvent(name, func)
{
	if (IsDefined(name) && IsDefined(func))
	{
		if (!IsDefined(level.CallbackEvents) || !IsDefined(level.CallbackEvents[name]))
			return;
		
		level.CallbackEvents[name] = core\include\array\_array::Remove(level.CallbackEvents[name], func);
	}
	else if (IsDefined(name))
	{
		if (!IsDefined(level.CallbackEvents))
			return;		
			
		level.CallbackEvents[name] = undefined;
	}
	else
	{
		level.CallbackEvents = undefined;
	}
}

 Args_Create()
{
	args = SpawnStruct();
	args Args_Reset();
	return args;
}

/// <summary>
/// Sets a default callbackEvent's args struct.
///  - 
/// </summary>
/// <returns>Struct</returns>
 Args_Reset()
{
	//args.Cancel = false;
}

/// <summary>
/// Runs a callback with specified name on self.
/// </summary>
/// <self>Struct</self>
/// <param name="name">String</param>
/// <param name="isThreaded">Bool</param>
/// <param name="args">Struct</param>
 RunEvent(name, isThreaded, args)
{
	if (self == level)
		ent = "Level";
	else if (IsPlayer(self))
		ent = "Player";
	else
		ent = "";
		
	text = "RunEvent;" + ent + ";" + name + ";0";
	
	if (IsDefined(level.CallbackEvents) && IsDefined(level.CallbackEvents[name]))
	{
		text = "RunEvent;" + ent + ";" + name + ";" + level.CallbackEvents[name].size;
	
		if (!IsDefined(args))
			args = Args_Create();
			
		for (i = 0; i < level.CallbackEvents[name].size; i++)
		{
			if (isThreaded)
				self thread [[level.CallbackEvents[name][i]]](args);			
			else
				self [[level.CallbackEvents[name][i]]](args);
		}
	}
	
	//self IDEBUG::Debug(text);
}

/*
DebugCallbacks( printTotalSize, printTypesSize )
{
	totalSize = 0;
	ents = GetEntArray();
	for( i = 0; i < ents.size; i++ )
		totalSize += DebugObjectCallbacks( ents[i], printTotalSize, printTypesSize );
		
	LogPrint( "CALLBACKS;totalSize;"+totalSize+"\n" );
}

DebugObjectCallbacks( object, printTotalSize, printTypesSize )
{
	if( !IsDefined( object ) || !IsDefined( object.CALLBACK ) )
		return 0;
		
	totalSize = 0;
	types = GetArrayKeys( object.CALLBACK );
	for( k = 0; k < types.size; k++ )
	{
		typeSize = object.CALLBACK[types[k]].size;
		if( printTypesSize )
			LogPrint( "CALLBACKS;typeName;"+types[k]+";typeSize;"+typeSize+"\n" );
		
		totalSize += typeSize;
	}
	
	if( printTotalSize )
	{
		text = "CALLBACKS;";
		if( IsDefined( object.className ) )
			text += "objectClassName;"+object.classname+";";
		if( IsDefined( object.targetName ) )
			text += "objectTargetName;"+object.targetname+";";
		
		LogPrint( text+";totalSize;"+totalSize+"\n" );
	}
	
	return totalSize;
}*/