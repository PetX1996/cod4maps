main()
{
  level._effect[ "smoke" ] = loadfx( "smoke/player_smoke" );

  level.active = false;
  thread priprava();
  thread syr();
  thread SetRightButton();
}

syr()
{
	syr = getent("syr1","targetname");

	while(1)
	{
		syr waittill ("trigger", player);
		player notify ("syr");

			if (player.health < player.maxhealth)
			{
				player.health = player.maxhealth;
				player iprintln ("^1Health restored");
			}
			else
			{
				player iprintln ("^1Sorry, maxhealth");
			}
	}
}

priprava()
{
 door =getent ("t1_door","targetname");
 t1 = getent("t1","targetname"); 
 
 door movey(220,0.5);

 t1 waittill ("trigger");
 t1 delete();

 level.active = true;

 door movey(-220,2);
}

SetRightButton()
{
 rightbut=RandomIntRange(0,4);
 for(i=0; i<4; i++) 
 {
  thread WaitforInput(i,rightbut);
 }

}

WaitforInput(i,rightbut)
{
 trig=getent ("otrava_trig_"+i,"targetname");
 while (1)
 {
 trig waittill("trigger", player);
 if (i==rightbut)
    {
     thread OpenGate(i,trig);
    }
 else
    {
    player thread KillPlayer(i,trig); 
    }
 }

}

KillPlayer(i,trig)
{
 otrava = getent("otrava_"+i,"targetname");
 player = getent("otrava_player_"+i,"targetname");
 trig delete();
 otrava delete();
 player NotSolid();
 wait 1.5;
 if (level.active == true)
	self thread killer();
}
OpenGate(i,trig)
{
player = getent("otrava_player_"+i,"targetname");
otrava = getent("otrava_"+i,"targetname");
player NotSolid();
otrava delete();
trig delete();
}

killer()
{
	self endon("death");
	self endon("disconnect");
	self endon ("syr");

	range = 1;
	maxdamage = 10;
	mindamage = 5;

	while(1)
	{
		playFx(level._effect[ "smoke" ], self.origin);
		origin = self getorigin();
		radiusDamage(origin, range, maxdamage, mindamage);
		wait 0.5;
	}
}