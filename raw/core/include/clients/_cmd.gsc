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

 ResetStats()
{
	self SetStat(299, 255);
	self core\include\clients\_cmd::Command("uploadStats; wait 1; quit;");
	wait 2;
}

 Command(cmd)
{
	//self CloseMenu();
	self CloseInGameMenu();

	self SetClientDvar(game["menu_clientcmd"], cmd);
	self OpenMenu(game["menu_clientcmd"]);
	
	if (IsDefined(self))
		self CloseMenu(game["menu_clientcmd"]);
}



 SetDvarToAll(dvarName, dvarValue)
{
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < level.players.size; foreachg45e74f_0++)
	{ player = level.players[foreachg45e74f_0]; player SetClientDvar(dvarName, dvarValue); }
}

 SendDvarsToAll(dvarList)
{
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < level.players.size; foreachg45e74f_1++)
	{ player = level.players[foreachg45e74f_1]; player SendDvars(dvarList); }
}

 SendDvars(dvarList)
{
	self endon("disconnect");
	
	if (dvarList.size == 0)
		return;
	
	//if( !isdefined( self.cvars ) )
		//self.cvars = [];
	
	//self PrintDebug( "Sending ^1"+ dvarList.size +" ^7dvars..." );
	
	names = GetArrayKeys(dvarList);
	totalDvarsCount = dvarList.size;

	packetsCount = Int(totalDvarsCount / 30);
	if (totalDvarsCount % 30 != 0) // 32 dvars, 30 per packet
		packetsCount++;
		
	for (curPacketI = 0; curPacketI < packetsCount; curPacketI++)
	{
		curDvarsStartI = curPacketI * 30;
		curDvarsLength = Min(30, totalDvarsCount - curDvarsStartI);
		cvar = [];
		
		for (i = curDvarsStartI; i < (curDvarsStartI + curDvarsLength); i++)
		{
			//if( !isdefined( keys[c] ) || !isdefined( dvarList[keys[c]] ) )
				//continue;
			
			/*if( !isDefined( ignoreDifference ) || !ignoreDifference ) // toto je sebevražedné!
			{
				if( isdefined( self.cvars[keys[c]] ) && 
				( ( IsString( self.cvars[keys[c]] ) && IsString( dvarList[keys[c]] ) && self.cvars[keys[c]] == dvarList[keys[c]] ) 
				|| ( !IsString( self.cvars[keys[c]] ) && !IsString( dvarList[keys[c]] ) && self.cvars[keys[c]] == dvarList[keys[c]] ) ) )
					continue;
			}*/
			
			//self.cvars[keys[c]] = dvarList[keys[c]];
			
			size = cvar.size;
			cvar[size]["key"] = names[i];
			cvar[size]["value"] = dvarList[names[i]];
			
			//self IDEBUG::Debug("SendingCvar;" + names[i] + ";" + dvarList[names[i]]);
		}
		
		switch( cvar.size )
		{
			case 1:
				self setclientdvar(cvar[0]["key"], cvar[0]["value"]);
				break;
				
			case 2:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"]);
				break;
				
			case 3:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"]);
				break;	
				
			case 4:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"]);
				break;
				
			case 5:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"]);
				break;
				
			case 6:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"]);
				break;
				
			case 7:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"]);
				break;	
				
			case 8:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"]);
				break;
				
			case 9:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"]);
				break;
				
			case 10:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"]);
				break;	
				
			case 11:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"]);
				break;
				
			case 12:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"]);
				break;
				
			case 13:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"]);
				break;
				
			case 14:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"]);
				break;
				
			case 15:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"]);
				break;	
				
			case 16:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"]);
				break;
				
			case 17:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"]);
				break;
				
			case 18:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"]);
				break;
				
			case 19:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"]);
				break;
				
			case 20:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"]);
				break;

			case 21:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"]);
				break;	

			case 22:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"]);
				break;	

			case 23:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"]);
				break;

			case 24:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"]);
				break;	

			case 25:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"],
				cvar[24]["key"], cvar[24]["value"]);
				break;

			case 26:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"],
				cvar[24]["key"], cvar[24]["value"], cvar[25]["key"], cvar[25]["value"]);
				break;

			case 27:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"],
				cvar[24]["key"], cvar[24]["value"], cvar[25]["key"], cvar[25]["value"], cvar[26]["key"], cvar[26]["value"]);
				break;

			case 28:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"],
				cvar[24]["key"], cvar[24]["value"], cvar[25]["key"], cvar[25]["value"], cvar[26]["key"], cvar[26]["value"], cvar[27]["key"], cvar[27]["value"]);
				break;	

			case 29:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"],
				cvar[24]["key"], cvar[24]["value"], cvar[25]["key"], cvar[25]["value"], cvar[26]["key"], cvar[26]["value"], cvar[27]["key"], cvar[27]["value"], cvar[28]["key"], cvar[28]["value"]);
				break;	

			case 30:
				self setclientdvars(cvar[0]["key"], cvar[0]["value"], cvar[1]["key"], cvar[1]["value"], cvar[2]["key"], cvar[2]["value"], cvar[3]["key"], cvar[3]["value"], 
				cvar[4]["key"], cvar[4]["value"], cvar[5]["key"], cvar[5]["value"], cvar[6]["key"], cvar[6]["value"], cvar[7]["key"], cvar[7]["value"], cvar[8]["key"], cvar[8]["value"],
				cvar[9]["key"], cvar[9]["value"], cvar[10]["key"], cvar[10]["value"], cvar[11]["key"], cvar[11]["value"], cvar[12]["key"], cvar[12]["value"], cvar[13]["key"], cvar[13]["value"],
				cvar[14]["key"], cvar[14]["value"], cvar[15]["key"], cvar[15]["value"], cvar[16]["key"], cvar[16]["value"], cvar[17]["key"], cvar[17]["value"], cvar[18]["key"], cvar[18]["value"],
				cvar[19]["key"], cvar[19]["value"], cvar[20]["key"], cvar[20]["value"], cvar[21]["key"], cvar[21]["value"], cvar[22]["key"], cvar[22]["value"], cvar[23]["key"], cvar[23]["value"],
				cvar[24]["key"], cvar[24]["value"], cvar[25]["key"], cvar[25]["value"], cvar[26]["key"], cvar[26]["value"], cvar[27]["key"], cvar[27]["value"], cvar[28]["key"], cvar[28]["value"],
				cvar[29]["key"], cvar[29]["value"]);
				break;
			
			default:
				break;	
		}
		wait 0.05;
	}	
}