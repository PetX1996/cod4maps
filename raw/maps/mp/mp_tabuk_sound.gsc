sound()

{

trig = getent("sound_activate","targetname"); //calls the trigger

sound1 = getent("sound1","targetname"); //a script origin or an actor

trig waittill ("trigger"); //waittill touched

sound1 playloopsound("sound1"); //tell the origin or actor to play the sound
IPrintLnBold( "Pisnicka!" );
sound1 stoploopsound("sound1"); //tohle je script pro ukonceni pisnicky

//beware as the actor will not play the sound through his on voice! Only whatever sound is from the sound file.

}