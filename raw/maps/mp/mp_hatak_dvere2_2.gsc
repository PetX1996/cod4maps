main() 
{ 
	thread slidedoor_slider_onlydouble (); 
	thread slidedoor_slider_onlydouble2 (); 
} 
 
slidedoor_slider_onlydouble() 
{ 
	prave = getent( "2prave", "targetname" ); 
        lave = getent( "2lave", "targetname" );
	trig = getent( "door2_trig_door", "targetname" ); 
 
	while(true) 
	{ 
		trig waittill ("trigger"); 
		prave movex ( -79, 2, 0.5, 0.5); 
		lave movex ( 79, 2, 0.5, 0.5);
                prave waittill ("movedone"); 
		wait 5; 
		prave movex ( 79, 2, 0.5, 0.5); 
		lave movex ( -79, 2, 0.5, 0.5);
		prave waittill ("movedone"); 
	} 
}

slidedoor_slider_onlydouble2() 
{ 
	prave2 = getent( "2prave2", "targetname" ); 
        lave2 = getent( "2lave2", "targetname" );
	trig2 = getent( "door2_trig_door2", "targetname" ); 
 
	while(true) 
	{ 
		trig2 waittill ("trigger"); 
		prave2 movex ( -79, 2, 0.5, 0.5); 
		lave2 movex ( 79, 2, 0.5, 0.5);
                prave2 waittill ("movedone"); 
		wait 5; 
		prave2 movex ( 79, 2, 0.5, 0.5); 
		lave2 movex ( -79, 2, 0.5, 0.5);
		prave2 waittill ("movedone"); 
	} 
}

