#ifndef VOBJ_ACTOR
#define VOBJ_ACTOR

#ifdef USE_VLD

#include <vld.h>

#endif

#include "didactorsheaders.h"


class DID_ACTORS_EXPORT ObjectActor : 
	public dtGame::GameActor
{
	public :
		ObjectActor(dtGame::GameActorProxy &proxy);
		virtual void TickLocal(const dtGame::Message &tickMessage);
		virtual void ProcessMessage(const dtGame::Message &message);
		virtual void OnEnteredWorld();
		void SetModel(const std::string &fileName);
		std::string GetModel() const { return mModelFile; }
		void SetVehicleID(int val) { mVehicleID = val;}
		int GetVehicleID() { return mVehicleID;}
		void SetTipeID(int val) { mTipeID = val;}
		int GetTipeID() { return mTipeID;}
		void UpdateHeight(float elapsedTime);
	protected :
		virtual ~ObjectActor();
	private :
		std::string	mModelFile;
		int mVehicleID;
		int mTipeID;
		float mHeight;
		void ProcessOrderEvent(const dtGame::Message &message);

};

class DID_ACTORS_EXPORT ObjectActorProxy : public dtGame::GameActorProxy
{
	public :
		virtual void BuildPropertyMap();
		virtual void BuildInvokables();
		virtual void CreateActor() { SetActor(*new ObjectActor(*this));}
		ObjectActorProxy();
	protected:
		virtual ~ObjectActorProxy();
		virtual void OnEnteredWorld();
	private:
};

#endif

