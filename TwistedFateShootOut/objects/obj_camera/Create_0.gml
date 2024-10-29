/// @description Make a camera
//setup for camera
camera = camera_create();

//Window of the game make sure its a multiple of the room size
pWidth = 1280; 
pHeight = 720;

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(pWidth, pHeight, 1, 100000);

camera_set_view_mat(camera, vm);
camera_set_proj_mat(camera, pm);

view_camera[0] = camera;

//Follow control for camera
follow = obj_CameraTarget;
xTo = x;
yTo = y;

//Shake for camera
shake = false;
shakeTime = room_speed * 0.2;

//Zoom and Follow
//follow var is already made
zoom = false;
zoomTime = room_speed * 0.1;
cZoomX = pWidth; //Current Zoom Size width
cZoomY = pHeight; //Current Zoom Size height
targetZoomX = pWidth;
targetZoomY = pHeight;
speedOfZoom = 0.2; //From 0 to 1;


//Shake Function
function Shake()
{
	shake = true;
	alarm_set(0, shakeTime/2);
}

function ShakeLight()
{
	shake = true;
	alarm_set(0, shakeTime/2);
}


function ShakeEndZone()
{
	shake = true;
	alarm_set(0, room_speed * 0.05);
}

//Zoom Function
function Zoom(_objToFollow)
{
	zoom = true;
	follow = _objToFollow;
	alarm_set(1, zoomTime);
}

function SuperZoom(_objToFollow)
{
	zoom = true;
	follow = _objToFollow;
	alarm_set(1, zoomTime*8);
}
