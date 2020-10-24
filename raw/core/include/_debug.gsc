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






 DebugOffline(msg, type)
{
	LogPrint("[DEBUG]" + msg + "\n");
}

 Debug(msg, type)
{
	thread ProcessDebug(msg, type);
}

 ProcessDebug(msg, type)
{
	if (!IsDefined(type)) type = 0;

	text = "";
	if (type == 0)
		text = "^4[V]^7";
	else if (type == 1)
		text = "^2[I]^7";
	else if (type == 2)
		text = "^3[W]^7";
	else if (type == 3)
		text = "^1[E]^7";
	else
		core\include\_exception::ArgumentMsg("Unknown type");
		
	text += msg;
	
	// iprintln prints at most 256 chars
	texts = [];
	for (i = 0; i < Int(text.size / 100) + 1; i++)
		texts[i] = GetSubStr(text, Int(i * 100), Int((i + 1) * 100));
	
	if (IsPlayer(self))
	{
		for (foreachg45e74f_0 = 0; foreachg45e74f_0 < texts.size; foreachg45e74f_0++)
		{ sText = texts[foreachg45e74f_0]; self IPrintLn(sText); }
	}
	else
	{
		for (foreachg45e74f_1 = 0; foreachg45e74f_1 < texts.size; foreachg45e74f_1++)
		{ sText = texts[foreachg45e74f_1]; IPrintLn(sText); }
	}	
	// TODO: write to log, to current user, svar specifications, ... 
}