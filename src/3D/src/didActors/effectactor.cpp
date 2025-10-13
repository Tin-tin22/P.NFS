#include "EffectActor.h"
#include "didactorssources.h"

#include <osg/TexEnv>
#include <osg/Material>

// -  [4/24/2014 EKA]
#include <osgParticle/ExplosionEffect>
#include <osgParticle/ExplosionDebrisEffect>
#include <osgParticle/SmokeEffect>
#include <osgParticle/SmokeTrailEffect>
#include <osgParticle/FireEffect>

/////////////////////////////////////////////////////// 
EffectActor::EffectActor(dtGame::GameActorProxy &proxy) : 
	dtGame::GameActor(proxy), 
	ExplodeSound(NULL),
	ExplodeParticle(NULL),
	mEffectIsRunning(false),
	mCycleLifeTime(0.0f)
	
{
	soundfile = "explosion.wav" ;
	particlefile = "explosion.osg" ;
}

EffectActor::~EffectActor()
{
	/*if (ExplodeSound)
	{
		ExplodeSound->Stop();
		dtAudio::AudioManager::GetInstance().FreeSound(ExplodeSound);
		ExplodeSound = NULL;
	}

	if (ExplodeParticle)
	{
		ExplodeParticle = NULL ;
	}*/

}

void EffectActor::SwitchOnEffect() 
{
	if ( ExplodeParticle != NULL )
	{
		ExplodeParticle->SetEnabled(false);
		ExplodeParticle->ResetTime();
		ExplodeParticle->SetEnabled(true);
		
		if ( ExplodeSound != NULL )
		{
			if ( ExplodeSound->IsPlaying() ) 
				 ExplodeSound->Stop();
			ExplodeSound->Play();
		}

		mCycleLifeTime = 0.0f ;
		mEffectIsRunning = true ;
	}

	
}

void EffectActor::OnExplode(const osg::Vec3 pos)
{
	if (!particlefile.empty())
	{
		ExplodeParticle= new dtCore::ParticleSystem();
		ExplodeParticle->LoadFile(particlefile.c_str(),true); 
		ExplodeParticle->SetEnabled(false);
		GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(ExplodeParticle.get());
		AddChild(ExplodeParticle.get());
	}

	if (!soundfile.empty())
	{
		ExplodeSound = dtAudio::AudioManager::GetInstance().NewSound();
		ExplodeSound->LoadFile(soundfile.c_str());
		assert(ExplodeSound);
		ExplodeSound->SetMaxDistance(1000.0f);
		ExplodeSound->SetLooping(false);
		AddChild(ExplodeSound.get());
	}

	pass_glare_shader();

	// - particle osg [4/24/2014 EKA]	
	/*osgParticle::ExplosionEffect* explosion = new osgParticle::ExplosionEffect(pos, 10.0f);
	osgParticle::ExplosionDebrisEffect* explosionDebri = new osgParticle::ExplosionDebrisEffect(pos, 10.0f);
	osgParticle::SmokeEffect* smoke = new osgParticle::SmokeEffect(pos, 10.0f);
	osgParticle::FireEffect* fire = new osgParticle::FireEffect(pos, 10.0f);

	osg::Vec3 wind(1.0f,0.0f,0.0f);  

	explosion->setWind(wind);
	explosionDebri->setWind(wind);
	smoke->setWind(wind);
	fire->setWind(wind);

	
	GetOSGNode()->asGroup()->addChild(explosion);
	GetOSGNode()->asGroup()->addChild(explosionDebri);
	GetOSGNode()->asGroup()->addChild(smoke);
	GetOSGNode()->asGroup()->addChild(fire);*/
}

void EffectActor::SwitchOFFEffect() 
{
	if ( ExplodeParticle != NULL )
	{
		mEffectIsRunning = false ;
		mCycleLifeTime = 0.0f ;
		ExplodeParticle->SetEnabled(false);

		if ( ExplodeSound != NULL )
		{
			if ( !ExplodeSound->IsPlaying() ) 
				ExplodeSound->Stop();
		}
	}
}
 
void EffectActor::SetTimeOut(const float tm ) 
{
	M_TIME_OUT = tm ;
}

bool EffectActor::GetEffectState() 
{
	return mEffectIsRunning ;
}

void EffectActor::SetEffectState(const bool isRun ) 
{
    mEffectIsRunning = isRun ;
}


int EffectActor::GetWeaponID()
{
	return mWeaponID ;
}

void EffectActor::SetWeaponID(const int WID )
{
	mWeaponID = WID;
	SetExplosionFile(mWeaponID);
}

int EffectActor::GetExplodeLauncher()
{
	return mLaucherExplode ;
}

void EffectActor::SetLauncherExplode(const int WID )
{
	mLaucherExplode = WID;
	SetExplotionSpoutFile(mLaucherExplode);
}
//////////////////////////////////////////////////////////////////////////
void EffectActor::pass_glare_shader()
{
	//osg::Group* root = static_cast<osg::Group*>(GetOSGNode());
	osg::StateSet* ss = GetOSGNode()->getOrCreateStateSet();

	ss->addUniform( new osg::Uniform( "uPassParticleGlare", 0 ) );
	ss->setTextureAttribute(0,new osg::TexEnv(osg::TexEnv::BLEND),osg::StateAttribute::ON);
	//ss->setMode()
	//Set Programs
	osg::ref_ptr<osg::Program> program = new osg::Program;

	char vertexSource[]=
		"void main(void)\n"
		"{\n"
		"    gl_TexCoord[0].st = gl_MultiTexCoord0.st;\n"
		"    gl_Position = ftransform();\n"
		"}\n";

	char fragmentSource[]=
		"uniform sampler2D uPassParticleGlare;\n"
		"\n"
		"void main(void)\n"
		"{\n"
		"   gl_FragData[0] = texture2D( uPassParticleGlare, gl_TexCoord[0].st );\n"
		"	gl_FragData[1] = vec4(0.0);\n"
		//"   vec4 color = texture2D( uPassParticleGlare, gl_TexCoord[0].st );\n"
		//"   gl_FragColor = color;\n"
		"}\n";

	program->setName( "partice_material" );
	program->addShader(new osg::Shader(osg::Shader::VERTEX,   vertexSource));
	program->addShader(new osg::Shader(osg::Shader::FRAGMENT, fragmentSource));
	ss->setAttributeAndModes( program, osg::StateAttribute::ON );
}

///////////////////////////////////////////////////////////////////////////////
void EffectActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){

		/*if(message.GetMessageType().GetName() == SimMessageType::EXPLODE_EVENT.GetName())
			ProcessOrderEvent(message);*/
	}
}

void EffectActor::TickLocal(const dtGame::Message &tickMessage)
{
	const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
	float deltaSimTime = tick.GetDeltaSimTime();

	if ( mEffectIsRunning )
	{
		mCycleLifeTime += deltaSimTime ;
		if ( mCycleLifeTime >= M_TIME_OUT)
		{
			SwitchOFFEffect();
			//std::cout<<Get Name()<<" time out for particle Effect.."<<mCycleLifeTime<<":"<<M_LIFE_TIME<<std::endl;
		}
	}

}
void EffectActor::SetExplotionSpoutFile(const int WID)
{
	if ( WID == CT_ASROC)				soundfile = "explosion.wav"; 
	else if ( WID == CT_C802)			soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_120)		soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_76)		soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_57)		soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_40)		soundfile = "explosion.wav"; 
	else if ( WID == CT_EXOCET_40)		soundfile = "explosion.wav"; 
	else if ( WID == CT_MISTRAL)		soundfile = "explosion.wav"; 
	else if ( WID == CT_RBU_6000)		soundfile = "explosion.wav"; 
	else if ( WID == CT_STRELA)			soundfile = "explosion.wav"; 
	else if ( WID == CT_TETRAL)			soundfile = "explosion.wav"; 
	else if ( WID == CT_TORPEDO_SUT)	soundfile = "explosion.wav"; 
	else if ( WID == CT_TORPEDO_A244S)	soundfile = "explosion.wav"; 
	else if ( WID == CT_YAKHONT)		soundfile = "explosion.wav"; 

	if ( WID == CT_ASROC)				particlefile = "Asap.osg"; 
	else if ( WID == CT_C802)			particlefile = "Asap.osg"; 
	else if ( WID == CT_CANNON_120)		particlefile = "AsapCannon.osg"; 
	else if ( WID == CT_CANNON_76)		particlefile = "AsapCannon.osg"; 
	else if ( WID == CT_CANNON_57)		particlefile = "AsapCannon.osg"; 
	else if ( WID == CT_CANNON_40)		particlefile = "AsapCannon.osg"; 
	else if ( WID == CT_EXOCET_40)		particlefile = "Asap.osg"; 
	else if ( WID == CT_MISTRAL)		particlefile = "Asap.osg"; 
	else if ( WID == CT_RBU_6000)		particlefile = "Asap.osg"; 
	else if ( WID == CT_STRELA)			particlefile = "Asap.osg"; 
	else if ( WID == CT_TETRAL)			particlefile = "Asap.osg"; 
	else if ( WID == CT_TORPEDO_SUT)	particlefile = "Asap.osg"; 
	else if ( WID == CT_TORPEDO_A244S)	particlefile = "Asap.osg"; 
	else if ( WID == CT_YAKHONT)		particlefile = "Asap.osg"; 
}

void EffectActor::SetExplosionFile(const int WID )
{
	if		( WID == 0 )					soundfile = "explosion.wav";
	else if ( WID == CT_ASROC)				soundfile = "explosion.wav"; 
	else if ( WID == CT_C802)				soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_120)			soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_76)			soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_57)			soundfile = "explosion.wav"; 
	else if ( WID == CT_CANNON_40)			soundfile = "explosion.wav"; 
	else if ( WID == CT_EXOCET_40)			soundfile = "explosion.wav"; 
	else if ( WID == CT_MISTRAL)			soundfile = "explosion.wav"; 
	else if ( WID == CT_RBU_6000)			soundfile = "explosion.wav"; 
	else if ( WID == CT_STRELA)				soundfile = "explosion.wav"; 
	else if ( WID == CT_TETRAL)				soundfile = "explosion.wav"; 
	else if ( WID == CT_TORPEDO_SUT)		soundfile = "explosion.wav"; 
	else if ( WID == CT_TORPEDO_A244S)		soundfile = "explosion.wav"; 
	else if ( WID == CT_YAKHONT)			soundfile = "explosion.wav"; 
	else if ( WID == CT_EXPLODE_SHIP)		soundfile = "explosion.wav";
	else if ( WID == CT_EXPLODE_SUBMARINE)	soundfile = "explosion.wav";
	else if ( WID == CT_EXPLODE_HELICOPTER)	soundfile = "explosion.wav";
	else if ( WID == CT_EXPLODE_AIRCFART)	soundfile = "explosion.wav";

	if		( WID == 0 )					particlefile = "explosion.osg";
	else if ( WID == CT_ASROC)				particlefile = "explosion.osg"; 
	else if ( WID == CT_C802)				particlefile = "explosion.osg"; 
	else if ( WID == CT_CANNON_120)			particlefile = "explosion.osg"; 
	else if ( WID == CT_CANNON_76)			particlefile = "explosion.osg"; 
	else if ( WID == CT_CANNON_57)			particlefile = "explosion.osg"; 
	else if ( WID == CT_CANNON_40)			particlefile = "explosion.osg"; 
	else if ( WID == CT_EXOCET_40)			particlefile = "explosion.osg"; 
	else if ( WID == CT_MISTRAL)			particlefile = "explosion.osg"; 
	else if ( WID == CT_RBU_6000)			particlefile = "explosion.osg"; 
	else if ( WID == CT_STRELA)				particlefile = "explosion.osg"; 
	else if ( WID == CT_TETRAL)				particlefile = "explosion.osg"; 
	else if ( WID == CT_TORPEDO_SUT)		particlefile = "explosion.osg"; 
	else if ( WID == CT_TORPEDO_A244S)		particlefile = "explosion.osg"; 
	else if ( WID == CT_YAKHONT)			particlefile = "explosion.osg"; 
	else if ( WID == CT_EXPLODE_SHIP)		particlefile = "explosion.osg";
	else if ( WID == CT_EXPLODE_SUBMARINE)	particlefile = "explosion.osg";
	else if ( WID == CT_EXPLODE_HELICOPTER)	particlefile = "explosion.osg";
	else if ( WID == CT_EXPLODE_AIRCFART)	particlefile = "explosion.osg";



}

//////////////////////////////////////////////////////////////////////////
void EffectActor::OnEnteredWorld()
{
	dtGame::GameActor::OnEnteredWorld();

	if ( GetParent() != NULL ) 
		GetParent()->RemoveChild(this);

	std::vector<dtDAL::ActorProxy *> ap;
	GetGameActorProxy().GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);
	if (ap[0]!= NULL)  
	{
		static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddActor( *(this) );
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;

	/*SetExplosionFile(mWeaponID);

	if (!particlefile.empty())
	{
		ExplodeParticle= new dtCore::ParticleSystem();
		ExplodeParticle->LoadFile(particlefile.c_str(),true); 
		ExplodeParticle->SetEnabled(false);
		GetGameActorProxy().GetGameManager()->GetScene().AddDrawable(ExplodeParticle.get());
		AddChild(ExplodeParticle.get());
	}

	if (!soundfile.empty())
	{
		ExplodeSound = dtAudio::AudioManager::GetInstance().NewSound();
		ExplodeSound->LoadFile(soundfile.c_str());
		assert(ExplodeSound);
		ExplodeSound->SetMaxDistance(1000.0f);
		ExplodeSound->SetLooping(false);
		AddChild(ExplodeSound.get());
	}

	pass_glare_shader();*/
}


void EffectActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));

}

///////////////////////////////////////////////////////
EffectActorProxy::EffectActorProxy()
{

}

EffectActorProxy::~EffectActorProxy()
{

}

void EffectActorProxy::BuildPropertyMap()
{
	dtGame::GameActorProxy::BuildPropertyMap();
}

void EffectActorProxy::BuildInvokables()
{
	dtGame::GameActorProxy::BuildInvokables();
}


void EffectActorProxy::OnEnteredWorld()
{
	dtGame::GameActorProxy::OnEnteredWorld();
	RegisterForMessages(dtGame::MessageType::TICK_LOCAL, dtGame::GameActorProxy::TICK_LOCAL_INVOKABLE);
	GetActor()->AddSender(&(GetGameManager()->GetScene()));

}

void EffectActorProxy::OnRemovedFromWorld()
{
	EffectActor &ea = static_cast<EffectActor&>(GetGameActor());

	if (dtAudio::AudioManager::GetInstance().IsInitialized() && ea.ExplodeSound != NULL)
	{
		dtAudio::AudioManager::GetInstance().FreeSound(ea.ExplodeSound);
	} 

	if ( ea.ExplodeParticle != NULL )
	{
		ea.ExplodeParticle = NULL ;
	} 
}