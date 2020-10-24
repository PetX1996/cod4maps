main()
{
  thread ele_dvere ();
}

ele_dvere()
{
down_l   = getent( "dolnedvere_l", "targetname" );
down_p   = getent( "dolnedvere_p", "targetname" );
dvere1   = getent( "dveretop_1", "targetname" );
trig1    = getent( "trig_ele", "targetname" );

trig1 waittill ("trigger");
/////////////////////////////////
dvere1 movez ( 120, 2, 0.4, 0.4);
wait 1;
down_l movex ( -38, 2, 0.4, 0.4); 
down_p movex ( 38, 2, 0.4, 0.4);
wait 4;
thread ele ();
}

ele()
{
vytah    = getent( "vytah", "targetname" );
vid      = getent( "ukazovatel", "targetname" );
svetlo   = getent( "svetlo", "targetname" );
tlacitko = getent( "tlacitko", "targetname" );
dvere1   = getent( "dveretop_1", "targetname" );
dvere2   = getent( "dveretop_2", "targetname" );
top_p    = getent( "dveretop_p", "targetname" );
top_l    = getent( "dveretop_l", "targetname" );
down_l   = getent( "dolnedvere_l", "targetname" );
down_p   = getent( "dolnedvere_p", "targetname" );
trig1    = getent( "trig_ele", "targetname" );

while(true)
   {
   trig1 waittill ("trigger"); //---1.faza---
   down_l movex ( 38, 2, 0.4, 0.4); 
   down_p movex ( -38, 2, 0.4, 0.4);
   down_l waittill ("movedone");
   dvere1 movez ( -120, 2, 0.4, 0.4); //---zavreni---
   wait 3;
   vytah movez ( 384, 10, 4, 4);  //cesta hore
   dvere1 movez ( 384, 10, 4, 4); //cesta hore
   dvere2 movez ( 384, 10, 4, 4); //cesta hore  
   tlacitko movez ( 384, 10, 4, 4); //cesta hore
   svetlo movez ( 384, 10, 4, 4); //cesta hore
   vid movez ( 16, 10, 4, 4);
   vytah waittill ("movedone");
   wait 2;
   dvere2 movez ( 120, 2, 0.4, 0.4); //---otevreni---
   wait 2;
   top_l movex ( -38, 2, 0.4, 0.4); 
   top_p movex ( 38, 2, 0.4, 0.4);
   wait 4;
   trig1 waittill ("trigger"); //---2.faza----
   ///////////////////////////////////////////////
   top_l movex ( 38, 2, 0.4, 0.4); //---zavreni---
   top_p movex ( -38, 2, 0.4, 0.4);
   top_l waittill ("movedone");
   dvere2 movez ( -120, 2, 0.4, 0.4);
   wait 3;
   vytah movez ( -384, 10, 1, 0.4);  //cesta dole
   dvere1 movez ( -384, 10, 1, 0.4); //cesta dole
   dvere2 movez ( -384, 10, 1, 0.4); //cesta dole  
   tlacitko movez ( -384, 10, 1, 0.4); //cesta dole
   svetlo movez ( -384, 10, 1, 0.4); //cesta dole
   vid movez ( -16, 10, 1, 0.4);
   vytah waittill ("movedone");
   wait 2;
   dvere1 movez ( 120, 2, 0.4, 0.4);
   wait 2;
   down_l movex ( -38, 2, 0.4, 0.4); //---otevreni---
   down_p movex ( 38, 2, 0.4, 0.4);
   wait 4;
   }
}
