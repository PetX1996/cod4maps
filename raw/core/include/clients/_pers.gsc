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

 InitPersStat(sDataName)
{
	if (!IsDefined(self.pers[sDataName]))
		self.pers[sDataName] = 0;
		
	switch (ToLower(sDataName))
	{
		case "score":
			self.Score = self.pers[sDataName];
			break;
		case "kills":
			self.Kills = self.pers[sDataName];
			break;
		case "assists":
			self.Assists = self.pers[sDataName];
			break;
		case "deaths":
			self.Deaths = self.pers[sDataName];
			break;
		default:
			break;
	}
}

 GetPersStat(sDataName)
{
	return self.pers[sDataName];
}

 IncPersStat(sDataName, iInc)
{
	if (!IsDefined(iInc)) iInc = 1;

	self.pers[sDataName] += iInc;
	self core\include\clients\_stat::AddByName(sDataName, iInc);
	
	switch (ToLower(sDataName))
	{
		case "score":
			self.Score += iInc;
			break;
		case "kills":
			self.Kills += iInc;
			break;
		case "assists":
			self.Assists += iInc;
			break;
		case "deaths":
			self.Deaths += iInc;
			break;
		default:
			break;
	}
}