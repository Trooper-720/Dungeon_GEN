/// @description Move camera
if(shake)
{
	var diff = 8;
	var xnew = random_range(x + -diff, x + diff);
	var ynew = random_range(y + -diff, y + diff);
	var vm = matrix_build_lookat(xnew, ynew, -10, xnew, ynew, 0, 0, 1, 0);
	camera_set_view_mat(camera, vm);
}
else
{
		x += (xTo - x)/25;
		y += (yTo - y)/25;

		if (follow != noone)
		{
			xTo = follow.x;
			yTo = follow.y;
		}

		var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);

		camera_set_view_mat(camera, vm);
		
		//Move the zoom of the camera
		if(cZoomX != targetZoomX or cZoomY != targetZoomY)
		{
			cZoomX = lerp(cZoomX, targetZoomX, speedOfZoom);
			cZoomY = lerp(cZoomY, targetZoomY, speedOfZoom);
			var pm = matrix_build_projection_ortho(cZoomX, cZoomY, 1, 100000);
			camera_set_proj_mat(camera, pm);
		}
		if(zoom)
		{
			targetZoomX = pWidth/1.2;
			targetZoomY = pHeight/1.2;
			var pm = matrix_build_projection_ortho(cZoomX, cZoomY, 1, 100000);
			camera_set_proj_mat(camera, pm);
		}
}