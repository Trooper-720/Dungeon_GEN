/// @description Initialize Variables

state = IDLE;
alarm_set(0, 1.5*room_speed);

targetX = 0;
targetY = 0;

spd = 1.2;
spdHurt = 1.7;

enemyHp = 3;
knockbackDir = 0;
hsp = 0;
vsp = 0;

flashAlpha = 0;

myPath = undefined;


//Lighting
enemyLight = instance_create_layer(x, y, "Instances", obj_lightsource);
var scale = 1.5;
enemyLight.image_xscale = scale;
enemyLight.image_yscale = scale;

enemyLight.color = c_purple;
enemyLight.intensity = 0.8;
