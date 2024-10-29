function holdingCard(){
		//Stop the players current movements
		hsp = 0;
		vsp = 0;
	
		//Get players inputs
		script_execute(getInputsGamePad, gamepadSlot);
	
		//Get the combo the player wants
		var combo = 0;
		//Get the combo the player wants (also handle if the player is facing left)
		if(player_face_right == false)
		{
			var reversedMoveKeyString = "";
			for(var i = string_length(moveKeyString); i > 0; i--)
			{
				reversedMoveKeyString += string_char_at(moveKeyString, i);
			}
			combo = ds_map_find_value(global.combos, reversedMoveKeyString);
			if(combo == undefined) combo = REGULARPATH;
		}
		else
		{
			combo = ds_map_find_value(global.combos, moveKeyString);
			if(combo == undefined) combo = REGULARPATH;
		}
		
		//Card speed
		var cardSpd = 20;
	
		//Handle for players facing left
		if(player_face_right == false) cardSpd = -cardSpd;
		
		//Start animating aagain
		image_speed = 1;
	
		//Throw the card
		var handRange = x;
		if(player_face_right == false) handRange -= 16; else handRange += 16;
		var card = instance_create_layer(handRange,y, "instances_layer", obj_card)
		
		//Set the speed of the card
		card.spd = cardSpd;
		card.hsp = cardSpd;
		
		//Vibrate Controller
		gamepad_set_vibration(gamepadSlot,0.4,0.4);
		alarm_set(11,0.2*room_speed);
		//Shake the screen
		if(instance_exists(obj_camera)) obj_camera.ShakeLight();
		
		
		//Give the card the team name
		card.team = team;
		//Specifiy which object throw you
		card.thrower = self;
		//tell the card how much it costs
		card.costOfCard = deckLevel;
		//Set the cards damage
		card.damage = cardDamage;
		//Set the state of the card
		card.state = combo;
		
		//Card sprite
		card.sprite_index = cardSprite;
		
		//Get rid of 1 card
		currentCardAmount -= 1;
		
		//Add to the players amount of cards thrown
		cardsThrown += 1;
		
		//Set the players direction
		if(player_face_right) dir = 1; else dir = 3;
		
		//Make the soundfx
		audio_play_sound(sn_throwCard,100,false);
		
		//Return to idle state
		state = IDLE;
}