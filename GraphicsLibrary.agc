
//*** Returns the angle of rotation required to ***
//*** have a sprite point in the direction of ***
//*** (x_new, y_new) when currently positioned ***
//*** at (x_old, y_old). Result -180 to +180. ***

function CalculateSpriteAngle(x_old as float, y_old as float, x_new as float, y_new as float)
	x_move as float
	y_move as float
	aspect as float
	//*** Calculate move required in x and y directions ***
	x_move = x_new - x_old
	y_move = y_new - y_old
	
	//*** Calculate the screen’s aspect ratio ***
	aspect = GetDeviceWidth()/(GetDeviceHeight()*1.0)
	//*** Calculate the angle of rotation needed ***
	angle = ATan2(y_move/aspect, x_move)
	//*** Return angle ***
endfunction angle
