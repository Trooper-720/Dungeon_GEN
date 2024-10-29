//Not my code make sure to cite
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float range;
uniform vec4 colorMatch;
uniform vec4 colorReplace;

void main()
{
	
	vec4 pixelColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float newRange = range / 255.0;
		
	if(abs(pixelColor.r - colorMatch.r) <= newRange) {
		if(abs(pixelColor.g - colorMatch.g) <= newRange) {
			if(abs(pixelColor.b - colorMatch.b) <= newRange) {	
				// replace red
				pixelColor.r = colorReplace.r;
				// replace green
				pixelColor.g = colorReplace.g;
				// replace blue
				pixelColor.b = colorReplace.b;
			}
		}
	}
	
    gl_FragColor = pixelColor;
}
