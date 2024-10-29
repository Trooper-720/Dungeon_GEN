//Gamepad Assignment and Camera lock
gamepad = 0; 
gamepad_set_axis_deadzone(gamepad, 0.2);
threshold = 0.1; //Analogue sensitivity 
with(obj_camera)
{
	follow = other;
}

//Cursor Radius around player and Coords of Cursor
radius = 70; // For the cursor
xCursor = 0;
yCursor = 0;
show_cursor = false;
cursor_direction = 0;

//Hand stuff
xHand = 0;
yHand = 0;
handRadius = 6;

state = IDLE;
//Player Movement variables
hsp = 0;
vsp = 0;
move_speed		= global.playerSpeed; // This is the player's baseline move speed.
move_direction	= 0;  // This is the direction the player will move. This value will change as we hit different inputs.

//Player Stats
damage = 1;
attackSpd = 0.2*room_speed; 

	//Throwing cards and reload
	canAttack = true;
	maxDeckSize = 8;
	currentCards = maxDeckSize;
	reloadTime = 1;
	
//Gamblers Vision
maxGambleTime = 2;
currentGambleTime = maxGambleTime;
gambleCoolDown = 3;
inGambleVision = false;


//Dodge Roll 
canRoll = true;
roll_Delay = 0.7;
dodge_speed = 4;
dodgeLength = 30;
maxDodgeLength = dodgeLength;

//Animation Stuff
anim_dir = 0; //Used for all the animations of the player
last_dir = 0; //Used to save the last direction the player is facing

//Hurt Flash
flashAlpha = 0;
immune = false;

//Lighting
playerLight = instance_create_layer(x, y, "Instances", obj_lightsource);
var scale = 2;
playerLight.image_xscale = scale;
playerLight.image_yscale = scale;

playerLight.color = c_red;
