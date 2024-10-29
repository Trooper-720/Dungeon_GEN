function playerCollisions(){
	//Collision Code for two objects *need to optimize this but is fine
	//Horizontal Collisions
	if(place_meeting(x + hsp, y, obj_Collision))
	{
		while(!place_meeting(x + sign(hsp), y, obj_Collision))
			x += sign(hsp);
		hsp = 0;
	}
	
	//Vertical Collisions
	if(place_meeting(x, y + vsp, obj_Collision))
	{
		while(!place_meeting(x, y + sign(vsp), obj_Collision))
			y += sign(vsp);
		vsp = 0;
	}	
}