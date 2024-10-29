/// @description Spawn Coin
if(mouse_check_button_pressed(mb_left)){
	instance_create_layer(mouse_x ,mouse_y, "Instances", obj_chests);
}
if(mouse_check_button_pressed(mb_right)){
	instance_create_layer(mouse_x ,mouse_y, "Instances", obj_enemy);
}
if(mouse_check_button_pressed(mb_middle)){
	makeStatusBubble("LEVEL UP", c_yellow, 1.5);
}

//Bullet Time Control
switch(bulletTime){
	case 0: bulletTimeFactor = 1; break;
	case 1: bulletTimeFactor = 0.4; break;
}
if(audio_is_playing(sn_BG)){
	audio_sound_pitch(sn_BG, bulletTimeFactor);
}

