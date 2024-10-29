/// @description Draw the player variables
draw_set_font(fnt_regular);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(0, 0, "damage: "+string(damage)+"\nAttackSpd: "+string(attackSpd)+"\ncanAttack: "+string(canAttack)
+" (0 = false/ 1 = true)\nCoins: "+ string(global.coins) + "\nMove_Direction: "+ string(move_direction)+ "\nState: "+ string(state)
 +"\nAnim Direction: "+ string(anim_dir) +"\nCan Roll: "+ string(canRoll) +"\nRoll Time Up: "+ string(alarm_get(2)/room_speed));
 
//Draw the gambler Vision bar
var size = 100;
var height = 20;
var value = (currentGambleTime/maxGambleTime)*100;
if(instance_exists(o_gameplay_manager))
{
	if(o_gameplay_manager.bulletTime == true)
	{
		draw_set_font(fnt_STATUS);
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_text(room_width/2 , 10, "GAMBLER VISION")
		draw_healthbar(room_width/2 - size, 32,room_width/2 +size, 32+height, value, c_black, c_purple, c_purple, 0, true, true);
	}
	else if(o_gameplay_manager.bulletTime == false and value == 0)
	{
		//Draw a rectangle then text
		draw_set_color(c_black);
		var boxWidth = 100;
		draw_rectangle(room_width/2 - boxWidth, 6, room_width/2 + boxWidth, 6+45, false);
		draw_set_font(fnt_STATUS);
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_text(room_width/2 , 10, "ON COOLDOWN\nTIME LEFT: " + string(round(alarm_get(5)/room_speed)) +"s");
	}
}
