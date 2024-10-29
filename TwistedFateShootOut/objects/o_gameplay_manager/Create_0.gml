/// @description Initialize Variables

//Player States
#macro IDLE 1
#macro MOVE 2
#macro ROLL 3
#macro HIT 4
#macro RELOADING 5

//Enemy STATES
#macro CHASE 1
#macro HURT 2

//Global Vars for the player
global.coins = 0;
global.playerSpeed = 1.5;
global.playerHealth = 3;
global.playerLuck = 0;
global.playerLaser = false;
audio_group_load(ag_BG);


//Bullet Time (SLOWMO)
bulletTime = false;
bulletTimeFactor = 1;

//Damage flash
global.enemyFlashColor = c_white;
global.playerFlashColor = c_red;


lighting_surf = -1;
