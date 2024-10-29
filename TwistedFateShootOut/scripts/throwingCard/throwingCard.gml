function throwingCard(){
	//Stop the players current movements
	hsp = 0;
	vsp = 0;
	
	//Get players inputs
	script_execute(getInputsGamePad, gamepadSlot);
	
	//Set the animation
	if(player_face_right) sprite_index = spriteThrowRight;
	else sprite_index = spriteThrowLeft;
	
	//Bad solution to animation prob
	if(image_index == 5) image_speed = 0;
	
	
	//Check for combos
	checkCombos();
	
	//Keep your state since player has not let go of throw card state
	state = THROW;
	
	//Throw card only when the throw button is released
	if(throwCard == 0)
	{
		image_index = 5;
		image_speed = 0;
		state = HOLDINGCARD;
	}
	//Bad solution to animation prob
	if(image_index == 5) image_speed = 0;
	
}