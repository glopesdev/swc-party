#version 400
uniform float alpha;
uniform sampler2D tex;
uniform sampler2D accum;
in vec2 texCoord;
out vec4 fragColor;

void main()
{
  vec4 axel = texture(accum,texCoord);
  vec4 texel = texture(tex, vec2(texCoord.x,1-texCoord.y));
  fragColor = texel * alpha + axel * (1 - alpha);
}
