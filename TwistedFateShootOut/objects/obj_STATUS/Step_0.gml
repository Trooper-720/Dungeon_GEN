/// @description 
if(life >= 0) 
{
	life--;
	verticalMove = lerp(verticalMove, maxVerticalMove, 0.1);
	alpha += 0.05;
	if(alpha > 1) alpha = 1;
}
else instance_destroy();