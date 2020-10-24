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
//    I                       scripted:  mnaauuu@4gf.cz                        I
//    I                         website: www.4GF.cz                            I
//    +========================================================================+
*/

main()
{
thread propadlo1 ();
thread propadlo2 ();
}

propadlo1 () 
{
	trig1 = getent ( "trap5" , "targetname" ) ;
	half_1= getentarray ( "propadlo1","targetname" ) ;
	half_2 = getentarray ( "propadlo11" , "targetname");
	trig1 waittill ("trigger", player );
	trig1 delete ();
	
	maps\mp\mp_deathrun_zero\coins::AddCoin( 5, level.coinPrice );
	
	if ( randomInt(2) == 1)
        half_1[0] delete();
		else
        half_2[0] delete();
}

propadlo2 () 
{
	trig1 = getent ( "trap6" , "targetname" ) ;
	half_1= getentarray ( "propadlo2","targetname" ) ;
	half_2 = getentarray ( "propadlo22" , "targetname");
	trig1 waittill ("trigger", player );
	trig1 delete ();
	
	maps\mp\mp_deathrun_zero\coins::AddCoin( 6, level.coinPrice );
	
	if ( randomInt(2) == 1)
        half_1[0] delete();
		else
        half_2[0] delete();
}