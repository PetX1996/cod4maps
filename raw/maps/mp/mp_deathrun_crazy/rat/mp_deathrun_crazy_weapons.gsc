main()
{
	level._effect[ "glow" ] = loadfx( "misc/ui_pickup_available" );
	//thread maps\mp\gametypes\_weapons::init();

	thread efekt();
	thread healt();
	thread ammo();
}

efekt()
{
	efekt_orig = getentarray ("glow" , "targetname");

		if (isdefined(efekt_orig))
		{
			for(i = 0;i < efekt_orig.size;i++)
			{
			playloopedFx(level._effect[ "glow" ],10, efekt_orig[i].origin);
			}
		}
}

healt()
{
	use = getent ("healt_use" , "targetname");
	go = getent ("healt_go" , "targetname");

	while(1)
	{
		use waittill("trigger", player);

			if (player.health < player.maxhealth)
			{
				player.health = player.maxhealth;
				player iprintln ("^1Health restored");
				wait 1;
				player thread teleport(go);
			}
			else
			{
				player iprintln ("^1Sorry, maxhealth");
				wait 1;
				player thread teleport(go);
			}
	}
}

teleport(go)
{
	self setplayerangles(go.angles);
	self setorigin(go.origin);
}

ammo()
{
	for(i=0;i<4;i++)
	{
	thread ammo_restore(i);
	}
}

ammo_restore(i)
{
	ammo_use = getent("ammo_use_"+i, "targetname");
	ammo_go = getent("ammo_go_"+i, "targetname");
	
	while(1)
	{
		ammo_use waittill("trigger", player);
		
		player.weapon = player GetCurrentWeapon();

		iprintln ("player.weapon = "+player.weapon);		

		player.maxammo = WeaponMaxAmmo(player.weapon);

		iprintln ("player.maxammo = "+player.maxammo);		

		player.ammo = player GetWeaponAmmoClip(player.weapon);

		iprintln ("player.ammo = "+player.ammo);		
		
			if (player.ammo < player.maxammo)
			{
				player GiveMaxAmmo(player.weapon);
				player iprintln ("^2Ammo restored");
                wait 1;				
				player thread teleport(ammo_go);
			}
			else
			{
				player iprintln ("^2Sorry, maxammo");
				wait 1;
				player thread teleport(ammo_go);
			}
	}
}
