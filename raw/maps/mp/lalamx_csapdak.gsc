/* Scripting: Lalus------------------- www.mapolok.clans.hu
                    CODUTILITY: http://www.codutility.com/vb/member.php?12689-lalus

                                          2012.01.14

*/

indul()
{

  level thread csapda_1 ();
  level thread csapda_2 ();
  level thread forgatas ();
  level thread kapu0 ();
  level thread tololap0 ();
  level thread forgatas_2 ();
  level thread forgatas_3 ();
  level thread forgatas_4 ();
  level thread forgatas_5 ();
  level thread teleport ();
  level thread teleport_2 ();
  level thread teleport_3 ();
  level thread teleport_4 ();
  level thread teleport_5 ();
  level thread eltuntet ();
  //level thread udvozlo ();

}

csapda_1()

{
  csapda = getent( "csapda_1", "targetname" );
  trig = getent( "csapda_1_trig", "targetname" );

  while(true)
     {
      trig waittill ("trigger");
      trig delete();
      csapda movez (360,2,0,0.6);
      csapda waittill ("movedone");


      wait 5;

      csapda movez(-360,1,0,0.6);
      csapda waittill ("movedone");
     }
}

csapda_2()

{

  csapda = getent( "csapda_2", "targetname" );
  trig = getent( "csapda_2_trig", "targetname" );

  while(true)

        {
        trig waittill ("trigger");
        trig delete();
        csapda movex (330,1,0,0.6);
        csapda waittill ("movedone");


        wait 3;

        csapda movex(-330,1,0,0.6);
        csapda waittill ("movedone");
        }
}

forgatas()

{
  trig = getEnt( "forg_indul", "targetname" );
  brush = getEnt( "forgat", "targetname" );

  trig waittill( "trigger");
        trig delete();

       {
       brush rotateYaw( 115200, 600 );
       wait 1;
       }
}


teleport()

{
  entTransporter = getentarray( "enter", "targetname" );

  if(isdefined(entTransporter))
     {
     for( i = 0; i < entTransporter.size; i++ )
     entTransporter[i] thread transporter();
     }
}

transporter()
{
  while(true)
  {
    self waittill( "trigger", player );
    entTarget = getEnt( self.target, "targetname" );
    wait 0.1;
    player setOrigin( entTarget.origin );
    player setplayerangles( entTarget.angles );
    wait 0.1;
  }
}


teleport_2()
{
  entTransporter = getentarray( "enter_2", "targetname" );

  if(isdefined(entTransporter))
  {
    for( i = 0; i < entTransporter.size; i++ )
      entTransporter[i] thread transporter_2();
  }
}

transporter_2()
{
  while(true)
  {
    self waittill( "trigger", player );
    entTarget = getEnt( self.target, "targetname" );
    wait 0.1;
    player setOrigin( entTarget.origin );
    player setplayerangles( entTarget.angles );
    wait 0.1;
  }
}


teleport_3()
{
  entTransporter = getentarray( "enter_3", "targetname" );

  if(isdefined(entTransporter))
  {
    for( i = 0; i < entTransporter.size; i++ )
      entTransporter[i] thread transporter_3();
  }
}

transporter_3()
{
  while(true)
  {
    self waittill( "trigger", player );
    entTarget = getEnt( self.target, "targetname" );
    wait 0.1;
    player setOrigin( entTarget.origin );
    player setplayerangles( entTarget.angles );
    wait 0.1;
  }
}

teleport_4()
{
  entTransporter = getentarray( "enter_4", "targetname" );

  if(isdefined(entTransporter))
  {
    for( i = 0; i < entTransporter.size; i++ )
      entTransporter[i] thread transporter_2();
  }
}

transporter_4()
{
  while(true)
  {
    self waittill( "trigger", player );
    entTarget = getEnt( self.target, "targetname" );
    wait 0.1;
    player setOrigin( entTarget.origin );
    player setplayerangles( entTarget.angles );
    wait 0.1;
  }
}

teleport_5()
{
  entTransporter = getentarray( "enter_5", "targetname" );

  if(isdefined(entTransporter))
  {
    for( i = 0; i < entTransporter.size; i++ )
      entTransporter[i] thread transporter_2();
  }
}

transporter_5()
{
  while(true)
  {
    self waittill( "trigger", player );
    entTarget = getEnt( self.target, "targetname" );
    wait 0.1;
    player setOrigin( entTarget.origin );
    player setplayerangles( entTarget.angles );
    wait 0.1;
  }
}

forgatas_2()

{
  trig = getEnt( "forgat_2", "targetname" );
  brush1 = getEnt( "forog_2_1", "targetname" );
  brush2 = getEnt( "forog_2_2", "targetname" );
  brush3 = getEnt( "forog_2_3", "targetname" );
  brush4 = getEnt( "forog_2_4", "targetname" );
  brush5 = getEnt( "forog_2_5", "targetname" );

  trig waittill( "trigger");
        trig delete();

  {
    brush1 rotateYaw( 3600, 100 );
    brush2 rotateYaw( 3600, 80 );
    brush3 rotateYaw( 3600, 100 );
    brush4 rotateYaw( 3600, 80 );
    brush5 rotateYaw( 3600, 100 );
    wait 1;
  }
}


kapu0()
{

  csapda = getent( "kapu", "targetname" );
  trig = getent( "kapu_trig", "targetname" );

  while(true)
  {
  trig waittill ("trigger");
  trig delete();
    csapda movez (-238,0.5,0,0.1);
    csapda waittill ("movedone");


    wait 5;

    csapda movez(238,1,0,0.6);
    csapda waittill ("movedone");
  }
}


forgatas_3()

{
  trig = getEnt( "forgat_3", "targetname" );
  brush = getEnt( "forog_3", "targetname" );

  trig waittill( "trigger");
        trig delete();

  {
    brush rotateroll( -57600, 480 );
    wait 1;
  }
}

forgatas_4()

{
  trig = getEnt( "forgat_4", "targetname" );
  brush = getEnt( "forog_4", "targetname" );

  trig waittill( "trigger");
        trig delete();

  {
    brush rotateYaw( 115200, 520 );
    wait 1;
  }
}


tololap0()
{

  csapda = getent( "tololap", "targetname" );
  trig = getent( "tololap_trig", "targetname" );

  while(true)
  {
  trig waittill ("trigger");
  trig delete();
    csapda movex (-529,1,0,0.1);
    csapda waittill ("movedone");


    wait 2;

    csapda movex(529,1,0,0.6);
    csapda waittill ("movedone");
  }
}



forgatas_5()

{
  trig = getEnt( "forgat_5", "targetname" );
  brush = getEnt( "forog_5", "targetname" );

  trig waittill( "trigger");
        trig delete();
  //who PlaySound("rotatething");


  //for( i = 0; i < 8; i++ )
  {
    brush rotatepitch( 115200, 400 );
    wait 1;
  }
}


eltuntet()

{
   trig = getEnt( "elrejt_trig", "targetname" );
   first = getent ("solid","targetname");
   second = getent ("not_solid","targetname");
   trig waittill( "trigger");
        trig delete();
   while(1)
{
    first movez(-1820,1,0,0.6);
    wait 2;
    first movez(1820,1,0,0.6);
    wait 1;
    second movez(-1820,1,0,0.6);
    wait 2;
    second movez(1820,1,0,0.6);
    wait 1;
  }

}


udvozlo()

{
    delay = 30;
    for(;;) {

        level waittill("connected", player);
        wait (10.0);
        player thread welc_issue(.15, "Üdv az mp_deathrun_lalamx pályáján"  + player.name);
        wait (9.0);
        player thread welc_issue(.10, "Készítette: [PKT]Adamx89  Scriptelte: {PST}Lalus");
    }
}

welc_issue(delay, welc)
{
  self endon("intermission");
      self endon("disconnect");
  self endon("killthreads");
  self endon("game_ended");

    wait(delay);

    notifyData = spawnStruct();
    notifyData.notifyText = welc;
    notifyData.glowColor = (0.2, 0.3, 0.7);
    notifyData.duration = level.welcomeduration;

    notifyData.sort = 5;
    notifyData.hideWhenInMenu = true;
    self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}