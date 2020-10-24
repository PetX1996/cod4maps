main()
{
  level._effect[ "red" ] = loadfx( "misc/rat_on" );
  precacheItem( "rpg_mp" );
  precacheItem( "c4_mp" );
  precacheItem( "claymore_mp" );
  precacheItem( "frag_grenade_mp" );
  precacheItem( "remington700_mp" );
  precacheItem( "m40a3_mp" );
  precacheItem( "m21_mp" );
  precacheItem( "barrett_mp" );
  
  thread weapons();
  thread snip();
  thread special();
}


weapons()
{
	enter_weapons = getent ("r_weapons_enter" , "targetname");
	red = getent ( "red_weapons" , "targetname" );
	enter_snip = getent ("r_snip_enter" , "targetname");
	enter_special = getent ("r_special_enter" , "targetname");

	enter_weapons waittill ("trigger" , jumper);
	enter_snip delete();
	enter_special delete();

	playFx(level._effect[ "red" ], red.origin, red.angles);
	
	enter_weapons thread jumper_port_weapons();
}

snip()
{
	enter_weapons = getent ("r_weapons_enter" , "targetname");
	red = getent ( "red_snip" , "targetname" );
	enter_snip = getent ("r_snip_enter" , "targetname");
	enter_special = getent ("r_special_enter" , "targetname");

	enter_snip waittill ("trigger" , jumper);
	enter_weapons delete();
	enter_special delete();
	playFx(level._effect[ "red" ], red.origin, red.angles);

	enter_snip thread jumper_port_snip();
}

special()
{
	enter_weapons = getent ("r_weapons_enter" , "targetname");
	red = getent ( "red_special" , "targetname" );
	enter_snip = getent ("r_snip_enter" , "targetname");
	enter_special = getent ("r_special_enter" , "targetname");

	enter_special waittill ("trigger" , jumper);
	enter_snip delete();
	enter_weapons delete();
	playFx(level._effect[ "red" ], red.origin, red.angles);

	enter_special thread jumper_port_special();
}

weapons_cislo()
{
	a = 0;
	b = 1;
	c = 2;
	d = 3;

	random = RandomIntRange( 0, 4 );

		if (random == a || random == c)
		{
			i = a;
			j = c;
			return i+j;
		}
		if (random == b || random == d)
		{
			i = b;
			j = d;
			return i+j;
		}
}

jumper_port_weapons()
{
	while(1)
	{
		randomcislo = weapons_cislo();
			if (randomcislo == 2) 
			{
				a = RandomIntRange( 0, 11 );
					if (a < 11)
					{
						i = 0;
						j = 2;
					}
					else
					{
						i = 2;
						j = 0;
					}			
			}
			else
			{
				a = RandomIntRange( 0, 11 );
					if (a < 11)
					{
						i = 1;
						j = 3;
					}
					else
					{
						i = 3;
						j = 1;
					}		
			}

		rgc = RandomIntRange( 0, 22 );	
			if (rgc < 10)
				random_gun = "c4_mp";
			else if (rgc == 10 || rgc == 20)
				random_gun = "claymore_mp";
			else if (rgc > 10 && rgc < 20)				
				random_gun = "frag_grenade_mp";
			else
				random_gun = "rpg_mp";
			
		trigger = getent("weapons_trig_"+i , "targetname");

		self waittill("trigger" ,jumper);
		
		player = players();

		if (player IsTouching(trigger))
				continue;
		
		jumper_go = getent("ammo_go_"+i , "targetname");
		aktiv_go = getent("ammo_go_"+j , "targetname");
		
		jumper thread teleport(jumper_go);

		iprintlnbold ("^3---^1" + jumper.name + "^3--- ^2go in WEAPONS room!");
		
		jumper TakeAllWeapons();
		jumper GiveWeapon(random_gun);
		wait 0.01;
		jumper SwitchToWeapon(random_gun);

		// /*
			if (!isdefined(level.aktivator))
			{		
				aktivator = aktivator_port(aktiv_go);

				aktivator TakeAllWeapons();
				aktivator GiveWeapon(random_gun);
				wait 0.01;
				aktivator SwitchToWeapon(random_gun);		
			}
		// */	
			
		jumper death();
		iprintlnbold ("^3---^1" + jumper.name + "^3--- ^2death!");
		iprintlnbold ("^2WEAPONS ^3room opened!!");				
	}		
}

jumper_port_special()
{
	jumper_go = getent("r_special_jumper" , "targetname");
	aktiv_go = getent("r_special_aktiv" , "targetname");
	
		while(1)
		{
		self waittill("trigger" ,jumper);
		
		jumper thread teleport(jumper_go);

		iprintlnbold ("^3---^1" + jumper.name + "^3--- ^2go in SPECIAL room!");
		
		//jumper TakeAllWeapons();
		//jumper GiveWeapon(random_gun);
		//wait 0.01;
		//jumper SwitchToWeapon(random_gun);

			if (!isdefined(level.aktivator))
			{
				aktivator_port(aktiv_go);

				//aktivator TakeAllWeapons();
				//aktivator GiveWeapon(random_gun);
				//wait 0.01;
				//aktivator SwitchToWeapon(random_gun);
			}
		}
}

jumper_port_snip()
{	
		while(1)
		{
		self waittill("trigger" ,jumper);
		
		i = RandomIntRange( 0, 4 );
		jumper_go = getent("r_snip_jumper_"+i , "targetname");
		aktiv_go = getent("r_snip_aktiv_"+i , "targetname");

		rgc = RandomIntRange( 0, 25 );	
			if (rgc < 10)
				random_gun = "remington700_mp";
			else if (rgc > 10 && rgc < 20)
				random_gun = "m40a3_mp";
			else if (rgc > 20 && rgc < 23)				
				random_gun = "m21_mp";
			else
				random_gun = "barrett_mp";
		
		jumper thread teleport(jumper_go);
		
		iprintlnbold ("^3---^1" + jumper.name + "^3--- ^2go in SNIPER room!");
		
		jumper TakeAllWeapons();
		jumper GiveWeapon(random_gun);
		wait 0.01;
		jumper SwitchToWeapon(random_gun);
		
			if (!isdefined(level.aktivator))
			{
				aktivator = aktivator_port(aktiv_go);
				
				if (isdefined(aktivator))
				{
					aktivator TakeAllWeapons();
					aktivator GiveWeapon(random_gun);
					wait 0.01;
					aktivator SwitchToWeapon(random_gun);
				}
			}
			
		jumper death();

		iprintlnbold ("^3---^1" + jumper.name + "^3--- ^2death!");
		iprintlnbold ("^2SNIPER ^3room opened!!");
		}
}

aktivator_port(go)
{
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( IsAlive(players[i]) && isPlayer(players[i]))
		{
			if( players[i].pers["team"] == "axis" )
			{
				level.aktivator = true;
				players[i] thread teleport(go);
				return players[i];
			}
		}
	}
}

players()
{
	players = getEntArray("player", "classname");
	for(i=0;i<players.size;i++)
	{
		if( IsAlive(players[i]) && isPlayer(players[i]))
		{
			return players[i];
		}
	}
}

death()
{
self endon("disconnect");

self waittill ("death");
}

teleport(go)
{
	self freezeControls( true );
	self setplayerangles(go.angles);
	self setorigin(go.origin);
	self iprintlnbold("^1Teleported!!!");
	wait 1;
	self freezeControls( false );
}
