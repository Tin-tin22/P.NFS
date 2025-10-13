#include <dtCore/refptr.h>
#include <dtGame/baseinputcomponent.h>
#include <dtDAL/gameevent.h>
#include <dtDAL/gameeventmanager.h>
#include <dtGame/logcontroller.h>

class didInputClientComponent : public dtGame::BaseInputComponent
{
   public:
      didInputClientComponent(const std::string &name, bool inPlaybackMode);
      bool HandleKeyPressed(  const dtCore::Keyboard* keyboard, int key );
      bool HandleKeyReleased(const dtCore::Keyboard* keyboard, int key ) ;
      void ProcessMessage(const dtGame::Message &message);
   protected:
      virtual ~didInputClientComponent() { }
   private:
      unsigned int mShipFocusIndex;
};


