/// @description Draw the text (status)
if(instance_exists(o_player))
{
	draw_set_font(fnt_STATUSs);
	draw_set_halign(fa_center);
	draw_text_color(o_player.x, o_player.y - verticalMove, status, color, color,
	color, color, alpha);
}