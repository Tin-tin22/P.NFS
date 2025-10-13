#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect osgOcean_ColorTexture;
const float glowAlphaValue = 0.5; //The alpha value that indicates glowing

void main( void )
{
	vec4 color = texture2DRect(osgOcean_ColorTexture, gl_TexCoord[0].st);

	if (color.a <= 0.51 )
    {
        color.a = 1.0;
        gl_FragColor = color;
    }
	else
		gl_FragColor = vec4(0.0);
}