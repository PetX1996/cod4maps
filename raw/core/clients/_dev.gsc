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

InSVStartGameType()
{
	thread ClientCvar();
}

InSVPreCache()
{
	if (1 != 1)
		return;
		
	PreCacheResourcesForModify();
}

 PreCacheResourcesForModify()
{
	dValue = GetDvar("dev_sBodyModel");
	if (dValue != "") PreCacheModel(dValue);
	
	dValue = GetDvar("dev_sHeadModel");
	if (dValue != "") PreCacheModel(dValue);
	
	dValue = GetDvar("dev_sViewModel");
	if (dValue != "") PreCacheModel(dValue);
	
	for (i = 0; ; i++)
	{
		dValue = GetDvar("dev_sWeapons_" + i);
		if (dValue == "")
			break;
		else
			PreCacheItem(dValue);
	}
	
	dValue = GetDvar("dev_sSpawnWeapon");
	if (dValue != "") PreCacheItem(dValue);
	
	dValue = GetDvar("dev_sOffHand");
	if (dValue != "") PreCacheItem(dValue);
	
	dValue = GetDvar("dev_sSecondaryOffHand" );
	if (dValue != "") PreCacheItem(dValue);
	
	dValue = GetDvar("dev_sActionSlot1");
	if (dValue != "") core\include\clients\_weapon::PreCacheActionSlotWeapon(dValue);
	
	dValue = GetDvar("dev_sActionSlot2");
	if (dValue != "") core\include\clients\_weapon::PreCacheActionSlotWeapon(dValue);
	
	dValue = GetDvar("dev_sActionSlot3");
	if (dValue != "") core\include\clients\_weapon::PreCacheActionSlotWeapon(dValue);
	
	dValue = GetDvar("dev_sActionSlot4");
	if (dValue != "") core\include\clients\_weapon::PreCacheActionSlotWeapon(dValue);
}

 ModifyPlayerSpawning(args)
{
	if (1 != 1)
		return;

	dValue = GetDvar("dev_vOrigin");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced SpawnPoint.Origin:^1" + dValue + "^7", 2);
		args.SpawnPoint.Origin = core\include\_type::StrToVec(dValue);
	}

	dValue = GetDvar("dev_vAngles");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced SpawnPoint.Angles:^1" + dValue + "^7", 2);
		args.SpawnPoint.Angles = core\include\_type::StrToVec(dValue);
	}

	dValue = GetDvar("dev_sBodyModel");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sBodyModel:^1" + dValue + "^7", 2);
		args.sBodyModel = dValue;
	}
	
	dValue = GetDvar("dev_sHeadModel");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sHeadModel:^1" + dValue + "^7", 2);
		args.sHeadModel = dValue;
	}
	
	dValue = GetDvar("dev_sViewModel");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sViewModel:^1" + dValue + "^7", 2);
		args.sViewModel = dValue;
	}
	
	dValue = GetDvar("dev_iHealth");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced iHealth:^1" + dValue + "^7", 2);
		args.iHealth = Int(dValue);
	}
	
	dValue = GetDvar("dev_fSpeed");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced fSpeed:^1" + dValue + "^7", 2);
		args.fSpeed = GetDvarFloat("dev_fSpeed");
	}

	for (i = 0; ; i++)
	{
		dValue = GetDvar("dev_sWeapons_" + i);
		if (dValue == "")
			break;
			
		core\include\_debug::Debug("SI forced Weapons:^1" + dValue + "^7", 2);
		args.Weapons[args.Weapons.size] = dValue;
	}
	
	dValue = GetDvar("dev_sSpawnWeapon");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sSpawnWeapon:^1" + dValue + "^7", 2);
		args.sSpawnWeapon = dValue;
	}
	
	dValue = GetDvar("dev_sOffHand");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sOffHand:^1" + dValue + "^7", 2);
		args.sOffHand = dValue;
	}
	
	dValue = GetDvar( "dev_sSecondaryOffHand" );
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sSecondaryOffHand:^1" + dValue + "^7", 2);
		args.sSecondaryOffHand = dValue;
	}
	
	dValue = GetDvar("dev_sActionSlot1");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sActionSlot1:^1" + dValue + "^7", 2);
		args.sActionSlot1 = dValue;
	}
	
	dValue = GetDvar("dev_sActionSlot2");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sActionSlot2:^1" + dValue + "^7", 2);
		args.sActionSlot2 = dValue;
	}
	
	dValue = GetDvar("dev_sActionSlot3");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sActionSlot3:^1" + dValue + "^7", 2);
		args.sActionSlot3 = dValue;
	}
	
	dValue = GetDvar("dev_sActionSlot4");
	if (dValue != "") 
	{
		core\include\_debug::Debug("SI forced sActionSlot4:^1" + dValue + "^7", 2);
		args.sActionSlot4 = dValue;
	}
	
	for (i = 0; ; i++)
	{
		dValue = GetDvar("dev_sPerks_" + i);
		if (dValue == "")
			break;
			
		core\include\_debug::Debug("SI forced Perks:^1" + dValue + "^7", 2);
		args.Perks[args.Perks.size] = dValue;
	}
}

OnCSpawned(args)
{
	if (1 != 1)
		return;
		
	self thread StartFlying();
	self thread GetFireVector();
}

 ClientCvar()
{
	while( true )
	{
		wait 0.5;
	
		dvar = GetDvar( "scr_cvar" );
		if( dvar == "" )
			continue;

		SetDvar( "scr_cvar", "" );
		data = StrTok( dvar, ":" );
		for( i = 0; i < level.players.size; i++ )
			level.players[i] SetClientDvar( data[0], data[1] );
	}
}

 StartFlying()
{
	self endon( "disconnect" );
	self endon( "death" );

	ent = spawn( "script_origin", self.origin );
	status = "idle";
	track = 800;
	
	while( true )
	{
		wait 0.1;
	
		if( self FragButtonPressed() )
		{
			if( status == "idle" )
			{
				ent.origin = self.origin;
				self linkto( ent );
				self DisableWeapons();
				status = "fly";
				self.flying = true;
				track = 800;
			}
		}	
		else if( status == "fly" )
		{
			status = "idle";
			self unlink();
			self EnableWeapons();
			self.flying = undefined;
		}
		
		if( self AttackButtonPressed() && status == "fly" )
		{
			if( track < 3000 )
				track += 150;
		}
		else if( track >= 1100 )
			track -= 300;
	
		if( status == "fly" )
		{
			ent.origin = self.origin;
		
			angles = self getPlayerAngles();
			origin = self.origin;
			
			vec = AnglesToForward( angles );
			new = (vec*track) + origin;
			
			ent moveto( new, 1 );
		}
	}
}

 GetFireVector()
{
	self endon( "death" );
	self endon( "disconnect" );
	
	vCOrigin = self.origin + (-200, 200, 200);
	vCSize = (10, 100, 500);
	vCAngles = (50, 50, 50);
	vCPivot = vCOrigin + (0, 0, 0);
	vCColor = (1, 1, 1);
	
	vOrigin = self.origin + (0,0,50);
	//vSize = (100, 100, 100);
	//vCenterPos = vPos + (vSize * 0.5);
	
	i = 0;
	
	a = 0;
	b = 0;
	c = 0;
	
	
	wait 1;

	//self deathrun\clients\_vg::Open();
	
	while (true)
	{
	
		/*vertices = GetCuboidVertices(vCOrigin, vCSize, vCAngles, vCPivot);
		PrintCuboid(vCAngles, vCPivot, vertices, vCColor);
	
		vLineB = ILOOK::GetPlayerCenterPos() + ILOOK::GetPlayerLookVector() * 300;
		vLineA = ILOOK::GetPlayerCenterPos();
		ISHAPE::DrawLine(vLineB + (10,0,0), vLineB, (1,0,0));
		ISHAPE::DrawLine(vLineB + (0,10,0), vLineB, (1,0,0));
		ISHAPE::DrawLine(vLineB + (0,0,10), vLineB, (1,0,0));
		
		//if (IsPointInCuboid(vLineB, vertices))
		//{
		//	ISHAPE::DrawLine(vLineB, vLineB + (1,1,1), (1,0,0), true, 50000);
		//	iprintln("intersecting");
		//}
		
		//vRnd = GetCuboidRandomPoint(vCSize, vertices);
		//ISHAPE::DrawLine(vRnd, vRnd + (1,1,1), (1,0,0), true, 30);
		
		IsCuboidWordColliding(vCSize, vertices);
		
		vCSize = (50 + a,50 + b,50 + c);
		*/
		/*for (a = 0; i < 360; a += 45)
		{
			for (b = 0; b < 360; b += 45)
			{
				for (c = 0; c < 360; c += 45)
				{
					vAngles = (a, b, c);
					vForward = AnglesToForward(vAngles);
					vRight = AnglesToRight(vAngles);
					vUp = AnglesToUp(vAngles);
					
					iprintln("vAngles : " + vAngles);
					iprintln("vForward: " + vForward + " ; " + VectorToAngles(vForward));
					iprintln("vRight  : " + vRight + " ; " + VectorToAngles(vRight));
					iprintln("vUp     : " + vUp + " ; " + VectorToAngles(vUp));
					
					wait 5;
				}
			}
		}*/
		/*
		vForward = (1, 0, 0);
		vRight = (0, 1, 0);
		vUp = (0, 0, 1);
		
		ISHAPE::DrawLine(vOrigin, vOrigin + vForward * 50, (1, 0, 0));
		ISHAPE::DrawLine(vOrigin, vOrigin + vRight * 50, (0, 1, 0));
		ISHAPE::DrawLine(vOrigin, vOrigin + vUp * 50, (0, 0, 1));
		
		if (self UseButtonPressed()) 		a++;
		else if (self FragButtonPressed()) 	b++;
		else if (self MeleeButtonPressed()) c++;
		else if (self AttackButtonPressed()) { a = 0; b = 0; c = 0; }
		
		if (a > 360) a = 0;
		if (b > 360) b = 0;
		if (c > 360) c = 0;
		
		vAngles = (a, b, c);
		self ICDEV::SetInfo(15, vAngles);
		
		vNewPos = RotatePoint(vOrigin + vUp * 100, vAngles, vOrigin);
		
		ISHAPE::DrawLine(vOrigin, vNewPos, (1, 1, 1));	
		self ICDEV::SetInfo(17, VectorToAngles(vNewPos - vOrigin));
		
		vForward = AnglesToForward(vAngles);
		vRight = AnglesToRight(vAngles);
		vUp = AnglesToUp(vAngles);
		
		ISHAPE::DrawLine(vOrigin, vOrigin + vForward * 100, (1, 0.5, 0.5));
		self ICDEV::SetInfo(19, "vNewPos " + VectorNormalize(vNewPos - vOrigin) + " . vForward " + vForward + " = " + VectorDot(VectorNormalize(vNewPos - vOrigin), vForward));
		ISHAPE::DrawLine(vOrigin, vOrigin + vRight * 100, (0.5, 1, 0.5));
		self ICDEV::SetInfo(20, "vNewPos " + VectorNormalize(vNewPos - vOrigin) + " . vRight " + vRight + " = " + VectorDot(VectorNormalize(vNewPos - vOrigin), vRight));
		ISHAPE::DrawLine(vOrigin, vOrigin + vUp * 100, (0.5, 0.5, 1));		
		self ICDEV::SetInfo(21, "vNewPos " + VectorNormalize(vNewPos - vOrigin) + " . vUp " + vUp + " = " + VectorDot(VectorNormalize(vNewPos - vOrigin), vUp));
		*/
		//ISHAPE::CuboidDraw(vPos, vSize);
	/*
		vMyPos = ILOOK::GetPlayerViewPos();
	
		iMyDist = 200;
		vMyVec = ILOOK::GetPlayerLookVector();
		vMyMayPos = vMyPos + (vMyVec * iMyDist);
		
		//ISHAPE::DrawLine(vCenterPos, vMyPos + (0,0,-30));
		ISHAPE::DrawLine(vMyMayPos, vMyPos + (0,0,-30));
		
		if (i % 100 == 0)
		{
			vMyToPosVec = VectorNormalize(vCenterPos - vMyPos);
			vMyToCornerPosVecA = VectorNormalize((vCenterPos + (vSize * 0.5)) - vMyPos);
			vMyToCornerPosVecB = VectorNormalize((vCenterPos - (vSize * 0.5)) - vMyPos);
			
			//vV = VectorDot(VectorNormalize(vCenterPos - vMyPos), VectorNormalize((vCenterPos + vSize) - vMyPos));
			vV0A = VectorDot((vMyToPosVec[0], vMyToPosVec[1], 0), (vMyToCornerPosVecA[0], vMyToCornerPosVecA[1], 0));
			vV1A = VectorDot((0, vMyToPosVec[1], vMyToPosVec[2]), (0, vMyToCornerPosVecA[1], vMyToCornerPosVecA[2]));
			vV2A = VectorDot((vMyToPosVec[0], 0, vMyToPosVec[2]), (vMyToCornerPosVecA[0], 0, vMyToCornerPosVecA[2]));
			
			vV0B = VectorDot((vMyToPosVec[0], vMyToPosVec[1], 0), (vMyToCornerPosVecB[0], vMyToCornerPosVecB[1], 0));
			vV1B = VectorDot((0, vMyToPosVec[1], vMyToPosVec[2]), (0, vMyToCornerPosVecB[1], vMyToCornerPosVecB[2]));
			vV2B = VectorDot((vMyToPosVec[0], 0, vMyToPosVec[2]), (vMyToCornerPosVecB[0], 0, vMyToCornerPosVecB[2]));		
			//iprintlnbold("dot: " + VectorDot(vMyVec, VectorNormalize(vCenterPos - vMyPos)) + "/" + vV);
			
			iprintlnbold("dot0: " + vV0A + "/" + VectorDot((vMyVec[0], vMyVec[1], 0), (vMyToPosVec[0], vMyToPosVec[1], 0)) + "/" + vV0B);
			iprintlnbold("dot1: " + vV1A + "/" + VectorDot((0, vMyVec[1], vMyVec[2]), (0, vMyToPosVec[1], vMyToPosVec[2])) + "/" + vV1B);
			iprintlnbold("dot2: " + vV2A + "/" + VectorDot((vMyVec[0], 0, vMyVec[2]), (vMyToPosVec[0], 0, vMyToPosVec[2])) + "/" + vV2B);
		}*/
		
		i++;
		wait 0.05;
	}
	
	/*vPos = self.origin + (0,0,50);
	vSize = (100, 100, 100);
	vCenterPos = vPos + (vSize * 0.5);
	
	i = 0;
	
	while (true)
	{
		ISHAPE::CuboidDraw(vPos, vSize);
	
		vMyPos = ILOOK::GetPlayerViewPos();
	
		iMyDist = Distance(vCenterPos, vMyPos);
		vMyVec = ILOOK::GetPlayerLookVector();
		vMyMayPos = vMyPos + (vMyVec * iMyDist);
		
		ISHAPE::DrawLine(vCenterPos, vMyPos + (0,0,-30));
		ISHAPE::DrawLine(vMyMayPos, vMyPos + (0,0,-30));
		
		if (i % 100 == 0)
		{
			vMyToPosVec = VectorNormalize(vCenterPos - vMyPos);
			vMyToCornerPosVecA = VectorNormalize((vCenterPos + (vSize * 0.5)) - vMyPos);
			vMyToCornerPosVecB = VectorNormalize((vCenterPos - (vSize * 0.5)) - vMyPos);
			
			//vV = VectorDot(VectorNormalize(vCenterPos - vMyPos), VectorNormalize((vCenterPos + vSize) - vMyPos));
			vV0A = VectorDot((vMyToPosVec[0], vMyToPosVec[1], 0), (vMyToCornerPosVecA[0], vMyToCornerPosVecA[1], 0));
			vV1A = VectorDot((0, vMyToPosVec[1], vMyToPosVec[2]), (0, vMyToCornerPosVecA[1], vMyToCornerPosVecA[2]));
			vV2A = VectorDot((vMyToPosVec[0], 0, vMyToPosVec[2]), (vMyToCornerPosVecA[0], 0, vMyToCornerPosVecA[2]));
			
			vV0B = VectorDot((vMyToPosVec[0], vMyToPosVec[1], 0), (vMyToCornerPosVecB[0], vMyToCornerPosVecB[1], 0));
			vV1B = VectorDot((0, vMyToPosVec[1], vMyToPosVec[2]), (0, vMyToCornerPosVecB[1], vMyToCornerPosVecB[2]));
			vV2B = VectorDot((vMyToPosVec[0], 0, vMyToPosVec[2]), (vMyToCornerPosVecB[0], 0, vMyToCornerPosVecB[2]));		
			//iprintlnbold("dot: " + VectorDot(vMyVec, VectorNormalize(vCenterPos - vMyPos)) + "/" + vV);
			
			iprintlnbold("dot0: " + vV0A + "/" + VectorDot((vMyVec[0], vMyVec[1], 0), (vMyToPosVec[0], vMyToPosVec[1], 0)) + "/" + vV0B);
			iprintlnbold("dot1: " + vV1A + "/" + VectorDot((0, vMyVec[1], vMyVec[2]), (0, vMyToPosVec[1], vMyToPosVec[2])) + "/" + vV1B);
			iprintlnbold("dot2: " + vV2A + "/" + VectorDot((vMyVec[0], 0, vMyVec[2]), (vMyToPosVec[0], 0, vMyToPosVec[2])) + "/" + vV2B);
		}
		
		i++;
		wait 0.05;
	}*/
	
/*
	FREE
	-------------
	0 - 100
	104 - 153
	249 - 1999
	2000 - 2299
	2300 - 2351
	2353 - 2999
	3100 - 3497
	-------------

	reserved
	2300 - 2352 - Player statistics & Rank
*/
	//wait 5;
	
	//deathrun\include\_logic::EndGame(deathrun\include\_victory::TYPE_Forced);
	
/*
	iprintln("^2sending first dvars...");
	for (i = 0; i < 60; i++)
		self SetClientDvar("dev_test_" + i, RandomInt(100));
		
	wait 10;
	
	iprintln("^2sending second dvars...");
	dvarList = [];
	for (i = 0; i < 60; i++)
		dvarList["dev_test_" + i] = RandomInt(100);
	
	self ICCMD::SendDvars(dvarList);
	*/
	/*while (true)
	{
		time = 1;
		if (self UseButtonPressed())
			time = 0.05;
			
		max = self deathrun\include\clients\_rank::GetRankIdMaxXP(self.pers["rank"]);
		min = self deathrun\include\clients\_rank::GetRankIdMinXP(self.pers["rank"]);
		
		ammount = ((max - min) / 5);
		
		self deathrun\include\clients\_rank::GiveRankXP(ammount);
		wait time;
	}*/
	
/*
	for (i = 0; i < 3500; i++)
	{
		iprintln(i + ";" + self GetStat(i));
		if (i % 50 == 0)
			wait 0.05;
	}
*/	

	/*stats = [];
	
	for (i = 2000; i < 3500; i++)
	{
		if (i == 299)
			continue;
		
		stat = {Id = i, Value = self GetStat(i)};
		stats = IARRAY::Add(stats, stat);
		
		self SetStat(i, 0);
		prints(i + " " + self GetStat(i));
		if (i % 10 == 0)
			wait 0.05;
	}*/
	/*
	nonZeroStats = [];
	nonChangeStats = [];
	i = 0;
	foreach (stat in stats)
	{
		if (stat["Value"] != 0)
			nonZeroStats = IARRAY::Add(nonZeroStats, stat);
		
		if (stat["Value"] != 244)
			nonChangeStats = IARRAY::Add(nonChangeStats, stat);
			
		if (i % 10 == 0)
			wait 0.05;
		i++;
	}
	
	i = 0;
	prints("nonZeroStats");
	foreach (stat in nonZeroStats)
	{
		prints(stat["Id"] + " " + stat["Value"]);
		
		if (i % 10 == 0)
			wait 0.05;
		i++;
	}
	
	i = 0;
	prints("nonChangeStats");
	foreach (stat in nonChangeStats)
	{
		prints(stat["Id"] + " " + stat["Value"]);
		
		if (i % 10 == 0)
			wait 0.05;
		i++;
	}*/
}

prints(text)
{
	iprintln(text);
	LogPrint(text + "\n");
}