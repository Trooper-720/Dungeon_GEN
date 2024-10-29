//Lighting 
if(surface_exists(lighting_surf) == false)
{
	lighting_surf = surface_create(room_width, room_height);
}

surface_set_target(lighting_surf);

draw_clear_alpha(c_black, 0.6);

with(obj_lightsource)
{
	//Make the lights wobble
	var wobble_amount_X = image_xscale + random_range(-wobble, wobble);
	var wobble_amount_Y = image_yscale + random_range(-wobble, wobble);
	
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(spr_light_sphere, image_index, x, y, wobble_amount_X , wobble_amount_Y, 0, c_white, intensity);
	
	if(obj_lightsource.x != o_player.x and obj_lightsource.y != o_player.y)
		{
			gpu_set_blendmode(bm_add);
			draw_sprite_ext(spr_light_sphere, image_index, x, y, wobble_amount_X , wobble_amount_Y, 0, color, intensity);
		}
	gpu_set_blendmode(bm_normal);
}

surface_reset_target();

//Draw the surface after the player (In player Draw)