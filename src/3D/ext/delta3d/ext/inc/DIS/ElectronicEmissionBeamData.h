#ifndef ELECTRONICEMISSIONBEAMDATA_H
#define ELECTRONICEMISSIONBEAMDATA_H

#include <DIS/FundamentalParameterData.h>
#include <DIS/TrackJamTarget.h>
#include <vector>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Description of one electronic emission beam

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ElectronicEmissionBeamData
{
protected:
  // This field shall specify the length of this beams data in 32 bit words
  unsigned char _beamDataLength; 

  // This field shall specify a unique emitter database number assigned to differentiate between otherwise similar or identical emitter beams within an emitter system.
  unsigned char _beamIDNumber; 

  // This field shall specify a Beam Parameter Index number that shall be used by receiving entities in conjunction with the Emitter Name field to provide a pointer to the stored database parameters required to regenerate the beam. 
  unsigned short _beamParameterIndex; 

  // Fundamental parameter data such as frequency range, beam sweep, etc.
  FundamentalParameterData _fundamentalParameterData; 

  // beam function of a particular beam
  unsigned char _beamFunction; 

  // Number of track/jam targets
  unsigned char _numberOfTrackJamTargets; 

  // wheher or not the receiving simulation apps can assume all the targets in the scan pattern are being tracked/jammed
  unsigned char _highDensityTrackJam; 

  // padding
  unsigned char _pad4; 

  // identify jamming techniques used
  unsigned int _jammingModeSequence; 

  // variable length list of track/jam targets
  std::vector<TrackJamTarget> _trackJamTargets; 


 public:
    ElectronicEmissionBeamData();
    virtual ~ElectronicEmissionBeamData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getBeamDataLength() const; 
    void setBeamDataLength(unsigned char pX); 

    unsigned char getBeamIDNumber() const; 
    void setBeamIDNumber(unsigned char pX); 

    unsigned short getBeamParameterIndex() const; 
    void setBeamParameterIndex(unsigned short pX); 

    FundamentalParameterData& getFundamentalParameterData(); 
    const FundamentalParameterData&  getFundamentalParameterData() const; 
    void setFundamentalParameterData(const FundamentalParameterData    &pX);

    unsigned char getBeamFunction() const; 
    void setBeamFunction(unsigned char pX); 

    unsigned char getNumberOfTrackJamTargets() const; 

    unsigned char getHighDensityTrackJam() const; 
    void setHighDensityTrackJam(unsigned char pX); 

    unsigned char getPad4() const; 
    void setPad4(unsigned char pX); 

    unsigned int getJammingModeSequence() const; 
    void setJammingModeSequence(unsigned int pX); 

    std::vector<TrackJamTarget>& getTrackJamTargets(); 
    const std::vector<TrackJamTarget>& getTrackJamTargets() const; 
    void setTrackJamTargets(const std::vector<TrackJamTarget>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ElectronicEmissionBeamData& rhs) const;
};
}

#endif
