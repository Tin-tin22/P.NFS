#ifndef TRANSMITTERPDU_H
#define TRANSMITTERPDU_H

#include <DIS/RadioEntityType.h>
#include <DIS/Vector3Double.h>
#include <DIS/Vector3Double.h>
#include <DIS/ModulationType.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Float.h>
#include <vector>
#include <DIS/RadioCommunicationsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.8.1. Detailed information about a radio transmitter. This PDU requires manually         written code to complete, since the modulation parameters are of variable length. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO TransmitterPdu : public RadioCommunicationsFamilyPdu
{
protected:
  // linear accelleration of entity
  RadioEntityType _radioEntityType; 

  // transmit state
  unsigned char _transmitState; 

  // input source
  unsigned char _inputSource; 

  // padding
  unsigned short _padding1; 

  // Location of antenna
  Vector3Double _antennaLocation; 

  // relative location of antenna
  Vector3Double _relativeAntennaLocation; 

  // antenna pattern type
  unsigned short _antennaPatternType; 

  // atenna pattern length
  unsigned short _antennaPatternCount; 

  // frequency
  double _frequency; 

  // transmit frequency Bandwidth
  float _transmitFrequencyBandwidth; 

  // transmission power
  float _power; 

  // modulation
  ModulationType _modulationType; 

  // crypto system enumeration
  unsigned short _cryptoSystem; 

  // crypto system key identifer
  unsigned short _cryptoKeyId; 

  // how many modulation parameters we have
  unsigned char _modulationParameterCount; 

  // padding2
  unsigned short _padding2; 

  // padding3
  unsigned char _padding3; 

  // variable length list of modulation parameters
  std::vector<Vector3Float> _modulationParametersList; 

  // variable length list of antenna pattern records
  std::vector<Vector3Float> _antennaPatternList; 


 public:
    TransmitterPdu();
    virtual ~TransmitterPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    RadioEntityType& getRadioEntityType(); 
    const RadioEntityType&  getRadioEntityType() const; 
    void setRadioEntityType(const RadioEntityType    &pX);

    unsigned char getTransmitState() const; 
    void setTransmitState(unsigned char pX); 

    unsigned char getInputSource() const; 
    void setInputSource(unsigned char pX); 

    unsigned short getPadding1() const; 
    void setPadding1(unsigned short pX); 

    Vector3Double& getAntennaLocation(); 
    const Vector3Double&  getAntennaLocation() const; 
    void setAntennaLocation(const Vector3Double    &pX);

    Vector3Double& getRelativeAntennaLocation(); 
    const Vector3Double&  getRelativeAntennaLocation() const; 
    void setRelativeAntennaLocation(const Vector3Double    &pX);

    unsigned short getAntennaPatternType() const; 
    void setAntennaPatternType(unsigned short pX); 

    unsigned short getAntennaPatternCount() const; 

    double getFrequency() const; 
    void setFrequency(double pX); 

    float getTransmitFrequencyBandwidth() const; 
    void setTransmitFrequencyBandwidth(float pX); 

    float getPower() const; 
    void setPower(float pX); 

    ModulationType& getModulationType(); 
    const ModulationType&  getModulationType() const; 
    void setModulationType(const ModulationType    &pX);

    unsigned short getCryptoSystem() const; 
    void setCryptoSystem(unsigned short pX); 

    unsigned short getCryptoKeyId() const; 
    void setCryptoKeyId(unsigned short pX); 

    unsigned char getModulationParameterCount() const; 

    unsigned short getPadding2() const; 
    void setPadding2(unsigned short pX); 

    unsigned char getPadding3() const; 
    void setPadding3(unsigned char pX); 

    std::vector<Vector3Float>& getModulationParametersList(); 
    const std::vector<Vector3Float>& getModulationParametersList() const; 
    void setModulationParametersList(const std::vector<Vector3Float>&    pX);

    std::vector<Vector3Float>& getAntennaPatternList(); 
    const std::vector<Vector3Float>& getAntennaPatternList() const; 
    void setAntennaPatternList(const std::vector<Vector3Float>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const TransmitterPdu& rhs) const;
};
}

#endif
