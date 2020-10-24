door() 
{ 
        prave = getent( "pravedvere", "targetname" );
        lave = getent( "lavedvere", "targetname" );
	trig = getent( "door_trig", "targetname" ); 
 
	while(true) 
	{ 
		trig waittill ("trigger"); 
		prave movey ( -75, 2, 0.5, 0.5);
		lave movey ( 75, 2, 0.5, 0.5);
                prave waittill ("movedone"); 
		wait 5;
		prave movey ( 75, 2, 0.5, 0.5);
		lave movey ( -75, 2, 0.5, 0.5);
		prave waittill ("movedone"); 
	} 
}

