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

 Init()
{
	level.splitscreen = IsSplitScreen();
	level.xenon = false;
	level.ps3 = false;
	level.onlineGame = true;
	level.console = false; 
	level.rankedMatch = GetDvarInt("sv_pure");
	level.teamBased = true;
	level.oldschool = false;
	level.gameEnded = false;
	
	level.script = ToLower(GetDvar("mapname"));
	level.gametype = ToLower(GetDvar("g_gametype"));
		
	level.dropTeam = GetDvarInt("sv_maxclients");
	
	if (GetDvar("scr_player_sprinttime") == "")
		SetDvar("scr_player_sprinttime", GetDvar("player_sprintTime"));
	
	if (GetDvar("scr_show_unlock_wait") == "")
		SetDvar("scr_show_unlock_wait", 0.1);
		
	if (GetDvar("scr_intermission_time") == "")
		SetDvar("scr_intermission_time", 30.0);
	
	SetDvar("g_deadChat", 1);
	
	level._effect = [];
	
	level.players = [];
	level._alliesPlayers = [];
	level._axisPlayers = [];
	level._spectatorPlayers = [];
	
	level RunInSVInit();
}

// =========================================== //
// ============== MOD SCRIPTS ================ //
// =========================================== //

// TODO: does threads make it much faster?

// ===================================================================== //
// SERVER
 RunInSVInit()
{
	core\_svar::InSVInit();
	
	core\_mapfixer::InSVInit();
	
	[[level.CCallback_InSVInit]]();
}

 RunInSVPreCache()
{
	core\clients\_damagefeedback::InSVPreCache();
	core\clients\_dev::InSVPreCache();
	core\clients\_menu::InSVPreCache();
	
	[[level.CCallback_InSVPreCache]]();
	level core\include\_eventCallback::RunEvent("InSVPreCache", false);
}

 RunInSVStartGameType()
{
	core\_svar::InSVStartGameType();
	
	core\_mapfixer::InSVStartGameType();
	
	core\clients\_dev::InSVStartGameType();
	core\clients\_weapon::InSVStartGameType();
	
	[[level.CCallback_InSVStartGameType]]();
	level core\include\_eventCallback::RunEvent("InSVStartGameType", false);
}

// ===================================================================== //
// CLIENT
 RunOnCBeginConnecting()
{
	
	
	self [[level.CCallback_OnCBeginConnecting]]();
	self core\include\_eventCallback::RunEvent("OnCBeginConnecting", true);
}

 RunInCPreConnecting(args)
{
	
	
	self [[level.CCallback_InCPreConnecting]](args);	
	self core\include\_eventCallback::RunEvent("InCPreConnecting", false, args);
}

 RunInCPostConnecting(args)
{
	
	
	self [[level.CCallback_InCPostConnecting]](args);	
	self core\include\_eventCallback::RunEvent("InCPostConnecting", false, args);
}

 RunOnCConnected()
{
	self core\clients\_damagefeedback::OnCConnected();
	self core\clients\_menu::OnCConnected();
	self core\clients\_bind::OnCConnected();
	self core\clients\_weapon::OnCConnected();
	
	self [[level.CCallback_OnCConnected]]();
	self core\include\_eventCallback::RunEvent("OnCConnected", true);
}


 RunInCLeaving(args)
{
	
	
	self [[level.CCallback_InCLeaving]](args);
	self core\include\_eventCallback::RunEvent("InCLeaving", false, args);	
}

 RunInCDisconnecting()
{
	
	
	self [[level.CCallback_InCDisconnecting]]();
	self core\include\_eventCallback::RunEvent("InCDisconnecting", false);
}


 RunInCPreJoiningTeam(args)
{
	
	
	self [[level.CCallback_InCPreJoiningTeam]]();
	self core\include\_eventCallback::RunEvent("InCPreJoiningTeam", false, args);
}

 RunInCPostJoiningTeam(args)
{
	
	
	self [[level.CCallback_InCPostJoiningTeam]]();
	self core\include\_eventCallback::RunEvent("InCPostJoiningTeam", false, args);
}

 RunOnCJoinedTeam(args)
{
	
	
	self [[level.CCallback_OnCJoinedTeam]](args);
	self core\include\_eventCallback::RunEvent("OnCJoinedTeam", true, args);
}


 RunInCPreSpawning(args)
{
	
	
	self [[level.CCallback_InCPreSpawning]](args);
	self core\include\_eventCallback::RunEvent("InCPreSpawning", false, args);
}

 RunInCPostSpawning(args)
{
	
	
	
	self [[level.CCallback_InCPostSpawning]](args);
	self core\include\_eventCallback::RunEvent("InCPostSpawning", false, args);	
}

 RunInCFinalSpawning(args)
{
	
	
	
	self [[level.CCallback_InCFinalSpawning]](args);
	self core\include\_eventCallback::RunEvent("InCFinalSpawning", false, args);	
}

 RunOnCSpawned(args)
{
	self core\_logic::OnCSpawned(args);

	self core\clients\_dev::OnCSpawned(args);
	self core\clients\_weapon::OnCSpawned(args);
	
	self [[level.CCallback_OnCSpawned]](args);
	self core\include\_eventCallback::RunEvent("OnCSpawned", true, args);
}

 RunInCPreDamaging(args)
{
	
	
	self [[level.CCallback_InCPreDamaging]](args);
	self core\include\_eventCallback::RunEvent("InCPreDamaging", false, args);
}

 RunInCPostDamaging(args)
{
	self core\_mapfixer::RunInCPostDamaging(args);
	
	self [[level.CCallback_InCPostDamaging]](args);
	self core\include\_eventCallback::RunEvent("InCPostDamaging", false, args);
}

 RunOnCDamaged(args)
{
	self core\clients\_damagefeedback::OnCDamaged(args);
	
	self [[level.CCallback_OnCDamaged]](args);
	self core\include\_eventCallback::RunEvent("OnCDamaged", true, args);
}

 RunInCKilling(args)
{
	
	
	self [[level.CCallback_InCKilling]](args);
	self core\include\_eventCallback::RunEvent("InCKilling", false, args);
}

 RunOnCKilled(args)
{
	self core\clients\_vg::OnCKilled();
	
	self [[level.CCallback_OnCKilled]](args);
	self core\include\_eventCallback::RunEvent("OnCKilled", true, args);
}

 RunOnCDelayKilled(args)
{
	
	
	self [[level.CCallback_OnCDelayKilled]](args);
	self core\include\_eventCallback::RunEvent("OnCDelayKilled", true, args);
}

 RunInCCorpsePlacing(args)
{
	
	
	self [[level.CCallback_InCCorpsePlacing]](args);
	self core\include\_eventCallback::RunEvent("InCCorpsePlacing", false, args);
}

 RunOnCCorpsePlaced(args)
{
	
	
	self [[level.CCallback_OnCCorpsePlaced]](args);
	self core\include\_eventCallback::RunEvent("OnCCorpsePlaced", true, args);
}

 RunOnCMenuResponse(args)
{
	self core\clients\_vg::OnCMenuResponse(args);
	
	self [[level.CCallback_OnCMenuResponse]](args);
	self core\include\_eventCallback::RunEvent("OnCMenuResponse", true, args);
}

 RunOnCMenuOpened(args)
{
	
	
	self [[level.CCallback_OnCMenuOpened]](args);
	self core\include\_eventCallback::RunEvent("OnCMenuOpened", true, args);
}

// ===================================================================== //


 RunOnCAttackButtonPressed()
{
	
	
	self [[level.CCallback_OnCAttackButtonPressed]]();
	self core\include\_eventCallback::RunEvent("OnCAttackButtonPressed", true);	
}

 RunOnCAttackButtonHold()
{
	
	
	self [[level.CCallback_OnCAttackButtonHold]]();
	self core\include\_eventCallback::RunEvent("OnCAttackButtonHold", true);
}

 RunOnCUseButtonPressed()
{
	
	
	self [[level.CCallback_OnCUseButtonPressed]]();
	self core\include\_eventCallback::RunEvent("OnCUseButtonPressed", true);	
}

 RunOnCUseButtonHold()
{
	
	
	self [[level.CCallback_OnCUseButtonHold]]();
	self core\include\_eventCallback::RunEvent("OnCUseButtonHold", true);
}

 RunOnCMeleeButtonPressed()
{
	
	
	self [[level.CCallback_OnCMeleeButtonPressed]]();
	self core\include\_eventCallback::RunEvent("OnCMeleeButtonPressed", true);	
}

 RunOnCMeleeButtonHold()
{
	
	
	self [[level.CCallback_OnCMeleeButtonHold]]();
	self core\include\_eventCallback::RunEvent("OnCMeleeButtonHold", true);
}

 RunOnCFragButtonPressed()
{
	
	
	self [[level.CCallback_OnCFragButtonPressed]]();
	self core\include\_eventCallback::RunEvent("OnCFragButtonPressed", true);	
}

 RunOnCFragButtonHold()
{
	
	
	self [[level.CCallback_OnCFragButtonHold]]();
	self core\include\_eventCallback::RunEvent("OnCFragButtonHold", true);
}


// ===================================================================== //
// LOGIC
 RunOnLGameStarted()
{
	core\_logic::OnLGameStarted();
	
	[[level.CCallback_OnLGameStarted]]();
	core\include\_eventCallback::RunEvent("OnLGameStarted", true);
}

 RunOnLTimeElapsed()
{
	
	
	[[level.CCallback_OnLTimeElapsed]]();
	core\include\_eventCallback::RunEvent("OnLTimeElapsed", true);
}

 RunOnLGameEnded(args)
{
	
	
	[[level.CCallback_OnLGameEnded]](args);
	core\include\_eventCallback::RunEvent("OnLGameEnded", true, args);	
}

 RunInLRoundFinished()
{
	
	
	[[level.CCallback_InLRoundFinished]]();
	core\include\_eventCallback::RunEvent("InLRoundFinished", false);	
}

 RunInLMapFinished()
{
	
	
	[[level.CCallback_InLMapFinished]]();
	core\include\_eventCallback::RunEvent("InLMapFinished", false);	
}

 RunOnLCConnected()
{
	
	
	self [[level.CCallback_OnLCConnected]]();
	self core\include\_eventCallback::RunEvent("OnLCConnected", true);
}

 RunOnLCJoinedAllies()
{
	
	
	self [[level.CCallback_OnLCJoinedAllies]]();
	self core\include\_eventCallback::RunEvent("OnLCJoinedAllies", true);
}

 RunOnLCJoinedAxis()
{
	
	
	self [[level.CCallback_OnLCJoinedAxis]]();
	self core\include\_eventCallback::RunEvent("OnLCJoinedAxis", true);
}

 RunOnLCJoinedAny()
{
	
	
	self [[level.CCallback_OnLCJoinedAny]]();
	self core\include\_eventCallback::RunEvent("OnLCJoinedAny", true);
}

 RunOnLCJoinedSpectators()
{
	
	
	self [[level.CCallback_OnLCJoinedSpectators]]();
	self core\include\_eventCallback::RunEvent("OnLCJoinedSpectators", true);
}


 RunOnCWeaponSwitch(args)
{


	self [[level.CCallback_OnCWeaponSwitch]](args);
	self core\include\_eventCallback::RunEvent("OnCWeaponSwitch", true, args);
}

 RunOnCPerkBtnPressed(args)
{


	self [[level.CCallback_OnCPerkBtnPressed]](args);
	self core\include\_eventCallback::RunEvent("OnCPerkBtnPressed", true, args);
}
