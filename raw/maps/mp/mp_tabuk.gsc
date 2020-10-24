main()
{
        maps\mp\_load::main();

        //maps\mp\mp_tabuk_plagat::main(); 

        maps\mp\mp_tabuk_fx::main();
       
        maps\mp\mp_tabuk_fxs::main(); 

        maps\mp\mp_tabuk_foliage::initdfs();

        //maps\createfx\mp_tabuk_fx::main();
	
        ambientPlay("ambient_crash");

	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "desert";
	game["axis_soldiertype"] = "desert";

	setdvar( "r_specularcolorscale", "1" );

	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");
	setdvar("compassmaxrange","1800");

	level.elevatorDown = true; // elevator starts at bottom: true/false
	level.elevatorMoving = false; // elevator is not currently moving
    level._effect[ "redflash" ]			= loadfx( "misc/lift_light_red" ); // loads the 3 different effects required - normally this would go in the _fx.gsc file
    level._effect[ "redstatic" ]		= loadfx( "misc/lift_light" );
    level._effect[ "greenstatic" ]		= loadfx( "misc/lift_light_green" );

    level.showgreen = true;
    level.redflash = false;
    level.redstatic = false;
    

	thread elevator_start();

}

elevator_start() 
{
level.elevLight = getentarray ("redlightb","targetname");
elevator = getentarray ("elevatorswitch","targetname");

toprightdoor = getent ("trightdoor","targetname");
topleftdoor = getent ("tleftdoor","targetname");
toprightdoor movey(-31,0.05);
topleftdoor moveY(31,0.05);

rightgate = getentarray ("rightdoor", "targetname"); 
leftgate = getentarray ("leftdoor", "targetname"); 


if ( isdefined(elevator) )
for (i = 0; i < elevator.size; i++)
elevator[i] thread elevator_think();


for(i=0; i<level.elevLight.size; i++)
{
    level.elevLight[i] thread flash_red();
    level.elevLight[i] thread staticRed();
    level.elevLight[i] thread staticGreen();
}
}

elevator_think() 
{

while (1) 
{
self waittill ("trigger");
if (!level.elevatorMoving)
thread elevator_move();
}
}


elevator_move() 
{
// read all required entities into script
elevatormodel = getent ("elevatormodel", "targetname");
rightgate = getent ("rightdoor", "targetname"); 
leftgate = getent ("leftdoor", "targetname"); 
topblock = getent ("topblock","targetname");
bottomblock = getent ("bottomblock","targetname");
toprightdoor = getent ("trightdoor","targetname");
topleftdoor = getent ("tleftdoor","targetname");
bottomrightdoor = getent ("brightdoor","targetname");
bottomleftdoor = getent ("bleftdoor","targetname");
topgauge = getent ("topgauge","targetname");
bottomgauge = getent ("bottomgauge","targetname");
top_point = getent ("shaft_top","targetname");
bottom_point = getent ("shaft_bottom","targetname");
lamp = getent ("elevatorlight","targetname");


level.showgreen = false;
level.redflash = true;

level.elevatorMoving = true;
hide_trigs(); // hides triggers while elevator is moving
speed = 10;

height = distance( top_point.origin, bottom_point.origin ); // calculates the distance between top and bottom
wait (0.5);

if (level.elevatorDown) 
{ // this half of the if statement executes if the elevator is at the bottom (i.e. level.elevatorDown equals true)
bottomblock moveZ(-100,0.2); // blocks gateway before closing visible gates

bottomblock waittill("movedone");

rightgate movey(-31,2,0.5,0.5); // closes right elevator gate
leftgate movey(31,2,0.5,0.5); // closes left elevator gate
wait 0.5;

bottomrightdoor movey(-31,2,0.5,0.5); // closes right bottom door which blocks entry to elevator shaft.
bottomleftdoor moveY(31,2,0.5,0.5); // closes left bottom door which blocks entry to elevator shaft.

bottomleftdoor waittill("movedone"); // script waits until gate is closed
bottomblock moveZ(100,0.2); // unsets door block (no longer needed)
wait (1); // short pause
level.redflash = false;
level.redstatic = true;


wait (1); 

elevatormodel moveZ (height, speed, 1, 1); // moves the cage up 
rightgate  moveZ (height, speed, 1, 1); // moves the right gate up at same speed as the cage - you can use the linkto technique, but it tends to make the doors shake
leftgate moveZ (height, speed, 1, 1); // moves the left gate up with cage
lamp moveZ (height, speed, 1, 1); // moves the elevator light
topgauge moveZ (14, speed); // moves the elevator position gauge
bottomgauge moveZ (14, speed); //ditto
elevatormodel waittill ("movedone"); // script waits until cage has finished its movement

level.redstatic = false;
level.redflash = true;

wait (1); 

toprightdoor movey(31,2,0.5,0.5); // opens top right door
topleftdoor moveY(-31,2,0.5,0.5); // opens top left door
wait 0.5;
rightgate movey(31,2,0.5,0.5); // opens elevator right door
leftgate moveY(-31,2,0.5,0.5); // opens elevator left door
leftgate waittill("movedone");

level.elevatorDown = false; // this var tells the script the elevator must go down next time.

}


else {  // this half makes the elevator go down - largely the same as above, but in reverse order
topblock moveZ(-100,0.2);

topblock waittill("movedone");
rightgate movey(-31,2,0.5,0.5);
leftgate moveY(31,2,0.5,0.5);
wait 0.5;

toprightdoor movey(-31,2,0.5,0.5);
topleftdoor moveY(31,2,0.5,0.5);

leftgate waittill("movedone");
topleftdoor waittill("movedone");
topblock moveZ(100,0.2);
level.redflash = false;
level.redstatic = true;
wait (1); 



wait (1);  
elevatormodel moveZ (height - (height * 2), speed, 1, 1);
rightgate  moveZ (height - (height * 2), speed, 1, 1);
leftgate moveZ (height - (height * 2), speed, 1, 1);
lamp moveZ (height - (height * 2), speed, 1, 1);
topgauge moveZ (-14, speed);
bottomgauge moveZ (-14, speed);
elevatormodel waittill ("movedone");

level.redstatic = false;
level.redflash = true;


wait (1); 
bottomrightdoor movey(31,2,0.5,0.5);
bottomleftdoor moveY(-31,2,0.5,0.5);
wait 0.5;
rightgate movey(31,2,0.5,0.5);
leftgate moveY(-31,2,0.5,0.5);
leftgate waittill("movedone");

level.elevatorDown = true;
}
level.redflash = false;
wait 0.5;
level.showgreen = true;

level.elevatorMoving = false;
show_trigs(); // shows triggers again.
}

//=================================================//
//       These two functions show                  //
//       and hide the triggers                     //
//=================================================//


hide_trigs()
{
switches = getentarray ("elevatorswitch","targetname");

for(i=0; i<switches.size; i++) switches[i] maps\mp\_utility::triggerOff();

}

show_trigs()
{
switches = getentarray ("elevatorswitch","targetname");

for(i=0; i<switches.size; i++) switches[i] maps\mp\_utility::triggerOn();

}


//=================================================//
//       These three functions control the         //
//       elevator indicator lights                 //
//=================================================//

flash_red()
{
      while(1)
      {
             while(level.redflash)
             {
                    PlayFX( level._effect[ "redflash" ], self.origin );
                    wait 0.5;
             }
             wait 0.05;
      }
}

staticRed()
{
      while(1)
      {
              while(level.redstatic)
              {
                      PlayFX( level._effect[ "redstatic" ], self.origin );
                      wait 0.1;
              }
              wait 0.05;
      }
}

staticGreen()
{
      while(1)
      {
              while(level.showgreen)
              {
                      PlayFX( level._effect[ "greenstatic" ], self.origin );
                      wait 0.1;
              }
              wait 0.05;
      }
}
