/*
* This source file is part of the osgOcean library
* 
* Copyright (C) 2009 Kim Bale
* Copyright (C) 2009 The University of Hull, UK
* 
* This program is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free Software
* Foundation; either version 3 of the License, or (at your option) any later
* version.

* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
* http://www.gnu.org/copyleft/lesser.txt.
*/

// ------------------------------------------------------------------------------
// -- THIS FILE HAS BEEN CREATED AS PART OF THE BUILD PROCESS -- DO NOT MODIFY --
// ------------------------------------------------------------------------------

static const char bawe_glow_convolution_frag[] =
        "#extension GL_ARB_texture_rectangle : enable\n"
        "\n"
        "uniform sampler2DRect osgOcean_ConvTexture;\n"
		"uniform float sample;\n"
		"uniform vec2 direction;\n"
        "\n"
        "void main( void )\n"
        "{\n"
		"    vec4 convColor= vec4(0.0);\n"
		"    vec2 texCoordSample1 = vec2(0.0);\n"
		"    vec2 texCoordSample2 = vec2(0.0);\n"
		"    float sf= float(0.0);\n"
        "    for (int s = 0; s < sample; s++)\n"
        "    {\n"
		"        sf = float(s);\n"
		"        texCoordSample1 = gl_TexCoord[0] + (direction*sf*1.0);\n"
		"        texCoordSample2 = gl_TexCoord[0] - (direction*sf*1.0);\n"
        "        convColor += texture2DRect(osgOcean_ConvTexture, texCoordSample1);\n"
        "        convColor += texture2DRect(osgOcean_ConvTexture, texCoordSample2);\n"
        "    }\n"
        "    vec4 color = vec4(convColor /  (sample*2) );\n"
		"    gl_FragColor = clamp(color, 0.0, 1.0);\n"
        "}\n";