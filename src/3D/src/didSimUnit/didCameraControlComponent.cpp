// $Id: didCameraControlComponent.cpp

/**
 * @file didCameraControlComponent.cpp
 *
 * @author Bawenang R. P. P.
 *
 * @date August 27th, 2010
 *
 * @brief The source file for didCameraControlComponent component.
 *
 * didCameraControlComponent is the component that manages / control the camera / cameras behaviour on the client.
 * There should be no camera at all on the server.
 * A client can have multiple camera / display.
 * Camera types are based on SimPlayerActor's LookCameraEnum. 
 * @see SimPlayerActor::LookCameraEnum
 * @todo The SimPlayerActor::LookCameraEnum should not be used because one player can have multiple camera. Make it here instead.
 *
 * NO_CAMERA		: No camera. For server / ghost opponents.
 * OBSERVER			: Observer camera.  DEFAULT. 
 * ANJUNGAN			: Anjungan / bridge camera.
 * ANJUNGAN_R30		: Anjungan / bridge 30 degree to the right (+30 degree) camera.
 * ANJUNGAN_R60		: Anjungan / bridge 60 degree to the right (+60 degree) camera.
 * ANJUNGAN_L30		: Anjungan / bridge 30 degree to the left (-30 degree) camera.
 * ANJUNGAN_L60		: Anjungan / bridge 60 degree to the left (-60 degree) camera.
 */

//++ Includes
#include "didCameraControlComponent.h"
#include <osg/Geode>
#include <osg/Geometry>
#include <osg/MatrixTransform>

#include <dtDAL/ActorType.h>
#include <dtDAL/enginepropertytypes.h>
#include <dtDAL/LibraryManager.h>
#include <dtDAL/actorproxy.h>

//-- Includes

//++ Static Consts
const dtUtil::RefString didWinCamera::DOF_CAMERA_NAME("DOF_anjungan");
const dtUtil::RefString didWinCamera::DOF_CANNON_CAMERA_01("DOF_Meriam40Camera2");
const dtUtil::RefString didWinCamera::DOF_CANNON_CAMERA_02("DOF_Meriam40Camera2");
const dtUtil::RefString didWinCamera::DOF_CANNON_CAMERA_03("DOF_Meriam40Camera2");
//-- Static Consts

///////////////////////////////////////////////////////////////////////////////////
/// ---------------------- didWinCamera definitions -------------------------------





/**
 * 
 */
didWinCamera::didWinCamera()
{
}

/**
 * Ctor for main camera 
 */
didWinCamera::didWinCamera( dtABC::Application &app
						  , const std::string& name	
						  , dtCore::DeltaWin::PositionSize &winPosSize
						  , LookCameraEnum lookCamera 
						  , CameraSplitEnum cameraSplit
						  , bool isFullScreen
						  , double fov
						  , FovTypeEnum fovType
						  , double leftFrustum
						  , double rightFrustum
						  , double bottomFrustum
						  , double topFrustum
						  , double nearClip
						  , double farClip
						  , dtDAL::ActorProxy* attachedActorProxy
						  , dtCore::Transform& observerCamPos
						  , int launcherID)
						  : mLookCamera(lookCamera)
{
	mWindow	= app.GetWindow();
	mCamera	= app.GetCamera();
	mView	= app.GetView();

	mWindow->SetName("Window_" + name);
	mCamera->SetName("Camera_" + name);
	mView->SetName("View_" + name);
	
	//mCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);
	//mCamera->GetOSGCamera()->getOrCreateStateSet()->setMode( GL_CULL_FACE, osg::StateAttribute::OFF );

	if (!isFullScreen)
		mWindow->SetPosition( winPosSize );

	mWindow->SetFullScreenMode(isFullScreen);
	mWindow->ShowCursor(false);
    app.GetMouse()->SetPosition(winPosSize.mWidth, winPosSize.mHeight);

	double aspectRatio = winPosSize.mWidth / (float) winPosSize.mHeight;

	double hfov, vfov;

	if ( fovType == HFOV_TYPE )
	{
		hfov = fov;
		vfov = (hfov * winPosSize.mHeight) / winPosSize.mWidth ;
	}
    else
        {
        vfov = fov;
        hfov = (vfov * winPosSize.mWidth) / winPosSize.mHeight ;
        }

	if ((mLookCamera != OBSERVER_1) || (mLookCamera != OBSERVER_2) || (mLookCamera != OBSERVER_3) || (mLookCamera != OBSERVER_4) )
	{
		mAttachedActorProxy = attachedActorProxy;
		SetCameraNode(launcherID);
        AttachCameraNode();

		if (cameraSplit == FRUSTUM_SPLIT)
		{
			//InitCameraFrustumSplit( lookCamera, hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip );
            InitCameraFrustumSplit( lookCamera, hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, 10000.0f );
            //InitCameraFrustumSplit( lookCamera, hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, 0.6f, 10000.0f );
		}
		else
		{
			//InitCameraOrientationSplit( lookCamera, hfov, vfov, aspectRatio, nearClip, farClip );
            InitCameraOrientationSplit( lookCamera, hfov, vfov, aspectRatio, nearClip, 10000.0f );
		}
	}
	else
	{
		mAttachedActorProxy = NULL;
		mCamera->SetTransform(observerCamPos);
	}

    if ((mLookCamera == ANJUNGAN)||( mLookCamera == TDS) ||
		(mLookCamera == OBSERVER_1) ||(mLookCamera == OBSERVER_2) ||(mLookCamera == OBSERVER_3) ||(mLookCamera == OBSERVER_4))
    {
        //Attach Sound Listener
        dtAudio::Listener* mic  = dtAudio::AudioManager::GetInstance().GetListener();
        mic->SetName("Client Audio Listener");
        //mMic->SetGain (1.0f);
        assert( mic );
        dtCore::Transform transform( 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f );
        mCamera->AddChild( mic );
        mic->SetTransform( transform,dtCore::Transformable::REL_CS); //  ,dtCore::Transformable::CoordSysEnum::REL_CS
    }

    //if (mLookCamera == ANJUNGAN)
    //{
    //    SetPrerender(app, winPosSize.mWidth, winPosSize.mHeight, mAttachedActorProxy.get(), mNodeCamera.get());
    //    InitPrerenderCameraFrustum(hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip);

    //}

    //mCamera->GetOSGCamera()->setCullMask(didCameraPreRender::NODEMASK_NO_NEAR_FAR_CALC);
    //mCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);
    

    // //Setting the actor
    //dtGame::GameActor* actor;
    //mAttachedActorProxy->GetActor(actor);

    //actor->GetOSGNode()->asGroup()->setNodeMask(didCameraPreRender::NODEMASK_NO_NEAR_FAR_CALC);
    

}

/**
 *  Camera constructor for FRUSTUM_SPLIT type
 */
didWinCamera::didWinCamera(	dtABC::Application &app
						   , const std::string &name
						   , LookCameraEnum lookCamera 
						   , dtCore::DeltaWin::PositionSize &winPosSize
						   , int screenNum
						   , bool isFullScreen
						   , double fov
						   , FovTypeEnum fovType
						   , double leftFrustum
						   , double rightFrustum
						   , double bottomFrustum
						   , double topFrustum
						   , double nearClip
						   , double farClip
						   , dtDAL::ActorProxy* attachedActorProxy
						   , dtCore::Transform& observerCamPos
						   , int launcherID) 
						: mLookCamera(lookCamera)				 
{
	dtCore::DeltaWin::DeltaWinTraits winTraits;
	winTraits.name = name;
	winTraits.x = winPosSize.mX;
	winTraits.y = winPosSize.mY;
	winTraits.width = winPosSize.mWidth;
	winTraits.height = winPosSize.mHeight;
	winTraits.displayNum = 0;
	winTraits.screenNum = screenNum;
	winTraits.fullScreen = isFullScreen;

	double aspectRatio = winTraits.width / (float) winTraits.height;

	double hfov, vfov;

	if ( fovType == HFOV_TYPE )
	{
		hfov = fov;
		vfov = (hfov * winTraits.height) / winTraits.width ;
	}
	else
	{
		vfov = fov;
		hfov = (vfov * winTraits.width) / winTraits.height ;
	}

	//Create instances
	//Create window
	CreateDeltaWindow( winTraits );

	//Create camera
	CreateCamera( name );
	if ((mLookCamera != OBSERVER_1) || (mLookCamera != OBSERVER_2) || (mLookCamera != OBSERVER_3) || (mLookCamera != OBSERVER_4) )
	{
		mAttachedActorProxy = attachedActorProxy;
		SetCameraNode(launcherID);
		InitCameraFrustumSplit( lookCamera, hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip );
		AttachCameraNode();
	}
	else
	{
		mAttachedActorProxy = NULL;
		mCamera->SetTransform(observerCamPos);
	}

	//Create view
	CreateView( name , app);

    if (mLookCamera == ANJUNGAN)
    {
        //Attach Sound Listener
        dtAudio::Listener* mic  = dtAudio::AudioManager::GetInstance().GetListener();
        mic->SetName("Client Audio Listener");
        //mMic->SetGain (1.0f);
        assert( mic );
        dtCore::Transform transform( 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f );
        mCamera->AddChild( mic );
        mic->SetTransform( transform,dtCore::Transformable::REL_CS); //  ,dtCore::Transformable::CoordSysEnum::REL_CS
    }
}

/**
 *  Camera constructor for ORIENTATION_SPLIT type
 */
didWinCamera::didWinCamera(	dtABC::Application &app
						   , const std::string &name
						   , LookCameraEnum lookCamera 
						   , dtCore::DeltaWin::PositionSize &winPosSize
						   , int screenNum
						   , bool isFullScreen
						   , double fov
						   , FovTypeEnum fovType
						   , double nearClip
						   , double farClip
						   , dtDAL::ActorProxy* attachedActorProxy
						   , dtCore::Transform& observerCamPos
						   , int launcherID) 
						: mLookCamera(lookCamera)				 
{
	dtCore::DeltaWin::DeltaWinTraits winTraits;
	winTraits.name = name;
	winTraits.x = winPosSize.mX;
	winTraits.y = winPosSize.mY;
	winTraits.width = winPosSize.mWidth;
	winTraits.height = winPosSize.mHeight;
	winTraits.displayNum = 0;
	winTraits.screenNum = screenNum;
	winTraits.fullScreen = isFullScreen;

	double aspectRatio = winTraits.width / (float) winTraits.height;

	double hfov, vfov;

	if ( fovType == HFOV_TYPE )
	{
		hfov = fov;
		vfov = (hfov * winTraits.height) / winTraits.width ;
	}
	else
	{
		vfov = fov;
		hfov = (vfov * winTraits.width) / winTraits.height ;
	}


	//Create instances
	//Create window
	CreateDeltaWindow( winTraits );

	//Create camera
	CreateCamera( name );
	if ((mLookCamera != OBSERVER_1) || (mLookCamera != OBSERVER_2) || (mLookCamera != OBSERVER_3) || (mLookCamera != OBSERVER_4) )
	{
		mAttachedActorProxy = attachedActorProxy;
		SetCameraNode(launcherID);
		InitCameraOrientationSplit( lookCamera, hfov, vfov, aspectRatio, nearClip, farClip );
		AttachCameraNode();
	}
	else
	{
		mAttachedActorProxy = NULL;
		mCamera->SetTransform(observerCamPos);
	}

	//Create view
	CreateView( name , app);

    if (mLookCamera == ANJUNGAN)
    {
        //Attach Sound Listener
        dtAudio::Listener* mic  = dtAudio::AudioManager::GetInstance().GetListener();
        mic->SetName("Client Audio Listener");
        //mMic->SetGain (1.0f);
        assert( mic );
        dtCore::Transform transform( 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f );
        mCamera->AddChild( mic );
        mic->SetTransform( transform,dtCore::Transformable::REL_CS); //  ,dtCore::Transformable::CoordSysEnum::REL_CS
    }

}

/**
 * Destructor
 */
didWinCamera::~didWinCamera()
{
}

/**
 * 
 */
bool didWinCamera::SetCameraNode(int launcherID)
{
	bool result = false;
	

	if (mAttachedActorProxy)
	{
		dtGame::GameActor* actor;

		mAttachedActorProxy->GetActor(actor);
		dtCore::RefPtr<dtUtil::NodeCollector> nc = new dtUtil::NodeCollector(actor->GetOSGNode(), 
													  dtUtil::NodeCollector::MatrixTransformFlag |
													  dtUtil::NodeCollector::DOFTransformFlag );


		if ( mAttachedActorProxy.valid() )
		{
			std::cout<<" launcher "<<launcherID<<" ready set on "<<mAttachedActorProxy->GetActor()->GetName()<<std::endl;
		}
		else
		{
			std::cout<<"WARNING ::: launcher "<<launcherID<<" ready set on "<<mAttachedActorProxy->GetActor()->GetName()<<std::endl;
		}

		if ( mLookCamera == TDS )
		{
			if ( launcherID == 1 ) 
				mNodeCamera = nc->GetDOFTransform(DOF_CANNON_CAMERA_01.Get());
			if ( launcherID == 2 ) 
				mNodeCamera = nc->GetDOFTransform(DOF_CANNON_CAMERA_02.Get());
			if ( launcherID == 3 ) 
				mNodeCamera = nc->GetDOFTransform(DOF_CANNON_CAMERA_03.Get());
		}
		else
			mNodeCamera = nc->GetDOFTransform(DOF_CAMERA_NAME.Get());

		//mNodeCamera->setCurrentHPR( osg::Vec3(0.0,0.0,0.0) );

		result = (mNodeCamera != NULL);
	}

	return result;
}

/**
 * 
 */
bool didWinCamera::AttachCameraNode( )
{
	bool result = false;

	if (mAttachedActorProxy)
	{
		dtGame::GameActor* actor;
		mAttachedActorProxy->GetActor(actor);

		if (mNodeCamera != NULL)
		{ 
			if ( mCamera->GetParent() != NULL )  
				 mCamera->GetParent()->RemoveChild(mCamera);

			mNodeCamera->addChild(mCamera->GetOSGNode());
			result = true;
		}
		else
		{
			actor->GetOSGNode()->asGroup()->addChild(mCamera->GetOSGNode());
		}

		if ( mCamera->GetParent() != NULL )  
			 mCamera->GetParent()->RemoveChild(mCamera);
		actor->AddChild(mCamera);
		if (mLookCamera== TDS) 
		{
			dtCore::Transform xform(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
			mCamera->SetTransform(xform, dtCore::Transformable::REL_CS);
		}
		else
		{
			dtCore::Transform xform(0.0f, -8.0f, 10.0f, 0.0f, 0.0f, 0.0f);
			mCamera->SetTransform(xform, dtCore::Transformable::REL_CS);
		}
        
		
		//actor->GetOSGNode()->getOrCreateStateSet()->setRenderingHint( osg::StateSet::OPAQUE_BIN );
		//actor->GetOSGNode()->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
		//actor->GetOSGNode()->getOrCreateStateSet()->setMode(GL_LIGHT0, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
		//
		//actor->GetOSGNode()->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
		//actor->GetOSGNode()->getOrCreateStateSet()->setMode(GL_CULL_FACE, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
		
	}
	
	return result;
}

/**
 * 
 */
void didWinCamera::CreateDeltaWindow( const dtCore::DeltaWin::DeltaWinTraits &winTraits )
{
	mWindow = new dtCore::DeltaWin(winTraits);
	mWindow->ShowCursor(false);
}

/**
 * 
 */
void didWinCamera::CreateCamera( const std::string &name )
{
	std::string camName = "Camera_" + name;
	mCamera = new dtCore::Camera( camName );

	// Setting the window
	mCamera->SetWindow(mWindow.get());
    //mCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);
}

/**
 * 
 */
void didWinCamera::SetPrerender(dtABC::Application &app, int width, int height,  dtDAL::ActorProxy* attachedActorProxy, osgSim::DOFTransform* nodeCamera)
{
    mPreRenderCamera = new didCameraPreRender;
    mPreRenderCamera->Init(app, width, height, attachedActorProxy, nodeCamera);
    //didCameraPreRender cameraPrerender = didCameraPreRender();
    //cameraPrerender.Init(app, width, height, attachedActorProxy, nodeCamera);

    // Setting the actor
    dtGame::GameActor* actor;
    mAttachedActorProxy->GetActor(actor);

    actor->GetOSGNode()->asGroup()->setNodeMask(didCameraPreRender::NODEMASK_NO_NEAR_FAR_CALC);
}

/**
* 
*/
void didWinCamera::InitPrerenderCameraFrustum(double hfov
                                              , double vfov
                                              , double aspectRatio
                                              , double leftFrustum
                                              , double rightFrustum
                                              , double bottomFrustum
                                              , double topFrustum
                                              , double nearClip
                                              , double farClip
                                              )
{
    mPreRenderCamera->InitPrerenderCameraFrustum(hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip);
}
/**
 * 
 */
void didWinCamera::InitCameraFrustumSplit( LookCameraEnum lookCamera 
											 , double hfov
											 , double vfov
											 , double aspectRatio
											 , double leftFrustum
											 , double rightFrustum
											 , double bottomFrustum
											 , double topFrustum
											 , double nearClip
											 , double farClip 
											 )
{
	dtCore::Transform xform;
	dtGame::GameActor* actor;

	
	if (mAttachedActorProxy)
	{
		mAttachedActorProxy->GetActor( actor );
	}

	//Set camera transform = attached 
	mCamera->SetPerspectiveParams( vfov, aspectRatio, nearClip, farClip );
	mCamera->SetClearColor(0.0f, 0.0f, 1.0f, 1.f);
	
	//nearClip = 1.0f;
	//farClip = 1000000.0f;

	//Set the frustum
	SetFrustumProjection( lookCamera
							, leftFrustum
							, rightFrustum
							, bottomFrustum
							, topFrustum
							, nearClip
							, farClip );

}

/**
 * 
 */
void didWinCamera::InitCameraOrientationSplit( LookCameraEnum lookCamera 
												 , double hfov
												 , double vfov
												 , double aspectRatio
												 , double nearClip
												 , double farClip )
{
	dtCore::Transform xform;
	dtGame::GameActor* actor;	

	if (mAttachedActorProxy)
	{
		mAttachedActorProxy->GetActor( actor );
	}

	//Sett camera transform = attached 
	mCamera->SetPerspectiveParams( vfov, aspectRatio, nearClip, farClip );
	mCamera->SetClearColor(0.0f, 0.0f, 1.0f, 1.f);

	//Rotate camera
	float rotation = GetAngleOrientationSplit(lookCamera, hfov);

	osg::Vec3 oriRot;
	osg::Vec3 rotVec(rotation, 0.0f, 0.0f);

	if (mCamera)
	{
        mCamera->GetTransform(xform, dtCore::Transformable::REL_CS);
		xform.GetRotation(oriRot);
		oriRot = oriRot + rotVec;
		xform.SetRotation(oriRot);
		//xform.SetRotation(rotVec);
		mCamera->SetTransform(xform, dtCore::Transformable::REL_CS);
	}

	// Setting the window
	mCamera->SetWindow(mWindow.get());
}

/**
 * 
 */
void didWinCamera::CreateView( const std::string &name, 	dtABC::Application &app )
{
	std::string viewName = "View_" + name;
	mView = new dtCore::View( viewName );

	mView->SetScene(app.GetScene());
	app.AddView(*mView);
	mView->SetCamera(mCamera.get());
}

/**
 * 
 */
void didWinCamera::SetFrustumProjection( LookCameraEnum lookCamera 
										  , double leftFrustum
										  , double rightFrustum
										  , double bottomFrustum
										  , double topFrustum
										  , double nearClip
										  , double farClip 
										  )
{
	switch(lookCamera)
	{
		case TDS:			//< Anjungan / bridge camera.
			mCamera->GetOSGCamera()->setProjectionMatrixAsFrustum( leftFrustum
																	, rightFrustum
																	, bottomFrustum
																	, topFrustum
																	, nearClip
																	, farClip );
			break;

		case ANJUNGAN:			//< Anjungan / bridge camera.
			mCamera->GetOSGCamera()->setProjectionMatrixAsFrustum( leftFrustum
																	, rightFrustum
																	, bottomFrustum
																	, topFrustum
																	, nearClip
																	, farClip );
			break;

		case ANJUNGAN_R30:		//< Anjungan / bridge 30 degree to the right (+30 degree) camera.
			mCamera->GetOSGCamera()->setProjectionMatrixAsFrustum( rightFrustum + (rightFrustum/8)
																	, rightFrustum * 3 + (rightFrustum/8)
																	, bottomFrustum
																	, topFrustum
																	, nearClip
																	, farClip );
			break;


		case ANJUNGAN_R60:		//< Anjungan / bridge 60 degree to the right (+60 degree) camera.
			mCamera->GetOSGCamera()->setProjectionMatrixAsFrustum( rightFrustum * 3 + (rightFrustum*2/8)
																	, rightFrustum * 5 + (rightFrustum*2/8)
																	, bottomFrustum
																	, topFrustum
																	, nearClip
																	, farClip );
			break;

		case ANJUNGAN_L30:		//< Anjungan / bridge 30 degree to the left (-30 degree) camera.
			mCamera->GetOSGCamera()->setProjectionMatrixAsFrustum( leftFrustum * 3 + (leftFrustum/8)
																	, leftFrustum + (leftFrustum/8)
																	, bottomFrustum
																	, topFrustum
																	, nearClip
																	, farClip );
			break;

		case ANJUNGAN_L60:		//< Anjungan / bridge 60 degree to the left (-60 degree) camera.
			mCamera->GetOSGCamera()->setProjectionMatrixAsFrustum( leftFrustum * 5 + (leftFrustum*2/8)
																	, leftFrustum * 3 + (leftFrustum*2/8)
																	, bottomFrustum
																	, topFrustum
																	, nearClip
																	, farClip );
			break;

		default:
			break;
	}
}

/**
 * 
 */
float didWinCamera::GetAngleOrientationSplit( LookCameraEnum lookCamera 
											   , double hfov
											   )
{
	switch(lookCamera)
	{
		case TDS:			//< Anjungan / bridge camera.
			return 0;

		case ANJUNGAN:			//< Anjungan / bridge camera.
			return 0;

		case ANJUNGAN_R30:		//< Anjungan / bridge 30 degree to the right (+30 degree) camera.
			return -(hfov+1.5f);

		case ANJUNGAN_R60:		//< Anjungan / bridge 60 degree to the right (+60 degree) camera.
			return -(2*(hfov+1.5f));

		case ANJUNGAN_L30:		//< Anjungan / bridge 30 degree to the left (-30 degree) camera.
			return (hfov+1.5f);

		case ANJUNGAN_L60:		//< Anjungan / bridge 60 degree to the left (-60 degree) camera.
			return (2*(hfov+1.5f));

		default:
			return 0;
	}
}

///////////////////////////////////////////////////////////////////////////////////
/// ------------- didCameraPreRender definitions ---------------------------

// Constant Definitions
const int didCameraPreRender::NODEMASK_NO_NEAR_FAR_CALC = 0x40;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++ Methods Definitions

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ Ctor & Dtor
didCameraPreRender::didCameraPreRender()
{

}

didCameraPreRender::~didCameraPreRender()
{

}

////-- Ctor & Dtor
////-------------------------------------------------------------------------------

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ Generic Methods

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::Init(dtABC::Application &app, int width, int height,  dtDAL::ActorProxy* attachedActorProxy, osgSim::DOFTransform* cameraNode)
{
    //Get GameManager
	dtGame::GameManager& gameManager =  *(dynamic_cast<dtGame::GameApplication&>(app).GetGameManager());

    ///////////////////////////////////
    // Render to Texture Pre Render Camera

    //Create Texture Camera
    if (!mTextureCamera.valid() )
        CreateTextureCamera(app, width, height);

    //Create Texture Target
    if (!mTextureTarget.valid())
        CreateTextureTarget(app, width, height);

    //Init Texture Camera
    InitTextureCamera();

    //Create / define Texture Scene
    mTextureScene = app.GetScene();

    //Set Texture View
    mTextureView = new dtCore::View;
    mTextureView->SetScene(mTextureScene.get());
    mTextureView->SetCamera(mTextureCamera.get());

    //Set view to app
    app.AddView(*mTextureView.get());

    ///////////////////////////////////
    // Masked Near Far Camera for the tip of the ship

    //Create Masked Node Camera (camera to render the masked nodes)
    if (!mMaskedCamera.valid() )
        CreateMaskedCamera(app, width, height);

    //Create Masked NodeTarget
    if (!mMaskedTarget.valid())
        CreateMaskedTarget(app, width, height);

    //Init Masked Node Camera
    InitMaskedCamera();

    //Create / define Masked Node Scene
    mMaskedScene = app.GetScene();

    //Set Masked Near Far View
    mMaskedView = new dtCore::View;
    mMaskedView->SetScene(mMaskedScene.get());
    mMaskedView->SetCamera(mMaskedCamera.get());

    //Set view to app
    app.AddView(*mMaskedView.get());

    ///////////////////////////////////
    // Quad Post Render Camera

    //Create Quad Camera
    if (!mQuadCamera.valid() )
        CreateQuadCamera(app, width, height);

    //Init Quad Camera
    InitQuadCamera();

    //Create / define Quad Scene
    mQuadScene = app.GetScene();

    //Set Quad View
    mQuadView = new dtCore::View;
    mQuadView->SetScene(mQuadScene.get());
    mQuadView->SetCamera(mQuadCamera.get());

    //Set view to app
    app.AddView(*mQuadView.get());


    //Create and bind quad to Quad Camera
    CreateScreenQuadGeode( width, height );
    InitScreenQuadGeode();
    

    //Attach cameras to Camera Node
    mCameraNode = cameraNode;
    mAttachedActorProxy = attachedActorProxy; //The Actor proxy that will be attached with all the cameras
    mCameraNode->addChild(mTextureCamera->GetOSGNode());
    mCameraNode->addChild(mMaskedCamera->GetOSGNode());
    mCameraNode->addChild(mQuadCamera->GetOSGNode());

    dtGame::GameActor* actor;
    mAttachedActorProxy->GetActor(actor);

    actor->AddChild(mTextureCamera);
    actor->AddChild(mMaskedCamera);
    actor->AddChild(mQuadCamera);

}


////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::CreateTextureCamera(dtABC::Application &app, int width, int height)
{
    // Create the delta camera
    mTextureCamera = new dtCore::Camera("Texture Camera");
    mTextureCamera->SetWindow(app.GetWindow());
    //mTextureCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);

}

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::CreateTextureTarget(dtABC::Application &app, int width, int height)
{
    // All of these parameters must be set for frame buffer objects (FBO's) to work
    mTextureTarget = new osg::Texture2D;
    mTextureTarget->setTextureSize(width, height);
    mTextureTarget->setInternalFormat(GL_RGBA);
    mTextureTarget->setFilter(osg::Texture2D::MIN_FILTER,osg::Texture2D::LINEAR);
    mTextureTarget->setFilter(osg::Texture2D::MAG_FILTER,osg::Texture2D::LINEAR);

    // Extra non essential parameters
    mTextureTarget->setResizeNonPowerOfTwoHint(false);
    mTextureTarget->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP );
    mTextureTarget->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP );
    mTextureTarget->setBorderColor(osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f));
    mTextureTarget->setDataVariance(osg::Object::DYNAMIC);
}

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::CreateMaskedCamera(dtABC::Application &app, int width, int height)
{
    // Create the delta camera
    mMaskedCamera = new dtCore::Camera("Masked Camera");
    mMaskedCamera->SetWindow(app.GetWindow());
    mMaskedCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);

}


////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::CreateMaskedTarget(dtABC::Application &app, int width, int height)
{
    // All of these parameters must be set for frame buffer objects (FBO's) to work
    mMaskedTarget = new osg::Texture2D;
    mMaskedTarget->setTextureSize(width, height);
    mMaskedTarget->setInternalFormat(GL_RGBA);
    mMaskedTarget->setFilter(osg::Texture2D::MIN_FILTER,osg::Texture2D::LINEAR);
    mMaskedTarget->setFilter(osg::Texture2D::MAG_FILTER,osg::Texture2D::LINEAR);
    // Extra non essential parameters
    mMaskedTarget->setResizeNonPowerOfTwoHint(false);
    mMaskedTarget->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP );
    mMaskedTarget->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP );
    //mMaskedTarget->setBorderColor(osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f));
    mMaskedTarget->setDataVariance(osg::Object::DYNAMIC);
}

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::CreateQuadCamera(dtABC::Application &app, int width, int height)
{
    // Create the delta camera
    mQuadCamera = new dtCore::Camera("Quad Camera");
    mQuadCamera ->SetWindow(app.GetWindow());
    //mTextureCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);

}

/**
* 
*/
void didCameraPreRender::InitPrerenderCameraFrustum( double hfov
                                                   , double vfov
                                                   , double aspectRatio
                                                   , double leftFrustum
                                                   , double rightFrustum
                                                   , double bottomFrustum
                                                   , double topFrustum
                                                   , double nearClip
                                                   , double farClip
                                                   )
{

    InitCameraFrustum(mTextureCamera.get(), hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip);
    InitCameraFrustum(mMaskedCamera.get(), hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip);
    InitCameraFrustum(mQuadCamera.get(), hfov, vfov, aspectRatio, leftFrustum, rightFrustum, bottomFrustum, topFrustum, nearClip, farClip, 1);
}

/**
* 
*/
void didCameraPreRender::InitCameraFrustum(  dtCore::Camera* camera
                                             , double hfov
                                             , double vfov
                                             , double aspectRatio
                                             , double leftFrustum
                                             , double rightFrustum
                                             , double bottomFrustum
                                             , double topFrustum
                                             , double nearClip
                                             , double farClip
                                             , int type /*0 = Frustum, 1 = ortho, 2 = ortho2D*/)
{
    //Set camera transform = attached 
    camera->SetPerspectiveParams( vfov, aspectRatio, nearClip, farClip );
    //camera->SetClearColor(0.0f, 0.0f, 1.0f, 1.f);

    //nearClip = 1.0f;
    //farClip = 1000000.0f;

    //Set the frustum
    if (!type)
    {
        camera->GetOSGCamera()->setProjectionMatrixAsFrustum( 
            leftFrustum
            , rightFrustum
            , bottomFrustum
            , topFrustum
            , nearClip
            , farClip );
    }
    else if (type == 1)
    {
        camera->GetOSGCamera()->setProjectionMatrixAsOrtho( 
            leftFrustum
            , rightFrustum
            , bottomFrustum
            , topFrustum
            , nearClip
            , farClip );
    }
    else
    {
        camera->GetOSGCamera()->setProjectionMatrixAsOrtho2D( 
            leftFrustum
            , rightFrustum
            , bottomFrustum
            , topFrustum );
    }

}

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::InitTextureCamera()
{
    // Make the necessary changes directly to the osg camera
    osg::Camera* osgCam = mTextureCamera->GetOSGCamera();
    osgCam->setReferenceFrame(osg::Transform:: ABSOLUTE_RF_INHERIT_VIEWPOINT);
    osgCam->setClearMask(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    osgCam->setClearColor(osg::Vec4(0.0f, 0.0f, 0.0f, 0.0f));
    //osgCam->setRenderOrder(osg::Camera::POST_RENDER);
    osgCam->setRenderTargetImplementation(osg::Camera::FRAME_BUFFER_OBJECT);
    //osgCam->setViewport( 0,0, mTextureTarget->getTextureWidth(), mTextureTarget->getTextureHeight() );
    osgCam->attach( osg::Camera::COLOR_BUFFER, mTextureTarget.get() );
}

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::InitMaskedCamera()
{
    // Make the necessary changes directly to the osg camera
    osg::Camera* osgCam = mMaskedCamera->GetOSGCamera();
    osgCam->setReferenceFrame(osg::Transform:: ABSOLUTE_RF_INHERIT_VIEWPOINT);
    osgCam->setClearMask(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    osgCam->setClearColor(osg::Vec4(0.0f, 0.0f, 0.0f, 0.0f));
    osgCam->setRenderOrder(osg::Camera::PRE_RENDER);
    osgCam->setRenderTargetImplementation(osg::Camera::FRAME_BUFFER_OBJECT);
    
    mMaskedCamera->SetNearFarCullingMode(dtCore::Camera::NO_AUTO_NEAR_FAR);
    //osgCam->setViewport( 0,0, mMaskedTarget->getTextureWidth(), mMaskedTarget->getTextureHeight() );
    osgCam->attach( osg::Camera::COLOR_BUFFER, mMaskedTarget.get() );

    osgCam->setCullMask(NODEMASK_NO_NEAR_FAR_CALC);

}

////////////////////////////////////////////////////////////////////////////////
void didCameraPreRender::InitQuadCamera( )
{
    // Make the necessary changes directly to the osg camera
    osg::Camera* osgCam = mQuadCamera->GetOSGCamera();
    osgCam->setClearMask(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    osgCam->setClearColor( osg::Vec4(0.f, 0.f, 0.f, 1.0) );
    osgCam->setRenderOrder(osg::Camera::POST_RENDER);
    osgCam->setReferenceFrame(osg::Transform::ABSOLUTE_RF_INHERIT_VIEWPOINT);
    //osgCam->setProjectionMatrixAsOrtho( 0, mMaskedTarget->getTextureWidth(), 0.f, mMaskedTarget->getTextureHeight(), 1.0, 500.f );
    osgCam->setViewMatrix(osg::Matrix::identity());
    //osgCam->setViewport( 0, 0, mMaskedTarget->getTextureWidth(), mMaskedTarget->getTextureHeight() );
}

void didCameraPreRender::CreateScreenQuadGeode( float width, float height )
{
    mScreenQuadGeode = new osg::Geode;

    osg::Geometry* quad = osg::createTexturedQuadGeometry( 
        osg::Vec3f(0.f,0.f,0.f), 
        osg::Vec3f(width, 0.f, 0.f), 
        osg::Vec3f( 0.f,height, 0.0f ),
        (float)mTextureTarget->getTextureWidth(),
        (float)mTextureTarget->getTextureHeight() );

    mScreenQuadGeode->addDrawable(quad);

    // Remove any previous drawables
    if (mQuadDrawable.valid())
    {
        mQuadScene->RemoveDrawable(mQuadDrawable.get());
    }

    // Create a new drawable for the new geometry
    mQuadDrawable = new dtCore::Transformable;
    mQuadDrawable->GetMatrixNode()->addChild(mScreenQuadGeode); 

    mQuadScene->AddDrawable(mQuadDrawable.get());  
}

void didCameraPreRender::InitScreenQuadGeode(    )
{
    static const char vertex_source[] = 
        "void main(void)\n"
        "{\n"
        "    gl_TexCoord[0] = gl_MultiTexCoord0;\n"
        "\n"
        "    gl_Position = ftransform();\n"
        "}\n";

    static const char fragment_source[] = 
        "uniform sampler2DRect did_ColorBuffer;\n"
        "uniform sampler2DRect did_MaskedBuffer;\n"
        "\n"
        "void main(void)\n"
        "{\n"
        "    vec4 fullColor    = texture2DRect(did_ColorBuffer,   gl_TexCoord[0].st );\n"
        "    vec4 maskedColor = texture2DRect(did_MaskedBuffer, gl_TexCoord[0].st );\n"
        "\n"
        "    vec4 color = fullColor;\n"
        //"    vec4 color = maskedColor;\n"
        "    if((maskedColor.r+maskedColor.g+maskedColor.b+maskedColor.a)>0.0)\n"
        "            color = maskedColor;\n"
        //"    \n"
        "    gl_FragColor = vec4( color.rgb, 1.0);\n"
        //"    gl_FragColor = vec4(1.0);\n"
        "}\n";

    osg::Camera* camera = mQuadCamera->GetOSGCamera();
    //camera->setComputeNearFarMode(osg::CullSettings::DO_NOT_COMPUTE_NEAR_FAR);

    osg::Program* program = CreateShaderProgram( "maskedNearFar_composite", vertex_source, fragment_source );

    osg::StateSet* ss = mScreenQuadGeode->getOrCreateStateSet();
    ss->setAttributeAndModes(program, osg::StateAttribute::ON);
    ss->setTextureAttributeAndModes(0, mTextureTarget.get(), osg::StateAttribute::OVERRIDE | osg::StateAttribute::ON );
    ss->setTextureAttributeAndModes(1, mMaskedTarget.get(), osg::StateAttribute::OVERRIDE | osg::StateAttribute::ON );
    ss->addUniform( new osg::Uniform("did_ColorBuffer",   0 ) );
    ss->addUniform( new osg::Uniform("did_MaskedBuffer", 1 ) );

    camera->addChild( mScreenQuadGeode );

}

osg::Program* didCameraPreRender::CreateShaderProgram(  const std::string& name, 
                                                        const std::string& vertexSrc, 
                                                        const std::string& fragmentSrc
                                                        )
{
    osg::ref_ptr<osg::Shader> vShader = 0;
    osg::ref_ptr<osg::Shader> fShader = 0;
    if (!vertexSrc.empty())
    {
        vShader = new osg::Shader( osg::Shader::VERTEX, vertexSrc );
    }
    if (!fragmentSrc.empty())
    {
        fShader = new osg::Shader( osg::Shader::FRAGMENT, fragmentSrc );
    }
    

    osg::Program* program = new osg::Program;
    program->setName(name);

    if (vShader.valid())
    {
        vShader->setShaderSource(vShader->getShaderSource());
        vShader->setName(name+"_vertex_shader");
        program->addShader( vShader.get() );
    }
    if (fShader.valid())
    {
        fShader->setShaderSource(fShader->getShaderSource());
        fShader->setName(name+"_fragment_shader");
        program->addShader( fShader.get() );
    }

    return program;
}

////-- Generic Methods
////-------------------------------------------------------------------------------


///////////////////////////////////////////////////////////////////////////////////
/// ------------- didCameraControlComponent definitions ---------------------------




//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++ Methods Definitions

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ Ctor & Dtor

////// Constructor
didCameraControlComponent::didCameraControlComponent(const std::string& name)
      : Parent(name)
      , mLogger(dtUtil::Log::GetInstance("didCameraControlComponent.cpp"))
	  , mIsInitialized(false)
	  , mCommonSettings()
	  , mCurrentActiveObserver(-1)
{
	mWinCameraSettingsVec.clear();
	mWinCameras.clear();
}

////// Destructor
didCameraControlComponent::~didCameraControlComponent( )
{
}


////-- Ctor & Dtor
////-------------------------------------------------------------------------------

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ INHERITED PUBLIC

void didCameraControlComponent::ProcessMessage(const dtGame::Message &msg)
{
	const dtGame::MessageType& msgType = msg.GetMessageType();

	if (mIsInitialized)
	{
		Parent::ProcessMessage(msg);
		/*
		 * @todo Add body
		 */

		if (dtGame::MessageType::INFO_MAP_LOADED == msgType)
		{
			//dtActors::StaticMeshActorProxy* proxy;

			//size_t numGameActors = GetGameManager()->GetNumGameActors();
			//size_t numActors = GetGameManager()->GetNumAllActors();
			//GetGameManager()->FindActorByName("PlayerShip", proxy);


			//this->Init( 0
			//			, 0
			//			, 448
			//			, 252
			//			, 30
			//			, HFOV_TYPE
			//			, true
			//			, FRUSTUM_SPLIT
			//			, ANJUNGAN
			//			, proxy );

			//this->AddWinCamera( "Tampilan2"
			//					, ANJUNGAN_R30
			//					, 1
			//					, true
			//					, proxy );

			PopulateWinCameras();
		}

	}
}

void didCameraControlComponent::OnAddedToGM( )
{
	mFmm = new dtCore::FlyMotionModel( GetGameManager()->GetApplication().GetKeyboard(), GetGameManager()->GetApplication().GetMouse() );
	mFmm->SetMaximumFlySpeed(500);
}

void didCameraControlComponent::OnRemovedFromGM( )
{
	
}

////-- INHERITED PUBLIC
////-------------------------------------------------------------------------------

////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
////++ Generic Methods

/**
 * Function to get the LookCameraEnum from the LookCamera application param
 *
 */
LookCameraEnum didCameraControlComponent::GetLookCameraEnum( const std::string& lookCamera	///< the camera name to be checkedhe actor that will be attached by the camera
															) const
{
	LookCameraEnum retVal= NO_CAMERA;
	if (lookCamera==C_LOGIN_OBS_1)
	{
		retVal = OBSERVER_1;
	}
	if (lookCamera==C_LOGIN_OBS_2)
	{
		retVal = OBSERVER_2;
	}
	if (lookCamera==C_LOGIN_OBS_3)
	{
		retVal = OBSERVER_3;
	}
	if (lookCamera==C_LOGIN_OBS_4)
	{
		retVal = OBSERVER_4;
	}
	if (lookCamera==C_LOGIN_TDS)
	{
		retVal = TDS;
	}
	else if (lookCamera==C_LOGIN_ANJUNGAN)
	{
		retVal = ANJUNGAN;
	}
	else if (lookCamera=="ANJUNGAN_R30")
	{
		retVal = ANJUNGAN_R30;
	}
	else if (lookCamera=="ANJUNGAN_R60")
	{
		retVal = ANJUNGAN_R60;
	}
	else if (lookCamera=="ANJUNGAN_L30")
	{
		retVal = ANJUNGAN_L30;
	}
	else if (lookCamera=="ANJUNGAN_L60")
	{
		retVal = ANJUNGAN_L60;
	}

	return retVal;
}

/**
 * Function to get the LookCameraEnum string from the LookCameraEnum
 *
 */
const std::string didCameraControlComponent::GetLookCameraString( LookCameraEnum lookCamera	///< the camera name to be checkedhe actor that will be attached by the camera
															) const
{
	std::string retVal= "";
	if (lookCamera==OBSERVER_1)
	{
		retVal = C_LOGIN_OBS_1;
	}
	if (lookCamera==OBSERVER_2)
	{
		retVal = C_LOGIN_OBS_2;
	}
	if (lookCamera==OBSERVER_3)
	{
		retVal = C_LOGIN_OBS_3;
	}
	if (lookCamera==OBSERVER_4)
	{
		retVal = C_LOGIN_OBS_4;
	}
	if (lookCamera==TDS)
	{
		retVal = C_LOGIN_TDS;
	}
	else if (lookCamera==ANJUNGAN)
	{
		retVal = C_LOGIN_ANJUNGAN;
	}
	else if (lookCamera==ANJUNGAN_R30)
	{
		retVal = "ANJUNGAN_R30";
	}
	else if (lookCamera==ANJUNGAN_R60)
	{
		retVal = "ANJUNGAN_R60";
	}
	else if (lookCamera==ANJUNGAN_L30)
	{
		retVal = "ANJUNGAN_L30";
	}
	else if (lookCamera==ANJUNGAN_L60)
	{
		retVal = "ANJUNGAN_L60";
	}

	return retVal;
}

/**
 * Function to initialize component
 */
void didCameraControlComponent::Init( const dtCore::DeltaWin::PositionSize&	posSize				///< default position (x, y) and size (width, height) of the window. in pixels
									, double								fov					///< default FOV. 
									, FovTypeEnum							fovType				///< the type of the inputted FOV 
									, bool									isFullScreen		///< default fullscreen mode
									, CameraSplitEnum						cameraSplitMode		///< default camerasplit mode. FRUSTUM (asymetric frustum for each camera) or ORIENTATION (different angles for each camera) type.
									)
{
	Init ( posSize.mX
		 , posSize.mY
		 , posSize.mWidth
		 , posSize.mHeight
		 , fov
		 , fovType
		 , isFullScreen
		 , cameraSplitMode );

}

/**
 * Function to initialize component
 */
void didCameraControlComponent::Init( int					x					///< default x position of the window. in pixels
									, int					y					///< default y position of the window. in pixels
									, int					width				///< default width of the window. in pixels
									, int					height				///< default height of the window. in pixels
									, double				fov					///< default fov. 
									, FovTypeEnum			fovType				///< the type of the inputted FOV 
									, bool					isFullScreen		///< default fullscreen mode
									, CameraSplitEnum		cameraSplitMode		///< default camerasplit mode. FRUSTUM (asymetric frustum for each camera) or ORIENTATION (different angles for each camera) type.
									)
{
	if (!mIsInitialized)
	{
	//const char* fovTypeStr = ;

		std::cout<<"\ndidCameraControlComponent::Init: Initialize camera controller component's common settings. \n" \
				<< "-- Window position: (" << x << ", " << y << ") \n" \
				<< "-- Window size: (" << width << ", " << height << ") \n" \
				<< "-- FOV: " << fov << " type " << ((fovType == HFOV_TYPE)? "Horizontal" : "Vertical") << "\n" \
				<< "-- Fullscreen: " << ((isFullScreen)? "Yes" : "No") << "\n" \
				<< "-- Camera Split mode (for anjungan look camera): " << ((cameraSplitMode == FRUSTUM_SPLIT)? "Frustum" : "Orientation") << "\n" \
				<< std::endl;

		//Setting the position and size of the window
		mCommonSettings.positionSize.mX = x;
		mCommonSettings.positionSize.mY = y;
		mCommonSettings.positionSize.mWidth = width;
		mCommonSettings.positionSize.mHeight = height;

		mCommonSettings.cameraSplit = cameraSplitMode;

		mCommonSettings.aspectRatio = width / (float) height;

		mCommonSettings.fullScreenMode = isFullScreen;
		

		if ( fovType == FovTypeEnum::HFOV_TYPE )
		{
			mCommonSettings.HFOV = fov;
			mCommonSettings.VFOV = (mCommonSettings.HFOV * height) / width ;
		}
		else
		{
			mCommonSettings.VFOV = fov;
			mCommonSettings.HFOV = (mCommonSettings.VFOV * width) / height ;
		}

		//Set the windows
		dtCore::DeltaWin* mainWin = GetGameManager()->GetApplication().GetWindow();

		mainWin->SetPosition( mCommonSettings.positionSize.mX
							, mCommonSettings.positionSize.mY
							, mCommonSettings.positionSize.mWidth
							, mCommonSettings.positionSize.mHeight );
		mainWin->SetFullScreenMode( mCommonSettings.fullScreenMode) ;

		// Set the cameras
		dtCore::Camera* mainCam = GetGameManager()->GetApplication().GetCamera();

		mainCam->GetOSGCamera()->getProjectionMatrixAsFrustum( mCommonSettings.leftFrustum
															 , mCommonSettings.rightFrustum
															 , mCommonSettings.bottomFrustum
															 , mCommonSettings.topFrustum
															 , mCommonSettings.nearClip
															 , mCommonSettings.farClip );
															 
		mainCam->SetPerspectiveParams( mCommonSettings.VFOV, mCommonSettings.aspectRatio, mCommonSettings.nearClip, mCommonSettings.farClip );
		mainCam->SetClearColor(0.0f, 0.0f, 1.0f, 1.f);

		mainCam->GetOSGCamera()->getProjectionMatrixAsFrustum( mCommonSettings.leftFrustum
															 , mCommonSettings.rightFrustum
															 , mCommonSettings.bottomFrustum
															 , mCommonSettings.topFrustum
															 , mCommonSettings.nearClip
															 , mCommonSettings.farClip );

		mIsInitialized = true;
	}
}

/**
 * Function to add a separate window and camera to the component (OBSERVER). The first call to this method won't create a new camera.
 * But instead it will change the settings of the main camera.
 *
 */
bool didCameraControlComponent::AddObserverWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
													 , int winPosX									///< window X position. for none fullscreen mode
													 , int winPosY									///< window Y position.  for none fullscreen mode
													 , int screenNum								///< the monitor / screen number that will display this camera
												     , dtCore::Transform& observerCamPos		 	///< the initial transform if the camera is an observer			
													 )
{
	bool retVal = false;
	if (mIsInitialized)
	{
		osg::Vec3 xyzPos;	
		osg::Vec3 hprRot;

		observerCamPos.Get( xyzPos, hprRot );

		std::cout<<"\ndidCameraControlComponent::AddObserverWinCamera: Adding observer camera settings at position: ( " \
				<< xyzPos._v[0] <<", "<< xyzPos._v[1] <<", "<< xyzPos._v[2] <<") & rotation (HPR): " \
				<< hprRot._v[0] <<", "<< hprRot._v[1] <<", "<< hprRot._v[2] <<") " \
				<< std::endl;

		AddWinCamera( name							///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
						, winPosX						///< window X position
						, winPosY						///< window Y position
						, LookCameraEnum::OBSERVER_1    ///< look camera setting
						, screenNum						///< the monitor / screen number that will display this camera
						, ""							///< the name of the actor that will be attached by the camera
						, observerCamPos				///< the initial transform if the camera is an observer			
						);

		retVal = true;
	}

	return retVal;
}

/**
 * Function to add a separate window and camera to the component (OBSERVER). The first call to this method won't create a new camera.
 * But instead it will change the settings of the main camera.
 *
 */
bool didCameraControlComponent::AddObserverWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
													 , int winPosX									///< window X position. for none fullscreen mode
													 , int winPosY									///< window Y position.  for none fullscreen mode
													 , int screenNum								///< the monitor / screen number that will display this camera
												     , osg::Vec3& xyzPosition					 	///< the initial position if the camera is an observer			
													 , osg::Vec3& hprRotation					 	///< the initial rotation if the camera is an observer			
													 )
{
	bool retVal = false;

	dtCore::Transform observerCamPos;
	observerCamPos.Set(xyzPosition, hprRotation);

	retVal = AddObserverWinCamera( name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
								 , winPosX					///< window X position. for none fullscreen mode
								 , winPosY					///< window Y position.  for none fullscreen mode
								 , screenNum				///< the monitor / screen number that will display this camera
							     , observerCamPos		 	///< the initial transform if the camera is an observer			
								 );

	return retVal;
}

/**
 * Function to add a separate window and camera to the component (ANJUNGAN???). The first call to this method won't create a new camera.
 * But instead it will change the settings of the main camera.
 *
 */
bool didCameraControlComponent::AddAnjunganWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
													, int winPosX									///< window X position
													, int winPosY									///< window Y position
													, LookCameraEnum lookCamera						///< look camera setting
													, int screenNum									///< the monitor / screen number that will display this camera
													, const std::string& attachedActorProxyName		///< the name of the actor that will be attached by the camera
													)
{
	bool retVal = false;
	if (mIsInitialized && lookCamera != LookCameraEnum::OBSERVER_1 && lookCamera != NO_CAMERA)
	{
		std::cout<<"\ndidCameraControlComponent::AddAnjunganWinCamera: Adding anjungan camera settings for " \
			<< GetLookCameraString(lookCamera) \
			<< " on Actor "
			<< attachedActorProxyName
			<< std::endl;


		AddWinCamera( name							///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
						, winPosX						///< window X position
						, winPosY						///< window Y position
						, lookCamera					///< look camera setting
						, screenNum						///< the monitor / screen number that will display this camera
						, attachedActorProxyName		///< the name of the actor that will be attached by the camera
						, dtCore::Transform()			///< the initial transform if the camera is an observer			
						);
		retVal = true;
	}

	return retVal;
}


bool didCameraControlComponent::AddTDSWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
													, int winPosX									///< window X position
													, int winPosY									///< window Y position
													, LookCameraEnum lookCamera						///< look camera setting
													, int screenNum									///< the monitor / screen number that will display this camera
													, const std::string& attachedActorProxyName		///< the name of the actor that will be attached by the camera
													, int launcherID	)
{
	bool retVal = false;
	if (mIsInitialized && lookCamera != LookCameraEnum::OBSERVER_1 && lookCamera != NO_CAMERA)
	{
		std::cout<<"\ndidCameraControlComponent::AddTDSWinCamera: Adding TDS camera settings for " \
			<< GetLookCameraString(lookCamera) \
			<< " on Actor "
			<< attachedActorProxyName
			<< std::endl;


		/// only cannon is TDS , maybe
		AddTDSCamera( name							///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
						, winPosX						///< window X position
						, winPosY						///< window Y position
						, lookCamera					///< look camera setting
						, screenNum						///< the monitor / screen number that will display this camera
						, attachedActorProxyName		///< the name of the actor that will be attached by the camera
						, dtCore::Transform()			///< the initial transform if the camera is an observer			
						, launcherID);
		retVal = true;
	}

	return retVal;
}


void didCameraControlComponent::SetFMM_ToCurrentObserver( )
{
	if (mIsInitialized && mCurrentActiveObserver >= 0)
	{
		mFmm->SetTarget(mWinCameras[mCurrentActiveObserver].GetCamera());
	}
}

void didCameraControlComponent::SetNextObserver( )
{
	std::vector<didWinCamera>::iterator it;
	bool isNextFound = false;

	if (mIsInitialized && mCurrentActiveObserver >= 0)
	{
		for ( it = mWinCameras.begin() + mCurrentActiveObserver + 1; it < mWinCameras.end(); ++it )
		{
			if (( it->GetLookCameraType() == OBSERVER_1 )||( it->GetLookCameraType() == OBSERVER_1 )
				|| ( it->GetLookCameraType() == OBSERVER_4 ) || ( it->GetLookCameraType() == OBSERVER_4 ))
			{
				mCurrentActiveObserver = it - mWinCameras.begin();
				isNextFound = true;
				break;
			}
		}

		if (!isNextFound)
		{
			for ( it =  mWinCameras.begin(); it < mWinCameras.begin() + mCurrentActiveObserver; ++it )
			{
				if (( it->GetLookCameraType() == OBSERVER_1 )||( it->GetLookCameraType() == OBSERVER_1 )
					|| ( it->GetLookCameraType() == OBSERVER_4 ) || ( it->GetLookCameraType() == OBSERVER_4 ))
				{
					mCurrentActiveObserver = it - mWinCameras.begin();
					isNextFound = true;
					break;
				}
			}
		}
		SetFMM_ToCurrentObserver();
	}
}

/**
 *
 *
 */
bool didCameraControlComponent::AddWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
												, int winPosX									///< window X position
												, int winPosY									///< window Y position
												, LookCameraEnum lookCamera						///< look camera setting
												, int screenNum									///< the monitor / screen number that will display this camera
												, const std::string& attachedActorProxyName		///< the name of the actor that will be attached by the camera
												, dtCore::Transform& observerCamPos				///< the initial transform if the camera is an observer			
												)
{
	bool retVal = false;
	if (mIsInitialized)
	{
			
		WinCameraSettings winCamSettings;
		winCamSettings.name = name;
		winCamSettings.winPosX = winPosX;
		winCamSettings.winPosY = winPosY;
		winCamSettings.lookCamera = lookCamera;
		winCamSettings.screenNum = screenNum;
		winCamSettings.attachedActorProxyName = attachedActorProxyName;
		winCamSettings.observerCamPos = observerCamPos;

		mWinCameraSettingsVec.push_back(winCamSettings);


		retVal = true;
	}

	return retVal;
}

bool didCameraControlComponent::AddTDSCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
												, int winPosX									///< window X position
												, int winPosY									///< window Y position
												, LookCameraEnum lookCamera						///< look camera setting
												, int screenNum									///< the monitor / screen number that will display this camera
												, const std::string& attachedActorProxyName		///< the name of the actor that will be attached by the camera
												, dtCore::Transform& observerCamPos				///< the initial transform if the camera is an observer			
												, int launcherID
												)
{
	bool retVal = false;
	if (mIsInitialized)
	{
			
		WinCameraSettings winCamSettings;
		winCamSettings.name = name;
		winCamSettings.winPosX = winPosX;
		winCamSettings.winPosY = winPosY;
		winCamSettings.lookCamera = lookCamera;
		winCamSettings.screenNum = screenNum;
		winCamSettings.attachedActorProxyName = attachedActorProxyName;
		winCamSettings.observerCamPos = observerCamPos;
		winCamSettings.launcherID = launcherID;

		mWinCameraSettingsVec.push_back(winCamSettings);


		retVal = true;
	}

	return retVal;
}

/**
 *
 *
 */
bool didCameraControlComponent::PopulateWinCameras( )
{
	bool retVal = false;
	if (mIsInitialized)
	{
		std::cout<<"\ndidCameraControlComponent::PopulateWinCameras: Populate / create all the cameras" \
			<< std::endl;

		if (mWinCameraSettingsVec.size() == 0)
		{
			 CreateMainWinCamera( "MainCamera" );
		}
		else
		{
			std::vector<WinCameraSettings>::iterator it;

			for ( it = mWinCameraSettingsVec.begin() ; it < mWinCameraSettingsVec.end(); ++it )
			{
				if ( it == mWinCameraSettingsVec.begin() ) //If the first element of the vector = main camera
				{
					CreateMainWinCamera( it->name, it->winPosX, it->winPosY, it->lookCamera, it->attachedActorProxyName, it->observerCamPos, it->launcherID );
				}
				else
				{
					switch (mCommonSettings.cameraSplit)
					{
						case FRUSTUM_SPLIT:
							CreateWinCameraFrustum( it->name, it->winPosX, it->winPosY, it->lookCamera, it->screenNum, it->attachedActorProxyName, it->observerCamPos, it->launcherID);
							break;

						case ORIENTATION_SPLIT:
							CreateWinCameraOrientation( it->name, it->winPosX, it->winPosY, it->lookCamera, it->screenNum, it->attachedActorProxyName, it->observerCamPos, it->launcherID);
							break;
					}
				}
				//Set current observer camera (for motion model)
				if ( (( it->lookCamera == OBSERVER_1 ) || ( it->lookCamera == OBSERVER_2 ) ||
					  ( it->lookCamera == OBSERVER_3 ) || ( it->lookCamera == OBSERVER_4 ) ) && mCurrentActiveObserver < 0)
				{
					mCurrentActiveObserver = it - mWinCameraSettingsVec.begin();
					
					SetFMM_ToCurrentObserver();
				}

			}
		}    


		retVal = true;
	}

	return retVal;
}

dtCore::RefPtr<dtDAL::ActorProxy> didCameraControlComponent::GetCannonLauncherActorByVehicleIDAndLauncherID(int mVehicleID , int LauncherID )
{

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_CANNONS )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> PLauncherID( (*iter)->GetProperty(C_SET_LID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( PLauncherID.get() ) );
				int lcr( ValLauncherID->GetValue() );
				if ( lcr == LauncherID )
				{
					proxy = (*iter);
					break;
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;

}


/**
 *
 *
 */
bool didCameraControlComponent::CreateMainWinCamera( const std::string& name						///< the name of the window, camera, and view
													  , int winPosX									///< window X position
													  , int winPosY									///< window Y position
													  , LookCameraEnum lookCamera					///< look camera setting
													  , const std::string& attachedActorProxyName	///< the name of the actor that will be attached by the camera
													  , dtCore::Transform& observerCamPos			///< the initial transform if the camera is an observer			
													  , int launcherID)
{
	bool retVal = false;
	if (mIsInitialized)
	{

		dtDAL::ActorProxy* attachedActorProxy;

		if (( lookCamera == OBSERVER_1)|| (lookCamera == OBSERVER_2) || (lookCamera == OBSERVER_3) || (lookCamera == OBSERVER_4))
		{
			osg::Vec3 xyzPos;	
			osg::Vec3 hprRot;

			observerCamPos.Get( xyzPos, hprRot );

			

			std::cout<<"\ndidCameraControlComponent::CreateMainWinCamera: Create the main camera (screenNum 0). \n" \
					<< "Camera Type: OBSERVER \n" \
					<< "At position ("<< xyzPos._v[0] <<", "<< xyzPos._v[1] <<", "<< xyzPos._v[2] <<") & rotation (HPR): (" \
					<< hprRot._v[0] <<", "<< hprRot._v[1] <<", "<< hprRot._v[2] <<") " \
					<< std::endl;
		}
		if (( lookCamera == TDS) )
		{

			dtDAL::ActorProxy* shipProxy;

			size_t numGameActors = GetGameManager()->GetNumGameActors();
			size_t numActors = GetGameManager()->GetNumAllActors();

			GetGameManager()->FindActorByName(attachedActorProxyName, shipProxy);

			if ( shipProxy  )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> VehicleID( shipProxy->GetProperty(C_SET_VID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValVehicleID( static_cast<dtDAL::IntActorProperty*>( VehicleID.get() ) );
				int shipID( ValVehicleID->GetValue() );

				//dtDAL::ActorProxy* cannonProxy;
				//cannonProxy = GetCannonLauncherActorByVehicleIDAndLauncherID(shipID,launcherID);
				
				attachedActorProxy = GetCannonLauncherActorByVehicleIDAndLauncherID(shipID,launcherID);

				//std::cout<<"\ndidCameraControlComponent::CreateMainWinCamera: Create the main camera (screenNum 0). \n " \
				
				if ( attachedActorProxy  )
			    {
					std::cout<< "Camera Type:" << GetLookCameraString(lookCamera) 
					<< " on Actor "
					//<< attachedActorProxyName
					<< attachedActorProxy->GetActor()->GetName()
					<< std::endl;
				}
				else
					std::cout<< "Camera Type:" << GetLookCameraString(lookCamera) 
					<< " can't attach Actor ship "<<shipID<<" launcher "<<launcherID
					<< std::endl;

			}
			else
			{
				attachedActorProxy = NULL ;
				std::cout<<GetName()<<" can not find parent ship with name :: "<< attachedActorProxyName <<std::endl;
			}

		}
		else
		{
			GetGameManager()->FindActorByName(attachedActorProxyName, attachedActorProxy);

			std::cout<<"\ndidCameraControlComponent::CreateMainWinCamera: Create the main camera (screenNum 0). \n " \
				<< "Camera Type:" << GetLookCameraString(lookCamera) \
				<< " on Actor "
				<< attachedActorProxyName
				<< std::endl;
		}

		
		//size_t numGameActors = GetGameManager()->GetNumGameActors();
		//size_t numActors = GetGameManager()->GetNumAllActors();
		// GetGameManager()->FindActorByName(attachedActorProxyName, attachedActorProxy);

		//std::cout<<"\ndidCameraControlComponent::CreateMainWinCamera: Recheck actor. \n" \
		//		<< "Actor Name:" << attachedActorProxyName  \
		//		<< "Actor Name Found:"	<< attachedActorProxy->GetName() \
		//		<< std::endl;

		dtCore::DeltaWin::PositionSize	posSize;
		posSize.mX = winPosX;
		posSize.mY = winPosY;
		posSize.mWidth = mCommonSettings.positionSize.mWidth;
		posSize.mHeight = mCommonSettings.positionSize.mHeight;

		didWinCamera newEntry = didWinCamera( GetGameManager()->GetApplication()
											, name
											, posSize
											, lookCamera 
											, mCommonSettings.cameraSplit
											, mCommonSettings.fullScreenMode
											, mCommonSettings.HFOV
											, HFOV_TYPE
											, mCommonSettings.leftFrustum
											, mCommonSettings.rightFrustum
											, mCommonSettings.bottomFrustum
											, mCommonSettings.topFrustum
											, mCommonSettings.nearClip
											, mCommonSettings.farClip
											, attachedActorProxy 
											, observerCamPos, launcherID );

		mWinCameras.push_back( newEntry );
	
		retVal = true;
	}

	return retVal;

}

/**
 *
 *
 */
bool didCameraControlComponent::CreateWinCameraFrustum( const std::string &name
														 , int winPosX
														 , int winPosY
														 , LookCameraEnum lookCamera 
														 , int screenNum
														 , const std::string& attachedActorProxyName
														 , dtCore::Transform& observerCamPos				///< the initial transform if the camera is an observer			
														 , int launcherID)

{
	bool retVal = false;

	if (mIsInitialized)
	{
		if (( lookCamera == OBSERVER_1)|| (lookCamera == OBSERVER_2) || (lookCamera == OBSERVER_3) || (lookCamera == OBSERVER_4))
		{
			osg::Vec3 xyzPos;	
			osg::Vec3 hprRot;

			observerCamPos.Get( xyzPos, hprRot );

			std::cout<<"\ndidCameraControlComponent::CreateWinCameraFrustum: Create the camera besides the main camera (screenNum 1 and above). FRUSTUM_SPLIT mode. \n" \
					<< "Camera Type: OBSERVER \n" \
					<< "At position "<< xyzPos._v[0] <<", "<< xyzPos._v[1] <<", "<< xyzPos._v[2] <<") & rotation (HPR): " \
					<< hprRot._v[0] <<", "<< hprRot._v[1] <<", "<< hprRot._v[2] <<") " \
					<< std::endl;
		}
		else
		{
			std::cout<<"\ndidCameraControlComponent::CreateWinCameraFrustum: Create the camera besides the main camera (screenNum 1 and above). FRUSTUM_SPLIT mode. \n" \
				<< "Camera Type:" << GetLookCameraString(lookCamera) \
				<< " on Actor " 	<< attachedActorProxyName \
				<< std::endl;
		}

		dtDAL::ActorProxy* attachedActorProxy;

		size_t numGameActors = GetGameManager()->GetNumGameActors();
		size_t numActors = GetGameManager()->GetNumAllActors();
		GetGameManager()->FindActorByName(attachedActorProxyName, attachedActorProxy);

		//std::cout<<"\ndidCameraControlComponent::CreateWinCameraFrustum: Recheck actor. \n" \
		//		<< "Actor Name:" << attachedActorProxyName  \
		//		<< "Actor Name Found:"	<< attachedActorProxy->GetName() \
		//		<< std::endl;

		dtCore::DeltaWin::PositionSize	posSize;
		posSize.mX = winPosX;
		posSize.mY = winPosY;
		posSize.mWidth = mCommonSettings.positionSize.mWidth;
		posSize.mHeight = mCommonSettings.positionSize.mHeight;

		didWinCamera newEntry = didWinCamera( GetGameManager()->GetApplication()
											, name
							 				, lookCamera
											, posSize
											, screenNum
											, mCommonSettings.fullScreenMode
											, mCommonSettings.HFOV
											, HFOV_TYPE
											, mCommonSettings.leftFrustum
											, mCommonSettings.rightFrustum
											, mCommonSettings.bottomFrustum
											, mCommonSettings.topFrustum
											, mCommonSettings.nearClip
											, mCommonSettings.farClip
											, attachedActorProxy
											, observerCamPos
											, launcherID);

		mWinCameras.push_back( newEntry );

		retVal = true;
	}

	return retVal;

}

/**
 *
 *
 */
bool didCameraControlComponent::CreateWinCameraOrientation( const std::string &name
															 , int winPosX
															 , int winPosY
															 , LookCameraEnum lookCamera 
															 , int screenNum
															 , const std::string& attachedActorProxyName
															 , dtCore::Transform& observerCamPos				///< the initial transform if the camera is an observer			
															 , int launcherID)
{
	bool retVal = false;

	if (mIsInitialized)
	{
		if (( lookCamera == OBSERVER_1)|| (lookCamera == OBSERVER_2) || (lookCamera == OBSERVER_3) || (lookCamera == OBSERVER_4))
		{
			osg::Vec3 xyzPos;	
			osg::Vec3 hprRot;

			observerCamPos.Get( xyzPos, hprRot );

			std::cout<<"\ndidCameraControlComponent::CreateWinCameraFrustum: Create the camera besides the main camera (screenNum 1 and above). ORIENTATION_SPLIT mode. \n" \
					<< "Camera Type: OBSERVER \n" \
					<< "At position "<< xyzPos._v[0] <<", "<< xyzPos._v[1] <<", "<< xyzPos._v[2] <<") & rotation (HPR): " \
					<< hprRot._v[0] <<", "<< hprRot._v[1] <<", "<< hprRot._v[2] <<") " \
					<< std::endl;
		}
		else
		{
			std::cout<<"\ndidCameraControlComponent::CreateWinCameraFrustum: Create the camera besides the main camera (screenNum 1 and above). ORIENTATION_SPLIT mode. \n" \
				<< "Camera Type:" << GetLookCameraString(lookCamera) \
				<< " on Actor "
				<< attachedActorProxyName
				<< std::endl;
		}

		dtDAL::ActorProxy* attachedActorProxy;

		size_t numGameActors = GetGameManager()->GetNumGameActors();
		size_t numActors = GetGameManager()->GetNumAllActors();
		GetGameManager()->FindActorByName(attachedActorProxyName, attachedActorProxy);

		dtCore::DeltaWin::PositionSize	posSize;
		posSize.mX = winPosX;
		posSize.mY = winPosY;
		posSize.mWidth = mCommonSettings.positionSize.mWidth;
		posSize.mHeight = mCommonSettings.positionSize.mHeight;

		didWinCamera newEntry = didWinCamera( GetGameManager()->GetApplication()
											, name
							 				, lookCamera
											, posSize
											, screenNum
											, mCommonSettings.fullScreenMode
											, mCommonSettings.HFOV
											, HFOV_TYPE
											, mCommonSettings.nearClip
											, mCommonSettings.farClip
											, attachedActorProxy
											, observerCamPos
											, launcherID);

		mWinCameras.push_back( newEntry );

		retVal = true;
	}

	return retVal;

}

////-- Generic Methods
////-------------------------------------------------------------------------------

