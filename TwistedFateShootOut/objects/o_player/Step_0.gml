//Run the correct state
switch(state)
{
	case IDLE: script_execute(state_IDLE); break;
	case MOVE: script_execute(state_MOVE); break;
	case HIT: break;
	case ROLL: script_execute(state_ROLL); break;
	//case RELOADING: script_execute(state_RELOAD); break;
}


//Update the location of the player Lights
playerLight.x = x;
playerLight.y = y;

//Reduce the flash
if(flashAlpha > 0){
	flashAlpha -= 0.05;
}
//Check if your dead
if(global.playerHealth <= 0) instance_destroy();
