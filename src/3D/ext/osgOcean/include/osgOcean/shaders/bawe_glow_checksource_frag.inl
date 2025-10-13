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

static const char bawe_glow_checksource_frag[] =
	"#extension GL_ARB_texture_rectangle : enable\n"
	"\n"
	"uniform sampler2DRect osgOcean_ColorTexture;\n"
    "const float glowAlphaValue = 0.05; //The alpha value that indicates glowing\n"
    "\n"
    "void main( void )\n"
    "{\n"
    "    vec4 color = texture2DRect(osgOcean_ColorTexture, gl_TexCoord[0].st);\n"
    "    \n"
    "    if(color.a == glowAlphaValue)\n"
    "    {\n"
    "        color.a = 1.0;\n"
    "        gl_FragColor = color;\n"
    "    }\n"
    "    else\n"
    "        gl_FragColor = vec4(0.0);\n"
    "}\n";
