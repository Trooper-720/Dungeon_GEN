function gamblerVision(){
	//Slow Down Time
	if(gamepad_button_check(gamepad, gp_shoulderrb) and currentGambleTime > 0){
		vibrateController(gamepad, 0.15, 0.8);
		if(instance_exists(o_gameplay_manager)){
			o_gameplay_manager.bulletTime = true;
			inGambleVision = true;
			currentGambleTime -= 0.01;
		}
	}
	else if(gamepad_button_check_released(gamepad, gp_shoulderrb)){
		if(instance_exists(o_gameplay_manager)){
			o_gameplay_manager.bulletTime = false;
			inGambleVision = false;
		}
	}
	else if(currentGambleTime <= 0 and alarm_get(5) == -1)
	{
		if(instance_exists(o_gameplay_manager)){
			vibrateController(gamepad, 0.2, 1);
			o_gameplay_manager.bulletTime = false;
			inGambleVision = false;
			alarm_set(5, room_speed*gambleCoolDown);
		}
	}
}