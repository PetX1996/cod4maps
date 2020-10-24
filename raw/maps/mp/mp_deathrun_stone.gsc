main()
{
	maps\mp\_load::main();
	
	thread traps();
	thread addtrapstofreerun();
}
traps()
{
	//Haha, the traps!
	thread trap1();
	thread trap2();
	thread trap3();
	thread trap4();
	thread trap5();
	thread trap6();
	thread trap7();
	thread trap8();
	thread enddoor();
}
trap1()
{
	trig = getent("trap1acti", "targetname");
	obj1 = getent("trap1","targetname");
	trig waittill( "trigger", who ); 
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 1 ^2Activated");
	while(1)
	{
		obj1 rotateYaw(360,5);
		obj1 waittill("rotatedone");
	}
}

trap2()
{
	trig = getent("trap2acti", "targetname");
	obj = getent("trap2","targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 2 ^2Activated");
	obj movez(-208, 1);
	obj waittill("movedone");
	wait (5);
	obj movez(208, 4);
	wait(5);
}

trap3()
{
	trig = getent("trap3acti", "targetname");
	obj1 = getent("trap3","targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 3 ^2Activated");
	while(1)
	{
		obj1 rotateroll (360 , 2 );
		obj1 waittill("rotatedone");
		wait 2;
	}
}

trap4()
{
	trig = getent("trap4acti", "targetname");
	obj1 = getent("trap4","targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 4 ^2Activated");
	obj1 movey(-500, 2);
	obj1 waittill("movedone");
	obj1 movey(500, 2);

}

trap5()
{
	trig = getent("trap5acti", "targetname");
	obj1 = getent("trap5","targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 5 ^2Activated");
	while(1)
	{
		obj1 rotatepitch (360 , 7 );
		obj1 waittill("rotatedone");
	}
}

trap6()
{
	trig = getent("trap6acti", "targetname");
	obj = getent("trap6", "targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 6 ^2Activated");
	obj movez(-80, 1);
	obj waittill("movedone");
	wait (5);
	obj movez(80, 4);
	wait(5);
}

trap7()
{
	trig = getent("trap7acti", "targetname");
	obj = getent("trap7", "targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 7 ^2Activated");
	obj movey(576, 1);
	obj waittill("movedone");
	wait (5);
}

trap8()
{
	trig = getent("trap8acti", "targetname");
	obj = getent("trap8", "targetname");
	trig waittill( "trigger", who );
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^1Trap 7 ^2Activated");
	obj movez(160, 1);
	obj waittill("movedone");
	wait (5);
	obj movez (-160, 3);
	obj waittill("movedone");
}

enddoor()
{
	trig = getent("door_end_acti", "targetname");
	obj = getent("door_end", "targetname");
	trig waittill( "trigger", who );
	who deathrun\include\_mapper::CFinishMap();
	wait 0.1;
	trig delete();
	wait 0.1;
	iprintln ("^Door ^2Opened!");
	obj movez(160, 3);
	obj waittill("movedone");
	wait (5);
}

addTriggerToList( name )
{
   if( !isDefined( level.trapTriggers ) )
      level.trapTriggers = [];
   level.trapTriggers[level.trapTriggers.size] = getEnt( name, "targetname" );
}
addtrapstofreerun()
{
	addTriggerToList("trap1acti");
	addTriggerToList("trap2acti");
	addTriggerToList("trap3acti");
	addTriggerToList("trap4acti");
	addTriggerToList("trap5acti");
	addTriggerToList("trap6acti");
	addTriggerToList("trap7acti");
	addTriggerToList("trap8acti");
	addTriggerToList("trap9acti");
	addTriggerToList("trap10acti");
	addTriggerToList("trap11acti");
}
