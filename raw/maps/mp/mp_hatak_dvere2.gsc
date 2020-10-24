main() 
{ 
	thread slidedoor_slider_onlydouble (); 
	thread slidedoor_slider_onlydouble2 (); 
	thread slidedoor_slider_onlydouble3 (); 
} 
 
slidedoor_slider_onlydouble() 
{ 
	prave = getent( "prave", "targetname" ); 
        lave = getent( "lave", "targetname" );
	trig = getent( "door_trig_door", "targetname" ); 
 
	while(true) 
	{ 
		trig waittill ("trigger"); 
		prave movex ( 79, 2, 0.5, 0.5); 
		lave movex ( -79, 2, 0.5, 0.5);
                prave waittill ("movedone"); 
		wait 5; 
		prave movex ( -79, 2, 0.5, 0.5); 
		lave movex ( 79, 2, 0.5, 0.5);
		prave waittill ("movedone"); 
	} 
}

slidedoor_slider_onlydouble2() 
{ 
	prave2 = getent( "prave2", "targetname" ); 
        lave2 = getent( "lave2", "targetname" );
	trig2 = getent( "door_trig_door2", "targetname" ); 
 
	while(true) 
	{ 
		trig2 waittill ("trigger"); 
		prave2 movex ( 79, 2, 0.5, 0.5); 
		lave2 movex ( -79, 2, 0.5, 0.5);
                prave2 waittill ("movedone"); 
		wait 5; 
		prave2 movex ( -79, 2, 0.5, 0.5); 
		lave2 movex ( 79, 2, 0.5, 0.5);
		prave2 waittill ("movedone"); 
	} 
}

slidedoor_slider_onlydouble3() 
{ 
	prave3 = getent( "prave3", "targetname" ); 
        lave3 = getent( "lave3", "targetname" );
	trig3 = getent( "door_trig_door3", "targetname" ); 
 
	while(true) 
	{ 
		trig3 waittill ("trigger"); 
		prave3 movex ( -79, 2, 0.5, 0.5); 
		lave3 movex ( 79, 2, 0.5, 0.5);
                prave3 waittill ("movedone"); 
		wait 5; 
		prave3 movex ( 79, 2, 0.5, 0.5); 
		lave3 movex ( -79, 2, 0.5, 0.5);
		prave3 waittill ("movedone"); 
	} 
}