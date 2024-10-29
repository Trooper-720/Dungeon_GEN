//Makes a status bubble(Text) above a player that fades out over time
function makeStatusBubble(_status, _color, _life){
	with(instance_create_layer(x, y, "Instances", obj_STATUS)){
		status = _status;
		color = _color;
		life = _life*room_speed;
	}
}

