/// @description Insert description here
// You can write your code in this editor
if(immune != true and state != ROLL)
{
	flashAlpha = 1;
	global.playerHealth--;
	immune = true;
	alarm_set(3, 2*room_speed);
	vibrateController(gamepad, 0.2, 1);
	audio_play_sound(sn_hit, 100, false);
	if(instance_exists(obj_camera))
	{
		obj_camera.Shake();
	}
}