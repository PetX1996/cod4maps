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

InSVPreCache()
{
	core\include\clients\_menu::AddMenu("team", "team_marinesopfor");
	core\include\clients\_menu::AddMenu("controls", "ingame_controls");
	core\include\clients\_menu::AddMenu("options", "ingame_options");
	
	core\include\clients\_menu::AddMenu("clientcmd", "clientcmd");
	core\include\clients\_menu::AddMenu("scoreboard", "scoreboard");
	
	core\include\clients\_menu::AddMenu("vg", "vg");
}

OnCConnected()
{
	self thread MonitorMenuResponses();
}

 MonitorMenuResponses()
{
	self endon("disconnect");
	
	while (true)
	{
		self waittill("menuresponse", sMenuName, sResponse);
		self ProcessMenuResponse(sMenuName, sResponse);
	}
}

 ProcessMenuResponse(sMenuName, sResponse)
{
	responseArgs = StrTok(sResponse, ",");
	sResponse = responseArgs[0];
	
	core\include\_debug::Debug("sMenuName;" + sMenuName + ";sResponse;" + sResponse + ";Args;" + core\include\_string::Join(",", responseArgs));
	
	if (self CheckTeamLogicResponses(sResponse))
		return;
	
	if (sResponse == "onOpen")
	{
		self core\include\clients\_menu::SetOpenedMenu(sMenuName, sResponse, responseArgs);
		return;
	}
	
	if (self CheckLeavingGame(sResponse))
		return;
	
	args = core\include\_eventCallback::Args_Create();
	args.sMenuName = sMenuName;
	args.sResponse = sResponse;
	args.ResponseArgs = responseArgs;
	self core\_init::RunOnCMenuResponse(args);
}

 CheckTeamLogicResponses(sResponse)
{
	switch (sResponse)
	{
		case "joinAllies":
			self core\_init::RunOnLCJoinedAllies();
			return true;
		case "joinAxis":
			self core\_init::RunOnLCJoinedAxis();
			return true;
		case "joinAny":
			self core\_init::RunOnLCJoinedAny();
			return true;
		case "joinSpectators":
			self core\_init::RunOnLCJoinedSpectators();
			return true;
		default:
			return false;
	}
}

 CheckLeavingGame(sResponse)
{
	if (sResponse == "leaving")
	{
		args = core\include\_eventCallback::Args_Create();
		args.bCancel = undefined;
		self core\_init::RunInCLeaving(args);
		if (!IsDefined(args.bCancel))
			self core\include\clients\_cmd::Command("disconnect;");
		
		return true;
	}
	return false;
}