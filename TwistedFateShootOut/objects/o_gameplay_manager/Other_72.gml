/// @description Load BG
if(audio_group_is_loaded(ag_BG)){
	audio_group_set_gain(ag_BG, 0, 0);
	audio_play_sound(sn_BG, 1000, true);
	audio_group_set_gain(ag_BG, 0.1, 2*room_speed);
}