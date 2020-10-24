///////////////////////////////////////////////////////////////////////////////////
// scripted: mnaauuu@4gf.cz
///////////////////////////////////////////////////////////////////////////////////
#include common_scripts\utility;

main()
{
	// debug
	//precacheModel("c130_zoomrig");
	
	ring = getRing("sgc_base_ring_0");
	ring.token = "1,38,1,38,38,1,0";
	//ring.token = "random-full";
	ring setupRing("sgc_base_chevrons_0", "sgc_base_activ_0", "gatefront_run_0", "gateback_run_0", "gate_teleport_0", "gate_kill_0", "gate_back_kill_0", "3,5,13,19,23,5,0");
	
	ring = getRing("sgc_base_ring_1");
	ring.token = "broken";
	ring setupRing("sgc_base_chevrons_1", "sgc_base_activ_1", "gatefront_run_1", "gateback_run_1", "gate_teleport_1", "gate_kill_1", "gate_back_kill_1", "1,38,1,38,38,1,0");
	
	ring = getRing("sgc_base_ring_2");
	ring.token = "1,38,1,38,38,1,0";
	ring setupRing("sgc_base_chevrons_2", "sgc_base_activ_2", "gatefront_run_2", "gateback_run_2", "gate_teleport_2", "gate_kill_2", "gate_back_kill_2", "1,2,3,39,22,15,0");
	
	for(i=0; i<level.rings.size; i++) {
		level.rings[i] thread loop();
	}
	
}

getRing(ringName) {
	return getent(ringName, "targetname"); // base ring
}

setupRing(shewronsName, triggerName, gateFrontName, gateBackName, tName, kName, kbName, address) {
	self.shewrons = getent(shewronsName, "targetname"); // ring with shewrons
	self.triggerActivator = getent(triggerName, "targetname"); // pannel activator
	self.triggerKill = getent(kName, "targetname"); // kill trigger
	self.triggerKillBack = getent(kbName, "targetname"); // kill trigger
	self.triggerTeleport = getent(tName, "targetname"); // teleport trigger

	self.front = getstructarray(gateFrontName, "targetname");
	self.front = self.front[0];
	
	self.back = getstructarray(gateBackName, "targetname");
	self.back = self.back[0];
	
	// startovacie hodnoty brany, definovat iba na zaciatku!
	self.currentShewron = 0; // aktualny sherwon
	self.currentIndex   = 0; //poziacia znakoveho kruhu
	self.status = "closed";
	self.shewronDegree = 9;
	self.shewronTime = 0.2;
	self.address = address;
	self.timeoutMax = 10;
	self.owner = undefined;
	
	if ( !isDefined(level.rings) )
		level.rings = [];

	self reset();
	
	level.rings[level.rings.size] = self;
	
	return self;
}


loop() {
	
	// debug
	//deb = spawn("script_model", (0,0,0));
	//deb setModel("c130_zoomrig");
	//deb.origin = ring getTagOrigin("tag_debug");
	//deb show();
	//deb linkto(ring, "tag_debug");

	//self reset();
	
	while (true)
	{
		// trigger pre spustenie rotacie
		self.triggerActivator waittill("trigger");
		
		
		// je brana otvorena?
		if( self.status == "closed"  )
		{
			if ( isDefined(self.owner) ) {
				self.status = "t-out";
				continue;
			}
			
			self.status = "prepare";
			iprintln("DEBUG: " + self.targetname);
			self thread openGate();
		} 
	}
}

toIntArray(str) {
	res = [];
	str = strtok(str,",");
	for(i=0;i<str.size;i++) {
		res[res.size] = int(str[i]);
	}
	
	return res;
}

toString(token) {
	str = "";
	for(i=0;i<token.size;i++) {
		if ( str != "" )
			str =  str + ",";
		str = str + token[i]; 
	}
	
	return str;
}


playInLoop(time) {
	self endon("death");
	
	while(true) {
		triggerFX(self);
		wait time;
	}
}

getRandomToken() {
	token = [];
	
	if ( self.token == "broken" || (self.token != "random" && randomInt(100)%2 == 0) ) {
		token[0] = randomIntRange(1, 5);
		token[1] = randomIntRange(24, 33);
		token[2] = randomIntRange(7, 14);
		token[3] = randomIntRange(34, 38);
		token[4] = randomIntRange(10, 20);
		token[5] = randomIntRange(22, 28);
		token[6] = 0;
	} else {
		while(true) {
			ring = level.rings[randomInt(level.rings.size)];
			if ( ring != self ) {
				token = toIntArray(ring.address);
				break;
			}
		}
	}
	
	return token;
}


openGate() {
	// testuj velkost 

	token = "";
	
	if ( self.token == "random" || self.token == "random-full" || self.token == "broken" )
		token = self getRandomToken();
	else
		token = toIntArray(self.token);
	
	if ( token.size != 7 ) {
		iprintlnbold("ERROR: wrong token size! - " + token.size);
		return;
	}

	self.status = "call";	
	self reset();
	
	if ( isDefined(self.owner)) {
		self.status = "t-out";
		return;
	}
	
	for(i=0; i < token.size; i++) {
		self rotate(token[i]);
	
		if ( isDefined(self.owner)) {
			self.status = "t-out";
			return;
		}
		if ( (token.size - 1) != i )
			wait 1;
	}

	if ( isDefined(self.owner)) {
		self.status = "t-out";
		return;
	} else {
		self.status = "teleport";
	}

	str = "";
	ent = undefined;
	
	if ( self.token != "broken" ) {
		str = toString(token);
		
		for(i=0;i<level.rings.size;i++) {
			if ( level.rings[i].address == str ) {
				ent = level.rings[i];
				break;
			}
		}
	}
	
	wait 0.1;
	
	if ( isDefined(self.owner) || !isDefined(ent) || 
		!( ent.status == "closed" || ent.status == "prepare" || ent.status == "call" ) ) {
		self brokenConnection(ent);
	} else {
		
		ent.owner = self;
		ent.triggerActivator notify("trigger");
		
		while(true) {
			if ( ent.status == "closed" || ent.status == "prepare" || ent.status == "call"  ) {
				wait 0.1;
			} else if ( ent.status == "t-out" && ent.owner == self ) {
				break;
			} else {
				ent.owner = undefined;
				self brokenConnection(ent);
				ent = undefined;
				break;
			}
		}
		
		if ( isDefined(self.owner)) {
			iprintln("ERROR CROSS-OWNER: ring " + self.targetname + " ");
			self.owner = undefined;
		} else
		if ( isDefined(ent) ) {
			ent reset();
			ent outTeleportEffect();
			
			self.timeout = self.timeoutMax;
			self thread teleport(ent);
			
			self effects(ent);
			ent reset();
			ent.owner = undefined;
			ent.status = "closed";
		}
	}
	
	wait 0.1;
	self reset();
	
	self.status = "closed";
	//iprintln("DEBUG: all done.");
}

brokenConnection(out) {
	iprintln("DEBUG: broken or in use");
}

teleport(out) {
	self.triggerTeleport endon("done");
	
	//self.triggerTeleport waittill("start");
	
	while(true) {
		self.triggerTeleport waittill("trigger", player);
		
		if ( isDefined(player) && isPlayer(player) ) {
			self.timeout = self.timeoutMax;
			out thread transport(player);
		} else {
			wait 0.1;
		}
	}
}


killZoneOnStart() {
	self.triggerKill endon("done");
	
	while(true) {
		self.triggerKill waittill("trigger", player);
		if ( isDefined(player) && isPlayer(player) ) { 
			player suicide();
		}
	}
}

killZonePortal() {
	self.triggerKillBack endon("done");
	
	while(true) {
		self.triggerKillBack waittill("trigger", player);
		if ( isDefined(player) && isPlayer(player) ) { 
			player suicide();
		}
	}
}

transport(player) {
	player endon("death");
	player endon("disconnect");
	
	player freezeControls(true);
	//player linkTo(self);
	player SetPlayerAngles(self.front.angles);
	vec = AnglesToForward( player GetPlayerAngles() );
	player setOrigin(vectorscale( vec, randomIntRange(60, 120) ) + self.front.origin);
	wait 0.01;
	//player unlink();
	player freezeControls(false);
}

outTeleportEffect() {
	for(i=0;i<7; i++) {
		self.shewrons showPart("tag_chevron_on" + i, self.shewrons.model);
		wait 0.5;
	}
}

effects(out) {

	self thread killZonePortal();
	out thread killZonePortal();
	
	self thread killZoneOnStart();
	out thread killZoneOnStart();
	
	
	self.ef1forw = AnglesToForward(  self.front.angles );
	self.ef1 = spawnfx(level._effect[ "gatestart" ], self.front.origin, self.ef1forw);
	triggerFX(self.ef1);
	
	self.ef2forw = AnglesToForward(  self.back.angles );
	self.ef2 = spawnfx(level._effect[ "gaterun" ], self.back.origin, self.ef2forw);
	triggerFX(self.ef2);
	
	out.ef1forw = AnglesToForward(  out.front.angles );
	out.ef1 = spawnfx(level._effect[ "gatestart" ], out.front.origin, out.ef1forw);
	triggerFX(out.ef1);
	
	out.ef2forw = AnglesToForward(  out.back.angles );
	out.ef2 = spawnfx(level._effect[ "gaterun" ], out.back.origin, out.ef2forw);
	triggerFX(out.ef2);
	
	wait 1.3;

	out.triggerKill notify("done");
	self.triggerKill notify("done");
	self.triggerTeleport notify("start");
	
	self.ef3 = spawnfx(level._effect[ "gaterun" ], self.front.origin, self.ef1forw);
	triggerFX(self.ef3);

	out.ef3 = spawnfx(level._effect[ "gaterun" ], out.front.origin, out.ef1forw);
	triggerFX(out.ef3);

	while( self.timeout > 0 ) {
		self.timeout--;
		wait 1;
	}

	self.ef2f = spawnfx(level._effect[ "gaterun_off" ], self.back.origin, self.ef2forw);
	triggerFX(self.ef2f);
	self.ef3f = spawnfx(level._effect[ "gaterun_off" ], self.front.origin, self.ef1forw);
	triggerFX(self.ef3f);
	
	out.ef2f = spawnfx(level._effect[ "gaterun_off" ], out.back.origin, out.ef2forw);
	triggerFX(out.ef2f);
	out.ef3f = spawnfx(level._effect[ "gaterun_off" ], out.front.origin, out.ef1forw);
	triggerFX(out.ef3f);
	
	wait 1.2;

	self.triggerTeleport notify("done");
	
	self.ef1 delete();
	self.ef2 delete();
	self.ef3 delete();
	
	out.ef1 delete();
	out.ef2 delete();
	out.ef3 delete();

	wait 1.5;
	
	self.triggerKillBack notify("done");
	out.triggerKillBack notify("done");
	
	wait 1;



	self.ef2f delete();
	self.ef3f delete();
	
	out.ef2f delete();
	out.ef3f delete();
}


effectsFirst() {
}

effectsSecond() {
}

reset() {
	
	//iprintln("DEBUG: reset start.");

	for(i=0;i<7; i++) {
		self.shewrons hidePart("tag_chevron_on" + i, self.shewrons.model);
	}
	
	
	if ( self.currentIndex != 0) {
		self rotatepitch( (-1) * self.shewronDegree * self.currentIndex, self.shewronTime * self.currentIndex);
		self waittill("rotatedone"); 
	}
	
	self.currentShewron = 0;
	self.currentIndex = 0;
	//iprintln("DEBUG: reset done.");
	wait 0.1;
}

rotate(position) {
	if ( isDefined(self.owner))
		return;
		
	//iprintln("DEBUG: position: " + position);
	
	shift = 0;
	time = 0;
	
	if ( self.currentShewron%2 == 0 ) { // to right
	
		if ( self.currentIndex < position )
			shift = position - self.currentIndex;
		else
			shift = (40 - self.currentIndex) + position;
		
		time = self.shewronTime * shift; // cas
		shift = self.shewronDegree * shift; // stupne
		
	} else { // to left
	
		if ( self.currentIndex < position )
			shift = (40 - position) + self.currentIndex;
		else
			shift = self.currentIndex - position;
		
		time = self.shewronTime * shift;
		shift = (-1) * self.shewronDegree * shift; // stupne
		
	}
	
	if ( time < 1 )
		self rotatepitch( shift, time, 0.1, 0,1);
	else
		self rotatepitch( shift, time, 0.5, 0.5 );
		
	self waittill("rotatedone");
	
	
	self.shewrons showPart("tag_chevron_on6", self.shewrons.model);
	
	if ( self.currentShewron < 6 ) {
		wait 0.5;
		self.shewrons showPart("tag_chevron_on" + self.currentShewron, self.shewrons.model);
		wait 0.5;
		self.shewrons hidePart("tag_chevron_on6", self.shewrons.model);
	} 
	
	self.currentShewron++;
	self.currentIndex = position;
	
	//iprintln("DEBUG: position done.");
}





