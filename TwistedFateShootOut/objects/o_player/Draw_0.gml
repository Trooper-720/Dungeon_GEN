//Draw Self and Cursor
//Safety net for animations and assigning which 
if(state == ROLL and move_direction != 0) anim_dir = move_direction;
else if(cursor_direction != 0) anim_dir = cursor_direction;
else if(move_direction != 0) anim_dir = move_direction;
else anim_dir = last_dir; 

var imgSpeed = 1;
if(state == ROLL)
{	
	if(anim_dir <= 5 or anim_dir > 275){
			sprite_index = spr_roll_1346	
			image_xscale = 1;
		}
		else if(anim_dir <= 85 and anim_dir > 5){
			sprite_index = spr_roll_79;
			image_xscale = 1;
		}
		else if(anim_dir <= 95 and anim_dir > 85){
			sprite_index = spr_roll_8;
			image_xscale = 1;
		}
		else if(anim_dir <= 175 and anim_dir > 95){
			sprite_index = spr_roll_79;
			image_xscale = -1;
		}
		else if(anim_dir <= 265 and anim_dir > 175){
			sprite_index = spr_roll_1346;
			image_xscale = -1;
		}
		else if(anim_dir <= 275 and anim_dir > 265){
			sprite_index = spr_roll_2;
			image_xscale = 1;
		}
	if(image_index == 5) vibrateController(gamepad, 0.2, 0.7);
}
else if(state == MOVE){
	//Player is aiming
	if(anim_dir == cursor_direction)
	{
		if(anim_dir <= 5 or anim_dir > 275){
			sprite_index = spr_run_1346	
			image_xscale = 1;
		}
		else if(anim_dir <= 85 and anim_dir > 5){
			sprite_index = spr_run_79;
			image_xscale = 1;
		}
		else if(anim_dir <= 95 and anim_dir > 85){
			sprite_index = spr_run_8;
			image_xscale = 1;
		}
		else if(anim_dir <= 175 and anim_dir > 95){
			sprite_index = spr_run_79;
			image_xscale = -1;
		}
		else if(anim_dir <= 265 and anim_dir > 175){
			sprite_index = spr_run_1346;
			image_xscale = -1;
		}
		else if(anim_dir <= 275 and anim_dir > 265){
			sprite_index = spr_run_2;
			image_xscale = 1;
		}
	}
	//Player is not aiming
	else
	{
		if(anim_dir <= 5 or anim_dir > 275){
			sprite_index = spr_run_1346	
			image_xscale = 1;
		}
		else if(anim_dir <= 85 and anim_dir > 5){
			sprite_index = spr_run_79;
			image_xscale = 1;
		}
		else if(anim_dir <= 95 and anim_dir > 85){
			sprite_index = spr_run_8;
			image_xscale = 1;
		}
		else if(anim_dir <= 175 and anim_dir > 95){
			sprite_index = spr_run_79;
			image_xscale = -1;
		}
		else if(anim_dir <= 265 and anim_dir > 175){
			sprite_index = spr_run_1346;
			image_xscale = -1;
		}
		else if(anim_dir <= 275 and anim_dir > 265){
			sprite_index = spr_run_2;
			image_xscale = 1;
		}
	}
}
else if(state == IDLE)
{
	//The animation angle updates for the correct sprite in the safety net
	if(anim_dir <= 5 or anim_dir > 275){
		sprite_index = spr_idle_1346	
		image_xscale = 1;
	}
	else if(anim_dir <= 85 and anim_dir > 5){
		sprite_index = spr_idle_79;
		image_xscale = 1;
	}
	else if(anim_dir <= 95 and anim_dir > 85){
		sprite_index = spr_idle_8;
		image_xscale = 1;
	}
	else if(anim_dir <= 175 and anim_dir > 95){
		sprite_index = spr_idle_79;
		image_xscale = -1;
	}
	else if(anim_dir <= 265 and anim_dir > 175){
		sprite_index = spr_idle_1346;
		image_xscale = -1;
	}
	else if(anim_dir <= 275 and anim_dir > 265){
		sprite_index = spr_idle_2;
		image_xscale = 1;
	}
}

//Tell the player they are reloading with the white bar
if(alarm_get(4) != -1)
{
	var sprWidth = 20;
	//Draw the horizontal line
	draw_set_color(c_white);
	var reloadBarPlace = 28;
	draw_line_width(x-sprWidth, y-reloadBarPlace, x+sprWidth,y-reloadBarPlace, 1.2);
	//Draw the 2 vertical lines at the end of each point
	var slitSize = 3;
	draw_line_width(x-sprWidth, y-reloadBarPlace+slitSize ,x-sprWidth, y-reloadBarPlace-slitSize, 1.1);
	draw_line_width(x+sprWidth, y-reloadBarPlace+slitSize ,x+sprWidth, y-reloadBarPlace-slitSize, 1.1);
	//Draw the moving slit
	slitSize = 2.5;
	var reloadLength = reloadTime*room_speed;
	var percent =alarm_get(4)/reloadLength; 
	if(alarm_get(4) == -1) percent = 1;
	var slitX =  (x+sprWidth) - (sprWidth*2)*percent;
	draw_line_width(slitX, y-reloadBarPlace+slitSize ,slitX, y-reloadBarPlace-slitSize, 1);
}
//Blink reload
else if(currentCards <= 0)
{
	draw_set_font(fnt_STATUSs);
	draw_set_halign(fa_center);
	var c = c_white;
	draw_text_color(x, y - 30, "RELOAD", c, c, c, c, 1);
}

//Sprite Scaling
scale = 1;
if(sign(image_xscale) == -1) image_xscale = -scale;
else if(sign(image_xscale) == 1) image_xscale = scale;
image_yscale = scale;

//Play Animations backwards if moving away from cursor
if(cursor_direction != 0){
	if(cursor_direction <= 90 or cursor_direction > 270 and xprevious > x and state == MOVE) imgSpeed = -1;
	else if(cursor_direction <= 270 or cursor_direction > 90 and xprevious < x and state == MOVE) imgSpeed = -1;
}
else imgSpeed = 1;
//Make sure the animation does not play backwards
if(state == ROLL) imgSpeed = 1;
//For the time slow Effect
image_speed = imgSpeed*o_gameplay_manager.bulletTimeFactor;

//Draw the players shadow
var diff = 2;
draw_sprite_ext(spr_playerShadow, -1, x, y+diff,scale,scale,0,c_white,0.5);
draw_sprite_ext(spr_playerShadow2, -1, x, y+diff,scale,scale,0,c_white,0.8);

//Draw the Cursor and hand
if(show_cursor) 
{
	draw_sprite_ext(spr_cursor, 0, xCursor, yCursor, 0.5, 0.5, 0, c_white, 1);
	
	//Draw hand
	draw_sprite(spr_hand, -1, xHand, yHand);
}


//Draw the player
draw_self();

//Player Hit
if(flashAlpha > 0){
	shader_set(sh_Flash);
	
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_angle,
	global.playerFlashColor, flashAlpha);
	
	shader_reset();
}


