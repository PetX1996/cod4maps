main() 
{ 
	thread slidedoor_slider_onlydouble (); 
	thread slidedoor_slider_onlydouble2 (); 
	thread slidedoor_slider (); 
	thread slidedoor_slider2 (); 

} 
 
slidedoor_slider_onlydouble() 
{ 
	prave = getent( "dvere_easy_x_p_6", "targetname" ); 
        lave = getent( "dvere_easy_x_l_6" , "targetname" );
	trig = getent( "dvere_6", "targetname" ); 
 
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
	prave = getent( "dvere_easy_x_p_7", "targetname" ); 
        lave = getent( "dvere_easy_x_l_7" , "targetname" );
	trig = getent( "dvere_7", "targetname" ); 
 
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

slidedoor_slider() 
{ 
	prave = getent( "dvere_x_p_5", "targetname" ); 
        lave = getent( "dvere_x_l_5", "targetname" );
	trig = getent( "dvere_5", "targetname" ); 
 
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

slidedoor_slider2() 
{ 
	prave = getent( "dvere_y_p_4", "targetname" ); 
        lave = getent( "dvere_y_l_4", "targetname" );
	trig = getent( "dvere_4", "targetname" );  
 
	while(true) 
	{ 
		trig waittill ("trigger"); 
		prave movey ( -79, 2, 0.5, 0.5); 
		lave movey ( 79, 2, 0.5, 0.5);
                prave waittill ("movedone"); 
		wait 5; 
		prave movey ( 79, 2, 0.5, 0.5); 
		lave movey ( -79, 2, 0.5, 0.5);
		prave waittill ("movedone"); 
	} 
}