//Update the players Cursor
function cursor_Update(_threshold){
	//How much that stick is moved (returns a negative value so it is absoluted for multiplication later)
	var magnitudex = gamepad_axis_value(gamepad, gp_axisrh);
	var magnitudey = gamepad_axis_value(gamepad, gp_axisrv);
	
	//Find the angle the player is aiming, and calculate the coordinates of the cursor
	if ((magnitudex != 0 || magnitudey != 0) and (abs(magnitudex) > _threshold || abs(magnitudey) > _threshold)){
		show_cursor = true;
		cursor_direction = point_direction(x, y, x+magnitudex, y+magnitudey);
		//Save the direction (For animations)
		last_dir = cursor_direction;
		//Save the direction of the cursor for the 
		oldCursor_direction = cursor_direction;
		xCursor = x+lengthdir_x(radius, cursor_direction);
		yCursor = y+lengthdir_y(radius, cursor_direction);
		xHand = x+lengthdir_x(handRadius, cursor_direction);
		yHand = y+lengthdir_y(handRadius, cursor_direction);
		
	}
	else
	{
		oldCursor_direction = cursor_direction;
		cursor_direction = 0;
		show_cursor = false;
	}
}