//Draw the grid with corresponding colors
draw_set_font(fnt_STATUS);
draw_set_halign(fa_center);
var i = 0;
var j = 0;
repeat (ds_grid_width(_grid))
   {
   repeat (ds_grid_height(_grid))
      {
		  var n = ds_grid_get(_grid, i, j);
		  switch(n)
		  {
			  #region leafs for debug
			  //case(0): draw_set_color(c_dkgray); break;
			  //case(1): draw_set_color(c_gray); break;
			  //case(2): draw_set_color(c_red); break;
			  //case(3): draw_set_color(c_blue); break;
			  //case(4): draw_set_color(c_green); break;
			  //case(5): draw_set_color(c_lime); break;
			  //case(6): draw_set_color(c_ltgray); break;
			  //case(7): draw_set_color(c_maroon); break;
			  //case(8): draw_set_color(c_navy); break;
			  //case(9): draw_set_color(c_fuchsia); break;
			  //case(10): draw_set_color(c_aqua); break;
			  //case(11): draw_set_color(c_olive); break;
			  //case(12): draw_set_color(c_orange); break;
			  //case(13): draw_set_color(c_purple); break;
			  //case(14): draw_set_color(c_teal); break;
			  //case(15): draw_set_color(c_yellow); break;
			  #endregion
			  //case(FLOOR): draw_set_color(c_black); break; //Floor
			  //case(WALL): draw_set_color(make_colour_rgb(238, 0, 255)); break; //Wall
			  //case(PFPOINT): draw_set_color(c_white); break; //Path finding point
			  case(DOOR): draw_set_color(c_orange); break; //Doors (fake ones that will be patched after the path finding)
			  //case(PFTRAIL): draw_set_color(c_black); break; //path Trail
		  }
		  draw_set_alpha(1);
		  if(_grid[# i, j] == DOOR)
			draw_rectangle(i*TILESIZE, j*TILESIZE,i*TILESIZE+TILESIZE, j*TILESIZE+TILESIZE, false);  
		  
		  //Find which number is on the grid
		  //draw_set_color(c_white);
		  //draw_set_alpha(0.5);
		  //draw_text(i*TILESIZE + TILESIZE/2, j*TILESIZE, string(n));
      j += 1;
      }
   j = 0;
   i += 1;
}
