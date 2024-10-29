/// @description Draw self
timer++;
y_anim = y_anim + sin(timer * 0.15 ) * 0.7;
draw_sprite_ext(sprite_index, image_index, x, y_anim, 1, 1, 0, c_white, 1);


//For the time slow Effect
image_speed = o_gameplay_manager.bulletTimeFactor;

//Sprite Scaling
scale = 1;
if(sign(image_xscale) == -1) image_xscale = -scale;
else if(sign(image_xscale) == 1) image_xscale = scale;
image_yscale = scale;