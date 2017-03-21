#version 400
uniform mat4 warp;
uniform mat4 modelview;
uniform mat4 projection;
uniform sampler2D tex;
uniform mat4 rotation;
uniform double audio;
uniform double u_time;

in vec3 vp;
in vec3 vn;
out vec3 position;
out vec3 normal;
out vec4 color;

uniform double activeY = -1;
uniform float rangeY = 1;
uniform double negativeCentreY = -1;
uniform double negativeRangeY = 1;

void main()
{
  mat4 normalmat = transpose(inverse(modelview));
  vec4 v = modelview * rotation* vec4(vp, 1.0);
  gl_Position = (projection * v) * warp;
  position = vec3(v);
  normal = normalize(vec3(normalmat * vec4(vn, 0.0)));
  //double flicker = 0.0;
  //if (audio < 1500) {flicker = 0.0;} else {flicker = 1.0;}
  float r = 0.0;

  if (vp.y > activeY - rangeY && vp.y < activeY + rangeY)
  {
    r = 1.0;
  }
  else r = 0.3;

  float b = 0.0;
  if (vp.y > negativeCentreY - negativeRangeY && vp.y < negativeCentreY + negativeRangeY)
  {
    b = 1.0;
  }
  else b = 0.3;

  color = vec4(r,0.3,b,1.0);
  //color = vec4(0.3+sin(float(u_time)*vp.y),0.3,0.3,1.0);
  //color = texture(tex,vp.xy/10.0)+vec4(0.4+flicker,0.4+flicker,0.4+flicker,1.0); //vec3(1.0,0.0,0.0);
}
