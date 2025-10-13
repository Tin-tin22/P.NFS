//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#include <dtCore/refptr.h>
#include <dtCore/camera.h>
#include <dtCore/scene.h>
#include <dtCore/deltawin.h>

#include <dtGame/baseinputcomponent.h>
#include <dtDAL/gameevent.h>
#include <dtDAL/gameeventmanager.h>
#include <dtGame/logcontroller.h>

#include <dtUtil/datapathutils.h>
#include <osgViewer/CompositeViewer>
#include <dtABC/application.h>

#include "../didActors/playeractor.h"

class InputComponent : public dtGame::BaseInputComponent
{
   public:
      InputComponent(const std::string &name, bool inPlaybackMode);
      bool HandleKeyPressed(  const dtCore::Keyboard* keyboard, int key );

      bool HandleKeyReleased(const dtCore::Keyboard* keyboard, int key ) ;
      void ProcessMessage(const dtGame::Message &message);

	  void TestErrorLooping();

	  // - enable process message [7/21/2014 EKA]
	  bool enableProcessMessage;

   protected:

      virtual ~InputComponent() { }

   private:
      unsigned int mShipFocusIndex;
	  unsigned int mSubMarineFocusIndex;
	  unsigned int mHeliFocusIndex;
	  unsigned int mMiscFocusIndex;

	  void follow_missile (  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void ceck_missile (  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_asroc(  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_reload_exocet(  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_rbu(  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_yakhont(  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_canon(  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_assigned_asroc(  const int VID, const int WID, const int LID, const int MID, const int MNUM  );
	  void test_sut_fire();
	  void test_sut_homing();

	  void test_explode(  const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos, const bool setCamera );
	  void test_explode_message(  const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos, const bool setCamera  );
	 
	  void test_player_forward();
	  void test_player_rotate();

	  void test_delete_ship_message(const int VID );
	
	  void test_ship_move_message(const int shipID, const int orderID, const float orderVal );
	  void test_follow_message(const int shipID);

	  void send_player_message( const int orderID, const int set0, const int set1, const int set2, const int set3, const int set4, const double set5, const double set6 );

	  void cycle_player_ship_focus();
	  void cycle_player_submarine_focus();
	  void cycle_player_heli_focus();

	  void test_camera();
		
};


