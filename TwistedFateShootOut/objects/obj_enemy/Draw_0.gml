/// @description Animate the enemy
if(state == CHASE)
{
	if(x > xprevious)
	{
		sprite_index = enemy_run_1346;
		image_xscale = 1;
	}
	if(x < xprevious)
	{
		sprite_index = enemy_run_1346;
		image_xscale = -1;
	}
}
else if(state == HURT or state == IDLE)
{
	sprite_index = enemy_Idle_1346;
}

//Sprite Scaling
scale = 1;
if(sign(image_xscale) == -1) image_xscale = -scale;
else if(sign(image_xscale) == 1) image_xscale = scale;
image_yscale = scale;

//For the time slow Effect
image_speed = o_gameplay_manager.bulletTimeFactor;

draw_self();


if(flashAlpha > 0){
	shader_set(sh_Flash);
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle,
	global.enemyFlashColor, flashAlpha);
	
	shader_reset();
}

//Draw the state of the enemy
var displayState = "State: ";
if(state == IDLE) displayState = "State: IDLE";
else if(state == CHASE) displayState = "State: CHASE";
else if(state == HURT) displayState = "State: HURT";

draw_set_color(c_white);
draw_set_font(fnt_STATUSs);
draw_set_halign(fa_center);
draw_text(x, y - 25, displayState);