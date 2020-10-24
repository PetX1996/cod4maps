main()
{
 
    maps\mp\_load::main();
	
	
	
	thread teleport1();
	thread startdoor();
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread teleportsniper();
	thread teleportbounce();
	
}




teleport1()
{
    trig = getEnt( "teleport_trigger1", "targetname" );
    org = getEnt( "teleport_target1", "targetname" );
	for(;;)
	{
		trig waittill( "trigger", player );
		player SetOrigin(org.origin);
	}
}

startdoor()
{

    trig = getEnt( "startdoor", "targetname" );
    brush = getEnt( "doora", "targetname" );
    brush2 = getEnt( "doorb", "targetname" );
    
	trig waittill( "trigger");
	trig delete();
	{
	wait 5;
	iPrintLnBold("^15");
	wait 1;
	iPrintLnBold("^24");
	wait 1;
	iPrintLnBold("^33");
	wait 1;
	iPrintLnBold("^42");
	wait 1;
	iPrintLnBold("^51");
	wait 1;
	brush moveZ(368,3);
	brush2 moveZ(-368,3);
	wait 0.5;
	iPrintLnBold("^1Map ^2By ^3Staab ^4www.alpha-gaming.co.uk");
	}
}


trap1()
{
	trig = getEnt( "trap1_trigger", "targetname" );
	brush1 = getEnt( "trap1_brush1", "targetname" );

	trig waittill( "trigger" );
	
	while(1)
	{
	trig delete();
	
	brush1 moveZ(50,1);
	brush1 waittill("movedone");
	brush1 moveZ(-100,1);
	brush1 waittill("movedone");
	brush1 moveZ(100,1);
	brush1 waittill("movedone");
	brush1 moveZ(-50,1);
	brush1 waittill("movedone");
}
}

trap2()
{
	trig = getent("trap2_trigger", "targetname");
	trap = getent("trap2_brush", "targetname");
	gold = getent("trap4gold","targetname");
	trig waittill( "trigger", who ); 
	wait 0.1;
	trig delete();
	gold delete();
	while(1)
	{
		trap rotatePitch (360 , 3 );
		trap waittill("rotatedone");
		wait 5.0;
	}

}


trap3()
{
	trig = getEnt( "trap3_trigger", "targetname" );
	brush1 = getEnt( "trap3_brush1", "targetname" );
	brush2 = getEnt( "trap3_brush2", "targetname" );
	brush3 = getEnt( "trap3_brush3", "targetname" );
	brush4 = getEnt( "trap3_brush4", "targetname" );
	brush5 = getEnt( "trap3_brush5", "targetname" );
	brush6 = getEnt( "trap3_brush6", "targetname" );
	brush7 = getEnt( "trap3_brush7", "targetname" );
	brush8 = getEnt( "trap3_brush8", "targetname" );
	brush9 = getEnt( "trap3_brush9", "targetname" );
	brush10 = getEnt( "trap3_brush10", "targetname" );
	brush11 = getEnt( "trap3_brush11", "targetname" );
	brush12 = getEnt( "trap3_brush12", "targetname" );
	brush13 = getEnt( "trap3_brush13", "targetname" );
	brush14 = getEnt( "trap3_brush14", "targetname" );
	brush15 = getEnt( "trap3_brush15", "targetname" );
	brush16 = getEnt( "trap3_brush16", "targetname" );
	brush17 = getEnt( "trap3_brush17", "targetname" );
	brush18 = getEnt( "trap3_brush18", "targetname" );

	trig waittill( "trigger" );
	
	while(1)
	{
	trig delete();
	
	brush1 rotateyaw (360,1);
	brush2 rotateyaw (360,1);
	brush3 rotateyaw (360,1);
	brush4 rotateyaw (360,1);
	brush5 rotateyaw (360,1);
	brush6 rotateyaw (360,1);
	brush7 rotateyaw (360,1);
	brush8 rotateyaw (360,1);
	brush9 rotateyaw (360,1);
	brush1 waittill ("rotatedone");
	
	brush10 rotateyaw (360,1);
	brush11 rotateyaw (360,1);
	brush12 rotateyaw (360,1);
	brush13 rotateyaw (360,1);
	brush14 rotateyaw (360,1);
	brush15 rotateyaw (360,1);
	brush16 rotateyaw (360,1);
	brush17 rotateyaw (360,1);
	brush18 rotateyaw (360,1);
	brush10 waittill ("rotatedone");
}
}

trap4()
{
	hammer1 = getEnt("trap4_hammer1","targetname");
	hammer2 = getEnt("trap4_hammer2","targetname");
	hammer3 = getEnt("trap4_hammer3","targetname");
	hammer4 = getEnt("trap4_hammer4","targetname");
	
	trigger = getEnt("trap4_trigger","targetname");
	trigger waittill("trigger");
	trigger setHintString("^1Trap Activated!");
	while(1)
	{
		hammer1 rotateRoll(-180,1);
		hammer2 rotateRoll(180,1);
		hammer3 rotateRoll(-180,1);
		hammer4 rotateRoll(180,1);
		wait 1;
	}
}

trap5()
{
	trig = getent("trap5_trigger", "targetname");
	trap5 = getent("trap5down", "targetname");
	trig SetCursorHint("HINT_ACTIVATE");
	gold = getent("trap5gold","targetname");
	trig waittill( "trigger", who ); 
	wait 0.1;
	trig delete();
	gold delete();
	trap5 movez(-250, 1);
	wait 1.5;
	trap5 movez(250, 1);
	
}

trap6()
{
	part1 = getentarray ("trap6_1" ,"targetname");
	part2 = getentarray ("trap6_2" ,"targetname");
	part3 = getentarray ("trap6_3" ,"targetname");
	part4 = getentarray ("trap6_4" ,"targetname");
	trig = getentArray ("trap6_trigger" , "targetname")[0];
	gold = getent("trap3gold","targetname");
	trig SetCursorHint("HINT_ACTIVATE");

 	trig waittill( "trigger", who ); 
	trig delete ();
	gold delete();
	random = randomint(2);

	switch(random)
	{
		case 0:
				part1[randomInt(part1.size)] notsolid();
				part4[randomInt(part4.size)] notsolid();
				break;
				
		case 1:	
				part2[randomInt(part2.size)] notsolid();
				part3[randomInt(part3.size)] notsolid();		
				
		default: return;
	}
}

trap7()
{
	hammer1 = getEnt("trap7_hammer1","targetname");
	hammer2 = getEnt("trap7_hammer2","targetname");
	hammer3 = getEnt("trap7_hammer3","targetname");
	hammer4 = getEnt("trap7_hammer4","targetname");
	
	trigger = getEnt("trap7_trigger","targetname");
	trigger waittill("trigger");
	trigger setHintString("^1Trap Activated!");
	while(1)
	{
		hammer1 rotateRoll(-180,1);
		hammer2 rotateRoll(180,1);
		hammer3 rotateRoll(-180,1);
		hammer4 rotateRoll(180,1);
		wait 1;
	}
}

trap8()
{
	trig = getEnt("trap8_trigger","targetname");
 	brush1 = getEnt("trap8_ran1","targetname");
 	brush2 = getEnt("trap8_ran2","targetname");

	trig waittill("trigger");
	trig SetHintstring ("^1Activated!");
	random = randomInt(2);
	switch(random)
	{
		case 0:	brush1 delete();
				break;
				
		case 1:	brush2 delete();
				break;
				
		default: return;
	}
}

addTestClients()
{
	setDvar("scr_testclients", "");
	wait 1;
	for(;;)
	{
		if(getdvarInt("scr_testclients") > 0)
			break;
		wait 1;
	}
	testclients = getdvarInt("scr_testclients");
	setDvar( "scr_testclients", 0 );
	for(i=0;i<testclients;i++)
	{
		ent[i] = addtestclient();

		if (!isdefined(ent[i]))
		{
			println("Could not add test client");
			wait 1;
			continue;
		}
		ent[i].pers["isBot"] = true;
		ent[i] thread TestClient("autoassign");
	}
	thread addTestClients();
}

TestClient(team)
{
	self endon( "disconnect" );

	while(!isdefined(self.pers["team"]))
		wait .05;
		
	self notify("menuresponse", game["menu_team"], team);
	wait 0.5;
}

teleportsniper()
{
level.teleactorigin4 = getEnt("sniperact", "targetname");
telesniperorigin = getEnt("telesniper", "targetname");
level.snipertrigger = getEnt("teleportsniperroom", "targetname");
for(;;)
{
level.snipertrigger waittill("trigger", player);
level.knifetrigger delete();
wait(0.05);
player SetOrigin( telesniperorigin.origin );
player setplayerangles( telesniperorigin.angles );
player TakeAllWeapons();
player GiveWeapon( "m40a3_mp" ); 
player Giveweapon( "remington700_mp" );
wait(0.05);
level.activ SetOrigin (level.teleactorigin4.origin);
level.activ setplayerangles (level.teleactorigin4.angles);
level.activ TakeAllWeapons();
level.activ GiveWeapon( "m40a3_mp" );
level.activ Giveweapon( "remington700_mp" ); 
wait(0.05);
player switchToWeapon( "m40a3_mp" );
level.activ SwitchToWeapon( "m40a3_mp" );
level.teleorigin delete();
iPrintLnBold(player.name+ "^4 has entered the ^1Sniper Room"); //Change the message if you want
AmbientStop( 2 );
		ambientplay( "sniper" );
while( isAlive( player ) && isDefined( player ) )
            wait 1;
}
}

teleportbounce()
{
level.teleactorigin3 = getEnt("actbounce", "targetname");
teleknifeorigin = getEnt("telebounce", "targetname");
level.knifetrigger = getEnt("teleportbounceroom", "targetname");
for(;;)
{
level.knifetrigger waittill("trigger", player);
level.jumpertrigger delete();
level.bouncetrigger delete();
level.snipertrigger delete();
level.oldtrigger delete();
level.oldtrigger2 delete();
wait(0.05);
player SetOrigin( teleknifeorigin.origin );
player setplayerangles( teleknifeorigin.angles );
player TakeAllWeapons();
player GiveWeapon( "knife_mp" ); 
wait(0.05);
level.activ SetOrigin (level.teleactorigin3.origin);
level.activ setplayerangles (level.teleactorigin3.angles);
level.activ TakeAllWeapons();
level.activ GiveWeapon( "knife_mp" ); 
wait(0.05);
player switchToWeapon( "knife_mp" );
level.activ SwitchToWeapon( "knife_mp" );
level.teleknifeorigin delete();
iPrintLnBold(player.name+ "^4 has entered the ^1Bounce Room"); //Change the message if you want
while( isAlive( player ) && isDefined( player ) )
            wait 1;
}
}


