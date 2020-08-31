#version 330

uniform vec3 cubeColor;
uniform vec2 cubePosition;
uniform vec3 cameraPosition;
uniform float aspectRatio;
in vec4 fpos;

out vec4 fragColor;


void main(){
  vec3 color = cubeColor;
  color *= 1.0 / (abs((-1.0) - fpos.z));
  fragColor = vec4(color, 1.0);

}
