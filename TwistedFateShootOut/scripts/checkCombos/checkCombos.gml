function checkCombos(){
	//Time delay for combos
	var timeDelay = 20;
	//Check each key
	for(var i = 0; i < ds_list_size(global.p1Map); i++){
		var key = ds_list_find_value(global.p1Map, i)[? "key"];
		if(is_array(key))
		{
			//Check if the key is pressed and it has not been pressed preivously
			if(gamepad_button_check(gamepadSlot, array_get(key, 0)) and gamepad_button_check(gamepadSlot, array_get(key, 1)) and ds_list_find_value(global.p1Map, i)[? "beenPressed"] == false)
			{
				moveKeyString += ds_list_find_value(global.p1Map, i)[? "FGInput"];
				ds_list_find_value(global.p1Map, i)[? "beenPressed"] = true;
				//Set the time between combo input resets
				alarm_set(5, timeDelay);
			}
			//Check if the key is pressed and it has not been pressed preivously
			else if(((gamepad_button_check(gamepadSlot, array_get(key, 0)) == false) or (gamepad_button_check(gamepadSlot, array_get(key, 1)) == false)) and ds_list_find_value(global.p1Map, i)[? "beenPressed"] == true)
			{
				ds_list_find_value(global.p1Map, i)[? "beenPressed"] = false;
			}
		}
		else
		{
		//Check if the key is pressed and it has not been pressed preivously
			if((gamepad_button_check(gamepadSlot, key) == true) and (ds_list_find_value(global.p1Map, i)[? "beenPressed"] == false))
			{
				moveKeyString += ds_list_find_value(global.p1Map, i)[? "FGInput"];
				ds_list_find_value(global.p1Map, i)[? "beenPressed"] = true;
				//Set the time between combo input resets
				alarm_set(5, timeDelay);
			}
			else if((gamepad_button_check(gamepadSlot, key) == false) and (ds_list_find_value(global.p1Map, i)[? "beenPressed"] == true))
			{
				ds_list_find_value(global.p1Map, i)[? "beenPressed"] = false;
			}
		}
	}
}