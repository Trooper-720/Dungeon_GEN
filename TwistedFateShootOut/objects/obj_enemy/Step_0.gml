/// @description Move towards the player
if(instance_exists(o_player))
{
	targetX = o_player.x;
	targetY = o_player.y;
}


if(state == CHASE)
{
	if(instance_exists(o_player))
	{
		//myPath = path_add();
		//mp_grid_path(obj_BSP._mpGrid, myPath, floor(x), floor(y), floor(targetX), floor(targetY), true);
		//path_start(myPath, spd*o_gameplay_manager.bulletTimeFactor, path_action_stop, false);
		mp_potential_step(targetX, targetY, spd*o_gameplay_manager.bulletTimeFactor, false);
	}
	
}
else if(state == HURT)
{
	hsp = lengthdir_x(spdHurt, knockbackDir)*o_gameplay_manager.bulletTimeFactor;
	vsp = lengthdir_y(spdHurt, knockbackDir)*o_gameplay_manager.bulletTimeFactor;
	x += hsp;
	y += vsp;
}

//Reduce the flash
if(flashAlpha > 0){
	flashAlpha -= 0.05;
}

//Move your lighting
//Update the location of the enemy Lights
enemyLight.x = x;
enemyLight.y = y;

//Check if your dead
if(enemyHp <= 0) instance_destroy();