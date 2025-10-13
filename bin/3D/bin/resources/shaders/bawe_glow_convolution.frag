#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect osgOcean_ConvTexture;
uniform float sample;
uniform vec2 direction;

void main( void )
{
    vec4 convColor= vec4(0.0);
    vec2 texCoordSample1 = vec2(0.0);
    vec2 texCoordSample2 = vec2(0.0);
    float sf= float(0.0);

    for (int s = 0; s < sample; s++)
    {
        sf = float(s);
        texCoordSample1 = gl_TexCoord[0] + (direction*sf*1.0);
        texCoordSample2 = gl_TexCoord[0] - (direction*sf*1.0);
        convColor += texture2DRect(osgOcean_ConvTexture, texCoordSample1);
        convColor += texture2DRect(osgOcean_ConvTexture, texCoordSample2);
    }

    vec4 color = vec4(convColor /  (sample*2) );
    gl_FragColor = clamp(color, 0.0, 1.0);
}