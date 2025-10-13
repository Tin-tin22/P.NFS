#include "treeactor.h"

#include <osg/TexEnv>

////////////////////////////////////////////////////////////
TreeActor::TreeActor(dtGame::GameActorProxy& proxy)
    : dtActors::GameMeshActor(proxy)
{
}

void TreeActor::AddedToScene(dtCore::Scene* scene)
{
    dtActors::GameMeshActor::AddedToScene(scene);

    if (GetMeshNode())
    {
        //Set stateset
        osg::StateSet* ss = GetMeshNode()->getOrCreateStateSet();

        ss->addUniform( new osg::Uniform( "baseTexture", 0 ) );
        ss->setTextureAttribute(0,new osg::TexEnv(osg::TexEnv::BLEND),osg::StateAttribute::ON);
        //ss->setMode()

        //Set Programs
        osg::ref_ptr<osg::Program> program = new osg::Program;

        char vertexSource[]=
            "void main(void)\n"
            "{\n"
            "    gl_Position = ftransform();\n"
            "    gl_TexCoord[0] = gl_MultiTexCoord0;\n"
            "}\n";

        char fragmentSource[]=
            "uniform sampler2D baseTexture;\n"
            "\n"
            "void main(void)\n"
            "{\n"
            "   vec4 color = texture2D( baseTexture, gl_TexCoord[0].st );\n"
            "   gl_FragColor = color;\n"
            "}\n";

        program->setName( "tree_material" );
        program->addShader(new osg::Shader(osg::Shader::VERTEX,   vertexSource));
        program->addShader(new osg::Shader(osg::Shader::FRAGMENT, fragmentSource));
        ss->setAttributeAndModes( program, osg::StateAttribute::ON );

    }
}

///////////////////////////////////////////////////////////////////////////////
TreeActorProxy::TreeActorProxy()
{
   SetClassName("TreeActor");
}

//-- BAWE-20111003: PEPOHONAN