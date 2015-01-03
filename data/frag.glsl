#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec4 nearColor;
uniform vec4 farColor;
uniform float near;
uniform float far;
uniform float near2;
uniform float far2;
uniform bool doble;
uniform bool invert;

varying vec4 vertColor;

void main() {
	vec4 color;
	if(doble){
		
        color = mix(nearColor, farColor, smoothstep(near, far, gl_FragCoord.z / gl_FragCoord.w)-
           smoothstep(near2, far2, gl_FragCoord.z / gl_FragCoord.w)) ;
        

    }
    else{
        color = mix(nearColor, farColor, smoothstep(near, far, gl_FragCoord.z / gl_FragCoord.w));	

    }

    if(invert){
    	color.r=1.0-color.r;
    	color.g=1.0-color.g;
    	color.b=1.0-color.b;

    }

    gl_FragColor = color;


}