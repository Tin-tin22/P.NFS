#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect osgOcean_ColorBuffer;
uniform sampler2DRect osgOcean_GlowBuffer;
uniform sampler2DRect osgOcean_GlowBuffer2;

void main(void)
{
	vec4 fullColor = texture2DRect(osgOcean_ColorBuffer, gl_TexCoord[0].st );
	vec4 glowColor = texture2DRect(osgOcean_GlowBuffer,  gl_TexCoord[0].st );
    vec4 glowColor2 = texture2DRect(osgOcean_GlowBuffer2,  gl_TexCoord[0].st );

    gl_FragColor = fullColor+glowColor+glowColor2; 
    //gl_FragColor = fullColor; 
}