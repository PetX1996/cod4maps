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
Pohybuje s modelom/brushom/originom po vami vytvorenej trajektorii z originov
zaroven je mozne na tento objekt nalinkovat dalsie(na model brush, na brush dalsi brush, ...)

Radiant
---------------
1. vytvorte trigger_multiple alebo trigger_use_touch a dajte mu nejaky targetname
2. vytvorte brush/model/origin, môzte ich vytvorit viacero, ale vsetci musia mat rovnaky targetname
   (ako zaklady objekt, na ktory sa nalinkuju ostatne sa vzdy vyberie prvy vytvoreny, ak je medzi objektami model, tak prvy model)
3. vytvorte script_origin, stlacte ESC, oznacte jeden z vytvorenych brushov/modelov/origin a nasledne spojte s script_origin pomocou W
4. ak chcete objekt pocas pohybu otacat, urcte uhly tohto originu(v entity okne, alebo otacanim(R))
5. ak sa ma objekt pohybovat dalej, vytvorte dalsi script_origin a spojte ho s predchadzajucim, taktiez môzte urcit uhol, kam sa ma objekt natocit
6. pocet originov nieje limitovany

GSC mapy
---------------
MovingAndRotate(targetname, brush, v, time, text, done_text)

targetname(parameter 1 - povinne): 	zadajte string, targetname vasho aktivacneho triggeru, trigger môze byt typu multiple alebo use_touch

brush(parameter 2 - povinne):		zadajte string, targetname vasich brushov/modelov/originov...

v(parameter 3 - povinne):			zadajte rychlost pohybu(v palcoch za sekundu)

time(parameter 4 - nepovinne): 		cas od aktivacie, za ktory sa brush/model/origin/trigger zacne pohybovat				 

text(parameter 5 - nepovinne): 		pri aktivacii vypise na obrazovku text
done_text(parameter 6 - nepovinne): pri dokonceni vypise na obrazovku text

Vzor
---------------
thread plugins\_moving::MovingAndRotate("trap1_trig", "trap1_model", 500, 20, "start in 20 second", "start!");


UPDATE: pozit iba jeden script_brushmodel! pocet modelov nieje limitovany...
I==============================================================================================I
*/

MovingAndRotate(targetname, brush, v, time, text, done_text)
{
	if(!isdefined(targetname))
		return;
	
	trig = getent(targetname, "targetname");

	if(!isdefined(trig))
	{
		DebugOnSpawn("undefined object(trigger): "+targetname);
		return;
	}	
	
	if(!(trig.classname == "trigger_multiple" || trig.classname == "trigger_use_touch"))
	{
		DebugOnSpawn("trigger must be type ^1trigger_multiple ^7or ^1trigger_use_touch: "+targetname);
		return;
	}
	
	if(!isdefined(brush))
	{
		DebugOnSpawn("undefined object(brush): "+targetname);
		return;
	}	
	
	if(!isdefined(v))
	{
		DebugOnSpawn("undefined velocity, set to 100: "+targetname);
		v = 100;
	}
	
	/*if(!isdefined(time))
	{
		DebugOnSpawn("undefined time to open, set to 0: "+targetname);
		time = 0;
	}*/
	
	entity = getentarray(brush, "targetname");
	
	if(!isdefined(entity) || !entity.size)
	{
		DebugOnSpawn("undefined object(brush): "+targetname);
		return;
	}		
	
	PluginInfo("Universal Moving System", "PetX", "0.2");
	
	for(i = 0;i < entity.size;i++)
	{
		if(isdefined(entity[i].target))
			brush = entity[i];
		else
			brush = entity[0];
	}

	linkent = entity[0];
	
	for(i = 0;i < entity.size;i++)
	{
		if(entity[i].classname == "script_brushmodel")
			linkent = entity[i];
	}
	
	for(i = 0;i < entity.size;i++)
	{
		if(linkent == entity[i])
			continue;
			
		//entity[i] enablelinkto();
		entity[i] linkto(linkent);
	}
	
	orig = [];
	ent = brush;	
	
	for(;;)
	{
		if(!isdefined(ent.target))
			break;
			
		ent = getent(ent.target, "targetname");
		
		if(!isdefined(ent))
			break;
			
		orig[orig.size] = ent;
		wait 0.01;		
	}
	
	trig waittill("trigger");
	trig delete();
	
	if(isdefined(text))
		iprintlnbold(text);
		
	wait time;
	
	if(isdefined(done_text))
		iprintlnbold(done_text);
	
	for(i = 0;i < orig.size;i++)
	{
		if(isdefined(orig[i].angles))
			angles = orig[i].angles;
		else
			angles = linkent.angles;
		
		t = distance(linkent.origin, orig[i].origin)/v;
		
		linkent moveto(orig[i].origin, t);
		wait (t/4)*3;
		linkent rotateto(angles, (t/3));
		linkent waittill("movedone");
		
		orig[i] delete();
	}
	
	for(i = 0;i < entity.size;i++)
	{
		if(linkent == entity[i])
			continue;
			
		//entity[i] enablelinkto();
		entity[i] unlink();
	}
}