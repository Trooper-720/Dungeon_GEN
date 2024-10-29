//Change the seed everytime
randomize();

//Size of the tiles
#macro TILESIZE 16
#macro FLOOR 16
#macro WALL 17
#macro PFPOINT 18
#macro DOOR 19
#macro PFTRAIL 20

//Setup the grid
_grid = ds_grid_create(room_width/TILESIZE, room_height/TILESIZE);

//Setup the motion-planning grid
_mpGrid = mp_grid_create(0, 0, room_width/TILESIZE, room_height/TILESIZE, TILESIZE, TILESIZE);


//Set all values to 0
ds_grid_set_region(_grid, 0, 0, ds_grid_width(_grid)-1, ds_grid_height(_grid)-1, 0);

//Iterations of BSP
grid_level = 0;
iteration = 0;
max_Iteration = 4;

//Room Array to hold coords for path finding
room_count = 0;
room_coords = []; //[x,y, width, height, pathx, pathy] 2d array

//Start the BSP
treeNode(0, 0, ds_grid_width(_grid)-1, ds_grid_height(_grid)-1, iteration);

//Clean up the walls (i.e remove walls in rooms)
#region clean up the walls
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		//is a floor block
		if(ds_grid_get(_grid, i, j) == FLOOR)
		{
			//Down direction 
			if(_grid[# i, j+1] == WALL and _grid[# i, j+2] == WALL and _grid[# i, j+3] == FLOOR)
			{
				_grid[# i, j+1] = FLOOR;
				_grid[# i, j+2] = FLOOR;
			}
			//up direction 
			if(_grid[# i, j-1] == WALL and _grid[# i, j-2] == WALL and _grid[# i, j-3] == FLOOR)
			{
				_grid[# i, j-1] = FLOOR;
				_grid[# i, j-2] = FLOOR;
			}
			//Left direction 
			if(_grid[# i-1, j] == WALL and _grid[# i-2, j] == WALL and _grid[# i-3, j] == FLOOR)
			{
				_grid[# i-1, j] = FLOOR;
				_grid[# i-2, j] = FLOOR;
			}
			//Right direction 
			if(_grid[# i+1, j] == WALL and _grid[# i+2, j] == WALL and _grid[# i+3, j] == FLOOR)
			{
				_grid[# i+1, j] = FLOOR;
				_grid[# i+2, j] = FLOOR;
			}
		}
	}
}
#endregion

//Spawn the random doors
#region spawn doors
for(var i = 0; i < array_length(room_coords); i++)
{
	var randDistW1 = irandom_range(1, room_coords[i][2]-1);
	var randDistW2 = irandom_range(1, room_coords[i][2]-1);
	var randDistH1 = irandom_range(1, room_coords[i][3]-1);
	var randDistH2 = irandom_range(1, room_coords[i][3]-1);
	var maximumWallSupport = 3;
	if((room_coords[i][2]/randDistW1) <= maximumWallSupport){
		ds_grid_set(_grid, room_coords[i][0]+ randDistW1, room_coords[i][1], DOOR);
	}
	if((room_coords[i][2]/randDistW2) <= maximumWallSupport){
		ds_grid_set(_grid, room_coords[i][0]+ randDistW2, room_coords[i][1]+room_coords[i][3], DOOR);
	}
	if((room_coords[i][3]/randDistH1) <= maximumWallSupport){
		ds_grid_set(_grid, room_coords[i][0], room_coords[i][1] + randDistH1, DOOR);
	}
	if((room_coords[i][3]/randDistH2) <= maximumWallSupport){
		ds_grid_set(_grid, room_coords[i][0]+room_coords[i][2], room_coords[i][1] + randDistH2, DOOR);
	}
}
#endregion

//Remove the doors that spawned in the middle of rooms
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		if(ds_grid_get(_grid, i, j) == DOOR)
		{
			if(_grid[# i+1, j] == FLOOR and _grid[# i-1, j] == FLOOR and _grid[# i, j+1] == FLOOR and _grid[# i, j-1] == FLOOR) 
			{
				ds_grid_set(_grid, i, j , FLOOR);
			}
		}
	}
}

//Add the obstacles for the MP grid
#region add obstacles
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		if(ds_grid_get(_grid, i, j) == WALL)
		{
			mp_grid_add_cell(_mpGrid, i, j);
		}
	}
}
#endregion

//Pathing Array
pathsArray = [];

//Check if the level is vaild can the pathfinding ai get to every room
#region Pathfind
//Set the object position
x = room_coords[0][4]*TILESIZE;
y = room_coords[0][5]*TILESIZE;
var okPaths = 0;

for(var i = 0; i < room_count; i++)
{
	var pathable = false;
	var myPath = path_add();
	pathable = mp_grid_path(_mpGrid, myPath, x, y, room_coords[i][4]*TILESIZE, room_coords[i][5]*TILESIZE, false);
	pathsArray[i] = myPath;
	if(pathable == false) 
	{
		show_debug_message("Path Not Found!");
		break;
	}
	else if(pathable == true) 
	{
		okPaths++;
		path_start(myPath, 64, path_action_stop, true);
		//Add the cooridoors
	}
	if(okPaths == (room_count)) break;
}

if(okPaths == (room_count)) show_debug_message("PATH FOUND!");
#endregion

//Assign the numbers that relate to the path to the regular grid
#region draw the path finding path 
for(var i = 0; i < array_length(pathsArray); i++)
{
	for(var j = 0 ; j <= 1; j += 0.001)
	{
		var xP = floor(path_get_x(pathsArray[i], j)/TILESIZE);
		var yP = floor(path_get_y(pathsArray[i], j)/TILESIZE);
		var pointValue = ds_grid_get(_grid, xP, yP);
		if(pointValue != FLOOR and pointValue != WALL and pointValue != DOOR)
		{
			//Set as floor value
			ds_grid_set(_grid, xP, yP, PFTRAIL);
		}
	}
}
#endregion

//Draw the corridor
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		if(ds_grid_get(_grid, i, j) == PFTRAIL)
		{
			if(_grid[# i+1, j] != FLOOR and _grid[# i+1, j] != WALL and _grid[# i+1, j] != DOOR and _grid[# i+1, j] != PFTRAIL)
			{
				_grid[# i+1, j] = WALL;
			}
			if(_grid[# i-1, j] != FLOOR and _grid[# i-1, j] != WALL and _grid[# i-1, j] != DOOR and _grid[# i-1, j] != PFTRAIL)
			{
				_grid[# i-1, j] = WALL;
			}
			if(_grid[# i, j+1] != FLOOR and _grid[# i, j+1] != WALL and _grid[# i, j+1] != DOOR and _grid[# i, j+1] != PFTRAIL)
			{
				_grid[# i, j+1] = WALL;
			}
			if(_grid[# i, j-1] != FLOOR and _grid[# i, j-1] != WALL and _grid[# i, j-1] != DOOR and _grid[# i, j-1] != PFTRAIL)
			{
				_grid[# i, j-1] = WALL;
			}
		}
	}
}

//check if door is connected to a pathway if so keep it else replace it with a wall
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		var connected = false
		if(ds_grid_get(_grid, i, j) == DOOR)
		{
			if(_grid[# i+1, j] == PFTRAIL) connected = true; 
			else if(_grid[# i-1, j] == PFTRAIL) connected = true; 
			else if(_grid[# i, j+1] == PFTRAIL) connected = true; 
			else if(_grid[# i, j-1] == PFTRAIL) connected = true; 
			
			if(connected == false) _grid[# i, j] = WALL;
		}
	}
}

//Remove the path way from the grid
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		if(ds_grid_get(_grid, i, j) == PFTRAIL)
		{
			ds_grid_set(_grid, i, j, FLOOR);
		}
	}
}

//Add corners to the corridors
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		if(_grid[# i,j] != WALL and _grid[# i,j] != DOOR and _grid[# i,j] != FLOOR)
		{
			_grid[# i, j] = WALL;
		}
	}
}

//Add obstacles aagain
#region add obstacles
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		if(ds_grid_get(_grid, i, j) == WALL)
		{
			mp_grid_add_cell(_mpGrid, i, j);
		}
	}
}
#endregion

//Put the Walls(collisions)into the room
global.ground_layer = layer_create(100);
dung_layer = layer_tilemap_create(global.ground_layer, 0, 0, tl_dungeon2, room_width, room_height);
var tilemap = dung_layer;
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
		//Put the floor in
		if(_grid[# i, j] == FLOOR)
		{
			//Overhang and wall 
			//Add the ground tile overhangs into the abyss
			if(_grid[# i, j+1] == WALL and _grid[# i, j-1] == WALL)
			{
				//Ground Tile connecting to wall
				var data = randomArrayPick([32]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, j*TILESIZE);
				//Add the overhang tile
				var data = randomArrayPick([48]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, (j+1)*TILESIZE);
			}
			//Add the ground tile that connects to the wall if next to wall
			if(_grid[# i, j-1] == WALL)
			{
				var data = randomArrayPick([32]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, j*TILESIZE);
			}
			//Add the ground tile overhangs into the abyss
			else if(_grid[# i, j+1] == WALL)
			{
				//Put regular floor tile
				var data = randomArrayPick([33]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, j*TILESIZE);
				//Add the overhang tile
				var data = randomArrayPick([48]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, (j+1)*TILESIZE);
			}
			else
			{
				//Put regular floor tile
				var data = randomArrayPick([33]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, j*TILESIZE);
			}
		}
		//Put wall collision
		else if(_grid[# i, j] != FLOOR and _grid[# i, j] != DOOR)
		{
			instance_create_layer(i*TILESIZE, j*TILESIZE, "CollisionLayer", obj_Collision);
			//Add the walls (Tile)
			if((_grid[# i, j+1] == FLOOR or _grid[# i, j+1] == DOOR) and _grid[# i, j-1] == WALL )
			{
				var data = randomArrayPick([17]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, j*TILESIZE);
			}
			//Top layer of bricks
			if(_grid[# i, j] == WALL and _grid[# i, j-1] == WALL and (_grid[# i, j+1] == FLOOR or _grid[# i, j+1] == DOOR))
			{
				var data = randomArrayPick([1]);
				tilemap_set_at_pixel(tilemap, data, i*TILESIZE, (j-1)*TILESIZE);
			}
		}
		else
			{
				//empty tile
				//var data = randomArrayPick([148]);
				//tilemap_set_at_pixel(tilemap, data, i*TILESIZE, j*TILESIZE);
			}
	}
}

//Extra Tiles stuff
for(var i = 0; i < ds_grid_width(_grid); i++)
{
	for(var j = 0; j < ds_grid_height(_grid); j++)
	{
	}
}

//Spawn gameplay manager and player
instance_create_layer(0, 0, "Instances", o_gameplay_manager);

var randomX = irandom_range(floor((room_coords[0][0]+1)*TILESIZE), floor((room_coords[0][2]-1)*TILESIZE));
var randomY = irandom_range(floor((room_coords[0][1]+1)*TILESIZE), floor((room_coords[0][3]-1)*TILESIZE));
instance_create_layer(randomX, randomY, "Instances" ,obj_camera);
instance_create_layer(randomX, randomY, "Instances" ,o_player);




