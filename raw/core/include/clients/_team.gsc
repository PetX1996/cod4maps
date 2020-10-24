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

 JoinAllies()
{
	self endon("disconnect");

	oldTeam = self.pers["team"];
	args = core\include\_eventCallback::Args_Create();
	args.bCancel = undefined;
	args.sOldTeam = oldTeam;
	args.sNewTeam = "allies";
	
	self core\_init::RunInCPreJoiningTeam(args);
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCPostJoiningTeam(args);

	if (IsDefined(args.bCancel))
		return;
	
	
	if ((oldTeam == "allies" || oldTeam == "axis") && IsAlive(self))
		self core\include\clients\_damage::SuicideSilent();

	//iprintln("JoinAllies");
	
	self core\include\clients\_player::ClearPlayerState();
	
	self.pers["team"] = "allies";
	self.Team = "allies";
	self.SessionTeam = "allies";
	self.StatusIcon = "hud_status_dead";
	
	self UpdateClientsLists();
	
	
	self notify("joined_team");
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunOnCJoinedTeam(args);
}

 JoinAxis()
{
	self endon("disconnect");

	oldTeam = self.pers["team"];
	args = core\include\_eventCallback::Args_Create();
	args.bCancel = undefined;
	args.sOldTeam = oldTeam;
	args.sNewTeam = "axis";
	
	self core\_init::RunInCPreJoiningTeam(args);
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCPostJoiningTeam(args);

	if (IsDefined(args.bCancel))
		return;
		
		
	if ((oldTeam == "allies" || oldTeam == "axis") && IsAlive(self))
		self core\include\clients\_damage::SuicideSilent();
	
	//iprintln("JoinAxis");
	
	self core\include\clients\_player::ClearPlayerState();
	
	self.pers["team"] = "axis";
	self.Team = "axis";
	self.SessionTeam = "axis";
	self.StatusIcon = "hud_status_dead";
	
	self UpdateClientsLists();
	
	
	self notify("joined_team");
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunOnCJoinedTeam(args);
}

 JoinSpectator()
{
	self endon("disconnect");

	oldTeam = self.pers["team"];
	args = core\include\_eventCallback::Args_Create();
	args.bCancel = undefined;
	args.sOldTeam = oldTeam;
	args.sNewTeam = "spectator";
	
	self core\_init::RunInCPreJoiningTeam(args);
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunInCPostJoiningTeam(args);

	if (IsDefined(args.bCancel))
		return;

	
	if ((oldTeam == "allies" || oldTeam == "axis") && IsAlive(self))
		self core\include\clients\_damage::SuicideSilent();
	
	//iprintln("JoinSpectator");
	
	self core\include\clients\_player::ClearPlayerState();
	
	self.pers["team"] = "spectator";
	self.SessionTeam = "spectator";
	self.SessionState = "spectator";
	self.SpectatorClient = -1;
	self.StatusIcon = "";
	self.Team = "spectator";
	
	spawnPoints = core\include\clients\_spawn::GetSpawnPoints("spectator");
	spawnPoint = spawnPoints[RandomInt(spawnPoints.size)];
	self Spawn(spawnPoint.Origin, spawnPoint.Angles);	
	
	self AllowSpectateTeam("freelook", true);
	self AllowSpectateTeam("allies", true);
	self AllowSpectateTeam("axis", true);
	self AllowSpectateTeam("none", true);
	
	self UpdateClientsLists();
	
	
	self notify("joined_spectators");
	
	args core\include\_eventCallback::Args_Reset();
	self core\_init::RunOnCJoinedTeam(args);
}

 UpdateClientsLists()
{
	level._alliesPlayers = core\include\array\_array::Remove(level._alliesPlayers, self);
	level._axisPlayers = core\include\array\_array::Remove(level._axisPlayers, self);
	level._spectatorPlayers = core\include\array\_array::Remove(level._spectatorPlayers, self);
	
	if (self.pers["team"] == "allies")
		level._alliesPlayers[level._alliesPlayers.size] = self;
	else if (self.pers["team"] == "axis")
		level._axisPlayers[level._axisPlayers.size] = self;
	else if	(self.pers["team"] == "spectator")
		level._spectatorPlayers[level._spectatorPlayers.size] = self;
}