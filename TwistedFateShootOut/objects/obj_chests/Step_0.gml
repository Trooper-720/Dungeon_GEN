/// @description Check if the player is close and open if pressed X
if(instance_exists(o_player))
{
	if(distance_to_object(o_player) < 32 and gamepad_button_check_pressed(o_player.gamepad, gp_face1) and open == false)
	{
		audio_play_sound(sn_chestCreak, 100, false);
		vibrateController(o_player.gamepad, 0.1, 1);
		image_speed = 1*o_gameplay_manager.bulletTimeFactor;
		instance_create_layer(x,y,"Items", chosenItem);
		open = true;
	}
}

if(image_speed == 1*o_gameplay_manager.bulletTimeFactor and image_index == 4)
{
	image_index = 4;
	image_speed = 0*o_gameplay_manager.bulletTimeFactor;
}