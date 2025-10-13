//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#include <string>
#include <xercesc/dom/DOMElement.hpp>
#include <osg/Vec2>
#include <osg/Vec3>
#include <osg/Vec4>
#include <dtUtil/Log.h>
#include <dtGame/GMComponent.h>

#include "../didActors/oceanconfigactor.h"
#include "../didUtils/SimActorDefinitions.h"

/**
 *
 *
 */
class SimEnvironmentXML :
		public dtGame::GMComponent
{
	//CONSTANTS & METHODS
	public:
		////////////////////////////////////////////////////////////////
		//Constants
		static const SimOceanConfig DEF_SIM_ENV_COMP;	///<default sim environment component

		static const std::string TAG_OCEAN;					///<ocean tag

		static const std::string TAG_OCEANSURFACE;							///<oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_FFT_GRIDSIZE;			///<FFT_gridsize attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_RESOLUTION;			///<resolution attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_NUM_TILES;				///<num_tiles  attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_WIND_DIRECTION;		///<wind_direction attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_WIND_SPEED;			///<wind_speed attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_DEPTH;					///<depth attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_WAVE_SCALE;			///<wave_scale attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_IS_CHOPPY;				///<is_choppy attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_CHOPPY_FACTOR;			///<choppy_factor attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_ANIM_LOOP_TIME;		///<anim_loop_time attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_NUM_FRAMES;			///<num_frames attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_FOAM_BOTTOM_HEIGHT;	///<foam_bottom_height attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_FOAM_TOP_HEIGHT;		///<foam_top_height attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_ENABLE_CREST_FOAM;		///<enable_crest_foam attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_ENABLE_ENDLESS_OCEAN;	///<enable_endless_ocean attribute of oceansurface tag
		static const std::string ATTRIB_OCEANSURFACE_OCEAN_HEIGHT;			///<ocean_height attribute of oceansurface tag

		static const std::string TAG_SKYBOX;				///<skybox tag
		static const std::string ATTRIB_SKYBOX_RADIUS;		///<skybox_radius attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_LONGSTEPS;	///<skybox_longsteps attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_LATSTEPS;	///<skybox_latsteps attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_TEX_UP;		///<tex_up attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_TEX_DOWN;	///<tex_down attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_TEX_LEFT;	///<tex_left attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_TEX_RIGHT;	///<tex_right attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_TEX_FRONT;	///<tex_front attribute of skybox tag
		static const std::string ATTRIB_SKYBOX_TEX_BACK;	///<tex_back attribute of skybox tag

		static const std::string TAG_LIGHTING;								///<lighting tag
		static const std::string ATTRIB_LIGHTING_LIGHT_COLOR;				///<light_color attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_SUN_DIRECTION;				///<sun_direction attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_SUN_DIFFUSE_COLOR;			///<sun_diffuse_color attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_SUN_AMBIENT_COLOR;			///<sun_ambient_color attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_SUN_SPECULAR_COLOR;		///<sun_specular_color attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_UNDERWATER_DIFFUSE_COLOR;	///<underwater_diffuse_color attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_UNDERWATER_ATTENUATION;	///<underwater_attenuation attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_ENABLE_UNDERWATER_DOF;		///<enable_underwater_DOF attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_ENABLE_REFLECTION;			///<enable_reflection attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_REFLECTION_DAMPING;		///<reflection_damping attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_ENABLE_REFRACTION;			///<enable_refraction attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_ENABLE_GODRAYS;			///<enable_godrays attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_ENABLE_SILT;				///<enable_silt attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_ENABLE_GLARE;				///<enable_glare attribute of lighting tag
        static const std::string ATTRIB_LIGHTING_ENABLE_GLOW;				///<enable_glow attribute of lighting tag // BAWE:20110809
		static const std::string ATTRIB_LIGHTING_GLARE_ATTENUATION;			///<glare_attenuation attribute of lighting tag
		static const std::string ATTRIB_LIGHTING_USE_DEFAULT_SCENE_SHADER;	///<use_default_scene_shader attribute of lighting tag
        static const std::string ATTRIB_LIGHTING_NIGHT_SCENE;	            ///<night_scene attribute of lighting tag. NIGHT_BODY


		static const std::string TAG_FOG;							///<fog tag
		static const std::string ATTRIB_FOG_ABOVEWATER_HEIGHT;		///<abovewater_fog_height attribute of fog tag
		static const std::string ATTRIB_FOG_ABOVEWATER_COLOR;		///<abovewater_fog_color attribute of fog tag
		static const std::string ATTRIB_FOG_UNDERWATER_HEIGHT;		///<underwater_fog_height attribute of fog tag
		static const std::string ATTRIB_FOG_UNDERWATER_COLOR;		///<underwater_fog_color attribute of fog tag

		////////////////////////////////////////////////////////////////
		// Constructor / Destructor
		SimEnvironmentXML();
		~SimEnvironmentXML();

		////////////////////////////////////////////////////////////////
		// Generic methods
		/** 
		 * 
		 */
		bool LoadXML( const std::string& fileName );

		/** 
		 * 
		 */
		bool CreateOceanConfig( );

		/** 
		 * 
		 */
		bool CreateOceanConfigFromXML( const std::string& fileName );

		/** 
		 * 
		 */
		void SetConfig( didEnviro::OceanConfigActor* configActor );

        //++ BAWE-20110606: NIGHT_BODY
        bool CheckNightScene();
        //-- BAWE-20110606: NIGHT_BODY

	//METHODS
	private:
		/** 
		 * Parsing XML file 
		 */
		bool ParseXML(std::string fileName);

		/** 
		 * Get the Element Attribute
		 */
		std::string GetElementAttribute( xercesc::DOMElement& element
										  , const std::string& attribName
										  );

		/** 
		 * Get the a string Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
									, const std::string& attribName
									, std::string& result
									);

		/** 
		 * Get the a boolean Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
								   , const std::string& attribName
								   , bool& result
								   );

		/** 
		 * Get the a float Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
								   , const std::string& attribName
								   , float& result
								   );

		/** 
		 * Get the an integer Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
								   , const std::string& attribName
								   , int& result
								   );

		/** 
		 * Get the an vector 2f Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
									, const std::string& attribName
									, osg::Vec2f& result
									);


		/** 
		 * Get the an vector 3f Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
									, const std::string& attribName
									, osg::Vec3f& result
									);


		/** 
		 * Get the an vector 4f Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
									, const std::string& attribName
									, osg::Vec4f& result
									);

		/**
		 * Parsing oceansurface element
		 */
		bool ParseOceansurfaceElement( xercesc::DOMElement *elem );

		/**
		 * Parsing skybox element
		 */
		bool ParseSkyboxElement( xercesc::DOMElement *elem );

		/**
		 * Parsing lighting element
		 */
		bool ParseLightingElement( xercesc::DOMElement *elem );

		/**
		 * Parsing fog element
		 */
		bool ParseFogElement( xercesc::DOMElement *elem );


	//VARIABLES
	// Protected Members
	protected:
		dtUtil::Log& mLogger;

	private:
		////////////////////////////////////////////////////////////////
		//Vars
		SimOceanConfig mSimOceanConfig;


		

};
