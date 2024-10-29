//Make the player DODGE ROLLLL
function state_ROLL(){
	//Cursor Update
	show_cursor = false;
	//Apply the respective spds
	hsp = lengthdir_x(dodge_speed, move_direction)*o_gameplay_manager.bulletTimeFactor;
	vsp = lengthdir_y(dodge_speed, move_direction)*o_gameplay_manager.bulletTimeFactor;
	//Apply Collisions
	playerCollisions();
	//Apply Movement per Step to x and y
	x += hsp;
	y += vsp;
	dodgeLength -= 1*o_gameplay_manager.bulletTimeFactor;
	//If roll finished go back to idle state
	if(dodgeLength <= 0) state = MOVE;
	
	//Slow Down time
	gamblerVision();
}