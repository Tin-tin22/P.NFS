#ifndef IFFATCNAVAIDSLAYER2PDU_H
#define IFFATCNAVAIDSLAYER2PDU_H

#include <DIS/LayerHeader.h>
#include <DIS/BeamData.h>
#include <DIS/BeamData.h>
#include <DIS/FundamentalParameterDataIff.h>
#include <vector>
#include <DIS/IffAtcNavAidsLayer1Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.7.4.2 When present, layer 2 should follow layer 1 and have the following fields. This requires manual cleanup.        the beamData attribute semantics are used in multiple ways. UNFINSISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IffAtcNavAidsLayer2Pdu : public IffAtcNavAidsLayer1Pdu
{
protected:
  // layer header
  LayerHeader _layerHeader; 

  // beam data
  BeamData _beamData; 

  // Secondary operational data, 5.2.57
  BeamData _secondaryOperationalData; 

  // variable length list of fundamental parameters. @@@This is wrong
  std::vector<FundamentalParameterDataIff> _fundamentalIffParameters; 


 public:
    IffAtcNavAidsLayer2Pdu();
    virtual ~IffAtcNavAidsLayer2Pdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    LayerHeader& getLayerHeader(); 
    const LayerHeader&  getLayerHeader() const; 
    void setLayerHeader(const LayerHeader    &pX);

    BeamData& getBeamData(); 
    const BeamData&  getBeamData() const; 
    void setBeamData(const BeamData    &pX);

    BeamData& getSecondaryOperationalData(); 
    const BeamData&  getSecondaryOperationalData() const; 
    void setSecondaryOperationalData(const BeamData    &pX);

    std::vector<FundamentalParameterDataIff>& getFundamentalIffParameters(); 
    const std::vector<FundamentalParameterDataIff>& getFundamentalIffParameters() const; 
    void setFundamentalIffParameters(const std::vector<FundamentalParameterDataIff>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const IffAtcNavAidsLayer2Pdu& rhs) const;
};
}

#endif
