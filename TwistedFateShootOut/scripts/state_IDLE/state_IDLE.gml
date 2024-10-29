function state_IDLE(){
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
	
	//Slow Down time
	gamblerVision();
	
	//----------------------------------------------------------------------
	//If the player moves the left stick change states
	if(abs(gamepad_axis_value(gamepad, gp_axislh)) > threshold or abs(gamepad_axis_value(gamepad, gp_axislv)) > threshold){
		state = MOVE;
	}
}