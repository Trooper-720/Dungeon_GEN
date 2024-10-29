/// @description Draw yourself

if(open == false)
{
	if(instance_exists(o_player))
	{
		if(distance_to_object(o_player) < 32){
			draw_sprite(spr_X, image_index, x, y-32);
		}
	}
}
draw_self();
