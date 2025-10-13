///////////////////////////////////////////////////////////////////////////////

#include "simmessages.h"
#include "../didCommon/BaseConstant.h"

#include <dtGame/messageparameter.h>
#include <dtCore/UniqueID.h>
#include <dtCore/transform.h>

//-- constant init for class simMessages
//-- di pindah ke sini biar gak nambahin berat compile

const std::string C_MSG_LOGIN_NAME		= "LoginName";
const std::string C_MSG_PARAMS_1		= "Params1";
const std::string C_MSG_PARAMS_2		= "Params2";
const std::string C_MSG_PARAMS_3		= "Params3";
const std::string C_MSG_UID		        = "UniqueID";

const std::string C_MSG_XTARGET  		= "SetXTarget";
const std::string C_MSG_YTARGET			= "SetYTarget";
const std::string C_MSG_ZTARGET			= "SetZTarget";
const std::string C_MSG_TOF				= "SetTOF";

//Nando Added
const std::string C_MSG_CANNON_RANGE_T		= "SetTargetRangeCannon";
const std::string C_MSG_CANNON_BEARING_T	= "SetTargetBearingCannon";
const std::string C_MSG_CANNON_ELEV			= "SetElevasi";
const std::string C_MSG_CANNON_SETTAEGETID	= "SetTargetID";
const std::string C_MSG_CANNON_SETMODE		= "SetMode";
const std::string C_MSG_CANNON_UPDOWN		= "SetUpDown";
const std::string C_MSG_CANNON_CORRELEV		= "SetCorrectElev";
const std::string C_MSG_CANNON_CORRBEARING	= "SetCorrectBearing";
const std::string C_MSG_CANNON_BALISTIK		= "SetBalistik";
const std::string C_MSG_CANNON_X			= "SetPosX";
const std::string C_MSG_CANNON_Y			= "SetPosY";
const std::string C_MSG_CANNON_Z			= "SetPosZ";

const std::string C_MSG_ID					= "MessageID";
const std::string C_MSG_CMD1				= "MessageCmd1";
const std::string C_MSG_CMD2				= "MessageCmd2";
const std::string C_MSG_CMD3				= "MessageCmd3";
const std::string C_MSG_CMD4                = "MessageCmd4";

const std::string C_MSG_TORP_ISC		= "SetTorpedoCourse";
const std::string C_MSG_TORP_COURSE		= "SetSUTCourse";
const std::string C_MSG_TORP_SPEED		= "SetTorpedoSpeed";
const std::string C_MSG_TORP_DEPTH		= "SetTorpedoDepth";
const std::string C_MSG_TORP_MODE		= "SetTorpedoMode"; 
const std::string C_MSG_TORP_SAFEDISTANCE= "SetTorpedoSafeDistance";
const std::string C_MSG_TORP_ENDIS		= "SetTorpedoEnDis";
const std::string C_MSG_TORP_TARGETTYPE	= "SetTorpedotargetType"; 

//EKA
const std::string C_MSG_TORP_WTR		= "SetTorpedoA244WTR";
const std::string C_MSG_TORP_PGR		= "SetTorpedoA244PGR";
const std::string C_MSG_TORP_ACM		= "SetTorpedoA244ACM";
const std::string C_MSG_TORP_DOP		= "SetTorpedoA244DOP";
const std::string C_MSG_TORP_ISD		= "SetTorpedoA244ISD";
const std::string C_MSG_TORP_ITA		= "SetTorpedoA244ITA";
const std::string C_MSG_TORP_ISR		= "SetTorpedoA244ISR";
const std::string C_MSG_TORP_CEI		= "SetTorpedoA244CEI";
const std::string C_MSG_TORP_FLO		= "SetTorpedoA244FLO";
const std::string C_MSG_TORP_ACE		= "SetTorpedoA244ACE";
const std::string C_MSG_TORP_BARREL		= "SetTorpedoA244BARREL";
const std::string C_MSG_TORP_TYPE		= "SetTorpedoA244TYPE";
const std::string C_MSG_TORP_SCE		= "SetTorpedoA244SCE";

//Nando Added 20120411
const std::string C_MSG_MM40_TGTRANGE			= "SetExocetMM40TargetRange";
const std::string C_MSG_MM40_TGTBEARING			= "SetExocetMM40TargetBearing";
const std::string C_MSG_MM40_ANGULAR_MODE		= "SetExocetMM40AngularMode";
const std::string C_MSG_MM40_AGILITY_MODE		= "SetExocetMM40AgilityMode";
const std::string C_MSG_MM40_INITIALSTEP_MODE	= "SetExocetMM40InitialStepMode";
const std::string C_MSG_MM40_OBSTACLE_ALT		= "SetExocetMM40ObstacleAltitude";
const std::string C_MSG_MM40_OBSTACLE_RANGE		= "SetExocetMM40ObstacleRange";
const std::string C_MSG_MM40_APPROACH_RANGE		= "SetExocetMM40ApproachRange";
const std::string C_MSG_MM40_TERMINAL_RANGE		= "SetExocetMM40TerminalRange";
const std::string C_MSG_MM40_Left_Angle			= "SetExxocetMM40LeftAngle";
const std::string C_MSG_MM40_Right_Angle		= "SetExxocetMM40RightAngle";
const std::string C_MSG_MM40_Far_Range			= "SetExxocetMM40FarRange";
const std::string C_MSG_MM40_Near_Range			= "SetExxocetMM40NearRange";
const std::string C_MSG_MM40_Masking_1			= "SetExxocetMM40Masking1";
const std::string C_MSG_MM40_Masking_2			= "SetExxocetMM40Masking2";
const std::string C_MSG_MM40_Masking_3			= "SetExxocetMM40Masking3";
const std::string C_MSG_MM40_Masking_4			= "SetExxocetMM40Masking4";
const std::string C_MSG_MM40_Masking_5			= "SetExxocetMM40Masking5";
const std::string C_MSG_MM40_Masking_6			= "SetExxocetMM40Masking6";
const std::string C_MSG_MM40_Masking_7			= "SetExxocetMM40Masking7";
const std::string C_MSG_MM40_Masking_8			= "SetExxocetMM40Masking8";
const std::string C_MSG_MM40_Masking_9			= "SetExxocetMM40Masking9";
const std::string C_MSG_MM40_Masking_10			= "SetExxocetMM40Masking10";
const std::string C_MSG_MM40_Masking_11			= "SetExxocetMM40Masking11";
const std::string C_MSG_MM40_Masking_12			= "SetExxocetMM40Masking12";
const std::string C_MSG_MM40_Masking_13			= "SetExxocetMM40Masking13";
const std::string C_MSG_MM40_Masking_14			= "SetExxocetMM40Masking14";
const std::string C_MSG_MM40_Masking_15			= "SetExxocetMM40Masking15";
const std::string C_MSG_MM40_Masking_16			= "SetExxocetMM40Masking16";
const std::string C_MSG_MM40_SeekerOpenPosX		= "SetExxocetMM40SeekerOpenPosX";
const std::string C_MSG_MM40_SeekerOpenPosY		= "SetExxocetMM40SeekerOpenPosY";
const std::string C_MSG_MM40_SeekerOpenHeading	= "SetExxocetMM40SeekerOpenHeading";

//const std::string C_MSG_MM40_MASKING			= "SetExocetMM40Masking";

/// struct const actor position
const std::string C_MSG_POSX			= "PosX";
const std::string C_MSG_POSY			= "PosY";
const std::string C_MSG_POSZ			= "PosZ";
const std::string C_MSG_POSH			= "PosH";
const std::string C_MSG_POSP			= "PosP";
const std::string C_MSG_POSR			= "PosR";

/// struct const name setting (ASROCK)
const std::string C_MSG_TBEARING_ASROCK = "SetBearingAsrock";
const std::string C_MSG_TRANGE_ASROCK	= "SetRangeAsrock";
const std::string C_MSG_RADIUS_ASROCK 	= "SetRadiusAsrock";
const std::string C_MSG_TYPE_ASROCK 	= "SetTypeAsrock"; //E11012012
const std::string C_MSG_DEPTH_ASROCK 	= "SetDepthAsrock"; //E11012012
const std::string C_MSG_FUZE_ASROCK 	= "SetFuzeAsrock"; //E11012012
const std::string C_MSG_TARGETID_ASROCK	= "SetTargetIDAsrock"; //E11012012
const std::string C_MSG_CORRRANGE_ASROCK = "SetCorrectRangeAsrock";

/// struct const name setting (MISTRAL)
const std::string C_MSG_TBEARING_MISTRAL = "SetBearingMistral";
const std::string C_MSG_TRANGE_MISTRAL	= "SetRangeMistral";
const std::string C_MSG_RADIUS_MISTRAL 	= "SetRadiusMistral";
const std::string C_MSG_ELEV_MISTRAL	= "SetElevMistral";

/// struct const name setting (TETRAL)
const std::string C_MSG_TBEARING_TETRAL = "SetBearingTetral";
const std::string C_MSG_TRANGE_TETRAL	= "SetRangeTetral";
const std::string C_MSG_RADIUS_TETRAL 	= "SetRadiusTetral";
const std::string C_MSG_ELEV_TETRAL		= "SetElevTetral";

/// struct const name setting (STRELA)
const std::string C_MSG_TBEARING_STRELA = "SetBearingStrela";
const std::string C_MSG_TRANGE_STRELA	= "SetRangeStrela";
const std::string C_MSG_RADIUS_STRELA	= "SetRadiusStrela";
const std::string C_MSG_ELEV_STRELA  	= "SetElevStrela";

/// struct const name setting (RBU)
const std::string C_MSG_TBEARING_RBU		= "SetBearingRBU";
const std::string C_MSG_TRANGE_RBU			= "SetRangeRBU";
const std::string C_MSG_RADIUS_RBU 			= "SetRadiusRBU";
const std::string C_MSG_TYPE_RBU			= "SetTypeRBU"; //E11012012
const std::string C_MSG_DEPTH_RBU	 		= "SetDepthRBU"; //E11012012
const std::string C_MSG_TARGETID_RBU		= "SetTargetIDRBU"; //E11012012
const std::string C_MSG_COUNT_RBU			= "SetCountRBU"; // Count salvo RBU [7/26/2012 DID RKT2]
const std::string C_MSG_CORRECTBEARING_RBU	= "SetCorrectBearingRBU";
const std::string C_MSG_CORRECTELEV_RBU		= "SetCorrectElevDRBU";

//
const std::string C_MSG_TBEARING_A244 = "SetBearingA244";

/// struct const name setting ( EXOCET )
const std::string C_MSG_PROXFUZE		= "SetProxFuze";
const std::string C_MSG_ALTITUDE		= "SetAltitude";
const std::string C_MSG_SEARCHAREA		= "SetSearchArea";
const std::string C_MSG_RTG				= "SetRtg";
const std::string C_MSG_MANUALWIDTH		= "SetManualWidth";
const std::string C_MSG_SELECDEPTH		= "SetSelecDepth";
const std::string C_MSG_TBEARING		= "SetTargetBearing";
const std::string C_MSG_TRANGE			= "SetTargetRange";
const std::string C_MSG_EXOCET_FIRE		= "Exocet Fire";

//EKA-06032012
const std::string C_MSG_COURSE_TETRAL   = "Tetral_CourseLeadAngle";
const std::string C_MSG_PITCH_TETRAL   = "Tetral_PitchAngle";
const std::string C_MSG_COURSE_MISTRAL   = "Mistral_CourseLeadAngle";
const std::string C_MSG_PITCH_MISTRAL  = "Mistral_PitchAngle";
const std::string C_MSG_COURSE_STRELA   = "Strela_CourseLeadAngle";
const std::string C_MSG_PITCH_STRELA   = "Strela_PitchAngle";

/// struct const name setting (UTILITY)
const std::string C_MSG_UAT0		= "SetUAT0";
const std::string C_MSG_UAT1		= "SetUAT1";
const std::string C_MSG_UAT2		= "SetUAT2";
const std::string C_MSG_UAT3		= "SetUAT3";
const std::string C_MSG_UAT4		= "SetUAT4";
const std::string C_MSG_UAT5		= "SetUAT5";
const std::string C_MSG_UAT6		= "SetUAT6";

/// struct const name setting (OCEAN CONTROL)
const std::string C_MSG_OCEAN_BOOL	    = "OceanBOOL";
const std::string C_MSG_OCEAN_INT	    = "OceanINT";
const std::string C_MSG_OCEAN_FLOAT		= "OceanFLOAT";
const std::string C_MSG_OCEAN_VEC2		= "OceanVEC2";
const std::string C_MSG_OCEAN_VEC3		= "OceanVEC3";
const std::string C_MSG_OCEAN_VEC4		= "OceanVEC4";
//-- constant init for class simMessages


	//==================== MsgApplyLogin CLASS DEF =========================//
	MsgApplyLogin::MsgApplyLogin()
	{
		AddParameter( new dtGame::StringMessageParameter (C_MSG_LOGIN_NAME) );
		AddParameter( new dtGame::IntMessageParameter(C_MSG_PARAMS_1));
		AddParameter( new dtGame::IntMessageParameter(C_MSG_PARAMS_2));
		AddParameter( new dtGame::IntMessageParameter(C_MSG_PARAMS_3));
		AddParameter( new dtGame::ActorMessageParameter(C_MSG_UID));
		//AddParameter( new dtGame::StringMessageParameter( "ReasonReject" ) );
		//AddParameter( new dtGame::StringMessageParameter ( "ObjectHandledName" ) );
	}

	MsgApplyLogin::~MsgApplyLogin()
	{
	}

	void MsgApplyLogin::SetLoginName(const std::string &mName)
	{
		dtGame::StringMessageParameter *mp = static_cast<dtGame::StringMessageParameter*> (GetParameter(C_MSG_LOGIN_NAME));
		mp->SetValue(mName);
	}

	const std::string MsgApplyLogin::GetLoginName() const
	{
		const dtGame::StringMessageParameter *mp = static_cast<const dtGame::StringMessageParameter*> (GetParameter(C_MSG_LOGIN_NAME));
		return mp->GetValue();
	}

	void MsgApplyLogin::SetParams1(const int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_PARAMS_1));
		mp->SetValue(val);
	}

	const int MsgApplyLogin::GetParams1() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_PARAMS_1));
		return mp->GetValue();
	}

	void MsgApplyLogin::SetParams2(const int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_PARAMS_2));
		mp->SetValue(val);
	}

	const int MsgApplyLogin::GetParams2() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_PARAMS_2));
		return mp->GetValue();
	}

	void MsgApplyLogin::SetParams3(const int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_PARAMS_3));
		mp->SetValue(val);
	}

	const int MsgApplyLogin::GetParams3() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_PARAMS_3));
		return mp->GetValue();
	}

	void MsgApplyLogin::SetObjectIDToBeHandled(const dtCore::UniqueId& uniqueId)
	{
		dtGame::ActorMessageParameter* uniqueIdParam =
					static_cast< dtGame::ActorMessageParameter* >( GetParameter(C_MSG_UID) );
		uniqueIdParam->SetValue( uniqueId );
	}

	const dtCore::UniqueId  MsgApplyLogin::GetObjectIDToBeHandled() const
	{
		const dtGame::ActorMessageParameter* uniqueIdParam =
					static_cast< const dtGame::ActorMessageParameter* >( GetParameter(C_MSG_UID) );
		return uniqueIdParam->GetValue();
	}

	/*void MsgApplyLogin::SetObjectNameToBeHandled(const std::string &mName)
	{
		dtGame::StringMessageParameter *mp = static_cast<dtGame::StringMessageParameter*> (GetParameter("ObjectHandledName"));
		mp->SetValue(mName);
	}

	const std::string MsgApplyLogin::GetObjectNameToBeHandled() const
	{
		const dtGame::StringMessageParameter *mp = static_cast<const dtGame::StringMessageParameter*> (GetParameter("ObjectHandledName"));
		return mp->GetValue();
	}*/

	/*void  MsgApplyLogin::SetReasonIfReject(const std::string& mReason)
	{
		dtGame::StringMessageParameter *mp = static_cast<dtGame::StringMessageParameter*> (GetParameter("ReasonReject"));
		mp->SetValue(mReason);
	}

	const std::string  MsgApplyLogin::GetReasonIfReject() const
	{
		const dtGame::StringMessageParameter *mp = static_cast<const dtGame::StringMessageParameter*> (GetParameter("ReasonReject"));
		return mp->GetValue();
	}*/

	//==================== MsgApplyLogin CLASS DEF =========================//

	//==================== MsgParentActor CLASS DEF =========================//

	MsgParentActor::MsgParentActor()
	{
		AddParameter( new dtGame::ActorMessageParameter( "ParentId" ) );
	}

	void MsgParentActor::SetParentId(dtCore::UniqueId UId)
	{
		dtGame::ActorMessageParameter* uniqueIdParam =
					static_cast< dtGame::ActorMessageParameter* >( GetParameter( "ParentId" ) );
		uniqueIdParam->SetValue( UId );
	}

	const dtCore::UniqueId MsgParentActor::GetParentId() const
	{
		const dtGame::ActorMessageParameter* uniqueIdParam =
					static_cast< const dtGame::ActorMessageParameter* >( GetParameter( "ParentId" ) );
		return uniqueIdParam->GetValue();
	}

	//==================== MsgParentActor CLASS DEF =========================//

	//==================== MsgPosition CLASS DEF =========================//
	MsgPosition::MsgPosition()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSX ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSY ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSZ ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSH ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_SET_SPEED ) );
	}

	void MsgPosition::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	
	const int MsgPosition::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgPosition::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}

	const int MsgPosition::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgPosition::SetPosXValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSX));
		mp->SetValue(val);
	}

	const float MsgPosition::GetPosXValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSX));
		return mp->GetValue();
	}

	void MsgPosition::SetPosYValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSY));
		mp->SetValue(val);
	}

	const float MsgPosition::GetPosYValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSY));
		return mp->GetValue();
	}

	void MsgPosition::SetPosZValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSZ));
		mp->SetValue(val);
	}

	const float MsgPosition::GetPosZValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSZ));
		return mp->GetValue();
	}

	void MsgPosition::SetPosHValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSH));
		mp->SetValue(val);
	}

	const float MsgPosition::GetPosHValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSH));
		return mp->GetValue();
	}

	void MsgPosition::SetSpeedValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_SET_SPEED));
		mp->SetValue(val);
	}

	const float MsgPosition::GetSpeedValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_SET_SPEED));
		return mp->GetValue();
	}

    //==================== MsgPosition CLASS DEF =========================// 

	//==================== MsgOrder CLASS DEF =========================//
	MsgOrder::MsgOrder()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::FloatMessageParameter ( "OrderValue" ) );
		AddParameter( new dtGame::StringMessageParameter( "StringValue" ) );
		AddParameter( new dtGame::FloatMessageParameter( "XValue" ) );
		AddParameter( new dtGame::FloatMessageParameter( "YValue" ) );
		AddParameter( new dtGame::FloatMessageParameter( "ZValue" ) );
		AddParameter( new dtGame::IntMessageParameter ( "ModeGuidance" ) );
		AddParameter( new dtGame::IntMessageParameter ( "ModeAltitude" ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LETHALITY ) );
	}

	void MsgOrder::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	
	const int MsgOrder::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgOrder::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}

	const int MsgOrder::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgOrder::SetStringValue(std::string strValue)
	{
		dtGame::StringMessageParameter *mp = static_cast<dtGame::StringMessageParameter*> (GetParameter("StringValue"));
		mp->SetValue(strValue);
	}

	const std::string MsgOrder::GetStringValue() const
	{
		const dtGame::StringMessageParameter *mp = static_cast<const dtGame::StringMessageParameter*> (GetParameter("StringValue"));
		return mp->GetValue();
	}

	void MsgOrder::SetFloatValue(float orderValue)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter("OrderValue"));
		mp->SetValue(orderValue);
	}

	const float MsgOrder::GetFloatValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter("OrderValue"));
		return mp->GetValue();
	}
	void MsgOrder::SetFloatValue1(float orderValue)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter("XValue"));
		mp->SetValue(orderValue);
	}

	const float MsgOrder::GetFloatValue1() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter("XValue"));
		return mp->GetValue();
	}
	void MsgOrder::SetFloatValue2(float orderValue)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter("YValue"));
		mp->SetValue(orderValue);
	}

	const float MsgOrder::GetFloatValue2() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter("YValue"));
		return mp->GetValue();
	}
	void MsgOrder::SetFloatValue3(float orderValue)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter("ZValue"));
		mp->SetValue(orderValue);
	}

	const float MsgOrder::GetFloatValue3() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter("ZValue"));
		return mp->GetValue();
	}

	// Guidance [10/25/2012 DID RKT2]
	void MsgOrder::SetModeGuidance(int orderValue)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter("ModeGuidance"));
		mp->SetValue(orderValue);
	}

	const int MsgOrder::GetModeGuidance() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter("ModeGuidance"));
		return mp->GetValue();
	}

	// Mode Altitude [11/26/2012 DID RKT2]
	void MsgOrder::SetModeAltitude(int orderValue)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter("ModeAltitude"));
		mp->SetValue(orderValue);
	}

	const int MsgOrder::GetModeAltitude() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter("ModeAltitude"));
		return mp->GetValue();
	}

	// Lethality [7/9/2013 DID RKT2]
	void MsgOrder::SetLethality(int orderValue)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LETHALITY));
		mp->SetValue(orderValue);
	}

	const int MsgOrder::GetLethality() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LETHALITY));
		return mp->GetValue();
	}
	//==================== MsgOrder CLASS DEF =========================//

	//==================== MsgSetTorpedoSUT CLASS DEF =========================//
	MsgSetTorpedoSUT::MsgSetTorpedoSUT()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_TGTID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_COURSE ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_SPEED ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_DEPTH) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_ENDIS) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_MODE ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_SAFEDISTANCE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_TARGETTYPE ) );
	}
	void MsgSetTorpedoSUT::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetTorpedoSUT::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetTorpedoSUT::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetTorpedoSUT::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetTorpedoSUT::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetTorpedoSUT::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetTorpedoSUT::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetTorpedoSUT::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetTorpedoSUT::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetTorpedoSUT::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetTorpedoSUT::SetTargetID(int TGTID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_TGTID));
		mp->SetValue(TGTID);
	}
	const int MsgSetTorpedoSUT::GetTargetID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_TGTID));
		return mp->GetValue();
	}
	void MsgSetTorpedoSUT::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetTorpedoSUT::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}
	
	void MsgSetTorpedoSUT::SetTorpedoCourse(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_COURSE));
		mp->SetValue(val);
	}
	const float MsgSetTorpedoSUT::GetTorpedoCourse() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_COURSE));
		return mp->GetValue();
	}
	void MsgSetTorpedoSUT::SetTorpedoSpeed(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_SPEED));
		mp->SetValue(val);
	}
	const float MsgSetTorpedoSUT::GetTorpedoSpeed() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_SPEED));
		return mp->GetValue();
	}
	void MsgSetTorpedoSUT::SetTorpedoSafeDistance(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_SAFEDISTANCE));
		mp->SetValue(val);
	}
	const float MsgSetTorpedoSUT::GetTorpedoSafeDistance() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_SAFEDISTANCE));
		return mp->GetValue();
	}
	void MsgSetTorpedoSUT::SetTorpedoDepth(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_DEPTH));
		mp->SetValue(val);
	}
	const float MsgSetTorpedoSUT::GetTorpedoDepth() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_DEPTH));
		return mp->GetValue();
	}
	void MsgSetTorpedoSUT::SetTorpedoEnDis(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_ENDIS));
		mp->SetValue(val);
	}
	const float MsgSetTorpedoSUT::GetTorpedoEnDis() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_ENDIS));
		return mp->GetValue();
	}
	void MsgSetTorpedoSUT::SetModePrediction(int predm)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_MODE));
		mp->SetValue(predm);
	}
	const int MsgSetTorpedoSUT::GetModePrediction() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_MODE));
		return mp->GetValue();
	}

	void MsgSetTorpedoSUT::SetTargetType(int targetType)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_TARGETTYPE));
		mp->SetValue(targetType);
	}
	const int MsgSetTorpedoSUT::GetTargetType() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_TARGETTYPE));
		return mp->GetValue();
	}
	//==================== MsgSetTorpedoSUT CLASS DEF =========================//  

	//==================== MsgSetTorpedoA244S CLASS DEF =========================// EKA-031111
	MsgSetTorpedo::MsgSetTorpedo()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_TGTID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_ISC ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_SPEED ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TORP_DEPTH) );


		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_WTR ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_PGR ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_ACM) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_DOP ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_ISD ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_ITA) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_ISR ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_CEI ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_FLO) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_ACE) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_BARREL) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TORP_TYPE) );
	}
	void MsgSetTorpedo::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetTorpedo::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTargetID(int TGTID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_TGTID));
		mp->SetValue(TGTID);
	}
	const int MsgSetTorpedo::GetTargetID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_TGTID));
		return mp->GetValue();
	}
	void MsgSetTorpedo::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetTorpedo::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}
	void MsgSetTorpedo::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoISC(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_ISC));
		mp->SetValue(val);
	}
	const float MsgSetTorpedo::GetTorpedoISC() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_ISC));
		return mp->GetValue();
	}
	void MsgSetTorpedo::SetTorpedoSpeed(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_SPEED));
		mp->SetValue(val);
	}
	const float MsgSetTorpedo::GetTorpedoSpeed() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_SPEED));
		return mp->GetValue();
	}
	void MsgSetTorpedo::SetTorpedoDepth(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_DEPTH));
		mp->SetValue(val);
	}
	const float MsgSetTorpedo::GetTorpedoDepth() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_DEPTH));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoISD(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ISD));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoISD() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ISD));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoITA(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ITA));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoITA() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ITA));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoISR(int val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_ISR));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoISR() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TORP_ISR));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoCEI(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_CEI));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoCEI() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_CEI));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoFLO(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_FLO));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoFLO() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_FLO));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoACE(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ACE));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoACE() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ACE));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoWTR(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_WTR));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoWTR() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_WTR));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoPRG(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_PGR));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoPRG() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_PGR));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoACM(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ACM));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoACM() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_ACM));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoDOP(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_DOP));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoDOP() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_DOP));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoBarrel(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_BARREL));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoBarrel() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_BARREL));
		return mp->GetValue();
	}

	void MsgSetTorpedo::SetTorpedoType(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_TYPE));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetTorpedoType() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_TYPE));
		return mp->GetValue();
	}
	void MsgSetTorpedo::SetScenario(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_SCE));
		mp->SetValue(val);
	}
	const int MsgSetTorpedo::GetScenario() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TORP_SCE));
		return mp->GetValue();
	}
	//==================== MsgSetTorpedo CLASS DEF =========================//

	//==================== MsgActorsControl CLASS DEF =========================//
	MsgActorsControl::MsgActorsControl()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_TID ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_AID1 ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_AID2 ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_AID3 ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_AID4 ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) ); 
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSX ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSY ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSZ ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSH ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSP ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_POSR ) );
	}

	void MsgActorsControl::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}

	const int MsgActorsControl::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgActorsControl::SetTipeID(int TipeID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_TID));
		mp->SetValue(TipeID);
	}

	const int MsgActorsControl::GetTipeID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_TID));
		return mp->GetValue();
	}

	void MsgActorsControl::SetActorRuntimeID1(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_AID1));
		mp->SetValue(VID);
	}

	const int MsgActorsControl::GetActorRuntimeID1() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_AID1));
		return mp->GetValue();
	}

	void MsgActorsControl::SetActorRuntimeID2(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_AID2));
		mp->SetValue(VID);
	}

	const int MsgActorsControl::GetActorRuntimeID2() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_AID2));
		return mp->GetValue();
	}

	void MsgActorsControl::SetActorRuntimeID3(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_AID3));
		mp->SetValue(VID);
	}

	const int MsgActorsControl::GetActorRuntimeID3() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_AID3));
		return mp->GetValue();
	}

	void MsgActorsControl::SetActorRuntimeID4(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_AID4));
		mp->SetValue(VID);
	}

	const int MsgActorsControl::GetActorRuntimeID4() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_AID4));
		return mp->GetValue();
	}

	void MsgActorsControl::SetOrderID(int TipeID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(TipeID);
	}

	const int MsgActorsControl::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgActorsControl::SetPosXValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSX));
		mp->SetValue(val);
	}

	const float MsgActorsControl::GetPosXValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSX));
		return mp->GetValue();
	}

	void MsgActorsControl::SetPosYValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSY));
		mp->SetValue(val);
	}

	const float MsgActorsControl::GetPosYValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSY));
		return mp->GetValue();
	}

	void MsgActorsControl::SetPosZValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSZ));
		mp->SetValue(val);
	}

	const float MsgActorsControl::GetPosZValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSZ));
		return mp->GetValue();
	}

	void MsgActorsControl::SetPosHValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSH));
		mp->SetValue(val);
	}

	const float MsgActorsControl::GetPosHValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSH));
		return mp->GetValue();
	}
	void MsgActorsControl::SetPosPValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSP));
		mp->SetValue(val);
	}

	const float MsgActorsControl::GetPosPValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSP));
		return mp->GetValue();
	}

	void MsgActorsControl::SetPosRValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSR));
		mp->SetValue(val);
	}

	const float MsgActorsControl::GetPosRValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_POSR));
		return mp->GetValue();
	}

	//==================== MsgActorsControl CLASS DEF =========================//

	//==================== MsgSetExocet CLASS DEF =========================//
	MsgSetExocet::MsgSetExocet()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_PROXFUZE ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_ALTITUDE ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_SEARCHAREA ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_RTG ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_MANUALWIDTH ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_SELECDEPTH ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TBEARING ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TRANGE ) );
		AddParameter( new dtGame::StringMessageParameter( C_MSG_EXOCET_FIRE ) );
	}

	void MsgSetExocet::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	
	const int MsgSetExocet::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetExocet::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetExocet::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}


	void MsgSetExocet::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetExocet::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetExocet::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetExocet::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetExocet::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetExocet::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}


	void MsgSetExocet::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}

	const int MsgSetExocet::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetExocet::SetProxFuze(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_PROXFUZE));
		mp->SetValue(val);
	}

	const float MsgSetExocet::GetProxFuze() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_PROXFUZE));
		return mp->GetValue();
	}

	void MsgSetExocet::SetAltitude(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ALTITUDE));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetAltitude() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ALTITUDE));
		return mp->GetValue();
	}
	void MsgSetExocet::SetSearchArea(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_SEARCHAREA));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetSearchArea() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_SEARCHAREA));
		return mp->GetValue();
	}
	void MsgSetExocet::SetTargetBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetTargetBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING));
		return mp->GetValue();
	}
	void MsgSetExocet::SetTargetRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetTargetRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE));
		return mp->GetValue();
	}
	void MsgSetExocet::SetRangeToGo(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_RTG));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetRangeToGo() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_RTG));
		return mp->GetValue();
	}
	void MsgSetExocet::SetManualWidth(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_MANUALWIDTH));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetManualWidth() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_MANUALWIDTH));
		return mp->GetValue();
	}
	void MsgSetExocet::SetSelecDepth(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_SELECDEPTH));
		mp->SetValue(val);
	}
	const float MsgSetExocet::GetSelecDepth() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_SELECDEPTH));
		return mp->GetValue();
	}

	//==================== MsgSetExocet CLASS DEF =========================//

	//==================== MsgSetAsrock CLASS DEF =========================//
	MsgSetAsrock::MsgSetAsrock()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TBEARING_ASROCK ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TRANGE_ASROCK ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TYPE_ASROCK ) ); //E11012012
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_DEPTH_ASROCK ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_FUZE_ASROCK ) ); //E11012012
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TARGETID_ASROCK ) ); //E11012012
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_CORRRANGE_ASROCK ) );
	}
	void MsgSetAsrock::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetAsrock::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}


	const int MsgSetAsrock::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}
	
	void MsgSetAsrock::SetTargetBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_ASROCK));
		mp->SetValue(val);
	}
	const float MsgSetAsrock::GetTargetBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_ASROCK));
		return mp->GetValue();
	}
	void MsgSetAsrock::SetTargetRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_ASROCK));
		mp->SetValue(val);
	}
	const float MsgSetAsrock::GetTargetRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_ASROCK));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetMissileType(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TYPE_ASROCK));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetMissileType() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TYPE_ASROCK));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetMissileFuze(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_FUZE_ASROCK));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetMissileFuze() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_FUZE_ASROCK));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetTargetDepth(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_DEPTH_ASROCK));
		mp->SetValue(val);
	}
	const float MsgSetAsrock::GetTargetDepth() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_DEPTH_ASROCK));
		return mp->GetValue();
	}

	void MsgSetAsrock::SetTargetID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TARGETID_ASROCK));
		mp->SetValue(val);
	}
	const int MsgSetAsrock::GetTargetID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TARGETID_ASROCK));
		return mp->GetValue();
	}
	void MsgSetAsrock::SetCorrectRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CORRRANGE_ASROCK));
		mp->SetValue(val);
	}
	const float MsgSetAsrock::GetCorrectRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CORRRANGE_ASROCK));
		return mp->GetValue();
	}
	//==================== MsgSetAsrock CLASS DEF =========================//


	//==================== MsgSetRBU CLASS DEF =========================//
	MsgSetRBU::MsgSetRBU()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TBEARING_RBU ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TRANGE_RBU ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TYPE_RBU ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_DEPTH_RBU ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_TARGETID_RBU ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_COUNT_RBU ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_CORRECTBEARING_RBU ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_CORRECTELEV_RBU ) );
	}
	void MsgSetRBU::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetRBU::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetRBU::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetRBU::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}
	void MsgSetRBU::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetRBU::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetRBU::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetRBU::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}
	
	void MsgSetRBU::SetTargetBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_RBU));
		mp->SetValue(val);
	}
	const float MsgSetRBU::GetTargetBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetTargetRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_RBU));
		mp->SetValue(val);
	}
	const float MsgSetRBU::GetTargetRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetMissileType(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TYPE_RBU));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetMissileType() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TYPE_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetTargetDepth(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_DEPTH_RBU));
		mp->SetValue(val);
	}
	const float MsgSetRBU::GetTargetDepth() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_DEPTH_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetTargetID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_TARGETID_RBU));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetTargetID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_TARGETID_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetCountRBU(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_COUNT_RBU));
		mp->SetValue(val);
	}
	const int MsgSetRBU::GetCountRBU() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_COUNT_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetCorrectBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CORRECTBEARING_RBU));
		mp->SetValue(val);
	}
	const float MsgSetRBU::GetCorrectBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CORRECTBEARING_RBU));
		return mp->GetValue();
	}
	void MsgSetRBU::SetCorrectElev(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CORRECTELEV_RBU));
		mp->SetValue(val);
	}
	const float MsgSetRBU::GetCorrectElev() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CORRECTELEV_RBU));
		return mp->GetValue();
	}

	//==================== MsgSetRBU CLASS DEF =========================//

	//==================== MsgSetMessage CLASS DEF =========================//

	MsgSetHandleMessage::MsgSetHandleMessage()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_ID ) );
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_CMD1 ) );
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_CMD2 ) );	
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_CMD3 ) );
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_CMD4 ) );	
	}

	void MsgSetHandleMessage::SetMsgID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_ID));
		mp->SetValue(val);
	}
	const int MsgSetHandleMessage::GetMsgID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_ID));
		return mp->GetValue();
	}

	void MsgSetHandleMessage::SetCmd1(double val)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD1));
		mp->SetValue(val);
	}
	const double MsgSetHandleMessage::GetCmd1() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD1));
		return mp->GetValue();
	}

	void MsgSetHandleMessage::SetCmd2(double val)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD2));
		mp->SetValue(val);
	}
	const double MsgSetHandleMessage::GetCmd2() const
	{	
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD2));
		return mp->GetValue();
	}

	void MsgSetHandleMessage::SetCmd3(double val)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD3));
		mp->SetValue(val);
	}
	const double MsgSetHandleMessage::GetCmd3() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD3));
		return mp->GetValue();
	}

	void MsgSetHandleMessage::SetCmd4(double val)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD4));
		mp->SetValue(val);
	}
	const double MsgSetHandleMessage::GetCmd4() const
	{	
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_CMD4));
		return mp->GetValue();
	}
	//==================== MsgSetMessage CLASS DEF =========================//

			
	//==================== MsgSetCannon CLASS DEF =========================//
	MsgSetCannon::MsgSetCannon()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::IntMessageParameter( C_MSG_CANNON_SETTAEGETID));
		AddParameter( new dtGame::IntMessageParameter( C_MSG_CANNON_SETMODE));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_CANNON_UPDOWN));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_CANNON_CORRBEARING));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_CANNON_CORRELEV));
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_CANNON_BALISTIK ));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_CANNON_X));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_CANNON_Y));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_CANNON_Z));
	}

	void MsgSetCannon::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetCannon::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetCannon::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetCannon::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetCannon::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetCannon::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetCannon::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}

	const int MsgSetCannon::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetCannon::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetCannon::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetCannon::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetCannon::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetCannon::SetTargetID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_CANNON_SETTAEGETID));
		mp->SetValue(val);
	}
	const int MsgSetCannon::GetTargetID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_CANNON_SETTAEGETID));
		return mp->GetValue();
	}

	void MsgSetCannon::SetModeID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_CANNON_SETMODE));
		mp->SetValue(val);
	}
	const int MsgSetCannon::GetModeID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_CANNON_SETMODE));
		return mp->GetValue();
	}

	void MsgSetCannon::SetUpDown(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_UPDOWN));
		mp->SetValue(val);
	}
	const float MsgSetCannon::GetUpDown() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_UPDOWN));
		return mp->GetValue();
	}

	void MsgSetCannon::SetAutoCorrectElev(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_CORRELEV));
		mp->SetValue(val);
	}
	const float MsgSetCannon::GetAutoCorrectElev() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_CORRELEV));
		return mp->GetValue();
	}

	void MsgSetCannon::SetAutoCorrectBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_CORRBEARING));
		mp->SetValue(val);
	}
	const float MsgSetCannon::GetAutoCorrectBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_CORRBEARING));
		return mp->GetValue();
	}

	void MsgSetCannon::SetBalistikID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_CANNON_BALISTIK));
		mp->SetValue(val);
	}
	const int MsgSetCannon::GetBalistikID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_CANNON_BALISTIK));
		return mp->GetValue();
	}
	void MsgSetCannon::SetPosXValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_X));
		mp->SetValue(val);
	}

	const float MsgSetCannon::GetPosXValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_X));
		return mp->GetValue();
	}

	void MsgSetCannon::SetPosYValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_Y));
		mp->SetValue(val);
	}

	const float MsgSetCannon::GetPosYValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_Y));
		return mp->GetValue();
	}

	void MsgSetCannon::SetPosZValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_Z));
		mp->SetValue(val);
	}

	const float MsgSetCannon::GetPosZValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_CANNON_Z));
		return mp->GetValue();
	}

	//==================== MsgSetCannon CLASS DEF =========================//

	//==================== MsgUtilityAndTools CLASS DEF =========================//
	MsgUtilityAndTools::MsgUtilityAndTools()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) ); 
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_UAT0 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_UAT1 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_UAT2 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_UAT3 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_UAT4 ) );
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_UAT5 ) );
		AddParameter( new dtGame::DoubleMessageParameter( C_MSG_UAT6 ) );
	}

	void MsgUtilityAndTools::SetOrderID(int OrderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(OrderID);
	}

	const int MsgUtilityAndTools::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT0(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT0));
		mp->SetValue(val);
	}

	const int MsgUtilityAndTools::GetUAT0() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT0));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT1(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT1));
		mp->SetValue(val);
	}

	const int MsgUtilityAndTools::GetUAT1() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT1));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT2(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT2));
		mp->SetValue(val);
	}

	const int MsgUtilityAndTools::GetUAT2() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT2));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT3(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT3));
		mp->SetValue(val);
	}

	const int MsgUtilityAndTools::GetUAT3() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT3));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT4(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT4));
		mp->SetValue(val);
	}

	const int MsgUtilityAndTools::GetUAT4() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_UAT4));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT5(double val)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_UAT5));
		mp->SetValue(val);
	}

	const double MsgUtilityAndTools::GetUAT5() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_UAT5));
		return mp->GetValue();
	}

	void MsgUtilityAndTools::SetUAT6(double val)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_UAT6));
		mp->SetValue(val);
	}

	const double MsgUtilityAndTools::GetUAT6() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_UAT6));
		return mp->GetValue();
	}

	//==================== MsgUtilityAndTools CLASS DEF =========================//

	//==================== MsgEnvironmentControl CLASS DEF =========================//

	MsgEnvironmentControl::MsgEnvironmentControl()
	{
		AddParameter( new dtGame::DoubleMessageParameter ( "Longitude" ) ); 
		AddParameter( new dtGame::DoubleMessageParameter ( "Latitude" ) );
	}
	void MsgEnvironmentControl::SetLatitude(double pLatitude)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter("Latitude"));
		mp->SetValue(pLatitude);
	};
	const double MsgEnvironmentControl::GetLatitude() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter("Latitude"));
		return mp->GetValue();
	};
	void MsgEnvironmentControl::SetLongitude(double pLongitude)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter("Longitude"));
		mp->SetValue(pLongitude);
	};
	const double MsgEnvironmentControl::GetLongitude() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter("Longitude"));
		return mp->GetValue();
	};

	//==================== MsgEnvironmentControl CLASS DEF =========================//

	//==================== MsgOceanControl CLASS DEF =========================//

	MsgOceanControl::MsgOceanControl()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) ); 
		AddParameter( new dtGame::BooleanMessageParameter ( C_MSG_OCEAN_BOOL ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_OCEAN_INT ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_OCEAN_FLOAT ) );
		AddParameter( new dtGame::Vec2MessageParameter ( C_MSG_OCEAN_VEC2 ) );
		AddParameter( new dtGame::Vec3MessageParameter ( C_MSG_OCEAN_VEC3 ) );
		AddParameter( new dtGame::Vec4MessageParameter ( C_MSG_OCEAN_VEC4 ) );
	}

	void MsgOceanControl::SetOrderID(int OrderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(OrderID);
	}

	const int MsgOceanControl::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgOceanControl::SetBoolValue(bool val)
	{
		dtGame::BooleanMessageParameter *mp = static_cast<dtGame::BooleanMessageParameter*> (GetParameter(C_MSG_OCEAN_BOOL));
		mp->SetValue(val);
	}

	const bool MsgOceanControl::GetBoolValue() const
	{
		const dtGame::BooleanMessageParameter *mp = static_cast<const dtGame::BooleanMessageParameter*> (GetParameter(C_MSG_OCEAN_BOOL));
		return mp->GetValue();
	}

	void MsgOceanControl::SetIntValue(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_OCEAN_INT));
		mp->SetValue(val);
	}

	const int MsgOceanControl::GetIntValue() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_OCEAN_INT));
		return mp->GetValue();
	}

	void MsgOceanControl::SetFloatValue(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_OCEAN_FLOAT));
		mp->SetValue(val);
	}

	const float MsgOceanControl::GetFloatValue() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_OCEAN_FLOAT));
		return mp->GetValue();
	}

	void MsgOceanControl::SetVec2Value(osg::Vec2& val)
	{
		dtGame::Vec2MessageParameter *mp = static_cast<dtGame::Vec2MessageParameter*> (GetParameter(C_MSG_OCEAN_VEC2));
		mp->SetValue(val);
	}

	const osg::Vec2& MsgOceanControl::GetVec2Value() const
	{
		const dtGame::Vec2MessageParameter *mp = static_cast<const dtGame::Vec2MessageParameter*> (GetParameter(C_MSG_OCEAN_VEC2));
		return mp->GetValue();
	}

	void MsgOceanControl::SetVec3Value(osg::Vec3& val)
	{
		dtGame::Vec3MessageParameter *mp = static_cast<dtGame::Vec3MessageParameter*> (GetParameter(C_MSG_OCEAN_VEC3));
		mp->SetValue(val);
	}

	const osg::Vec3& MsgOceanControl::GetVec3Value() const
	{
		const dtGame::Vec3MessageParameter *mp = static_cast<const dtGame::Vec3MessageParameter*> (GetParameter(C_MSG_OCEAN_VEC3));
		return mp->GetValue();
	}

	void MsgOceanControl::SetVec4Value(osg::Vec4& val)
	{
		dtGame::Vec4MessageParameter *mp = static_cast<dtGame::Vec4MessageParameter*> (GetParameter(C_MSG_OCEAN_VEC4));
		mp->SetValue(val);
	}

	const osg::Vec4& MsgOceanControl::GetVec4Value() const
	{
		const dtGame::Vec4MessageParameter *mp = static_cast<const dtGame::Vec4MessageParameter*> (GetParameter(C_MSG_OCEAN_VEC4));
		return mp->GetValue();
	}
	//==================== MsgOceanControl CLASS DEF =========================//

	
	//==================== MsgSetC802 CLASS DEF =========================//
	MsgSetC802::MsgSetC802()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );   
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );

		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_C802_BEARING));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_C802_DISTANCE));
	}

	void MsgSetC802::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetC802::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}
	void MsgSetC802::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetC802::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetC802::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetC802::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetC802::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetC802::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}
	    
	void MsgSetC802::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetC802::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}
	        
	void MsgSetC802::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetC802::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}
	void MsgSetC802::SetBearingToTarget(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_C802_BEARING));
		mp->SetValue(val);

	}
	const float MsgSetC802::GetBearingToTarget() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_C802_BEARING));
		return mp->GetValue();
	}

	void MsgSetC802::SetDistanceToTarget(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_C802_DISTANCE));
		mp->SetValue(val);

	}
	const float MsgSetC802::GetDistanceToTarget() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_C802_DISTANCE));
		return mp->GetValue();
	}
	//==================== MsgSetC802 CLASS DEF =========================//

	//==================== MsgSetYakhont CLASS DEF =========================//

	MsgSetYakhont::MsgSetYakhont()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );   
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_COUNT_YAKHONT ) );	        
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_YAKHONT_BEARING));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_YAKHONT_DISTANCE));
	}


	void MsgSetYakhont::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetYakhont::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetYakhont::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetYakhont::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetYakhont::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetYakhont::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}
	    
	void MsgSetYakhont::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetYakhont::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetYakhont::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetYakhont::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetYakhont::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetYakhont::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}
	void MsgSetYakhont::SetBearingToTarget(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_YAKHONT_BEARING));
		mp->SetValue(val);

	}
	const float MsgSetYakhont::GetBearingToTarget() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_YAKHONT_BEARING));
		return mp->GetValue();
	}

	void MsgSetYakhont::SetDistanceToTarget(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_YAKHONT_DISTANCE));
		mp->SetValue(val);

	}
	const float MsgSetYakhont::GetDistanceToTarget() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_YAKHONT_DISTANCE));
		return mp->GetValue();
	}

	void MsgSetYakhont::SetCountYakhont(int countYakhont)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_COUNT_YAKHONT));
		mp->SetValue(countYakhont);
	}
	const int MsgSetYakhont::GetCountYakhont()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_COUNT_YAKHONT));
		return mp->GetValue();
	}
	//==================== MsgSetYakhont CLASS DEF =========================//
	//==================== MsgSetExocet40 CLASS DEF =========================//

	MsgSetExocet40::MsgSetExocet40()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );   
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );	    
		AddParameter (new dtGame::FloatMessageParameter ( C_MSG_TBEARING));
		AddParameter( new dtGame::FloatMessageParameter( C_MSG_TRANGE));

	}


	void MsgSetExocet40::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetExocet40::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetExocet40::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetExocet40::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetExocet40::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetExocet40::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}
	    
	void MsgSetExocet40::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetExocet40::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetExocet40::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetExocet40::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetExocet40::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}
	const int MsgSetExocet40::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}
	void MsgSetExocet40::SetCourse(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING));
		mp->SetValue(val);

	}
	const float MsgSetExocet40::GetCourse() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING));
		return mp->GetValue();
	}

	void MsgSetExocet40::SetDistance(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE));
		mp->SetValue(val);

	}
	const float MsgSetExocet40::GetDistance() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE));
		return mp->GetValue();
	}

	//==================== MsgSetExocet40 CLASS DEF =========================//


	//==================== MsgSetMistral CLASS DEF =========================//
	MsgSetMistral::MsgSetMistral()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TBEARING_MISTRAL ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TRANGE_MISTRAL ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_ELEV_MISTRAL ) );
	}
	void MsgSetMistral::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetMistral::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetMistral::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetMistral::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetMistral::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetMistral::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetMistral::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetMistral::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetMistral::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetMistral::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetMistral::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}


	const int MsgSetMistral::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetMistral::SetTargetBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_MISTRAL));
		mp->SetValue(val);
	}
	const float MsgSetMistral::GetTargetBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_MISTRAL));
		return mp->GetValue();
	}
	void MsgSetMistral::SetTargetRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_MISTRAL));
		mp->SetValue(val);
	}
	const float MsgSetMistral::GetTargetRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_MISTRAL));
		return mp->GetValue();
	}
	void MsgSetMistral::SetTargetElev(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ELEV_MISTRAL));
		mp->SetValue(val);
	}
	const float MsgSetMistral::GetTargetElev() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ELEV_MISTRAL));
		return mp->GetValue();
	}
	//==================== MsgSetMistral CLASS DEF =========================//


	//==================== MsgSetTetral CLASS DEF =========================//
	MsgSetTetral::MsgSetTetral()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TBEARING_TETRAL ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TRANGE_TETRAL ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_ELEV_TETRAL ) );
	}
	void MsgSetTetral::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetTetral::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetTetral::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetTetral::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetTetral::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetTetral::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetTetral::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetTetral::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetTetral::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetTetral::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}

	void MsgSetTetral::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}


	const int MsgSetTetral::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetTetral::SetTargetBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_TETRAL));
		mp->SetValue(val);
	}
	const float MsgSetTetral::GetTargetBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_TETRAL));
		return mp->GetValue();
	}
	void MsgSetTetral::SetTargetRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_TETRAL));
		mp->SetValue(val);
	}
	const float MsgSetTetral::GetTargetRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_TETRAL));
		return mp->GetValue();
	}
	void MsgSetTetral::SetTargetElev(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ELEV_TETRAL));
		mp->SetValue(val);
	}
	const float MsgSetTetral::GetTargetElev() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ELEV_TETRAL));
		return mp->GetValue();
	}
	//==================== MsgSetTetral CLASS DEF =========================//


	//==================== MsgSetStrela CLASS DEF =========================//
	MsgSetStrela::MsgSetStrela()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TBEARING_STRELA ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_TRANGE_STRELA ) );
		AddParameter( new dtGame::FloatMessageParameter ( C_MSG_ELEV_STRELA ) );
	}
	void MsgSetStrela::SetVehicleID(int VID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(VID);
	}
	const int MsgSetStrela::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetStrela::SetWeaponID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(val);
	}
	const int MsgSetStrela::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetStrela::SetLauncherID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(val);
	}
	const int MsgSetStrela::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}

	void MsgSetStrela::SetMissileID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(val);
	}
	const int MsgSetStrela::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}

	void MsgSetStrela::SetMissileNum(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(val);
	}
	const int MsgSetStrela::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}


	void MsgSetStrela::SetOrderID(int orderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(orderID);
	}


	const int MsgSetStrela::GetOrderID()const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetStrela::SetTargetBearing(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_STRELA));
		mp->SetValue(val);
	}
	const float MsgSetStrela::GetTargetBearing() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TBEARING_STRELA));
		return mp->GetValue();
	}
	void MsgSetStrela::SetTargetRange(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_STRELA));
		mp->SetValue(val);
	}
	const float MsgSetStrela::GetTargetRange() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_TRANGE_STRELA));
		return mp->GetValue();
	}
	void MsgSetStrela::SetTargetElev(float val)
	{
		dtGame::FloatMessageParameter *mp = static_cast<dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ELEV_STRELA));
		mp->SetValue(val);
	}
	const float MsgSetStrela::GetTargetElev() const
	{
		const dtGame::FloatMessageParameter *mp = static_cast<const dtGame::FloatMessageParameter*> (GetParameter(C_MSG_ELEV_STRELA));
		return mp->GetValue();
	}
	//==================== MsgSetStrela CLASS DEF =========================//

	//==================== MsgDatabaseEvent CLASS DEF =========================//

	MsgDatabaseEvent::MsgDatabaseEvent()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_TID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_DID ) );
	}

	void MsgDatabaseEvent::SetTypeID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_TID));
		mp->SetValue(val);
	}

	const int MsgDatabaseEvent::GetTypeID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_TID));
		return mp->GetValue();
	}

	void MsgDatabaseEvent::SetOrderID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(val);
	}

	const int MsgDatabaseEvent::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgDatabaseEvent::SetDetailID(int val)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_DID));
		mp->SetValue(val);
	}

	const int MsgDatabaseEvent::GetDetailID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_DID));
		return mp->GetValue();
	}

	//==================== MsgDatabaseEvent CLASS DEF =========================//


	//==================== MsgExocetMM40 CLASS DEF =========================//
	MsgSetExocetMM40::MsgSetExocetMM40()
	{
		AddParameter( new dtGame::IntMessageParameter ( C_SET_VID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_WID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_LID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_OID ) );
		AddParameter( new dtGame::IntMessageParameter ( C_SET_MNUM ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_TGTRANGE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_TGTBEARING ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_ANGULAR_MODE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_AGILITY_MODE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_INITIALSTEP_MODE	) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_OBSTACLE_ALT ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_OBSTACLE_RANGE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_APPROACH_RANGE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_TERMINAL_RANGE ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Left_Angle ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Right_Angle ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Far_Range ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Near_Range ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_1 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_2 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_3 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_4 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_5 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_6 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_7 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_8 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_9 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_10 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_11 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_12 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_13 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_14 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_15 ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_Masking_16 ) );
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_MM40_SeekerOpenPosX ) );
		AddParameter( new dtGame::DoubleMessageParameter ( C_MSG_MM40_SeekerOpenPosY ) );
		AddParameter( new dtGame::IntMessageParameter ( C_MSG_MM40_SeekerOpenHeading ) );
	}

	void MsgSetExocetMM40::SetVehicleID(int aVehicleID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		mp->SetValue(aVehicleID);
	}

	const int MsgSetExocetMM40::GetVehicleID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_VID));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetWeaponID(int aWeaponID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		mp->SetValue(aWeaponID);
	}

	const int MsgSetExocetMM40::GetWeaponID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_WID));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetLauncherID(int alauncherID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		mp->SetValue(alauncherID);
	}
	
	const int MsgSetExocetMM40::GetLauncherID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_LID));
		return mp->GetValue();
	}			
	
	void MsgSetExocetMM40::SetMissileID(int aMissileID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		mp->SetValue(aMissileID);
	}
	
	const int MsgSetExocetMM40::GetMissileID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MID));
		return mp->GetValue();
	}
	
	void MsgSetExocetMM40::SetMissileNum(int aMissileNum)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		mp->SetValue(aMissileNum);
	}
	
	const int MsgSetExocetMM40::GetMissileNum() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_MNUM));
		return mp->GetValue();
	}
	
	void MsgSetExocetMM40::SetOrderID(int aOrderID)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		mp->SetValue(aOrderID);
	}
	
	const int MsgSetExocetMM40::GetOrderID() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_SET_OID));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetTargetRange(float aTgtRange)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_TGTRANGE));
		mp->SetValue(aTgtRange);
	}
	
	const int MsgSetExocetMM40::GetTargetRange() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_TGTRANGE));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetTargetBearing(float aTgtBearing)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_TGTBEARING));
		mp->SetValue(aTgtBearing);
	}
	
	const int MsgSetExocetMM40::GetTargetBearing() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_TGTBEARING));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetAngularMode(float aAngularMode)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_ANGULAR_MODE));
		mp->SetValue(aAngularMode);
	}
	
	const int MsgSetExocetMM40::GetAngularMode() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_ANGULAR_MODE));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetAgilityMode(float aAgilityMode)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_AGILITY_MODE));
		mp->SetValue(aAgilityMode);
	}
	
	const int MsgSetExocetMM40::GetAgilityMode() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_AGILITY_MODE));
		return mp->GetValue();
	}
	
	void MsgSetExocetMM40::SetInitialStepMode(float aInitialStepMode)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_INITIALSTEP_MODE));
		mp->SetValue(aInitialStepMode);
	}
		
	const int MsgSetExocetMM40::GetInitialStepMode() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_INITIALSTEP_MODE));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetObstacle_Alt(float aObstacle_Alt)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_OBSTACLE_ALT));
		mp->SetValue(aObstacle_Alt);
	}
	
	const int MsgSetExocetMM40::GetObstacle_Alt() const
	{	
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_OBSTACLE_ALT));
		return mp->GetValue();
	}
	
	void MsgSetExocetMM40::SetObstacle_Range(float aObstacle_Range)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_OBSTACLE_RANGE));
		mp->SetValue(aObstacle_Range);
	}
		
	const int MsgSetExocetMM40::GetObstacle_Range() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_OBSTACLE_RANGE));
		return mp->GetValue();
	}
	
	void MsgSetExocetMM40::SetApproach_Range(float aApproach_Range)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_APPROACH_RANGE));
		mp->SetValue(aApproach_Range);
	}
	
	const int MsgSetExocetMM40::GetApproach_Range() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_APPROACH_RANGE));
		return mp->GetValue();
	}
	
	void MsgSetExocetMM40::SetTerminal_Range(float aTerminal_Range)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_TERMINAL_RANGE));
		mp->SetValue(aTerminal_Range);
	}
	
	const int MsgSetExocetMM40::GetTerminal_Range() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_TERMINAL_RANGE));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetLeft_Angle(float aLeft_Angle)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Left_Angle));
		mp->SetValue(aLeft_Angle);
	}

	const int MsgSetExocetMM40::GetLeft_Angle() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Left_Angle));
		return mp->GetValue();	
	}

	void MsgSetExocetMM40::SetRight_Angle(float aRight_Angle)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Right_Angle));
		mp->SetValue(aRight_Angle);
	}

	const int MsgSetExocetMM40::GetRight_Angle() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Right_Angle));
		return mp->GetValue();	
	}

	void MsgSetExocetMM40::SetFar_Range(float aFar_Range)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Far_Range));
		mp->SetValue(aFar_Range);	
	}

	const int MsgSetExocetMM40::GetFar_Range() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Far_Range));
		return mp->GetValue();	
	}

	void MsgSetExocetMM40::SetNear_Range(float aNear_Range)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Near_Range));
		mp->SetValue(aNear_Range);	
	}

	const int MsgSetExocetMM40::GetNear_Range() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Near_Range));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_1(float aMasking_1)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_1));
		mp->SetValue(aMasking_1);
	}

	const int MsgSetExocetMM40::GetMasking_1() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_1));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_2(float aMasking_2)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_2));
		mp->SetValue(aMasking_2);
	}

	const int MsgSetExocetMM40::GetMasking_2() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_2));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_3(float aMasking_3)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_3));
		mp->SetValue(aMasking_3);
	}

	const int MsgSetExocetMM40::GetMasking_3() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_3));
		return mp->GetValue();
	}
	void MsgSetExocetMM40::SetMasking_4(float aMasking_4)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_4));
		mp->SetValue(aMasking_4);
	}

	const int MsgSetExocetMM40::GetMasking_4() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_4));
		return mp->GetValue();
	}
	void MsgSetExocetMM40::SetMasking_5(float aMasking_5)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_5));
		mp->SetValue(aMasking_5);
	}

	const int MsgSetExocetMM40::GetMasking_5() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_5));
		return mp->GetValue();
	}
	void MsgSetExocetMM40::SetMasking_6(float aMasking_6)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_6));
		mp->SetValue(aMasking_6);
	}

	const int MsgSetExocetMM40::GetMasking_6() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_6));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_7(float aMasking_7)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_7));
		mp->SetValue(aMasking_7);
	}

	const int MsgSetExocetMM40::GetMasking_7() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_7));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_8(float aMasking_8)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_8));
		mp->SetValue(aMasking_8);
	}

	const int MsgSetExocetMM40::GetMasking_8() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_8));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_9(float aMasking_9)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_9));
		mp->SetValue(aMasking_9);
	}

	const int MsgSetExocetMM40::GetMasking_9() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_9));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_10(float aMasking_10)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_10));
		mp->SetValue(aMasking_10);
	}

	const int MsgSetExocetMM40::GetMasking_10() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_10));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_11(float aMasking_11)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_11));
		mp->SetValue(aMasking_11);
	}

	const int MsgSetExocetMM40::GetMasking_11() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_11));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_12(float aMasking_12)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_12));
		mp->SetValue(aMasking_12);
	}

	const int MsgSetExocetMM40::GetMasking_12() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_12));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_13(float aMasking_13)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_13));
		mp->SetValue(aMasking_13);
	}

	const int MsgSetExocetMM40::GetMasking_13() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_13));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_14(float aMasking_14)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_14));
		mp->SetValue(aMasking_14);
	}

	const int MsgSetExocetMM40::GetMasking_14() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_14));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_15(float aMasking_15)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_15));
		mp->SetValue(aMasking_15);
	}

	const int MsgSetExocetMM40::GetMasking_15() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_15));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetMasking_16(float aMasking_16)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_16));
		mp->SetValue(aMasking_16);
	}

	const int MsgSetExocetMM40::GetMasking_16() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_Masking_16));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetSeekerOpenPosX(double aSeekerOpenPosX)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_MM40_SeekerOpenPosX));
		mp->SetValue(aSeekerOpenPosX);
	}

	const double MsgSetExocetMM40::GetSeekerOpenPosX() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_MM40_SeekerOpenPosX));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetSeekerOpenPosY(double aSeekerOpenPosY)
	{
		dtGame::DoubleMessageParameter *mp = static_cast<dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_MM40_SeekerOpenPosY));
		mp->SetValue(aSeekerOpenPosY);
	}

	const double MsgSetExocetMM40::GetSeekerOpenPosY() const
	{
		const dtGame::DoubleMessageParameter *mp = static_cast<const dtGame::DoubleMessageParameter*> (GetParameter(C_MSG_MM40_SeekerOpenPosY));
		return mp->GetValue();
	}

	void MsgSetExocetMM40::SetSeekerOpenHeading(float aSeekerOpenHeading)
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_SeekerOpenHeading));
		mp->SetValue(aSeekerOpenHeading);
	}

	const int MsgSetExocetMM40::GetSeekerOpenHeading() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_SeekerOpenHeading));
		return mp->GetValue();
	}

	/*
	void MsgSetExocetMM40::SetMasking(int Masking[16])
	{
		dtGame::IntMessageParameter *mp = static_cast<dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_MASKING));
		mp->SetValue(Masking[16]);
	}
	
	const int MsgSetExocetMM40::GetMasking() const
	{
		const dtGame::IntMessageParameter *mp = static_cast<const dtGame::IntMessageParameter*> (GetParameter(C_MSG_MM40_MASKING));
		return mp->GetValue();
	}
	*/

	//==================== MsgExocetMM40 CLASS DEF =========================//