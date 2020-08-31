#version 330
layout (location = 0) in vec3 vertex;
uniform vec3 cubeColor;
uniform vec2 cubePosition;
uniform vec3 cameraPosition;
uniform float aspectRatio;

out vec4 fpos;


float cubeWidth = 0.2;
float border = 0.02;


mat4 rotx4(float t){
  return mat4(
	      1.0, 0, 0, 0,
	      0, cos(t), -sin(t), 0,
	      0, sin(t), cos(t), 0,
	      0, 0, 0, 1.0
	      );
}

// Only temporary
mat4 perspective(){
  float fovy = 3.1415 / 6.0;//3.1415 / 4;
  float f = 1.0 / tan(fovy / 2.0);
  float zNear = 100.0;
  float zFar  = 1.0;
  return mat4(
	      (f / aspectRatio), 0, 0, 0,
	      0, f, 0, 0,
	      0, 0, (zFar + zNear) / (zNear - zFar), (2.0 * zFar * zNear) / (zNear - zFar),
	      0, 0, (-1.0),0
	      );
}

void main(){

  vec4 f = vec4(vertex, 1.);

  fpos = f;
  f *= cubeWidth / 2;
  f.xy += (cubePosition - cameraPosition.xy) * (cubeWidth + border);
  f.z += cameraPosition.z;

  //f.y *= aspectRatio;

  gl_Position = perspective() * f;
}
