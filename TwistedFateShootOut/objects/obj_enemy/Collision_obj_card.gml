/// @description Hurt
enemyHp -= other.damage;
state = HURT;
knockbackDir = other.dir;
if(instance_exists(obj_camera)){
	obj_camera.Shake();
}
flashAlpha = 1;
audio_play_sound(sn_hit_2, 100, false);
alarm_set(0, 0.2*room_speed)
instance_destroy(other);

