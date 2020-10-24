/*
//    +========================================================================+
//    I                    ___  _____  _____                                   I
//    I                   /   !!  __ \!  ___!                                  I
//    I                  / /! !! !  \/! !_          ___  ____                  I
//    I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//    I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//    I                     !_/ \____/\_!     (_)  \___!/___!                  I
//    I========================================================================I
//    I                    random lightning trap generator                     I
//    I========================================================================I
//    I                       scripted:  mnaauuu@4gf.cz                        I
//    I                         website: www.4GF.cz                            I
//    +========================================================================+
*/

#include common_scripts\utility;

main()
{
	thread blesky();
}
//tblesky1 aktivacni triger
//blesky_1  cislo 1 az 16 script_struct pro efekty efekt: blesky1
//bleskyd_1  cislo 1 az 16 zabijeci trigery
//aktivace vsech po 3 sec off pak random po jednom po 3 sec


blesky() {
	trig = getent( "trap2" , "targetname" ) ;
	trig waittill("trigger", player );
	
	maps\mp\mp_deathrun_zero\coins::AddCoin( 2, level.coinPrice );
	
	b = [];
	for (i=0; i<8; i++) {
		while(true) {
			x = RandomIntRange(1,16);
			
			f = false;
			for(j=0;j<b.size;j++) {
				if (b[j] == x) {
					f = true;
					break;
				}
			}
			
			if (!f) {
				b[b.size] = x;
				break;
			}
			wait 0.02;
		}
	}
	
	for(i=1;i<b.size;i++) {
		thread blesk(b[i]);
	}
	
	wait 3;
	while(true) {
		thread blesk(RandomIntRange(1,16));
		wait 3;
	}
}

blesk(index) {
	level endon("blesk_" + index); // timeout pre kill trigger
	
	level thread timeout_blesk(index); // timeout pre killt rigger
	
	b = getstructarray ( "blesky_"  + index, "targetname" );
	t = getent ( "bleskyd_" + index, "targetname" );
	
	
	playFx(level._effect[ "blesky1" ], b[0].origin); // urob efekt
	t playsound("blesky"); // zvuk z kill triggra
	
	// kill trigger
	while(true) {
		t waittill( "trigger", player );
		
		if ( isPlayer(player) && isAlive(player) ) {
			player suicide();
		}
		
	}
}

// zrus killtriger po X sekundach
timeout_blesk(index) {
	wait 2;
	level notify("blesk_" + index); // ukonci kill trigger
}