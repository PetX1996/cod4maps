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
// Mod      : Escape
// Website  : http://www.4gf.cz/
//I========================================================================I
// Script by: PetX
//I========================================================================I

#include plugins\_include;

/* 
I==============================================================================================I
Posunie brush/model/origin o urcitu dlzku, za urcity cas, urcitou rychlostou

Radiant
---------------
1. vytvorte trigger_multiple alebo trigger_use_touch a dajte mu nejaky targetname
2. vytvorte brush/model/origin/trigger, stlacte ESC, oznacte trigger a potom brush/model/origin/trigger a spojte pomocou W 

GSC mapy
---------------
Door(targetname, axis, s, t, time, text, done_text)

targetname(parameter 1 - povinne): 	zadajte string, targetname vasho aktivacneho triggeru, trigger môze byt typu multiple alebo use_touch
									s triggerom spojte brush/model/origin/trigger, ktory sa po aktivacii a ubehnutia casu zacne hybat

axis(parameter 2 - povinne):		zadajte os("X", "Y", "Z"), po ktorej sa bude objekt pohybovat

s(parameter 3 - povinne):			zadajte drahu, ktoru objekt pocas pohybu prejde

t(parameter 4 - povinne):			zadajte cas, za ktory objekt dononci pohyb									
									
time(parameter 5 - nepovinne): 		cas od aktivacie, za ktory sa brush/model/origin/trigger zacne pohybovat			 

text(parameter 6 - nepovinne): 		pri aktivacii vypise na obrazovku text
done_text(parameter 7 - nepovinne): pri dokonceni vypise na obrazovku text

preturn(parameter 8 - nepovinne):	true - pod dokoneni pohybu sa dvere vratia na pôvodnu pozíciu
pwait(parameter 9 - nepovinne):		cas, za ktory sa dvere vratia na pôvodnu poziciu

Vzor
---------------
thread plugins\_doors::Door("door_start", "X", 1500, 20, 5, "Start door open in 5 second.", "Door open!");

I==============================================================================================I
*/

Door(targetname, axis, s, t, time, text, done_text, preturn, pwait)
{
	if(!isdefined(targetname))
		return;
		
	brush = undefined;	
	ent = getent(targetname, "targetname");

	if(!isdefined(ent))
	{
		DebugOnSpawn("undefined object(trigger): "+targetname);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		DebugOnSpawn("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+targetname);
		return;
	}
	
	if(isdefined(ent.target))
	{
		brush = getent(ent.target, "targetname");
		
		if(!isdefined(brush))
		{
			DebugOnSpawn("undefined object(brush): "+targetname);
			return;			
		}
	}
	else
	{
		DebugOnSpawn("undefined object(brush): "+targetname);
		return;
	}	
	
	if(!isdefined(s))
	{
		DebugOnSpawn("undefined track, set to 100: "+targetname);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		DebugOnSpawn("undefined time(velocity), set to 10: "+targetname);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		DebugOnSpawn("undefined time to open, set to 0: "+targetname);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		DebugOnSpawn("undefined axis, set to X: "+targetname);
		axis = "X";
	}
	
	PluginInfo("Moving doors", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;

	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
		brush movex(s,t);
	else if(axis == "y")
		brush movey(s,t);
	else
		brush movez(s,t);
		
	if(isdefined(preturn) && preturn)
	{
		if(isdefined(pwait))
			wait pwait;
	
		if(axis == "x")
			brush movex(s*(-1),t);
		else if(axis == "y")
			brush movey(s*(-1),t);
		else
			brush movez(s*(-1),t);		
	}	
}

/* 
I==============================================================================================I
Posunutie dvoch brushov/modelov/originov smerom od seba, o urcitu dlzku, za urcity cas, urcitou rychlostou

Radiant
---------------
1. vytvorte trigger_multiple alebo trigger_use_touch a dajte mu nejaky targetname
2. vytvorte brush/model/origin/trigger, dajte mu nejaky targetname
3. vytvorte dalsi brush/model/origin/trigger, dajte mu nejaky targetname

GSC mapy
---------------
SlideDoors(trig, door1_t, door2_t, axis, s, t, time, text, done_text)

trig(parameter 1 - povinne): 		zadajte string, targetname vasho aktivacneho triggeru, trigger môze byt typu multiple alebo use_touch

door1_t(parameter 2 - povinne):		zadajte string, targetname vasho objektu, s ktorym chcete hybat(prve kridlo dveri)

door2_t(parameter 3 - povinne):		zadajte string, targetname vasho objektu, s ktorym chcete hybat(druhe kridlo dveri)

axis(parameter 4 - povinne):		zadajte os("X", "Y", "Z"), po ktorej sa bude objekt pohybovat

s(parameter 5 - povinne):			zadajte drahu, o ktoru sa objekt pohne

t(parameter 6 - povinne):			zadajte cas, za ktory objekt dononci pohyb									
									
time(parameter 7 - nepovinne): 		cas od aktivacie, za ktory sa brush/model/origin/trigger zacne pohybovat			 

text(parameter 8 - nepovinne): 		pri aktivacii vypise na obrazovku text
done_text(parameter 9 - nepovinne): pri dokonceni vypise na obrazovku text

preturn(parameter 10 - nepovinne):	true - pod dokoneni pohybu sa dvere vratia na pôvodnu pozíciu
pwait(parameter 11 - nepovinne):	cas, za ktory sa dvere vratia na pôvodnu poziciu

Vzor
---------------
thread plugins\_doors::SlideDoors("door_start", "X", 500, 12, 5, "Start door open in 5 second.", "Door open!");

I==============================================================================================I
*/

SlideDoors(trig, door1_t, door2_t, axis, s, t, time, text, done_text, preturn, pwait)
{
	if(!isdefined(trig))
		return;
		
	if(!isdefined(door1_t))
		return;
		
	if(!isdefined(door2_t))
		return;
		
	ent = getent(trig, "targetname");
	door1 = getent(door1_t, "targetname");
	door2 = getent(door2_t, "targetname");

	if(!isdefined(ent))
	{
		DebugOnSpawn("undefined object(trigger): "+trig);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		DebugOnSpawn("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+trig);
		return;
	}	
	
	if(!isdefined(door1))
	{
		DebugOnSpawn("undefined object(door1): "+door1_t);
		return;
	}		
	
	if(!isdefined(s))
	{
		DebugOnSpawn("undefined track, set to 100: "+trig);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		DebugOnSpawn("undefined time(velocity), set to 10: "+trig);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		DebugOnSpawn("undefined time to open, set to 0: "+trig);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		DebugOnSpawn("undefined axis, set to X: "+trig);
		axis = "X";
	}	
	
	PluginInfo("Moving slide doors", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;

	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
	{
		door1 movex(s,t);
		door2 movex(s*(-1),t);
	}	
	else if(axis == "y")
	{
		door1 movey(s,t);
		door2 movey(s*(-1),t);
	}	
	else
	{
		door1 movez(s,t);
		door2 movez(s*(-1),t);
	}
	
	if(isdefined(preturn) && preturn)
	{
		if(isdefined(pwait))
			wait pwait;
			
		if(axis == "x")
		{
			door1 movex(s*(-1),t);
			door2 movex(s,t);
		}	
		else if(axis == "y")
		{
			door1 movey(s*(-1),t);
			door2 movey(s,t);
		}	
		else
		{
			door1 movez(s*(-1),t);
			door2 movez(s,t);
		}		
	}
}

/* 
I==============================================================================================I
Otocenie brush/model/origin o urcity uhol, za urcity cas, urcitou rychlostou
2 brushe, otacaju sa smerom od seba  __ __  ==>  / \  ==>  |  |

Radiant
---------------
1. vytvorte trigger_multiple alebo trigger_use_touch a dajte mu nejaky targetname
2. vytvorte brush/model/origin/trigger, dajte mu nejaky targetname
3. vytvorte dalsi brush/model/origin/trigger, dajte mu nejaky targetname

GSC mapy
---------------
RotateDoubleDoors(trig, door1_t, door2_t, axis, s, t, time, text, done_text)

trig(parameter 1 - povinne): 		zadajte string, targetname vasho aktivacneho triggeru, trigger môze byt typu multiple alebo use_touch

door1_t(parameter 2 - povinne):		zadajte string, targetname vasho objektu, s ktorym chcete hybat(prve kridlo dveri)

door2_t(parameter 3 - povinne):		zadajte string, targetname vasho objektu, s ktorym chcete hybat(druhe kridlo dveri)

axis(parameter 4 - povinne):		zadajte os("X", "Y", "Z"), po ktorej sa bude objekt otacat

s(parameter 5 - povinne):			zadajte uhol, o ktory sa objekt otoci

t(parameter 6 - povinne):			zadajte cas, za ktory objekt dononci rotaciu									
									
time(parameter 7 - nepovinne): 		cas od aktivacie, za ktory sa brush/model/origin/trigger zacne otacat			 

text(parameter 8 - nepovinne): 		pri aktivacii vypise na obrazovku text
done_text(parameter 9 - nepovinne): pri dokonceni vypise na obrazovku text

Vzor
---------------
thread plugins\_doors::RotateDoubleDoors("door_start_trig", "door_start_a", "door_start_b", "X", 90, 20, 5, "Start door open in 5 second.", "Door open!");

I==============================================================================================I
*/

RotateDoubleDoors(trig, door1_t, door2_t, axis, s, t, time, text, done_text)
{
	if(!isdefined(trig))
		return;
		
	if(!isdefined(door1_t))
		return;
		
	if(!isdefined(door2_t))
		return;
		
	ent = getent(trig, "targetname");
	door1 = getent(door1_t, "targetname");
	door2 = getent(door2_t, "targetname");

	if(!isdefined(ent))
	{
		DebugOnSpawn("undefined object(trigger): "+trig);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		DebugOnSpawn("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+trig);
		return;
	}	
	
	if(!isdefined(door1))
	{
		DebugOnSpawn("undefined object(door1): "+door1_t);
		return;
	}		
	
	if(!isdefined(s))
	{
		DebugOnSpawn("undefined angle, set to 100: "+trig);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		DebugOnSpawn("undefined time(velocity), set to 10: "+trig);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		DebugOnSpawn("undefined time to open, set to 0: "+trig);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		DebugOnSpawn("undefined axis, set to X: "+trig);
		axis = "X";
	}	
	
	PluginInfo("Rotating double doors", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;
	
	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
	{
		door1 RotatePitch(s,t);
		door2 RotatePitch(s*(-1),t);
	}	
	else if(axis == "y")
	{
		door1 RotateRoll(s,t);
		door2 RotateRoll(s*(-1),t);
	}	
	else
	{
		door1 RotateYaw(s,t);
		door2 RotateYaw(s*(-1),t);
	}
}

/* 
I==============================================================================================I
Otocenie brush/model/origin o urcity uhol, za urcity cas, urcitou rychlostou

Radiant
---------------
1. vytvorte trigger_multiple alebo trigger_use_touch a dajte mu nejaky targetname
2. vytvorte brush/model/origin/trigger, stlacte ESC, oznacte trigger a potom brush/model/origin/trigger a spojte pomocou W 

GSC mapy
---------------
RotateDoor(targetname, axis, s, t, time, text, done_text)

targetname(parameter 1 - povinne): 	zadajte string, targetname vasho aktivacneho triggeru, trigger môze byt typu multiple alebo use_touch
									s triggerom spojte brush/model/origin/trigger, ktory sa po aktivacii a ubehnutia casu zacne hybat

axis(parameter 2 - povinne):		zadajte os("X", "Y", "Z"), po ktorej sa bude objekt otacat

s(parameter 3 - povinne):			zadajte uhol, o ktory sa objekt otoci

t(parameter 4 - povinne):			zadajte cas, za ktory objekt dononci rotaciu									
									
time(parameter 5 - nepovinne): 		cas od aktivacie, za ktory sa brush/model/origin/trigger zacne otacat			 

text(parameter 6 - nepovinne): 		pri aktivacii vypise na obrazovku text
done_text(parameter 7 - nepovinne): pri dokonceni vypise na obrazovku text

Vzor
---------------
thread plugins\_doors::RotateDoor("door_start", "X", 90, 20, 5, "Start door open in 5 second.", "Door open!");

I==============================================================================================I
*/

RotateDoor(targetname, axis, s, t, time, text, done_text)
{
	if(!isdefined(targetname))
		return;
		
	brush = undefined;	
	ent = getent(targetname, "targetname");

	if(!isdefined(ent))
	{
		DebugOnSpawn("undefined object(trigger): "+targetname);
		return;
	}	
	
	if(!(ent.classname == "trigger_multiple" || ent.classname == "trigger_use_touch"))
	{
		DebugOnSpawn("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+targetname);
		return;
	}
	
	if(isdefined(ent.target))
	{
		brush = getent(ent.target, "targetname");
		
		if(!isdefined(brush))
		{
			DebugOnSpawn("undefined object(brush): "+targetname);
			return;			
		}
	}
	else
	{
		DebugOnSpawn("undefined object(brush): "+targetname);
		return;
	}	
	
	if(!isdefined(s))
	{
		DebugOnSpawn("undefined angle, set to 100: "+targetname);
		s = 100;
	}
	
	if(!isdefined(t))
	{
		DebugOnSpawn("undefined time(velocity), set to 10: "+targetname);
		t = 10;
	}
	
	if(!isdefined(time))
	{
		DebugOnSpawn("undefined time to open, set to 0: "+targetname);
		time = 0;
	}
	
	if(!isdefined(axis))
	{
		DebugOnSpawn("undefined axis, set to X: "+targetname);
		axis = "X";
	}	
	
	PluginInfo("Rotating door", "PetX", "0.1");
	
	ent waittill("trigger");
	ent delete();
	if(isdefined(text))
		iprintlnbold(text);
	
	wait time;

	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	axis = ToLower( axis );
	if(axis == "x")
		brush RotatePitch(s,t);	
	else if(axis == "y")
		brush RotateRoll(s,t);	
	else
		brush RotateYaw(s,t);
}
