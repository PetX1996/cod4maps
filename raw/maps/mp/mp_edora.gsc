main()
{
	precacheModel("4gf_laser_emitor");
	precacheModel("body_mp_usmc_engineer");
	level._effect[ "laser" ] = loadfx( "misc/laser" );

	maps\mp\_load::main();
	//maps\mp\_rings::main();
	//maps\mp\rings::main();

	    //thread door();
	    //thread use();	
		//thread models_print();
		thread vektory();
		//thread init_po();
	
	
        ambientPlay("ambient_backlot_ext");
	
	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "1" );
	
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");	
}

door()
{
	trig = getentarray( "door_trig", "targetname" );
	door1 = getentarray( "door1", "targetname" );
	door2 = getentarray( "door2", "targetname" );	
	
	if(isdefined(trig) && isdefined(door1) && isdefined(door2) && door1.size == door2.size && door1.size == trig.size)
	{
		for( i = 0; i < trig.size; i++ )
		{
			trig[i] Precache_door(door1[i], door2[i]);
			trig[i] thread door_move();
		}	
	}
	else
		thread log_on_spawn("return, undefined trig/door/bad size");

}

Precache_door(door1, door2)
{	
	self.door1 = door1;
	self.door2 = door2;
	
	if(!isdefined(self.script_noteworthy) || (self.script_noteworthy != "x" && self.script_noteworthy != "y"))
	{
		self.script_noteworthy = "x";
		thread log_on_spawn("axis set to X");
	}
	
	if (!isdefined(self.door1.count))
	{
		self.door1.count = 100;
		thread log_on_spawn("distance set to 100");
	}
	
	if (!isdefined(self.door2.count))
	{
		self.door2.count = 100;
		thread log_on_spawn("distance set to 100");
	}	
	
	self.axis = self.script_noteworthy;
	
	self.startorigin = [];
	self.endorigin = [];
	
	self.startorigin[1] = self.door1.origin;
	self.startorigin[2] = self.door2.origin;
	
	addorigin = 100;
	
	if(self.axis == "x")
		self.endorigin[1] = self.door1.origin + (self.door1.count , 0, 0);
	if(self.axis == "y")
		self.endorigin[1] = self.door1.origin + (0, self.door1.count, 0);
	
	if(self.axis == "x")
		self.endorigin[2] = self.door2.origin + (self.door2.count , 0, 0);
	if(self.axis == "y")
		self.endorigin[2] = self.door2.origin + (0, self.door2.count, 0);
}

door_move()
{
	while(1)
	{
		players = getentarray("player","classname");
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(isdefined(player) && isplayer(player) && isalive(player) && player IsTouching(self))
			{
				if(self.door1.origin != self.endorigin[1] && self.door2.origin != self.endorigin[2]) //otvorenie
				{
					self.door1 moveto(self.endorigin[1], distance(self.door1.origin,self.endorigin[1])/40);
					self.door2 moveto(self.endorigin[2], distance(self.door2.origin,self.endorigin[2])/40);
				}			
			}
			else
			{
				if(self.door1.origin != self.startorigin[1] && self.door2.origin != self.startorigin[2]) //zavretie
				{
					self.door1 moveto(self.startorigin[1], distance(self.door1.origin,self.startorigin[1])/40);
					self.door2 moveto(self.startorigin[2], distance(self.door2.origin,self.startorigin[2])/40);					
				}
			}
		}
		wait 1;
	}
}

log_on_spawn(text)
{
	level waittill("connected", player);
	player waittill("spawned");
	
	player iprintln("DEBUG: "+text);
}

use()
{
	brush = [];
	
	for(i = 0;i < 2;i++)
	{	
		brush[i] = getent("brush_"+i , "targetname");
		brush[i] thread move_dinosaur();
	}
}

move_dinosaur()
{
	ent = [];
	i = 1;
	ent[0] = self;
	
	//log_on_spawn("start funkcion");
	for(;;)
	{
		next = getent( ent[i-1].target , "targetname" );
		
		if(isdefined(next) && next != self)
		{
			ent[i] = next;
		}	
		else
		{
			break;
		}
		i++;
	}
	
	//log_on_spawn("for1 done");
	origin = [];
	angles = [];
	
	for(j = 0; j < i; j++)
	{
		origin[j] = ent[j].origin;
		angles[j] = ent[j].angles;
	}
	//log_on_spawn("for2 done");
	max = i;
	
	while(1)
	{
		for(i = 0;i<max;i++)
		{
			dis = distance(self.origin,origin[i]);
			iprintln("dis: "+dis );
			self moveto(origin[i], 5);
			self waittill("movedone");
			self RotateTo(angles[i], 1);
		}
		//log_on_spawn("for3 done");
	}
}


maxlvl()
{
	use = getent( "use", "targetname" );
	
	use waittill("trigger",player);
	
	player iprintln ("debug: USE");

	maxlvl = 20;
	for (i = 0;i<maxlvl;i++)
	{	
		self maps\mp\gametypes\_persistence::statSet( "plevel", 1 );
		self maps\mp\gametypes\_persistence::statSet( "rank", 1 );
	}
	use waittill("trigger",player);
	self maps\mp\gametypes\_persistence::statSet( "rank", 1 );
}

test()
{
	use = getent( "use", "targetname" );
	
	use waittill("trigger",player);
	
	player iprintln ("debug: USE");
	wait 1;
	health = player.health;
	player iprintln ("oldhealth_"+health);
	
	while(1)
	{
	health -= 5;
    player setnormalhealth (health);
	wait 1;
	player iprintln ("health_"+health);	
	}
}

schovka()
{
	use = getent( "use", "targetname" );
	objekt = getent( "objekt", "targetname" );
	
	use waittill("trigger",player);
	
	wait 2;
	
	objekt hide();
	
	use waittill("trigger",player);
	
	wait 2;
	
	objekt show();

}

/*models_print()
{
	wait 15;
	return;

	models = getentarray();
	iprintln("start "+models.size);
	
	for(i = 0;i < models.size;i++)
	{
		if(!isdefined(models[i].model))
			continue;
			
		iprintln("M: "+models[i].model);	
		wait 0.1;
	}
	
	brush = spawn("script_brushmodel", (0,0,0), 50, 50);
	
}*/

vektory()
{
	level waittill("connected",player);
	player waittill("spawned");

	thread pacman_move(player,player);
}

pacman_move(position,player)
{
	wait 5;
	final = (0,0,0);
	
	pacman = spawn("script_model", position.origin);
    pacman setModel("4gf_laser_emitor");
	pacman.angles = (270,0,0);
	pacman.radius = 300;
	PlayFXontag( level._effect[ "laser" ], pacman, "tag_fx" );
	wait 1;
	PlayFXontag( level._effect[ "laser" ], pacman, "tag_fx" );
	
	thread pacman_rotate(pacman,player);
	
	while(1)
	{
		wait 0.5;
		
		height = player geteye();
		dist = distance(pacman.origin,player.origin);

		trace = bullettrace(pacman.origin, height, false, pacman);
		
		vec1 = vectorNormalize((height[0],height[1],0)-(pacman.origin[0],pacman.origin[1],0));
		ang1 = VectorToAngles(vec1);
		leght = (anglesToForward(ang1)*dist)+(pacman.origin[0],pacman.origin[1],0);
		newtrace = bullettrace(pacman.origin, pacman.origin+(0,0,-10000), false, pacman);
		final = leght+(0,0,trace["position"][2]+60);
		pacman moveto(final,4);
	}
	
}

pacman_rotate(pacman,target)
{
	while(1)
	{
		height = target geteye();
		angles = VectorToAngles(vectorNormalize(height-pacman.origin));
		pacman RotateTo(angles,1);	
		wait 1;
	}
}

init_po()
{
thread Trap1();
thread Trap2();
thread Trap3();
thread Trap4();
thread Open();
thread End();
}

Trap1()
{
Trap1=getent("trap1","targetname");
trigger=getent("trigtrap1","targetname");
while(1)
{
trigger waittill ("trigger");
wait (1);
Trap1 movex (22000,4,1,2);
Trap1 waittill ("movedone");
}
}

Trap2()
{
Trap2=getent("trap2","targetname");
trigger=getent("trigtrap2","targetname");
while(1)
{
trigger waittill ("trigger");
wait (1);
Trap2 movez (-60,4,1,2);
Trap2 waittill ("movedone");
}
}

Trap3()
{
Trap3=getent("trap3","targetname");
trigger=getent("trigtrap3","targetname");
while(1)
{
trigger waittill ("trigger");
wait (1);
Trap3 movey (316,4,1,2);
Trap3 waittill ("movedone");
wait (10);
Trap3 movey (-316,4,1,2);
Trap3 waittill ("movedone");
wait (60);
}
}

Trap4()
{
Trap4=getent("trap4","targetname");
trigger=getent("trigtrap4","targetname");
while(1)
{
trigger waittill ("trigger");
wait (1);
Trap4 movez (250,4,1,2);
Trap4 waittill ("movedone");
}
}

Open()
{
Open=getent("open","targetname");
trigger=getent("trigopen","targetname");
while(1)
{
trigger waittill ("trigger");
wait (1);
Open movez (250,4,1,2);
Open waittill ("movedone");
}
}

End()
{
end=getent("end","targetname");
while(1)
{
wait (10);
end movex (22000,4,1,2);
end waittill ("movedone");
}
}

hledac()
{
	level waittill("connected",player);
	player waittill("spawned");

	entity = getentarray("hladana_entita","targetname");
	
	if(!isdefined(entity) || entity.size == 0)
		return;
	
	for(i = 0;i < entity.size;i++)
	{
		iprintln("Origin: "+entity[i].origin);
	}
}