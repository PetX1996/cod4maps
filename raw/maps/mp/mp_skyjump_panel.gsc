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
		diaglift moveto ((-1760,2912,1016),6,2,2); 
		diaglift waittill ("movedone"); 
		wait (1); 
		trig waittill ("trigger"); 
		diaglift moveto ((-1760,800,1016),6,2,2); 
		diaglift waittill ("movedone"); 
		
	}
}