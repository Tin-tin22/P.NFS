// $Id: didCameraControlComponent.h

/**
 * @file didCameraControlComponent.h
 *
 * @author Bawenang R. P. P.
 *
 * @date August 27th, 2010
 *
 * @brief The header file for didCameraControlComponent component.
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


//++ BAWE-20100927: Include guard
#ifndef _DID_CAM_CTRL_COMP_H_
#define _DID_CAM_CTRL_COMP_H_

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

//++ Includes
#include "..\didCommon\const.h"
#include "Export.h"
#include "assert.h"

#include <vector>
#include <iostream>
#include <dtUtil/log.h>
#include <dtUtil/nodecollector.h>
#include <dtGame/messagetype.h>
#include <dtGame/message.h>
#include <dtGame/gmcomponent.h>
#include <dtGame/gameapplication.h>
#include <dtGame/gameactorproxy.h>
#include <dtGame/gameactor.h>
#include <dtCore/camera.h>
#include <dtCore/deltawin.h>
#include <dtCore/view.h>
#include <dtCore/transform.h>
#include <dtCore/flymotionmodel.h>
#include <dtCore/scene.h>

#include <dtCore/transformable.h>
#include <dtActors/staticmeshactorproxy.h>

#include <dtAudio/sound.h>
#include <dtAudio/audiomanager.h>
#include <dtAudio/soundeffectbinder.h>

#include <osgSim/DOFTransform>
//-- Includes

//++ Enumerations

////++ BAWE-20100927: LookCameraEnum enumeration
/**
 * This enum describes the type of the look camera mode
 */
enum LookCameraEnum 
{
	NO_CAMERA,			//< No camera. For server / ghost opponents.
	OBSERVER_1,			//< Observer camera.  DEFAULT. 
	OBSERVER_2,
	OBSERVER_3,
	OBSERVER_4,
	TDS,			
	ANJUNGAN,			//< Anjungan / bridge camera.
	ANJUNGAN_R30,		//< Anjungan / bridge 30 degree to the right (+30 degree) camera.
	ANJUNGAN_R60,		//< Anjungan / bridge 60 degree to the right (+60 degree) camera.
	ANJUNGAN_L30,		//< Anjungan / bridge 30 degree to the left (-30 degree) camera.
	ANJUNGAN_L60		//< Anjungan / bridge 60 degree to the left (-60 degree) camera.
};
////-- BAWE-20100927: LookCameraEnum enumeration

////++ BAWE-20100930: FovTypeEnum enumeration
/**
 * This enum describes the type of the FOV that's entered as the starting angle of the camera
 */
enum FovTypeEnum 
{
	HFOV_TYPE,		//< Horisontal FOV type. DEFAULT
	VFOV_TYPE		//< Vertical FOV type
};
////-- BAWE-20100930: FovTypeEnum enumeration

//++ BAWE-20100930: CameraSplitType enumeration
/**
 * This enum describes the type of the camera splitting technique
 */
enum CameraSplitEnum 
{
	FRUSTUM_SPLIT,				//< Split monitors by multiple frustums. DEFAULT
	ORIENTATION_SPLIT			//< Split monitors by camera orientation / heading angle.
};
//-- BAWE-20100930: LookCameraEnum enumeration

//++ BAWE-20110303: didCameraPreRender class
/**
* @class didCameraControlComponent didCameraControlComponent.h
*
* @brief The class for the pre render camera for displaying the tip of the ship.
*
* The class is used to make the tip of the ship displays correctly, without being culled.
*/
//class DID_DLL_EXPORT didCameraPreRender 
class didCameraPreRender 
{
    // METHODS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Public Methods
    public:
        ///////////////////////////////////////////////////////////////////
        // Static Const
        static const int NODEMASK_NO_NEAR_FAR_CALC;

        ///////////////////////////////////////////////////////////////////
        // Ctor & Dtor

        didCameraPreRender();
        ~didCameraPreRender();

        void Init(dtABC::Application &app, int width, int height,  dtDAL::ActorProxy* attachedActorProxy, osgSim::DOFTransform* cameranNode);

        void CreateTextureCamera(dtABC::Application &app, int width, int height);
        void CreateMaskedCamera(dtABC::Application &app, int width, int height);
        void CreateQuadCamera(dtABC::Application &app, int width, int height);

        void InitTextureCamera();
        void InitMaskedCamera();
        void InitQuadCamera();

        void CreateTextureTarget(dtABC::Application &app, int width, int height);
        void CreateMaskedTarget(dtABC::Application &app, int width, int height);
        void CreateScreenQuadGeode(  float width, float height );
        void InitScreenQuadGeode();

        osg::Program* CreateShaderProgram(  const std::string& name, 
            const std::string& vertexSrc, 
            const std::string& fragmentSrc
            );

        /**
        * 
        */
        void InitPrerenderCameraFrustum( double hfov
                                       , double vfov
                                       , double aspectRatio
                                       , double leftFrustum
                                       , double rightFrustum
                                       , double bottomFrustum
                                       , double topFrustum
                                       , double nearClip
                                       , double farClip
                                       );

        void InitCameraFrustum( dtCore::Camera* camera
                              , double hfov
                              , double vfov
                              , double aspectRatio
                              , double leftFrustum
                              , double rightFrustum
                              , double bottomFrustum
                              , double topFrustum
                              , double nearClip
                              , double farClip
                              , int type = 0 /*0 = Frustum, 1 = ortho, 2 = ortho2D*/
                              );

    private:
        dtCore::RefPtr<dtCore::Camera>      mTextureCamera;
        dtCore::RefPtr<dtCore::View>        mTextureView;
        dtCore::RefPtr<dtCore::Scene>       mTextureScene;

        dtCore::RefPtr<dtCore::Camera>      mMaskedCamera;
        dtCore::RefPtr<dtCore::View>        mMaskedView;
        dtCore::RefPtr<dtCore::Scene>       mMaskedScene;

        dtCore::RefPtr<dtCore::Camera>      mQuadCamera;
        dtCore::RefPtr<dtCore::View>        mQuadView;
        dtCore::RefPtr<dtCore::Scene>       mQuadScene;

        osg::ref_ptr<osg::Texture2D>        mTextureTarget;
        osg::ref_ptr<osg::Texture2D>        mMaskedTarget;
        osg::ref_ptr<osg::Geode>            mScreenQuadGeode;
        osg::ref_ptr<dtCore::Transformable> mQuadDrawable;
        dtCore::RefPtr<dtDAL::ActorProxy>			mAttachedActorProxy;
        dtCore::ObserverPtr<osgSim::DOFTransform>	mCameraNode;
    };

//-- BAWE-20110303: didCameraPreRender class

//++ BAWE-20100930: didWinCamera class
/**
 * @class didWinCamera didCameraControlComponent.h
 *
 * @brief The class to describe the window and camera initialization value and instances. 
 *
 * This struct is used as the entries for the mWinCameras vector.
 */
//class DID_DLL_EXPORT didWinCamera 
class didWinCamera 
{
	// METHODS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// Public Methods
	public:
		///////////////////////////////////////////////////////////////////
		// Static Const
		static const dtUtil::RefString didWinCamera::DOF_CAMERA_NAME;
		static const dtUtil::RefString didWinCamera::DOF_CANNON_CAMERA_01;
		static const dtUtil::RefString didWinCamera::DOF_CANNON_CAMERA_02;
		static const dtUtil::RefString didWinCamera::DOF_CANNON_CAMERA_03;

		///////////////////////////////////////////////////////////////////
		// Ctor & Dtor

		/**
		 * Ctor for main camera
		 */
		didWinCamera( dtABC::Application &app
					, const std::string& name	
					, dtCore::DeltaWin::PositionSize& winPosSize
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
					, int launcherID
					);


		/**
		 * Ctor for FRUSTUM_TYPE split
		 */
		didWinCamera( dtABC::Application& app
					, const std::string& name
					, LookCameraEnum lookCamera 
					, dtCore::DeltaWin::PositionSize& winPosSize
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
					, int launcherID);

		/**
		 * Ctor for ORIENTATION_TYPE split
		 */
		didWinCamera( dtABC::Application &app
					, const std::string &name
					, LookCameraEnum lookCamera 
					, dtCore::DeltaWin::PositionSize& winPosSize
					, int screenNum
					, bool isFullScreen
					, double fov
					, FovTypeEnum fovType
					, double nearClip
					, double farClip
					, dtDAL::ActorProxy* attachedActorProxy
					, dtCore::Transform& observerCamPos
					, int launcherID);

		/**
		 * Dtor
		 */
		~didWinCamera();

		///////////////////////////////////////////////////////////////////
		// Generic methods

		inline LookCameraEnum GetLookCameraType() const
		{
			return mLookCamera;
		}

		inline dtCore::Camera* GetCamera() const
		{
			return mCamera.get();
		}
	
	// Public Methods
	private:
		//Private default constructor
		
		/**
		 * 
		 */
		didWinCamera();

		/**
		 * 
		 */
		bool SetCameraNode(int launcherID);

		/**
		 * 
		 */
		bool AttachCameraNode( );

		/**
		 * 
		 */
		void CreateDeltaWindow( const dtCore::DeltaWin::DeltaWinTraits &winTraits );

		/**
		 * 
		 */
		void CreateCamera( const std::string &name );

        /**
        * 
        */
        void SetPrerender( dtABC::Application &app, int width, int height,  dtDAL::ActorProxy* attachedActorProxy, osgSim::DOFTransform* nodeCamera );

        /**
         * 
         */
        void InitPrerenderCameraFrustum(double hfov
            , double vfov
            , double aspectRatio
            , double leftFrustum
            , double rightFrustum
            , double bottomFrustum
            , double topFrustum
            , double nearClip
            , double farClip
            );

		/**
		 * 
		 */
		void InitCameraFrustumSplit(  LookCameraEnum lookCamera 
									  , double hfov
									  , double vfov
									  , double aspectRatio
									  , double leftFrustum
									  , double rightFrustum
									  , double bottomFrustum
									  , double topFrustum
									  , double nearClip
									  , double farClip 
									  );

		/**
		 * 
		 */
		void InitCameraOrientationSplit(  LookCameraEnum lookCamera 
										  , double hfov
										  , double vfov
										  , double aspectRatio
										  , double nearClip
										  , double farClip 
										  );

		/**
		 * 
		 */
		void CreateView(  const std::string &name
						  , dtABC::Application &app 
						  );

		/**
		 * 
		 */
		void SetFrustumProjection(  LookCameraEnum lookCamera 
									, double leftFrustum
									, double rightFrustum
									, double bottomFrustum
									, double topFrustum
									, double nearClip
									, double farClip 
									);

		/**
		 * 
		 */
		float GetAngleOrientationSplit( LookCameraEnum lookCamera 
										, double hfov
										);


	// MEMBERS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// Private Members
	private:
		LookCameraEnum								mLookCamera;

		//< Object Instances
		dtCore::RefPtr<dtCore::DeltaWin>			mWindow;
		dtCore::RefPtr<dtCore::Camera>				mCamera;
		dtCore::RefPtr<dtCore::View>				mView;

		dtCore::RefPtr<dtDAL::ActorProxy>			mAttachedActorProxy;
		dtCore::ObserverPtr<osgSim::DOFTransform>	mNodeCamera;

        didCameraPreRender*                         mPreRenderCamera;
};
//-- BAWE-20100930: didWinCamera class


//++ BAWE-20100930: didCameraControlComponent class
/**
 * @class didCameraControlComponent didCameraControlComponent.h
 *
 * @brief The class for the camera control component
 *
 * The component is used to manage all instances of the cameras.
 */
//class DID_DLL_EXPORT didCameraControlComponent : public dtGame::GMComponent
class didCameraControlComponent : public dtGame::GMComponent
{
	// METHODS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// Public Methods
	public:
		///////////////////////////////////////////////////////////////////
		// Parent Typedef
		typedef dtGame::GMComponent Parent;

		///////////////////////////////////////////////////////////////////
		// Structs


		/**
		 * This struct is used to store the settings of the initialization of the component
		 * 
		 */
		struct CommonSettings
		{
			dtCore::DeltaWin::PositionSize	positionSize;			///< default position (x, y) and size (width, height) of the window
			double							aspectRatio;			///< default aspect ratio. will be calculated from 
			double							HFOV;					///< default hfov. 
			double							VFOV;					///< default vfov. 
			bool							fullScreenMode;			///< default fullscreen mode
			CameraSplitEnum					cameraSplit;			///< default camerasplit mode. FRUSTUM (asymetric frustum for each camera) or ORIENTATION (different angles for each camera) type.

			//Frustum values will be calculated on runtime based on the settings above
			double							leftFrustum;			///< default left side of the frustum for the cameras. 
			double							rightFrustum;			///< default right side of the frustum for the cameras
			double							bottomFrustum;			///< default bottom side of the frustum for the cameras
			double							topFrustum;				///< default top side of the frustum for the cameras
			double							nearClip;				///< default near clipping for the cameras
			double							farClip;				///< default far clipping for the cameras
		};

		/**
		 * This struct is used to store the settings of the window and camera. At least one camera must be set, the main camera.
		 * 
		 */
		struct WinCameraSettings
		{
			std::string name;							///< the name of the window, camera, and view
			int winPosX;								///< window X position
			int winPosY;								///< window Y position
			LookCameraEnum lookCamera;					///< look camera setting
			int screenNum;								///< the monitor / screen number that will display this camera
			std::string attachedActorProxyName;			///< the name of the actor that will be attached by the camera
			dtCore::Transform observerCamPos;			///< the initial transform if the camera is an observer
			int launcherID;	
		};

		///////////////////////////////////////////////////////////////////
		// Structs

		///////////////////////////////////////////////////////////////////
		// Ctor & Dtor
        didCameraControlComponent(const std::string& name = "didCameraControlComponent");
		~didCameraControlComponent(void);

		///////////////////////////////////////////////////////////////////
		// Inherited Methods

		/**
		 * Function called by a GameManager to process Messages. This function forwards the connection related
		 * messages to the functions processing these messages.
		 * 
		 * @param The Message to be processed
		 */        
		virtual void ProcessMessage(const dtGame::Message& msg); 

		/**
		 * Called when this component is added to the Game Manager
		 */
		virtual void OnAddedToGM();	

		/**
		 * Called when this component is removed from the Game Manager
		 */
		virtual void OnRemovedFromGM();

		///////////////////////////////////////////////////////////////////
		// Class Generic Methods

		/**
		 * Function to get the LookCameraEnum from the LookCamera application param
		 *
		 */
		LookCameraEnum GetLookCameraEnum( const std::string& lookCamera	///< the camera name to be checkedhe actor that will be attached by the camera
										) const;

		/**
		 * Function to get the LookCameraEnum string from the LookCameraEnum
		 *
		 */
		const std::string GetLookCameraString( LookCameraEnum lookCamera	///< the camera name to be checkedhe actor that will be attached by the camera
											) const;

		/**
		 *
		 *
		 */
		void Init( const dtCore::DeltaWin::PositionSize&	defaultPositionSize	///< default position (x, y) and size (width, height) of the window. in pixels
				 , double									fov					///< default FOV. 
				 , FovTypeEnum								fovType				///< the type of the inputted FOV 
				 , bool										isFullScreen		///< default fullscreen mode
				 , CameraSplitEnum							cameraSplitMode		///< default camerasplit mode. FRUSTUM (asymetric frustum for each camera) or ORIENTATION (different angles for each camera) type.
				);

		/**
		 *
		 *
		 */
		void Init( int					x	= 0								///< default x position of the window. in pixels
				 , int					y	= 0								///< default y position of the window. in pixels
				 , int					width =	448							///< default width of the window. in pixels
				 , int					height = 252						///< default height of the window. in pixels
				 , double				fov	= 30							///< default fov. 
				 , FovTypeEnum			fovType	= HFOV_TYPE					///< the type of the inputted FOV 
				 , bool					isFullScreen = true					///< default fullscreen mode
				 , CameraSplitEnum		cameraSplitMode	= FRUSTUM_SPLIT		///< default camerasplit mode. FRUSTUM (asymetric frustum for each camera) or ORIENTATION (different angles for each camera) type.
//				 , CameraSplitEnum		cameraSplitMode	= ORIENTATION_SPLIT		///< default camerasplit mode. FRUSTUM (asymetric frustum for each camera) or ORIENTATION (different angles for each camera) type.
				 );

		/**
		 * Function to add a separate window and camera to the component (OBSERVER). The first call to this method won't create a new camera.
		 * But instead it will change the settings of the main camera.
		 *
		 */
		bool AddObserverWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
								 , int winPosX									///< window X position. for none fullscreen mode
								 , int winPosY									///< window Y position.  for none fullscreen mode
								 , int screenNum								///< the monitor / screen number that will display this camera
							     , dtCore::Transform& observerCamPos		 	///< the initial transform if the camera is an observer			
								 );
		
		/**
		 * Function to add a separate window and camera to the component (OBSERVER). The first call to this method won't create a new camera.
		 * But instead it will change the settings of the main camera.
		 *
		 */
		bool AddObserverWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
								 , int winPosX									///< window X position. for none fullscreen mode
								 , int winPosY									///< window Y position.  for none fullscreen mode
								 , int screenNum								///< the monitor / screen number that will display this camera
							     , osg::Vec3& xyzPosition					 	///< the initial position if the camera is an observer			
								 , osg::Vec3& hprRotation					 	///< the initial rotation if the camera is an observer			
								 );

		/**
		 * Function to add a separate window and camera to the component (ANJUNGAN???). The first call to this method won't create a new camera.
		 * But instead it will change the settings of the main camera.
		 *
		 */
		bool AddAnjunganWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
								 , int winPosX									///< window X position
								 , int winPosY									///< window Y position
								 , LookCameraEnum lookCamera					///< look camera setting
								 , int screenNum								///< the monitor / screen number that will display this camera
								 , const std::string& attachedActorProxyName	///< the name of the actor that will be attached by the camera
								 );

		/**
		 *
		 */

		bool AddTDSWinCamera    ( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
								 , int winPosX									///< window X position
								 , int winPosY									///< window Y position
								 , LookCameraEnum lookCamera					///< look camera setting
								 , int screenNum								///< the monitor / screen number that will display this camera
								 , const std::string& attachedActorProxyName	///< the name of the actor that will be attached by the camera
								 , int launcherID);

		/**
		 *
		 */

		void SetFMM_ToCurrentObserver( );

		/**
		 *
		 */
		void SetNextObserver( );
		
	// Private methods
	private:
		/**
		 * Function to add a separate window and camera to the component. The first call to this method won't create a new camera.
		 * But instead it will change the settings of the main camera.
		 *
		 */
		bool AddWinCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
							 , int winPosX									///< window X position
							 , int winPosY									///< window Y position
							 , LookCameraEnum lookCamera					///< look camera setting
							 , int screenNum								///< the monitor / screen number that will display this camera
							 , const std::string& attachedActorProxyName 	///< the name of the actor that will be attached by the camera
						     , dtCore::Transform& observerCamPos		 	///< the initial transform if the camera is an observer			
							 );


		bool AddTDSCamera( const std::string& name						///< the name of the window, camera, and view. MUST BE UNIQUE. NOTE: UNIQUENESS IS NOT CHECKED RIGHT NOW.
							 , int winPosX									///< window X position
							 , int winPosY									///< window Y position
							 , LookCameraEnum lookCamera					///< look camera setting
							 , int screenNum								///< the monitor / screen number that will display this camera
							 , const std::string& attachedActorProxyName 	///< the name of the actor that will be attached by the camera
						     , dtCore::Transform& observerCamPos		 	///< the initial transform if the camera is an observer	
							 , int launcherID
							 );

		/**
		 *
		 *
		 */
		bool PopulateWinCameras( );

		dtCore::RefPtr<dtDAL::ActorProxy> GetCannonLauncherActorByVehicleIDAndLauncherID(int mVehicleID , int LauncherID );

		/**
		 *
		 *
		 */
		bool CreateMainWinCamera( const std::string& name					= ""												///< the name of the window, camera, and view
								   , int winPosX								= 0													///< window X position
								   , int winPosY								= 0													///< window Y position
								   , LookCameraEnum lookCamera					= OBSERVER_1    									///< look camera setting
								   , const std::string& attachedActorProxyName	= NULL												///< the name of the actor that will be attached by the camera
								   , dtCore::Transform& observerCamPos			= dtCore::Transform(0.0f,0.0f,0.0f,0.0f,0.0f,0.0f)	///< the initial transform if the camera is an observer			
								   , int launcherID								= 0);

		/**
		 *
		 *
		 */
		bool CreateWinCameraFrustum( const std::string &name
									  , int winPosX
									  , int winPosY
									  , LookCameraEnum lookCamera 
									  , int screenNum
									  , const std::string& attachedActorProxyName
									  , dtCore::Transform& observerCamPos			
									  , int launcherID);


		/**
		 *
		 *
		 */
		bool CreateWinCameraOrientation( const std::string &name
										  , int winPosX
										  , int winPosY
										  , LookCameraEnum lookCamera 
										  , int screenNum
										  , const std::string& attachedActorProxyName
										  , dtCore::Transform& observerCamPos			
										  , int launcherID);

	// MEMBERS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// Protected Members
	protected:
		dtUtil::Log& mLogger;

	// Private Members
	private:
		bool									mIsInitialized;				///< Is the component initialized and ready to be used

		CommonSettings							mCommonSettings;
		std::vector<WinCameraSettings>			mWinCameraSettingsVec;

		int										mCurrentActiveObserver;		///< -1 if no observer found (default value = -1).

		std::vector<didWinCamera>				mWinCameras;					///< The cameras vector of the application
		dtCore::RefPtr<dtCore::FlyMotionModel>	mFmm;						///< FlyMotionModel for observer


};


//-- BAWE-20100930: didCameraControlComponent class

#endif
//-- BAWE-20100930: Include guard