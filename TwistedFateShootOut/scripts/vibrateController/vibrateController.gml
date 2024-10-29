//Vibrate Contrller
//@args GamepadSlot
//@args time
//@args intesnsity(0-1)
function vibrateController(_GamepadSlot, _time, _intensity){
	var gamepad = _GamepadSlot;
	var time = _time*room_speed;
	var intensity = _intensity;
	
	gamepad_set_vibration(gamepad, intensity, intensity);
	if(instance_exists(o_player)) with(o_player){
		alarm_set(0, time);
	}
	else alarm_set(0, time);
}