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

// SET - GET
// TODO: optimalizovaù...ukladaù stream s˙Ëasnej mapy, atÔ...
 Set(sMapName, sName, sValue)
{
	stream = Stream_Create(sMapName);
	stream Stream_Set(sName, sValue);
	stream Stream_Save();
}

 Get(sMapName, sName)
{
	stream = Stream_Create(sMapName);
	return stream Stream_Get(sName);
}

// ======================================================================= //


 Stream_Create(sMapName)
{
	stream = SpawnStruct();
	stream.sMapName = sMapName;
	stream.Vars = [];
	
	stream LoadVarsFromDvar(sMapName);
	
	return stream;
}

 Stream_Set(sName, sValue)
{
	self.Vars[sName] = sValue;
}

 Stream_Get(sName)
{
	return self.Vars[sName];
}

 Stream_Save()
{
	self SaveVarsToDvar();
}

 LoadVarsFromDvar(sMapName)
{
	dvarValue = GetDvar("mapVars_" + sMapName);
	if (dvarValue == "")
		return;
		
	toks = StrTok(dvarValue, ";");
	isValue = false;
	name = undefined;
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < toks.size; foreachg45e74f_0++)
	{ tok = toks[foreachg45e74f_0];
		if (tok == "")
			continue;
	
		if (!isValue)
			name = tok;
		else
			self.Vars[name] = tok;
			
		isValue = !isValue;
	}
}

 SaveVarsToDvar()
{
	value = "";

	names = GetArrayKeys(self.Vars);
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < names.size; foreachg45e74f_1++)
	{ name = names[foreachg45e74f_1]; value += name + ";" + self.Vars[name] + ";"; }
		
	SetDvar("mapVars_" + self.sMapName, value);
}


// ======================================================================= //