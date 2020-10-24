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

// ======================================================================================= //


 Entity_Get(sClassName, vOrigin, sTargetName)
{
	eEnt = Entity_OnlyGet(sClassName, vOrigin, sTargetName);
	eEnt Entity_Register();
	return eEnt;
}

 Entity_OnlyGet(sClassName, vOrigin, sTargetName)
{
	ents = GetEntArray(sClassName, "classname");
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < ents.size; foreachg45e74f_0++)
	{ eEnt = ents[foreachg45e74f_0];
		if (IsDefined(sTargetName) && IsDefined(eEnt.sOrigTargetName))
		{
			if (eEnt.sOrigTargetName == sTargetName)
			{
				if ((IsDefined(eEnt.vOrigOrigin) && eEnt.vOrigOrigin == vOrigin)
					|| (!IsDefined(eEnt.vOrigOrigin) && eEnt.origin == vOrigin))
				{
					return eEnt;
				}
			}
		}
		else if (!IsDefined(sTargetName) && !IsDefined(eEnt.sOrigTargetName))
		{
			if ((IsDefined(eEnt.vOrigOrigin) && eEnt.vOrigOrigin == vOrigin)
				|| (!IsDefined(eEnt.vOrigOrigin) && eEnt.origin == vOrigin))
			{
				return eEnt;
			}	
		}
	}

	return undefined;
}

 Entity_Spawn(sClassName, vOrigin, sTargetName, fRadius, fHeight)
{
	eEnt = Spawn(sClassName, vOrigin, 0, fRadius, fHeight);
	eEnt.targetname = sTargetName;
	eEnt.radius = fRadius;
	eEnt.height = fHeight;
	
	eEnt.vOrigOrigin = vOrigin;
	eEnt.sOrigTargetName = sTargetName;
	
	eEnt Entity_Register();
	if (core\include\_game::IsDev())
	{
		eEnt.MF.bIsSpawned = true;
	}

	return eEnt;
}

 Entity_Delete()
{
	if (core\include\_game::IsDev() && !IsDefined(self.bIsFake))
	{
		self Entity_Register();
		if (!IsDefined(self.MF.bIsDeleted))
		{
			self.MF.bIsDeleted = true;
			
			if (self.classname == "script_model" || self.classname == "script_brushmodel")
			{
				self Hide();
				self NotSolid();
			}
		}
	}
	else
		self Delete();
}

 Entity_Property(sPropName, propValue)
{
	if (core\include\_game::IsDev() && !IsDefined(self.bIsFake))
	{
		if (!IsDefined(self.MF) || !IsDefined(self.MF.OrigPropValues[sPropName]))
		{
			self Entity_Register();
			
			self.MF.OrigPropValues[sPropName] = self Entity_GetPropOrigValue(sPropName);;
		}
	}
	
	self core\include\_entity::SetValueByKey(sPropName, propValue);
}

 Entity_Register()
{
	if (core\include\_game::IsDev() && !IsDefined(self.MF))
	{
		level.MF.Ents.EntsList[level.MF.Ents.EntsList.size] = self;
		self Entity_MFInit();
	}
}

 Entity_UnRegister()
{
	if (core\include\_game::IsDev() && IsDefined(self.MF))
	{
		level.MF.Ents.EntsList = core\include\array\_array::Remove(level.MF.Ents.EntsList, self);
		
		if (IsDefined(self.MF.bIsSpawned))
			self Delete();
		else
		{
			self Entity_Restore();
			self.MF = undefined;
		}
	}
}

 Entity_Restore()
{
	if (core\include\_game::IsDev() && IsDefined(self.MF))
	{
		if (IsDefined(self.MF.bIsDeleted))
		{
			self.MF.bIsDeleted = undefined;
			if (self.classname == "script_model" || self.classname == "script_brushmodel")
			{
				self Show();
				self Solid();
			}
		}
		
		keys = GetArrayKeys(self.MF.OrigPropValues);
		for (foreachg45e74f_1 = 0; foreachg45e74f_1 < keys.size; foreachg45e74f_1++)
		{ sKey = keys[foreachg45e74f_1];
			self core\include\_entity::SetValueByKey(sKey, self.MF.OrigPropValues[sKey]);
		}
		self.MF.OrigPropValues = [];
	}
}

 Entity_MFInit()
{
	self.MF = SpawnStruct();
	self.MF.bIsDeleted = undefined;
	self.MF.bIsSpawned = undefined;
	self.MF.OrigPropValues = [];
}

 Entity_GetPropOrigValue(sPropName)
{
	if (core\include\_game::IsDev() && !IsDefined(self.bIsFake))
	{
		if (sPropName == "origin")
			return self.vOrigOrigin;
		else if (sPropName == "targetname")
			return self.sOrigTargetName;
	}

	if (IsDefined(self.MF) && IsDefined(self.MF.OrigPropValues[sPropName]))
		return self.MF.OrigPropValues[sPropName];
	else
		return self core\include\_entity::GetValueByKey(sPropName);
}



 Entities_GetOutputForSave()
{
	ls = core\include\array\_list::Create();
	ls core\include\array\_list::Add("    " + "// Entities");
	
	for (foreachg45e74f_2 = 0; foreachg45e74f_2 < level.MF.Ents.EntsList.size; foreachg45e74f_2++)
	{ eEnt = level.MF.Ents.EntsList[foreachg45e74f_2];
		if (IsDefined(eEnt.MF.bIsSpawned) && IsDefined(eEnt.MF.bIsDeleted))
			continue;
	
		origOrigin = eEnt Entity_GetPropOrigValue("origin");
		origTargetName = eEnt Entity_GetPropOrigValue("targetname");
		
		if (IsDefined(eEnt.MF.bIsSpawned))
		{
			if (IsDefined(origTargetName) && IsDefined(eEnt.radius) && IsDefined(eEnt.height))
				ls core\include\array\_list::Add("    " + "eEnt = core\\include\\_mapfixer::Entity_Spawn(\"" + eEnt.classname + "\", " + origOrigin + ", \"" + origTargetName + "\", " + eEnt.radius + ", " + eEnt.height + ");");
			else if (IsDefined(origTargetName))
				ls core\include\array\_list::Add("    " + "eEnt = core\\include\\_mapfixer::Entity_Spawn(\"" + eEnt.classname + "\", " + origOrigin + ", \"" + origTargetName + "\");");
			else if (IsDefined(eEnt.radius) && IsDefined(eEnt.height))
				ls core\include\array\_list::Add("    " + "eEnt = core\\include\\_mapfixer::Entity_Spawn(\"" + eEnt.classname + "\", " + origOrigin + ", undefined, " + eEnt.radius + ", " + eEnt.height + ");");
			else
				ls core\include\array\_list::Add("    " + "eEnt = core\\include\\_mapfixer::Entity_Spawn(\"" + eEnt.classname + "\", " + origOrigin + ");");
		}
		else
		{
			if (IsDefined(origTargetName))
				ls core\include\array\_list::Add("    " + "eEnt = core\\include\\_mapfixer::Entity_Get(\"" + eEnt.classname + "\", " + origOrigin + ", \"" + origTargetName + "\");");
			else
				ls core\include\array\_list::Add("    " + "eEnt = core\\include\\_mapfixer::Entity_Get(\"" + eEnt.classname + "\", " + origOrigin + ");");
		}
		
		if (IsDefined(eEnt.MF.bIsDeleted))
			ls core\include\array\_list::Add("    " + "eEnt core\\include\\_mapfixer::Entity_Delete();");
		else
		{
			keys = GetArrayKeys(eEnt.MF.OrigPropValues);
			for (foreachg45e74f_3 = 0; foreachg45e74f_3 < keys.size; foreachg45e74f_3++)
			{ sKey = keys[foreachg45e74f_3];
				value = eEnt core\include\_entity::GetValueByKey(sKey);
				if (IsString(value))
					value = "\"" + value + "\"";
					
				ls core\include\array\_list::Add("    " + "eEnt core\\include\\_mapfixer::Entity_Property(\"" + sKey + "\", " + value + ");");
			}
		}
		
		ls core\include\array\_list::Add("");
	}
	
	ls core\include\array\_list::Add("");
	return ls;
}


// ======================================================================================= //








 BG_Create()
{
	bg = SpawnStruct();
	bg.Cuboids = [];
	
	return bg;
}


 BG_CreateHurt(iDmg, sTeam)
{
	bg = BG_Create();
	bg.iDmg = iDmg;
	bg.sTeam = sTeam;
	
	if (core\include\_game::IsDev())
		bg.sClassName = "BG_Hurt";
	
	level.MF.Boxes.Hurts[level.MF.Boxes.Hurts.size] = bg;
	return bg;
}

 BG_UnRegHurt()
{
	level.MF.Boxes.Hurts = core\include\array\_array::Remove(level.MF.Boxes.Hurts, self);
}


 BG_CreateCollide(sTeam)
{
	bg = BG_Create();
	bg.sTeam = sTeam;
	
	if (core\include\_game::IsDev())
		bg.sClassName = "BG_Collide";
	
	level.MF.Boxes.Collides[level.MF.Boxes.Collides.size] = bg;
	return bg;
}

 BG_UnRegCollide()
{
	level.MF.Boxes.Collides = core\include\array\_array::Remove(level.MF.Boxes.Collides, self);
}


 BG_CreateBulletWall(sTeam)
{
	bg = BG_Create();
	bg.sTeam = sTeam;
	
	if (core\include\_game::IsDev())
		bg.sClassName = "BG_BulletWall";
	
	level.MF.Boxes.BulletWalls[level.MF.Boxes.BulletWalls.size] = bg;
	return bg;
}

 BG_UnRegBulletWall()
{
	level.MF.Boxes.BulletWalls = core\include\array\_array::Remove(level.MF.Boxes.BulletWalls, self);
}


 BG_UnReg()
{
	self BG_UnRegHurt();
	self BG_UnRegCollide();
	self BG_UnRegBulletWall();
}

 BG_RemoveShape(shape)
{
	switch (shape.sClassName)
	{
		case "SHAPE_Cuboid":
			self BG_RemoveCuboid(shape);
			break;
		default:
			core\include\_exception::InvalidOperationMsg("Unknown shape " + shape.sClassName);
			break;
	}
}
/*
public sealed BulletBool_BothInside = 0;
public sealed BulletBool_BothOutside = 1;
public sealed BulletBool_InsideOutside = 2;
public Box_BulletBool(iType)
{
	box = Box_Create();
	box.iType = iType;
	
	level.MF.Boxes.BulletBoolsList[level.MF.Boxes.BulletBoolsList.size] = box;
	return box;
}

public Box_BulletBoolDelete()
{
	level.MF.Boxes.BulletBoolsList = IARRAY::Remove(level.MF.Boxes.BulletBoolsList, self);
}
*/
 BG_AddCuboid(vOrigin, vSize, vAngles, vPivot)
{
	cuboid = core\include\_shape::Cuboid_Create(vOrigin, vSize, vAngles, vPivot);
	cuboid.BG = self;
	
	if (core\include\_game::IsDev())
		cuboid.sClassName = "SHAPE_Cuboid";
	
	self.Cuboids[self.Cuboids.size] = cuboid;
}

 BG_RemoveCuboid(cuboid)
{
	self.Cuboids = core\include\array\_array::Remove(self.Cuboids, cuboid);
}

 BG_GetShapes()
{
	return self.Cuboids;
}

 BG_GetOutputShapes(ls, shapes)
{
	for (foreachg45e74f_4 = 0; foreachg45e74f_4 < shapes.size; foreachg45e74f_4++)
	{ shape = shapes[foreachg45e74f_4];
		switch (shape.sClassName)
		{
			case "SHAPE_Cuboid":
				ls core\include\array\_list::Add("    " + "bg core\\include\\_mapfixer::BG_AddCuboid(" + shape.vOrigin + ", " + shape.vSize + ", " + shape.vAngles + ", " + shape.vPivot + ");");
				break;
			default:
				core\include\_exception::InvalidOperationMsg();
				break;
		}
	}
	
	return ls;
}

 BG_GetOutputForSave()
{
	ls = core\include\array\_list::Create();
	ls core\include\array\_list::Add("    " + "// BoxGroups");
	
	for (foreachg45e74f_5 = 0; foreachg45e74f_5 < level.MF.Boxes.Hurts.size; foreachg45e74f_5++)
	{ bg = level.MF.Boxes.Hurts[foreachg45e74f_5];
		shapes = bg BG_GetShapes();
		if (shapes.size == 0)
			continue;
		
		iDmg = bg.iDmg;
		sTeam = bg.sTeam;
		if (!IsDefined(sTeam))	sTeam = "undefined";
		else					sTeam = "\"" + sTeam + "\"";
		
		ls core\include\array\_list::Add("    " + "bg = core\\include\\_mapfixer::BG_CreateHurt(" + iDmg + ", " + sTeam + ");");
		ls = BG_GetOutputShapes(ls, shapes);
		ls core\include\array\_list::Add("");
	}
	
	for (foreachg45e74f_6 = 0; foreachg45e74f_6 < level.MF.Boxes.Collides.size; foreachg45e74f_6++)
	{ bg = level.MF.Boxes.Collides[foreachg45e74f_6];
		shapes = bg BG_GetShapes();
		if (shapes.size == 0)
			continue;
		
		sTeam = bg.sTeam;
		if (!IsDefined(sTeam))	sTeam = "undefined";
		else					sTeam = "\"" + sTeam + "\"";
		
		ls core\include\array\_list::Add("    " + "bg = core\\include\\_mapfixer::BG_CreateCollide(" + sTeam + ");");
		ls = BG_GetOutputShapes(ls, shapes);
		ls core\include\array\_list::Add("");
	}
	
	for (foreachg45e74f_7 = 0; foreachg45e74f_7 < level.MF.Boxes.BulletWalls.size; foreachg45e74f_7++)
	{ bg = level.MF.Boxes.BulletWalls[foreachg45e74f_7];
		shapes = bg BG_GetShapes();
		if (shapes.size == 0)
			continue;
		
		sTeam = bg.sTeam;
		if (!IsDefined(sTeam))	sTeam = "undefined";
		else					sTeam = "\"" + sTeam + "\"";
		
		ls core\include\array\_list::Add("    " + "bg = core\\include\\_mapfixer::BG_CreateBulletWall(" + sTeam + ");");
		ls = BG_GetOutputShapes(ls, shapes);
		ls core\include\array\_list::Add("");
	}

	ls core\include\array\_list::Add("");
	return ls;
}


// ======================================================================================= //