main() 
{ 
	thread slidedoor_slider1 (); 
	thread slidedoor_slider2 (); 
	thread slidedoor_slider3 (); 
	thread slidedoor_slider4 (); 
} 
 
slidedoor_slider1() 
{ 
	horne = getent( "2hornedvere", "targetname" ); 
        dolne = getent( "2dolnedvere", "targetname" );
        prave = getent( "2pravedvere", "targetname" );
        lave = getent( "2lavedvere", "targetname" );
	trig = getent( "door2_trig", "targetname" ); 
 
	while(true) 
	{ 
		trig waittill ("trigger"); 
		horne movez ( 83, 1, 0.4, 0.4); 
                dolne movez ( -46, 1, 0.4, 0.4);
		prave movey ( 75, 2, 0.5, 0.5);
		lave movey ( -75, 2, 0.5, 0.5);
                horne waittill ("movedone"); 
		wait 5;
		horne movez ( -83, 2, 0.5, 0.5); 
                dolne movez ( 46, 2, 0.5, 0.5);
		prave movey ( -75, 2, 0.5, 0.5);
		lave movey ( 75, 2, 0.5, 0.5);
		horne waittill ("movedone"); 
	} 
}

slidedoor_slider2() 
{ 
	horne2 = getent( "2hornedvere2", "targetname" ); 
        dolne2 = getent( "2dolnedvere2", "targetname" );
        prave2 = getent( "2pravedvere2", "targetname" );
        lave2 = getent( "2lavedvere2", "targetname" );
	trig2 = getent( "door2_trig2", "targetname" ); 
 
	while(true) 
	{ 
		trig2 waittill ("trigger"); 
		horne2 movez ( 83, 1, 0.4, 0.4);
                dolne2 movez ( -46, 1, 0.4, 0.4);
		prave2 movex ( -75, 2, 0.5, 0.5);
		lave2 movex ( 75, 2, 0.5, 0.5);
                horne2 waittill ("movedone"); 
		wait 5; 
		horne2 movez ( -83, 2, 0.5, 0.5); 
                dolne2 movez ( 46, 2, 0.5, 0.5);
		prave2 movex ( 75, 2, 0.5, 0.5);
		lave2 movex ( -75, 2, 0.5, 0.5);
		horne2 waittill ("movedone"); 
	} 
}

slidedoor_slider3() 
{ 
	horne3 = getent( "2hornedvere3", "targetname" ); 
        dolne3 = getent( "2dolnedvere3", "targetname" );
        prave3 = getent( "2pravedvere3", "targetname" );
        lave3 = getent( "2lavedvere3", "targetname" );
	trig3 = getent( "door2_trig3", "targetname" ); 
 
	while(true) 
	{ 
		trig3 waittill ("trigger"); 
		horne3 movez ( 83, 1, 0.4, 0.4);
                dolne3 movez ( -46, 1, 0.4, 0.4);
		prave3 movey ( 75, 2, 0.5, 0.5);
		lave3 movey ( -75, 2, 0.5, 0.5);
                horne3 waittill ("movedone"); 
		wait 5; 
		horne3 movez ( -83, 2, 0.5, 0.5); 
                dolne3 movez ( 46, 2, 0.5, 0.5);
		prave3 movey ( -75, 2, 0.5, 0.5);
		lave3 movey ( 75, 2, 0.5, 0.5);
		horne3 waittill ("movedone"); 
	} 
}

slidedoor_slider4() 
{ 
	horne4 = getent( "2hornedvere4", "targetname" ); 
        dolne4 = getent( "2dolnedvere4", "targetname" );
        prave4 = getent( "2pravedvere4", "targetname" );
        lave4 = getent( "2lavedvere4", "targetname" );
	trig4 = getent( "door2_trig4", "targetname" ); 
 
	while(true) 
	{ 
		trig4 waittill ("trigger"); 
		horne4 movez ( 83, 1, 0.4, 0.4);
                dolne4 movez ( -46, 1, 0.4, 0.4);
		prave4 movey ( 75, 2, 0.5, 0.5);
		lave4 movey ( -75, 2, 0.5, 0.5);
                horne4 waittill ("movedone"); 
		wait 5; 
		horne4 movez ( -83, 2, 0.5, 0.5); 
                dolne4 movez ( 46, 2, 0.5, 0.5);
		prave4 movey ( -75, 2, 0.5, 0.5);
		lave4 movey ( 75, 2, 0.5, 0.5);
		horne4 waittill ("movedone"); 
	} 
}

