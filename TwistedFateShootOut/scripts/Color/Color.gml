//Shader setup (make sure comes after assigning sprite)
function Color (r, g, b) constructor {
	red = r;
	green = g;
	blue = b;
	
	static toShaderValue = function (value) {
		return value / 255;
	}
};