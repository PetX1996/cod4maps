/*
//    +========================================================================+
//    I                    ___  _____  _____                                   I
//    I                   /   !!  __ \!  ___!                                  I
//    I                  / /! !! !  \/! !_          ___  ____                  I
//    I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//    I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//    I                     !_/ \____/\_!     (_)  \___!/___!                  I
//    I========================================================================I
//    I                      random pad move generator                         I
//    I========================================================================I
//    I                       scripted:  mnaauuu@4gf.cz                        I
//    I                         website: www.4GF.cz                            I
//    +========================================================================+
*/

main()
{
	for(i=1;i < 37; i++) {
		thread padr(i);
	}
}
//padr_1  script_brushmodel  cisla 1 az 36
//pohyb nahoru a dolu reset ve stredu random vyska +200 -200 rychlost tak 2 az 5 wait 1 az 5



padr(index) {
	ent = getEnt("padr_" + index, "targetname");
	origin = ent.origin;
	
	while(true) {
		//hore
		z = RandomIntRange(10,200);
	
		ent movez(z, z/100, z/500,z/500); // posun hore
		wait(RandomIntRange(1,5) + (z/100) + (z/250));
		
		ent movez((0-z), z/100,z/500,z/500); // zarovnanie na nulu
		
		//central
		wait (0.5 + (z/100) + (z/250));
		
		//dole
		z = RandomIntRange(10,200);
		
		ent movez((0-z), z/100,z/500,z/500); // posun dole
		wait(RandomIntRange(1,5) + (z/100) + (z/250));
		
		ent movez(z, z/100,z/500,z/500); // zarovnanie na nulu
		wait(RandomIntRange(1,5) + (z/100) + (z/250));
		
		// zarovnanie
		ent.origin = origin;
		
	}
}