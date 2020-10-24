/*
//    +========================================================================+
//    I                    ___  _____  _____                                   I
//    I                   /   !!  __ \!  ___!                                  I
//    I                  / /! !! !  \/! !_          ___  ____                  I
//    I                 / /_! !! ! __ !  _!        / __!!_  /                  I
//    I                 \___  !! !_\ \! !      _  ! (__  / /                   I
//    I                     !_/ \____/\_!     (_)  \___!/___!                  I
//    I========================================================================I
//    I                                 trap                                   I
//    I========================================================================I
//    I                       scripted: PetX                                   I
//    I                       updated:  mnaauuu@4gf.cz                         I
//    I                         website: www.4GF.cz                            I
//    +========================================================================+
*/

main()
{
thread rotateCylinder1();
}

rotateCylinder1()
{
	rotate = getent( "rotor1" , "targetname" );
	rotate_trig = getent( "trap1" , "targetname" );

	rotate_trig waittill ("trigger");

	maps\mp\mp_deathrun_zero\coins::AddCoin( 1, level.coinPrice );
	
	while (true) {
		if ( randomInt(99)%2 == 0 )
			rotate RotateYaw(  360, 2, 0.5, 0.5 );
		else
			rotate RotateYaw( -360, 2, 0.5, 0.5 );
		wait 7;
	}
}