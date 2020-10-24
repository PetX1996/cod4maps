main()
{
	maps\mp\_load::main();

	thread platfrm ();
	thread trap1();
	thread trap2();
	thread hiddingtraps();
	thread trap3();
	thread trap5();
	thread trap6();
	thread trap7();
	thread doora();
	thread noneedforactive();

}

	platfrm ()
	 {
	   plat = getEnt ("platform" , "targetname");
	      while (1)
		   {
		   plat moveY (-300 , 2 );
		   wait 2.5 ;
		   plat moveY (300 , 2 );
		   wait 2.5 ;
		   }
	 }

//////////////////////////////////////////////////////////////////////////////////


trap1 ()
	{
	trig_1 = getent ("trig1","targetname");
	brush_1 = getent ("brush_1","targetname");
	coin_1 = getent ("coin_1","targetname");
	trig_1 waittill ("trigger");
	trig_1 PlaySound("coin");
	trig_1 delete ();
	coin_1 movez (12 , 0.1);
	wait 0.1;
	coin_1 movez (-12 , 0.1);
	
	while (1)
		{
		brush_1 rotatePitch (360 , 8 );
		wait 1 ;
		}
	}


//////////////////////////////////////////////////////////////////////////////////

trap2 ()
	{
	part1 = getentarray ("part_1" ,"targetname");
	part2 = getentarray ("part_2" ,"targetname");
	trig_2 = getent ("trig2" , "targetname");
	coin_2 = getent ("coin_2","targetname");
	trig_2 waittill ("trigger" , player );
	trig_2 PlaySound("coin");
	trig_2 delete ();
	coin_2 movez (12 , 0.1);
	wait 0.1;
	coin_2 movez (-12 , 0.1);
	part1[randomInt(part1.size)] notsolid();
    part2[randomInt(part2.size)] notsolid();
	}

hiddingtraps () 
	      {
		  trig2 = getent ( "trig_2" , "targetname" ) ;
		  half_1= getentarray ( "half_1","targetname" ) ;
		  half_2 = getentarray ( "half_2" , "targetname");
		  trig2 waittill ("trigger", player );
		  trig2 delete ();
		  half_1[randomInt(half_1.size)] delete();
          half_2[randomInt(half_2.size)] delete();

		  }

	  trap3 ()
		   {
		   trig3 = getent ( "trig_3" , "targetname" );
		   trp3 = getent ("trap_3" , "targetname");
		   trig3 waittill ("trigger" , player );
		   trig3 delete ();
		   trp3 rotatepitch (1800 , 12  );
		   wait 1 ;
		   }

trap5()
			{
			trig5 = getent ("trig_5" , "targetname" );
			trap5_a = getent ("trap_5_1" , "targetname" );
			trap5_b = getent ("trap_5_2" , "targetname");
			trig5 waittill ("trigger",player);
			trig5 delete ();
			trap5_a rotatepitch (-90 , 0.5 );
			trap5_b rotatepitch (90 , 0.5 );
			wait 4 ;
			trap5_a rotatepitch (90 , 0.5 );
			trap5_b rotatepitch (-90 , 0.5 );
			wait 1;
			}

trap6 ()
			{
			trig6 = getent ("trig_6" , "targetname");
			trp6_1 = getent ("trap_6_1" , "targetname");
			trp6_2 = getent ("trap_6_2" , "targetname");
			trig6 waittill ("trigger", player);
			trig6 delete ();
			trp6_1 movez (150, 1);
			trp6_2 movez (-150 , 1);
			wait 2 ;
			trp6_1 movez (-150,1);
			trp6_2 movez (150,1);
			wait 2 ;
			trp6_1 movez (-150, 1);
			trp6_2 movez (150 , 1);
			wait 2;
			trp6_1 movez (150,1);
			trp6_2 movez (-150,1);
			wait 2 ;
			}

trap7 ()
			{
			  trig7 = getent ("trig_7" ,"targetname");
			  trp7 = getent ("trap_7","targetname");
			  kill1 = getent ("killzone","targetname");
			  trig7 waittill ("trigger",player);
			  trig7 delete ();
			  kill1 enablelinkto ();
			  kill1 linkto (trp7);
			  trp7 rotatepitch (-180 , 1.5 );
			  wait 5;
			  trp7 rotatepitch (180 , 2 );
			  wait 5;
			}

	doora ()
			{
			trigdoor = getent ("dooropen" , "targetname");
			dooro = getent ("door" ,"targetname" );
			trigdoor waittill ("trigger",player);
			trigdoor delete ();
			player deathrun\include\_mapper::CFinishMap();
			iprintlnbold("^3Nice" + " " + "^1"+ player.name + " "+ "^7finished the map!");
			dooro movez (98 , 1.1);
			wait 1 ;
			}
			
noneedforactive ()
		{
			push1 = getent ("pusher1","targetname" );
			push2 = getent ("pusher2","targetname" );
			push3 = getent ("pusher3","targetname" );
			push4 = getent ("pusher4","targetname" );
			push1 rotateroll (45 ,0.4);
			push2 rotateroll (-45 ,0.4);
			push3 rotateroll (45 ,0.4);
			push4 rotateroll (-45 ,0.4);
			wait 0.4;
			while (1) 
			{
			
			push1 rotateroll (-90 ,0.8);
			push2 rotateroll (90 ,0.8);
			push3 rotateroll (-90 ,0.8);
			push4 rotateroll (90 ,0.8);
			wait 0.8;
			push1 rotateroll (90 ,0.8);
			push2 rotateroll (-90 ,0.8);
			push3 rotateroll (90 ,0.8);
			push4 rotateroll (-90 ,0.8);
			wait 0.8 ;
			}
			}