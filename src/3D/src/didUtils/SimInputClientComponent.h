//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#include <dtCore/refptr.h>
#include <dtGame/baseinputcomponent.h>
#include <dtDAL/gameevent.h>
#include <dtDAL/gameeventmanager.h>
#include <dtGame/logcontroller.h>

class InputComponent : public dtGame::BaseInputComponent
{
   public:
      InputComponent(const std::string &name, bool inPlaybackMode);
      bool HandleKeyPressed(  const dtCore::Keyboard* keyboard, int key );

      bool HandleKeyReleased(const dtCore::Keyboard* keyboard, int key ) ;
      void ProcessMessage(const dtGame::Message &message);

   protected:

      virtual ~InputComponent() { }

   private:
	  unsigned int mShipFocusIndex;
	  unsigned int mSubMarineFocusIndex;
	  unsigned int mHeliFocusIndex;
	  unsigned int mMiscFocusIndex;

	  void send_player_message( const int orderID, const int set0, const int set1, const int set2, const int set3, const int set4, const double set5, const double set6 );

	  void cycle_player_ship_focus();
	  void cycle_player_submarine_focus();
	  void cycle_player_heli_focus();

	  void test_explode(  const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos, const bool setCamera  );
};


