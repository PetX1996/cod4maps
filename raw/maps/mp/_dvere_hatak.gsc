/*
//    +========================================================================+
//    I                    ___  _____  _____                                   I
//    I                   /   !!  __ \!  ___!                                  I
//    I                  / /! !! !  \/! !_          ___  ____                  I
//    I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//    I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//    I                     !_/ \____/\_!     (_)  \___!/___!                  I
//    I========================================================================I
//    I                          univerzalne dvere                             I
//    I========================================================================I
//    I                           scripted: PetX                               I
//    I                         website: www.4GF.cz                            I
//    +========================================================================+
*/

main()
{
thread trig_main();
} 

trig_main()
{
	trig = getentarray( "door_trig", "targetname" );
	door1 = getentarray( "door1", "targetname" );
	door2 = getentarray( "door2", "targetname" );

	if(isdefined(trig))
	{
		for (i=0;i<trig.size;i++)
		{
			trig[i] thread door_move(door1[i], door2[i]);
		}
	}
}

/*
door(trig)
{
for (j=0;j<trig.size;j++)
{
door1 = getent( "door1_"+j, "targetname" );
door2 = getent( "door2_"+j, "targetname" );

self thread door_move(door1,door2,i);
}
}
*/

door_move(door1, door2)
{

self waittill("trigger");

	if (!isdefined(self.script_noteworthy) || (self.script_noteworthy != "x" && self.script_noteworthy != "y" && self.script_noteworthy != "z"))
    {
	self.script_noteworthy = "x";
	iprintln("error: defined x");
	}

	if (!isdefined(self.count))
    {
	draha = 100;
	iprintln("error: defined draha:"+draha);
    }	
	
draha = self.count;
cas = 5;
acc = cas/2;
dcc = cas/2;

self.doorfinish_y = false;
self.doorfinish_x = false;
self.doorfinish_z = false;

    if (self.script_noteworthy == "y") //osa Y
	{
	while(true)
	{
    if (self.doorfinish_y == false)
	{
	self waittill ("trigger");
	self.doorfinish_y = true;
	self.doormoving_y = true;
	
	self thread door_moving_y(draha,cas,door1,door2,acc,dcc);
	}
	wait 0.1;
	}
	}
	
    if (self.script_noteworthy == "x") //osa X
	{
	while(true)
	{
    if (self.doorfinish_x == false)
	{
	self waittill ("trigger");
	self.doorfinish_x = true;
	self.doormoving_x = true;
	
	self thread door_moving_x(draha,cas,door1,door2,acc,dcc);
	}
	wait 0.1;
	}
	}
	
    if (self.script_noteworthy == "z") //osa Z
	{
	while(true)
	{
    if (self.doorfinish_z == false)
	{
	self waittill ("trigger");
	self.doorfinish_z = true;
	self.doormoving_z = true;
	
	self thread door_moving_z(draha,cas,door1,door2,acc,dcc);
	}
	wait 0.1;
	}
	}
}

door_moving_y(draha,cas,door1,door2,acc,dcc)
{
	while (1)
	{
		players = getentarray( "player", "classname" );

		for(i=0;i<players.size;i++)
		{
			if( isPlayer(players[i]) && isAlive(players[i]) && self.doorfinish_y == true)
			{
				if (self.doormoving_y == true)
				{
					iprintln("pohyb po y");
					door1 movey ( draha, cas, acc, dcc);
					door2 movey ( (-1)*draha, cas, acc, dcc);
					door1 waittill ("movedone");
					self.doormoving_y = false;
				}
				
				if ( !(players[i] IsTouching(self)) )
				{
					door1 movey ( (-1)*draha, cas, acc, dcc);
					door2 movey ( draha, cas, acc, dcc);
					door1 waittill ("movedone");
					self.doorfinish_y = false;
				}		
			}
		}
		wait 0.1;
	}
}

door_moving_x(draha,cas,door1,door2,acc,dcc)
{
while (1)
{
	players = getentarray( "player", "classname" );

	for(i=0;i<players.size;i++)
	{
		if( isPlayer(players[i]) && isAlive(players[i]))
		{
			if (self.doorfinish_x == true)
			{
				if (self.doormoving_x == true)
				{
				iprintln("pohyb po x");
				door1 movex ( draha, cas, acc, dcc);
				door2 movex ( (-1)*draha, cas, acc, dcc);
				door1 waittill ("movedone");
				self.doormoving_x = false;
				}
				
					if ( !(players[i] IsTouching(self)) )
					{
					door1 movex ( (-1)*draha, cas, acc, dcc);
					door2 movex ( draha, cas, acc, dcc);
					door1 waittill ("movedone");
					self.doorfinish_x = false;
					}		
			}
		}
	}
wait 0.1;
}
}

door_moving_z(draha,cas,door1,door2,acc,dcc)
{
while (1)
{
	players = getentarray( "player", "classname" );

	for(i=0;i<players.size;i++)
	{
		if( isPlayer(players[i]) && isAlive(players[i]))
		{
			if (self.doorfinish_z == true)
			{
				if (self.doormoving_z == true)
				{
				iprintln("pohyb po z");
				door1 movez ( draha, cas, acc, dcc);
				door2 movez ( (-1)*draha, cas, acc, dcc);
				door1 waittill ("movedone");
				self.doormoving_z = false;
				}
				
					if ( !(players[i] IsTouching(self)) )
					{
					door1 movez ( (-1)*draha, cas, acc, dcc);
					door2 movez ( draha, cas, acc, dcc);
					door1 waittill ("movedone");
					self.doorfinish_z = false;
					}		
			}
		}
	}
wait 0.1;
}
}