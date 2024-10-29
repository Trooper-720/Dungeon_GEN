function treeNode(_xStart, _yStart, _gWidth, _gHeight, _iter){
	var cutVertical = irandom_range(0,1);
	var minimumThreshold =  12; //How big the leafs can be
	var minRoomSize = minimumThreshold - 3; //the minimum size of the rooms
	
	var internalIteration = _iter
	
	//(x, y) and (xx, yy)
	var _x  = noone;
	var _y  = noone;
	var _xx = noone;
	var _yy = noone;
	
	if(cutVertical){
		_x  = round((_gWidth +_xStart)/2); 
		_y  = _yStart;
		_xx = _x;
		_yy = _gHeight;
		
		if(internalIteration < max_Iteration and (_x - _xStart) >= minimumThreshold){
			//Assign the colors
			var temp = ds_grid_get(_grid, _xStart, _yStart);
			ds_grid_set_region(_grid, _xStart, _yStart, _x, _gHeight, temp);
			grid_level++;
			ds_grid_set_region(_grid, _xx+1, _yStart, _gWidth, _gHeight, grid_level);
			
			
			//Continue making Nodes
			treeNode(_xStart, _yStart, _x, _gHeight, internalIteration+1); //left block
			treeNode(_xx+1, _yStart, _gWidth, _gHeight, internalIteration+1); //right block
		}
		else
		{
			//Assign the region a room as this is a leaf of the BSP
			//16 == floor
			var xR = irandom_range(_xStart, _gWidth);
			var yR = irandom_range(_yStart, _gHeight);
			var xxR = irandom_range(_xStart, _gWidth);
			var yyR = irandom_range(_yStart, _gHeight);
			while((xxR - xR) < minRoomSize or  (yyR - yR) < minRoomSize)
			{
				if((xxR - xR) < minRoomSize) 
				{
					xxR = irandom_range(_xStart, _gWidth);
					xR = irandom_range(_xStart, _gWidth);
				}
				if((yyR - yR) < minRoomSize)
				{
					var yR = irandom_range(_yStart, _gHeight);
					var yyR = irandom_range(_yStart, _gHeight);
				}
			}
			//Treating as entire block
			//Draw room
			ds_grid_set_region(_grid, xR, yR, xxR, yyR, FLOOR);
			//Draw Wall
			ds_grid_set_region(_grid, xR, yR, xxR, yR, WALL); //Top
			ds_grid_set_region(_grid, xR, yyR, xxR, yyR, WALL); //Bottom
			ds_grid_set_region(_grid, xR, yR, xR, yyR, WALL); //Left
			ds_grid_set_region(_grid, xxR, yR, xxR, yyR, WALL); //Right
			//Draw the path finding point anywhere in the room
			var randPointX = irandom_range(xR+1, xxR-1);
			var randPointY = irandom_range(yR+1, yyR-1);
			ds_grid_set(_grid, randPointX, randPointY, PFPOINT);
			
			//Store the size of the room and the coordinates with the path finding point
			var width = xxR-xR;
			var height = yyR-yR;
			room_coords[room_count] = [xR, yR, width, height, randPointX, randPointY];
			room_count++;
		}
	}
	else if(cutVertical == false)
	{
		_x  = _xStart;
		_y  = round((_gHeight +_yStart)/2); 
		_xx = _gWidth;
		_yy = _y;
		
		if(internalIteration < max_Iteration and (_y - _yStart) >= minimumThreshold){
			//Assign the colors
			var temp = ds_grid_get(_grid, _xStart, _yStart);
			ds_grid_set_region(_grid, _xStart, _yStart, _gWidth, _y, temp);
			grid_level++;
			ds_grid_set_region(_grid, _xStart, _y+1, _gWidth, _gHeight, grid_level);
			
			
			//Continue making Nodes
			treeNode(_xStart, _yStart, _gWidth, _y, internalIteration+1);
			treeNode(_xStart, _y+1, _gWidth, _gHeight, internalIteration+1);
		}
		else
		{
			//Assign the region a room as this is a leaf of the BSP
			//16 == floor
			var xR = irandom_range(_xStart, _gWidth);
			var yR = irandom_range(_yStart, _gHeight);
			var xxR = irandom_range(_xStart, _gWidth);
			var yyR = irandom_range(_yStart, _gHeight);
			while((xxR - xR) < minRoomSize or  (yyR - yR) < minRoomSize)
			{
				if((xxR - xR) < minRoomSize) 
				{
					xxR = irandom_range(_xStart, _gWidth);
					xR = irandom_range(_xStart, _gWidth);
				}
				if((yyR - yR) < minRoomSize)
				{
					var yR = irandom_range(_yStart, _gHeight);
					var yyR = irandom_range(_yStart, _gHeight);
				}
			}
			//Treating as entire block
			//Draw room
			ds_grid_set_region(_grid, xR, yR, xxR, yyR, 16);
			//Draw Wall
			ds_grid_set_region(_grid, xR, yR, xxR, yR, 17); //Top
			ds_grid_set_region(_grid, xR, yyR, xxR, yyR, 17); //Bottom
			ds_grid_set_region(_grid, xR, yR, xR, yyR, 17); //Left
			ds_grid_set_region(_grid, xxR, yR, xxR, yyR, 17); //Right
			//Draw the path finding point anywhere in the room
			var randPointX = irandom_range(xR+1, xxR-1);
			var randPointY = irandom_range(yR+1, yyR-1);
			ds_grid_set(_grid, randPointX, randPointY, 18);
			
			//Store the size of the room and the coordinates
			var width = xxR-xR;
			var height = yyR-yR;
			room_coords[room_count] = [xR, yR, width, height, randPointX, randPointY];
			room_count++;
		}
	}
}