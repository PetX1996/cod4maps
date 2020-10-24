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



 Create()
{
	self.BG = SpawnStruct();
	
	// public
	self.BG.dBeginMoving = undefined;
	self.BG.dMoving = undefined;
	self.BG.dFinishMoving = undefined;
		self.BG.vMovingStartOrigin = undefined;
	
	self.BG.dBeginRotating = undefined;
	self.BG.dRotating = undefined;
	self.BG.dFinishRotating = undefined;
		self.BG.vRotatingStartAngles = undefined;
	
	self.BG.dChooseBegin = undefined;
		self.BG.Sources = undefined;
		
	self.BG.dChooseSwitch = undefined; // bool VG func(eEnt)
	self.BG.dChooseFinish = undefined;
	
	self.BG.dShowing = undefined;
		self.BG.eShowingShape = undefined;
		self.BG.vShowingColor = undefined;
		self.BG.sShowingTextA = undefined;
		self.BG.sShowingTextB = undefined;

	// private
	self.BG.vLastSourcesPos = undefined;
	self.BG.iLastSourcesCount = undefined;
	self.BG.Shapes = undefined;
	
	self.BG.eLastSelected = undefined;
	self.BG.eSelected = undefined;
	self.BG.eHolding = undefined;
	
	self.BG.PropsDic = undefined;
	self.BG.BGPropsDic = undefined;
	self.BG.iPropSelected = undefined;
	self.BG.iBGPropSelected = undefined;
	self.BG.Prop_SelectedBG = undefined;
	self.BG.Prop_SelectedShape = undefined;
	self.BG.Prop_sSelectedKey = undefined;
	
	self.BG.fMovingDist = undefined;
	self.BG.vMovingDiff = undefined;
	
	self.BG.fPivotMovingDist = undefined;
	self.BG.vPivotMovingDiff = undefined;
	self.BG.vPivotMovingStartOrigin = undefined;
	
	self.BG.fRotatingDist = undefined;
	
	self.BG.AddShape_bValidClose = undefined;
	self.BG.AddShape_bWasCreatedBG = undefined;
	self.BG.SelectedBG = undefined;
	
	self thread BGThread();
}

 Close()
{
	self notify("bgClose");
	
	self.BG = undefined;
}

 BGThread()
{
	self.pOwner endon("disconnect");
	self endon("close");
	self endon("bgClose");

	while (true)
	{
		self ChooseForShow();
		
		if (!IsDefined(self.BG.eHolding))
		{
			self.BG.eLastSelected = self.BG.eSelected;
			self.BG.eSelected = self FindSelected();
		}
		else if (IsDefined(self.BG.fMovingDist))
			self MovingUpdate();
		else if (IsDefined(self.BG.fPivotMovingDist))
			self PivotMovingUpdate();
		else if (IsDefined(self.BG.fRotatingDist))
			self RotatingUpdate();
		
		self PropsUpdate();
		
		self ShowOnMap();
		
		wait 0.05;
	}
}



 // 256 ^ 2

 ChooseForShow()
{
	if (IsDefined(self.BG.dChooseBegin))
		self [[self.BG.dChooseBegin]]();
	
	if (!IsDefined(self.BG.Sources))
		self.BG.Sources = self GetSources();

	if (IsDefined(self.BG.iLastSourcesCount) 
		&& IsDefined(self.BG.iLastSourcesCount)
		&& self.BG.Sources.size == self.BG.iListSourceCount
		&& DistanceSquared(self.BG.iLastSourcesCount, self.pOwner.origin) < 65536)
	{
		self.BG.Sources = undefined;
		return;
	}
	
	self.BG.iLastSourcesCount = self.pOwner.origin;
	self.BG.iListSourceCount = self.BG.Sources.size;
		
	iRange = 0;
	iRangeSteps = 0;
	if (self.BG.Sources.size >= 128 / 2)
		iRangeSteps = GetAverageBGDist(self.pOwner.origin, self.BG.Sources) / 4;
	else
		iRange = 10000;
		
	leftList = core\include\array\_list::Create();
	leftList core\include\array\_list::AddRange(self.BG.Sources);
	news = [];
	
	while (news.size < 128 / 2)
	{
		iRange += iRangeSteps;
		
		if (leftList.iCount <= 0)
			break;
		
		for (i = 0; i < leftList.iCount; i++)
		{
			shape = leftList core\include\array\_list::Get(i);
			
			if (IsDefined(self.BG.dChooseSwitch) && !self [[self.BG.dChooseSwitch]](shape))
			{
				leftList core\include\array\_list::RemoveAt(i);
				i--;
			}
			else if (iRange >= 10000 || Distance(shape.vOrigin, self.pOwner.origin) < iRange)
			{
				news[news.size] = shape;
				leftList core\include\array\_list::RemoveAt(i);
				i--;
			}	
			
			if (news.size >= 128 / 2)
				break;
		}
	}
	
	self.BG.Shapes = news;
	
	if (IsDefined(self.BG.dChooseFinish))
		self [[self.BG.dChooseFinish]]();
	
	self UpdateShownStats();
	
	self.BG.Sources = undefined;
}

 GetSources()
{
	sourcesList = core\include\array\_list::Create();
	
	hurts = 0;
	collides = 0;
	bulletWallls = 0;
	
	for (foreachg45e74f_0 = 0; foreachg45e74f_0 < level.MF.Boxes.Hurts.size; foreachg45e74f_0++)
	{ bg = level.MF.Boxes.Hurts[foreachg45e74f_0];
		shapes = bg core\include\_mapfixer::BG_GetShapes();
		sourcesList core\include\array\_list::AddRange(shapes);
		
		self DrawShapesConnection(shapes, (0, 1, 0));
		hurts += shapes.size;
	}
	
	for (foreachg45e74f_1 = 0; foreachg45e74f_1 < level.MF.Boxes.Collides.size; foreachg45e74f_1++)
	{ bg = level.MF.Boxes.Collides[foreachg45e74f_1];
		shapes = bg core\include\_mapfixer::BG_GetShapes();
		sourcesList core\include\array\_list::AddRange(shapes);
		
		self DrawShapesConnection(shapes, (0, 1, 1));
		collides += shapes.size;
	}
	
	for (foreachg45e74f_2 = 0; foreachg45e74f_2 < level.MF.Boxes.BulletWalls.size; foreachg45e74f_2++)
	{ bg = level.MF.Boxes.BulletWalls[foreachg45e74f_2];
		shapes = bg core\include\_mapfixer::BG_GetShapes();
		sourcesList core\include\array\_list::AddRange(shapes);
		
		self DrawShapesConnection(shapes, (0, 0, 1));
		bulletWallls += shapes.size;
	}
	
	self core\include\clients\_vg::AddTextSet(2, "^2Hurts: " + level.MF.Boxes.Hurts.size + "(" + hurts + ")");
	self core\include\clients\_vg::AddTextSet(3, "^3Collides: " + level.MF.Boxes.Collides.size + "(" + collides + ")");
	self core\include\clients\_vg::AddTextSet(4, "^4BulletWalls: " + level.MF.Boxes.BulletWalls.size + "(" + bulletWallls + ")");
	
	return sourcesList core\include\array\_list::ToArray();
}

 DrawShapesConnection(shapes, vColor)
{
	for (i = 0; i < shapes.size; i++)
	{
		j = (i + 1) % shapes.size;
		core\include\_shape::DrawLine(shapes[i].vOrigin, shapes[j].vOrigin, vColor);
	}
}

 GetAverageBGDist(vPoint, shapes)
{
	fSum = 0;
	for (foreachg45e74f_3 = 0; foreachg45e74f_3 < shapes.size; foreachg45e74f_3++)
	{ shape = shapes[foreachg45e74f_3]; fSum += Distance(shape.vOrigin, vPoint); }

	return fSum / shapes.size;
}

 UpdateShownStats()
{
	self core\include\clients\_vg::AddTextSet(0, "Shown: " + self.BG.Shapes.size + "/" + self.BG.Sources.size);
}

 FindSelected()
{
	pVec = self.pOwner core\include\_look::GetPlayerLookVector();
	fLastDot = 0.85;
	selectedShape = undefined;
	for (foreachg45e74f_4 = 0; foreachg45e74f_4 < self.BG.Shapes.size; foreachg45e74f_4++)
	{ shape = self.BG.Shapes[foreachg45e74f_4];
		fDot = VectorDot(pVec, VectorNormalize(shape.vOrigin - self.pOwner core\include\_look::GetPlayerViewPos()));
		if (fDot > fLastDot)
		{
			fLastDot = fDot;
			selectedShape = shape;
		}
	}
	return selectedShape;
}

 ShowOnMap()
{
	for (foreachg45e74f_5 = 0; foreachg45e74f_5 < self.BG.Shapes.size; foreachg45e74f_5++)
	{ shape = self.BG.Shapes[foreachg45e74f_5];
		self.BG.eShowingShape = shape;
		self.BG.vShowingColor = (1, 1, 1);
		self.BG.sShowingTextA = shape.BG.sClassName;
		self.BG.sShowingTextB = "";
		
		if (IsDefined(self.BG.eSelected) && shape == self.BG.eSelected)
			self.BG.vShowingColor = (1, 0, 0);
		
		bgColor = (1, 1, 1);
		switch (shape.BG.sClassName)
		{
			case "BG_Hurt":
				bgColor = (0, 1, 0);
				break;
			case "BG_Collide":
				bgColor = (1, 1, 0);
				break;
			case "BG_BulletWall":
				bgColor = (0, 0, 1);
				break;
			default:
				core\include\_exception::InvalidOperationMsg("Unknown bg " + shape.BG.sClassName);
		}
		
		switch (shape.sClassName)
		{
			case "SHAPE_Cuboid":
				shape core\include\_shape::Cuboid_Draw(bgColor, true);
				break;
			default:
				core\include\_exception::InvalidOperationMsg("Unknown shape " + shape.sClassName);
				break;
		}
		
		if (IsDefined(self.BG.sShowingTextB))
			core\include\_shape::DrawText(shape.vOrigin + (0, 0, 15), self.BG.sShowingTextB, self.BG.vShowingColor);
		if (IsDefined(self.BG.sShowingTextA))
			core\include\_shape::DrawText(shape.vOrigin, self.BG.sShowingTextA, self.BG.vShowingColor);
		else
			core\include\_shape::DrawText(shape.vOrigin, "Unknown shape", self.BG.vShowingColor);
	}
}

 PropsUpdate()
{
	if (!IsDefined(self.BG.eSelected))
	{
		self PropsReset();
		self core\include\clients\_vg::TextClear();
	}
	else
	{
		self PropsShow();
	}
}

 PropsReset()
{
	self.BG.PropsDic = undefined;
	self.BG.BGPropsDic = undefined;
}

 PropsShow()
{
	if (!core\include\_type::IsEqual(self.BG.eLastSelected, self.BG.eSelected) 
		|| !IsDefined(self.BG.PropsDic) || !IsDefined(self.BG.BGPropsDic))
	{
		self.BG.PropsDic = [];
		self.BG.BGPropsDic = [];
		shape = self.BG.eSelected;
		bg = shape.BG;
		
		switch (bg.sClassName)
		{
			case "BG_Hurt":
				BGPropRegister("iDmg", bg.iDmg);
				BGPropRegister("sTeam", bg.sTeam);
				break;
			case "BG_Collide":
				BGPropRegister("sTeam", bg.sTeam);
				break;
			case "BG_BulletWall":
				BGPropRegister("sTeam", bg.sTeam);
				break;
			default:
				core\include\_exception::InvalidOperationMsg();
				break;
		}

		switch (shape.sClassName)
		{
			case "SHAPE_Cuboid":
				PropRegister("sClassName", shape.sClassName);
				PropRegister("vOrigin", shape.vOrigin);
				PropRegister("vAngles", shape.vAngles);
				PropRegister("vSize", shape.vSize);
				PropRegister("vPivot", shape.vPivot);
				break;
			default:
				core\include\_exception::InvalidOperationMsg();
				break;
		}
		
		if (IsDefined(self.BG.iPropSelected))
		{
			self.BG.iBGPropSelected = 0;
			self.BG.iPropSelected = -1;
			
			self PropCheckAvailables();
		}
	}

	keys = GetArrayKeys(self.BG.BGPropsDic);
	for (i = 0; i < keys.size; i++)
		self BGPropShow(i, keys[i], self.BG.BGPropsDic[keys[i]]);
	
	self core\include\clients\_vg::TextSet(self.BG.BGPropsDic.size, "");
	
	keys = GetArrayKeys(self.BG.PropsDic);
	for (i = 0; i < keys.size; i++)
		self PropShow(i, keys[i], self.BG.PropsDic[keys[i]]);	
	
	self core\include\clients\_vg::TextClear(self.BG.BGPropsDic.size + 1 + self.BG.PropsDic.size);
}


 BGPropRegister(sName, value)
{
	if (IsDefined(value))
		self.BG.BGPropsDic[sName] = value;
	else
		self.BG.BGPropsDic[sName] = "undefined";
}


 PropRegister(sName, value)
{
	if (IsDefined(value))
		self.BG.PropsDic[sName] = value;
	else
		self.BG.PropsDic[sName] = "undefined";
}


 BGPropShow(iIndex, sName, value)
{
	if (IsDefined(self.BG.iBGPropSelected) && self.BG.iBGPropSelected == iIndex)
		self core\include\clients\_vg::TextSet(iIndex, "^1" + sName + ": " + value);
	else
		self core\include\clients\_vg::TextSet(iIndex, sName + ": " + value);
}

 PropShow(iIndex, sName, value)
{
	if (IsDefined(self.BG.iPropSelected) && self.BG.iPropSelected == iIndex)
		self core\include\clients\_vg::TextSet(self.BG.BGPropsDic.size + 1 + iIndex, "^1" + sName + ": " + value);
	else
		self core\include\clients\_vg::TextSet(self.BG.BGPropsDic.size + 1 + iIndex, sName + ": " + value);
}

// ============================================================================== //


 MenuMove()
{
	if (IsDefined(self.BG.fMovingDist))
	{
		if (IsDefined(self.BG.dFinishMoving))
			self [[self.BG.dFinishMoving]]();
	
		//eEnt = self.BG.eHolding;
		//eEnt IMAPFIXER::Entity_Property("origin", eEnt.origin);
	
		self core\include\clients\_vg::Menu_TurnBtnOff(0);
		self.BG.eHolding = undefined;
		self.BG.fMovingDist = undefined;
		self.BG.vMovingDiff = undefined;
		self.BG.vMovingStartOrigin = undefined;
		return;
	}
	else if (!IsDefined(self.BG.eSelected) 
		|| self.BG.eSelected == self.pOwner
		|| IsDefined(self.BG.eHolding))
	{
		self core\include\clients\_vg::Menu_TurnBtnOff(0);
		return;
	}
	
	if (IsDefined(self.BG.dBeginMoving))
		self [[self.BG.dBeginMoving]]();
	
	self.BG.eHolding = self.BG.eSelected;
	
	shape = self.BG.eHolding;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = Distance(pPos, shape.vOrigin);
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = (shape.vOrigin - pPos) - vLook;
	
	self.BG.fMovingDist = fDist;
	self.BG.vMovingDiff = vDiff;
	
	self.BG.vMovingStartOrigin = shape.vOrigin;
}

 MovingUpdate()
{
	shape = self.BG.eHolding;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = self.BG.fMovingDist;
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = self.BG.vMovingDiff;
	
	shape core\include\_shape::Cuboid_SetOrigin(pPos + vLook + vDiff);
	
	if (IsDefined(self.BG.dMoving))
		self [[self.BG.dMoving]]();
		
	self PropsReset();
}


// ============================================================================== //


 MenuPivotMove()
{
	if (IsDefined(self.BG.fPivotMovingDist))
	{
		if (IsDefined(self.BG.dFinishPivotMoving))
			self [[self.BG.dFinishPivotMoving]]();
	
		//eEnt = self.BG.eHolding;
		//eEnt IMAPFIXER::Entity_Property("origin", eEnt.origin);
		self.BG.eHolding core\include\_shape::Cuboid_UpdateVertices();
	
		self core\include\clients\_vg::Menu_TurnBtnOff(1);
		self.BG.eHolding = undefined;
		self.BG.fPivotMovingDist = undefined;
		self.BG.vPivotMovingDiff = undefined;
		self.BG.vPivotMovingStartOrigin = undefined;
		return;
	}
	else if (!IsDefined(self.BG.eSelected) 
		|| self.BG.eSelected == self.pOwner
		|| IsDefined(self.BG.eHolding))
	{
		self core\include\clients\_vg::Menu_TurnBtnOff(1);
		return;
	}
	
	if (IsDefined(self.BG.dBeginPivotMoving))
		self [[self.BG.dBeginPivotMoving]]();
	
	self.BG.eHolding = self.BG.eSelected;
	
	shape = self.BG.eHolding;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = Distance(pPos, shape.vPivot);
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = (shape.vPivot - pPos) - vLook;
	
	self.BG.fPivotMovingDist = fDist;
	self.BG.vPivotMovingDiff = vDiff;
	
	self.BG.vPivotMovingStartOrigin = shape.vPivot;
}

 PivotMovingUpdate()
{
	shape = self.BG.eHolding;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = self.BG.fPivotMovingDist;
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = self.BG.vPivotMovingDiff;
	
	shape core\include\_shape::Cuboid_SetPivot(pPos + vLook + vDiff);
	
	if (IsDefined(self.BG.dPivotMoving))
		self [[self.BG.dPivotMoving]]();
		
	self PropsReset();
}


// ============================================================================== //


 MenuRotate()
{
	if (IsDefined(self.BG.fRotatingDist))
	{
		if (IsDefined(self.BG.dFinishRotating))
			self [[self.BG.dFinishRotating]]();
	
		//eEnt = self.BG.eHolding;
		//eEnt IMAPFIXER::Entity_Property("angles", eEnt.angles);
	
		self core\include\clients\_vg::Menu_TurnBtnOff(2);
		self.BG.eHolding = undefined;
		self.BG.fRotatingDist = undefined;
		self.BG.vRotatingStartAngles = undefined;
		return;
	}
	else if (!IsDefined(self.BG.eSelected) 
		|| self.BG.eSelected == self.pOwner
		|| IsDefined(self.BG.eHolding))
	{
		self core\include\clients\_vg::Menu_TurnBtnOff(2);
		return;
	}
	
	if (IsDefined(self.BG.dBeginRotating))
		self [[self.BG.dBeginRotating]]();
	
	self.BG.eHolding = self.BG.eSelected;

	shape = self.BG.eHolding;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	
	fDist = Distance(pPos, shape.vPivot);
	
	self.BG.fRotatingDist = fDist;
	
	self.BG.vRotatingStartAngles = shape.vAngles;
}

 RotatingUpdate()
{
	shape = self.BG.eHolding;
	pPos = self.pOwner core\include\_look::GetPlayerViewPos();
	fDist = self.BG.fRotatingDist;
	
	vLook = self.pOwner core\include\_look::GetPlayerLookVector() * fDist;
	vDiff = vLook - (shape.vPivot - pPos);
	
	shape core\include\_shape::Cuboid_SetAngles(VectorToAngles(vDiff));

	if (IsDefined(self.BG.dRotating))
		self [[self.BG.dRotating]]();
		
	self PropsReset();
}


// ============================================================================== //


 MenuProps()
{
	if (!IsDefined(self.BG.eSelected) 
		|| self.BG.eSelected == self.pOwner
		|| IsDefined(self.BG.eHolding))
	{
		return;
	}

	self core\include\clients\_vg::Menu_Clear(true, ::MenuProp_OnClose);
	self core\include\clients\_vg::Menu_RegisterBtn(0, "Prev", ::MenuProp_OnPrev);
	self core\include\clients\_vg::Menu_RegisterBtn(1, "Next", ::MenuProp_OnNext);
	self core\include\clients\_vg::Menu_RegisterBtn(2, "Select", ::MenuProp_OnSel);
	self core\include\clients\_vg::Menu_RegisterBtn(3, "Delete", ::MenuProp_OnDel);
	self core\include\clients\_vg::Menu_Show();

	self.BG.iBGPropSelected = 0;
	self.BG.iPropSelected = -1;
	self PropCheckAvailables();
	
	self.BG.eHolding = self.BG.eSelected;
	
}

 MenuProp_OnClose()
{
	self.BG.iPropSelected = undefined;
	self.BG.iBGPropSelected = undefined;
	self.BG.eHolding = undefined;
}

 PropCheckAvailables()
{
	if (self.BG.iBGPropSelected >= 0 && self.BG.BGPropsDic.size == 0)
	{
		self.BG.iBGPropSelected = -1;
		self.BG.iPropSelected = 0;
	}

	if (self.BG.iPropSelected >= 0 && self.BG.PropsDic.size == 0)
	{
		self.BG.iPropSelected = -1;
	}
}

 MenuProp_OnPrev()
{
	if (self.BG.iBGPropSelected == 0 && self.BG.iPropSelected < 0)
	{
		if (self.BG.PropsDic.size > 0)
		{
			self.BG.iPropSelected = self.BG.PropsDic.size - 1;
			self.BG.iBGPropSelected = -1;
		}
		else
		{
			self.BG.iPropSelected = -1;
			self.BG.iBGPropSelected = self.BG.BGPropsDic.size - 1;			
		}
	}
	else if (self.BG.iPropSelected == 0 && self.BG.iBGPropSelected < 0)
	{
		if (self.BG.BGPropsDic.size > 0)
		{
			self.BG.iPropSelected = -1;
			self.BG.iBGPropSelected = self.BG.BGPropsDic.size - 1;
		}
		else
		{
			self.BG.iPropSelected = self.BG.PropsDic.size - 1;
			self.BG.iBGPropSelected = -1;			
		}
	}
	else if (self.BG.iBGPropSelected > 0)
		self.BG.iBGPropSelected--;
	else if (self.BG.iPropSelected > 0)
		self.BG.iPropSelected--;
	
	self PropCheckAvailables();
}

 MenuProp_OnNext()
{
	if (self.BG.iPropSelected >= 0)
		self.BG.iPropSelected++;
	else
		self.BG.iBGPropSelected++;
		
	if (self.BG.iPropSelected >= self.BG.PropsDic.size)
	{
		self.BG.iPropSelected = -1;
		self.BG.iBGPropSelected = 0;
	}
	else if (self.BG.iBGPropSelected >= self.BG.BGPropsDic.size)
	{
		self.BG.iPropSelected = 0;
		self.BG.iBGPropSelected = -1;
	}
	
	self PropCheckAvailables();
}

 MenuProp_OnSel()
{
	self.BG.Prop_SelectedBG = undefined;
	self.BG.Prop_SelectedShape = undefined;
	self.BG.Prop_sSelectedKey = undefined;

	sKey = undefined;
	value = undefined;
	if (self.BG.iBGPropSelected >= 0)
	{
		self.BG.Prop_SelectedBG = self.BG.eHolding.BG;
		keys = GetArrayKeys(self.BG.BGPropsDic);
		sKey = keys[self.BG.iBGPropSelected];
		value = self.BG.BGPropsDic[sKey];	
	}
	else if (self.BG.iPropSelected >= 0)
	{
		self.BG.Prop_SelectedShape = self.BG.eHolding;
		keys = GetArrayKeys(self.BG.PropsDic);
		sKey = keys[self.BG.iPropSelected];
		value = self.BG.PropsDic[sKey];	
	}
	else
		return;
	
	self.BG.Prop_sSelectedKey = sKey;
	self core\include\clients\_vg::TextBox_Show(sKey, ::MenuProp_OnSel_OnTextBoxOK, undefined, value);
}

 MenuProp_OnSel_OnTextBoxOK(sA, sB, sC)
{
	if (IsDefined(self.BG.Prop_SelectedBG))
		self.BG.Prop_SelectedBG SetBGKey(self.BG.Prop_sSelectedKey, sA);
	else if (IsDefined(self.BG.Prop_SelectedShape))
		self.BG.Prop_SelectedShape SetShapeKey(self.BG.Prop_sSelectedKey, sA);
	
	self core\include\clients\_vg::TextBox_Close();
	self PropsReset();
}

 SetBGKey(sKey, sValue)
{
	switch (sKey)
	{
		case "sTeam":
			self.sTeam = sValue;
			break;
		case "iDmg":
			if (IsDefined(sValue))
				self.iDmg = core\include\_type::IntToStr(sValue);
			break;
		default:
			core\include\_exception::InvalidOperationMsg();
	}
}

 SetShapeKey(sKey, sValue)
{
	switch (sKey)
	{
		case "vOrigin":
			if (IsDefined(sValue))
				self core\include\_shape::Cuboid_SetOrigin(core\include\_type::StrToVec(sValue));
			break;
		case "vSize":
			if (IsDefined(sValue))
				self core\include\_shape::Cuboid_SetSize(core\include\_type::StrToVec(sValue));
			break;
		case "vAngles":
			if (IsDefined(sValue))
				self core\include\_shape::Cuboid_SetAngles(core\include\_type::StrToVec(sValue));
			break;
		case "vPivot":
			if (IsDefined(sValue))
				self core\include\_shape::Cuboid_SetPivot(core\include\_type::StrToVec(sValue));
			break;
		default:
			core\include\_exception::InvalidOperationMsg();
	}
}

 MenuProp_OnDel()
{
	if (self.BG.iBGPropSelected >= 0)
	{
		keys = GetArrayKeys(self.BG.BGPropsDic);
		sKey = keys[self.BG.iBGPropSelected];	
		self.BG.eHolding.BG SetBGKey(sKey, undefined);
	}
	else if (self.BG.iPropSelected >= 0)
	{
		keys = GetArrayKeys(self.BG.PropsDic);
		sKey = keys[self.BG.iPropSelected];
		self.BG.eHolding SetShapeKey(sKey, undefined);
	}
	else
		return;
	
	self PropsReset();
}


// ============================================================================== //

 MenuDelete()
{
	shape = self.BG.eSelected;
	if (IsDefined(shape))
	{
		bg = shape.BG;
		bg core\include\_mapfixer::BG_RemoveShape(shape);
		
		if (bg core\include\_mapfixer::BG_GetShapes().size == 0)
			bg core\include\_mapfixer::BG_UnReg();
			
		self.BG.eSelected = undefined;
	}
}

// ============================================================================== //


 CreateBG_MenuOpen()
{
	self core\include\clients\_vg::Menu_Clear(true, ::CreateBG_MenuOnClose);
	self core\include\clients\_vg::Menu_RegisterBtn(0, "Hurt", ::CreateBG_MenuOnHurt);
	self core\include\clients\_vg::Menu_RegisterBtn(1, "Collide", ::CreateBG_MenuOnCollide);
	self core\include\clients\_vg::Menu_RegisterBtn(2, "BulletWall", ::CreateBG_MenuOnBulletWall);
	self core\include\clients\_vg::Menu_Show();
}

 CreateBG_MenuOnClose()
{}

 CreateBG_MenuOnHurt()
{
	self core\include\clients\_vg::Menu_OnBackBtn();
	
	self core\include\clients\_vg::TextBox_Show("BG_Hurt", ::CreateBG_Hurt_OnTextBoxOK, undefined, "iDmg", "sTeam");
}

 CreateBG_Hurt_OnTextBoxOK(sA, sB, sC)
{
	iDmg = sA;
	sTeam = sB;
	
	if (sA == "iDmg" || sA == "")
		iDmg = 1000;
		
	if (sB == "sTeam" || sB == "")
		sTeam = undefined;
		
	iDmg = core\include\_type::StrToInt(iDmg);
	
	hurtBG = core\include\_mapfixer::BG_CreateHurt(iDmg, sTeam);
	
	self core\include\clients\_vg::TextBox_Close();
	
	self.BG.SelectedBG = hurtBG;
	self.BG.AddShape_bWasCreatedBG = true;
	self AddShape_MenuOpen();
}


 CreateBG_MenuOnCollide()
{
	self core\include\clients\_vg::Menu_OnBackBtn();
	
	self core\include\clients\_vg::TextBox_Show("BG_Collide", ::CreateBG_Collide_OnTextBoxOK, undefined, "sTeam");
}

 CreateBG_Collide_OnTextBoxOK(sA, sB, sC)
{
	sTeam = sA;

	if (sA == "sTeam" || sA == "")
		sTeam = undefined;
	
	collideBG = core\include\_mapfixer::BG_CreateCollide(sTeam);
	
	self core\include\clients\_vg::TextBox_Close();
	
	self.BG.SelectedBG = collideBG;
	self.BG.AddShape_bWasCreatedBG = true;
	self AddShape_MenuOpen();
}


 CreateBG_MenuOnBulletWall()
{
	self core\include\clients\_vg::Menu_OnBackBtn();
	
	self core\include\clients\_vg::TextBox_Show("BG_BulletWall", ::CreateBG_BulletWall_OnTextBoxOK, undefined, "sTeam");
}

 CreateBG_BulletWall_OnTextBoxOK(sA, sB, sC)
{
	sTeam = sA;

	if (sA == "sTeam" || sA == "")
		sTeam = undefined;
	
	bulletWallBG = core\include\_mapfixer::BG_CreateBulletWall(sTeam);
	
	self core\include\clients\_vg::TextBox_Close();
	
	self.BG.SelectedBG = bulletWallBG;
	self.BG.AddShape_bWasCreatedBG = true;
	self AddShape_MenuOpen();
}


// ============================================================================== //


 AddShape_MenuOpen()
{
	if (!IsDefined(self.BG.SelectedBG) && IsDefined(self.BG.eSelected))
		self.BG.SelectedBG = self.BG.eSelected.BG;
		
	if (!IsDefined(self.BG.SelectedBG))
		return;

	self core\include\clients\_vg::Menu_Clear(true, ::AddShape_MenuOnClose);
	self core\include\clients\_vg::Menu_RegisterBtn(0, "Cuboid", ::AddShape_MenuOnCuboid);
	self core\include\clients\_vg::Menu_Show();
}

 AddShape_MenuOnClose()
{
	if (IsDefined(self.BG.AddShape_bValidClose))
	{
		self.BG.AddShape_bValidClose = undefined;
		return;
	}
	
	// AddShape menu has been closed -> delete created BG
	if (IsDefined(self.BG.AddShape_bWasCreatedBG) && IsDefined(self.BG.SelectedBG))
	{
		self.BG.AddShape_bWasCreatedBG = undefined;
		self.BG.SelectedBG core\include\_mapfixer::BG_UnReg();
	}
	
	self.BG.SelectedBG = undefined;
}

 AddShape_MenuOnCuboid()
{
	self.BG.AddShape_bValidClose = true;
	self core\include\clients\_vg::Menu_OnBackBtn(); // closes AddShape choices -> lost BG
	
	self core\include\clients\_vg::TextBox_Show(self.BG.SelectedBG.sClassName + " - " + "SHAPE_Cuboid", ::AddShape_Cuboid_OnTextBoxOK, ::AddShape_Cuboid_OnTextBoxCancel, self.pOwner.origin, (10, 10, 10), (0, 0, 0));
}

 AddShape_Cuboid_OnTextBoxOK(sA, sB, sC)
{
	vOrigin = core\include\_type::StrToVec(sA);
	vSize = core\include\_type::StrToVec(sB);
	vAngles = core\include\_type::StrToVec(sC);

	self.BG.SelectedBG core\include\_mapfixer::BG_AddCuboid(vOrigin, vSize, vAngles);
	self.BG.SelectedBG = undefined;
	
	self core\include\clients\_vg::TextBox_Close();
}

 AddShape_Cuboid_OnTextBoxCancel()
{
	self.BG.SelectedBG = undefined;
}


// ============================================================================== //