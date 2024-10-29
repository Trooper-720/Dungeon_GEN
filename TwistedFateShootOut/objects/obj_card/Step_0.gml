/// @description Move the card

hsp = lengthdir_x(spd, dir)*o_gameplay_manager.bulletTimeFactor;
vsp = lengthdir_y(spd, dir)*o_gameplay_manager.bulletTimeFactor;
x += hsp;
y += vsp;