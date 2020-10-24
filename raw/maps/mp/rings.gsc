
main()
{
	thread slidedoor();
	thread hide_rings();
}

slidedoor()
{

	doortrig = getent("rings", "targetname");
	if(!isdefined(doortrig))
		return;
	
	doortrig.doorclosed = true;

	while (true)
	{
		doortrig waittill("trigger", other);
		iprintln("bleeee");
		if(doortrig.doorclosed)
		{
			doortrig thread slidedoor_move(other);
		}
	}
}

slidedoor_move(other)
{
	time = 0.2;
	move = 120;
	acc = 0.05;
	dec = 0.05;
	ring_0_1 = getent("rings_0_1","targetname");
	ring_0_2 = getent("rings_0_2","targetname");
	ring_0_3 = getent("rings_0_3","targetname");
	ring_0_4 = getent("rings_0_4","targetname");
	ring_0_5 = getent("rings_0_5","targetname");
	
	rings_0_1 = getent("sgc_rings_0_1","targetname");

        origin = getent( "origin", "targetname" ); //brana 1
        origin2 = getent( "origin2", "targetname" ); // brana2

	if(!isdefined(ring_0_1)||!isdefined(ring_0_2)||!isdefined(ring_0_3)||!isdefined(ring_0_4)||!isdefined(ring_0_5)||!isdefined(rings_0_1))
		return;
		
	if(!isdefined(origin)||!isdefined(origin2))	
		return;
		
	//Vysunuti
	self.doorclosed = false;
	//door_sg_1 playsound("door_open");
	wait (2);
	ring_0_1 movez( move, time,acc,dec);
	rings_0_1 movez( move, time);
	ring_0_1 waittill ("movedone");
	ring_0_2 movez( move, time,acc,dec);

	ring_0_2 waittill ("movedone");
	ring_0_3 movez( move, time,acc,dec);

	ring_0_3 waittill ("movedone");
	ring_0_4 movez( move, time,acc,dec);

	ring_0_4 waittill ("movedone");
	thread acitvate_rings_1();
	ring_0_5 movez( move, time,acc,dec);

	
	ring_0_5 waittill ("movedone");
	
    //wait(2);
	//thread acitvate_rings_1();
	//playFx(level._effect[ "rings" ], origin.origin);
	trigger = spawn( "trigger_radius", origin.origin, 0, 60, 40);
	trigger thread enable_teleport(origin, origin2);

	wait (0.5);

    if ( isDefined(trigger))
	{
		trigger notify("delete");
        trigger delete();	
	}	
    /*trigger thread timetout_trigger(0.5);
        trigger waittill("trigger",player); 
    if (isDefined(player)) {
        playFx(level._effect[ "rings" ], origin.origin);
		trigger notify("player_touched");
        player setOrigin( origin2.origin );
        player setplayerangles( origin2.angles ); 
		playFx(level._effect[ "rings" ], origin2.origin);
        wait (0.5);
    }

    if ( isDefined(trigger))
        trigger delete();*/

//Zasunuti
	//door_sg_1 playsound("door_close");
	
	ring_0_5 movez( (-1)*move, time,acc,dec);

	ring_0_5 waittill ("movedone");
	ring_0_4 movez( (-1)*move, time,acc,dec);

	ring_0_4 waittill ("movedone");
	ring_0_3 movez( (-1)*move, time,acc,dec);

	ring_0_3 waittill ("movedone");
	ring_0_2 movez( (-1)*move, time,acc,dec);

	ring_0_2 waittill ("movedone");
	ring_0_1 movez( (-1)*move, time, acc, dec);
	rings_0_1 movez( (-1)*move, time);
	//wait(0.5);
	
	ring_0_1 waittill ("movedone");
	self.doorclosed = true;
}

enable_teleport(origin, origin2)
{
	self endon("delete");
	effect = false;
	
	while(1)
	{
		self waittill("trigger", player);
		
		if(isdefined(player))
		{
			if(!effect)
			{
				effect = true;
				playFx(level._effect[ "rings" ], origin.origin);
				playFx(level._effect[ "rings" ], origin2.origin);
			}
			
			player setOrigin( origin2.origin );
			player setplayerangles( origin2.angles ); 
		}
		wait 0.001;
	}
}
acitvate_rings_1()
{
	time = 0.01;
	move = 120;
	acc = 0.005;
	dec = 0.005;
	
	time2 = 0.2;
	move = 120;
	acc2 = 0.05;
	dec2 = 0.05;

	ring_1_1 = getent("rings_1_1","targetname");
	ring_1_2 = getent("rings_1_2","targetname");
	ring_1_3 = getent("rings_1_3","targetname");
	ring_1_4 = getent("rings_1_4","targetname");
	ring_1_5 = getent("rings_1_5","targetname");
	
	rings_1_1 = getent("sgc_rings_1_1","targetname");
	
	if(!isdefined(ring_1_1)||!isdefined(ring_1_2)||!isdefined(ring_1_3)||!isdefined(ring_1_4)||!isdefined(ring_1_5)||!isdefined(rings_1_1))
		return;
	
	ring_1_1 movez( move, time,acc,dec);
	rings_1_1 movez( move, time);
	ring_1_1 waittill ("movedone");
	ring_1_2 movez( move, time,acc,dec);

	ring_1_2 waittill ("movedone");
	ring_1_3 movez( move, time,acc,dec);

	ring_1_3 waittill ("movedone");
	ring_1_4 movez( move, time,acc,dec);

	ring_1_4 waittill ("movedone");
	
	ring_1_5 movez( move, time,acc,dec);

	
	ring_1_5 waittill ("movedone");
	wait (0.5);
	ring_1_5 movez((-1)*move, time2,acc2,dec2);
	ring_1_5 waittill ("movedone");
	ring_1_4 movez((-1)*move, time2,acc2,dec2);
	ring_1_4 waittill ("movedone");
	ring_1_3 movez((-1)*move, time2,acc2,dec2);
	ring_1_3 waittill ("movedone");
	ring_1_2 movez((-1)*move, time2,acc2,dec2);
	ring_1_2 waittill ("movedone");
	ring_1_1 movez((-1)*move, time2,acc2,dec2);
	ring_1_1 waittill ("movedone");
	rings_1_1 movez((-1)*move, time2,acc2,dec2);
	
	
	
}
hide_rings()
{
    time = 0.1;
	move = 120;
	ring_0_1 = getent("rings_0_1","targetname");
	ring_0_2 = getent("rings_0_2","targetname");
	ring_0_3 = getent("rings_0_3","targetname");
	ring_0_4 = getent("rings_0_4","targetname");
	ring_0_5 = getent("rings_0_5","targetname");

	rings_0_1 = getent("sgc_rings_0_1","targetname");
	
	ring_1_1 = getent("rings_1_1","targetname");
	ring_1_2 = getent("rings_1_2","targetname");
	ring_1_3 = getent("rings_1_3","targetname");
	ring_1_4 = getent("rings_1_4","targetname");
	ring_1_5 = getent("rings_1_5","targetname");	
	rings_1_1 = getent("sgc_rings_1_1","targetname");
	//rings 0
	
	if(!isdefined(ring_1_1)||!isdefined(ring_1_2)||!isdefined(ring_1_3)||!isdefined(ring_1_4)||!isdefined(ring_1_5)||!isdefined(rings_1_1))
		return;

	if(!isdefined(ring_0_1)||!isdefined(ring_0_2)||!isdefined(ring_0_3)||!isdefined(ring_0_4)||!isdefined(ring_0_5)||!isdefined(rings_0_1))
		return;
		
	ring_0_1 movez((-1)*move, time);
	
	ring_0_2 movez((-1)*move, time);
	
	ring_0_3 movez((-1)*move, time);
	
	ring_0_4 movez((-1)*move, time);
	
	ring_0_5 movez((-1)*move, time);
	
	rings_0_1 movez((-1)*move, time);
	
	ring_0_5 waittill ("movedone");
	//rings 1
	ring_1_1 movez((-1)*move, time);
	
	ring_1_2 movez((-1)*move, time);
	
	ring_1_3 movez((-1)*move, time);
	
	ring_1_4 movez((-1)*move, time);
	
	ring_1_5 movez((-1)*move, time);
	
	rings_1_1 movez((-1)*move, time);
	
	ring_1_5 waittill ("movedone");
}