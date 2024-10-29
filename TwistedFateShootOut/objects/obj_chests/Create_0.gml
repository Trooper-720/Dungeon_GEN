/// @description Pick a random item for the player
listOfItems = [obj_boots, obj_pill, obj_luck, obj_laser, obj_heart];
chosenItem = listOfItems[irandom_range(0, array_length(listOfItems)-1)];

image_speed = 0;
var scale = 1;
image_xscale = scale;
image_yscale = scale;
open = false;