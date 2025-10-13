#ifndef PROPULSIONSYSTEMDATA_H
#define PROPULSIONSYSTEMDATA_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Data about a propulsion system

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO PropulsionSystemData
{
protected:
  // powerSetting
  float _powerSetting; 

  // engine RPMs
  float _engineRpm; 


 public:
    PropulsionSystemData();
    virtual ~PropulsionSystemData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    float getPowerSetting() const; 
    void setPowerSetting(float pX); 

    float getEngineRpm() const; 
    void setEngineRpm(float pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const PropulsionSystemData& rhs) const;
};
}

#endif
