//Script for all movement
function state_MOVE(){
	//Movement
	//How much that stick is moved (returns a negative value so it is absoluted for multiplication later)
	var magnitudex = gamepad_axis_value(gamepad, gp_axislh);
	var magnitudey = gamepad_axis_value(gamepad, gp_axislv);
	
	//Find the angle the player wants to go in, and calculate the respective speeds
	if magnitudex != 0 || magnitudey != 0 {
	
		move_direction = point_direction(0, 0, magnitudex, magnitudey);
		//Save the direction (For animations)
		last_dir = move_direction;
		//Apply the respective spds
		hsp = lengthdir_x(move_speed*abs(magnitudex), move_direction)*o_gameplay_manager.bulletTimeFactor;
		vsp = lengthdir_y(move_speed*abs(magnitudey), move_direction)*o_gameplay_manager.bulletTimeFactor;
	}
	//This means the player did not move thus go back to IDLE state
	else
	{
		move_direction = 0;
		state = IDLE;
	}
	//Apply Collisions
	playerCollisions();
	//Apply Movement per Step to x and y
	x += hsp;
	y += vsp;
	
	//----------------------General Actions------------------------------------
	//Cursor Update
	script_execute(cursor_Update, threshold);

	//Shoot (if u have ammo)
	if (gamepad_button_check(gamepad, gp_shoulderr) and canAttack == true and currentCards > 0){
		currentCards--;
		vibrateController(gamepad, 0.15, 0.8);
		with(instance_create_layer(x,y, "Instances", obj_card)){ 
			dir = other.cursor_direction;
			image_angle = other.cursor_direction+90;
			image_xscale = 0.25;
			image_yscale = 0.25;
		}
		canAttack = false;
		alarm_set(1, attackSpd);
	}
	else if((gamepad_button_check_pressed(gamepad, gp_shoulderr) and currentCards <= 0) or (gamepad_button_check_pressed(gamepad, gp_face3) and currentCards < maxDeckSize))
	{
		if(alarm_get(4) == -1){
			alarm_set(4, room_speed*reloadTime);
			vibrateController(gamepad, 0.15, 0.8);
		}
	}
	//Roll
	if (gamepad_button_check(gamepad, gp_shoulderl) and canRoll = true){
		canRoll = false;
		alarm_set(2, roll_Delay*room_speed);
		state = ROLL;
		dodgeLength = maxDodgeLength;
		image_index = 0;
		vibrateController(gamepad, 0.2, 0.7);
	}
	
	//Slow Down time
	gamblerVision();

}