main()
{
dvere = getent( "dvere1", "targetname" );
trig  = getent( "trig_dvere1", "targetname" );

while(true)
  {
  trig waittill ( "trigger" );
  dvere movez ( 168, 15, 0.4, 0.4);
  dvere waittill ( "movedone" );
  trig waittill ( "trigger" );
  dvere movez ( -168, 15, 0.4, 0.4);
  dvere waittill ( "movedone" );
  }
}