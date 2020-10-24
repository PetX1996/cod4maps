main() 
{ 
	thread diaglift_slider (); 
} 

diaglift_slider() 
{ 
	diaglift=getent( "diaglift", "targetname" ); 
	trig = getent( "switch", "targetname" ); 
	
	while(true) 
	{ 
		trig waittill ("trigger"); 
		diaglift moveto ((-40,764,48),6,2,2); 
		diaglift waittill ("movedone"); 
		wait (1); 
		trig waittill ("trigger"); 
		diaglift moveto ((-163,764,48),6,2,2); 
		diaglift waittill ("movedone"); 
		
	}
}
