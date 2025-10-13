#ifndef GRIDDEDDATAPDU_H
#define GRIDDEDDATAPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityType.h>
#include <DIS/Orientation.h>
#include <DIS/GridAxisRecord.h>
#include <vector>
#include <DIS/SyntheticEnvironmentFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.11.2: Information about globat, spatially varying enviornmental effects. This requires manual cleanup; the grid axis        records are variable sized. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO GriddedDataPdu : public SyntheticEnvironmentFamilyPdu
{
protected:
  // environmental simulation application ID
  EntityID _environmentalSimulationApplicationID; 

  // unique identifier for each piece of enviornmental data
  unsigned short _fieldNumber; 

  // sequence number for the total set of PDUS used to transmit the data
  unsigned short _pduNumber; 

  // Total number of PDUS used to transmit the data
  unsigned short _pduTotal; 

  // coordinate system of the grid
  unsigned short _coordinateSystem; 

  // number of grid axes for the environmental data
  unsigned char _numberOfGridAxes; 

  // are domain grid axes identidal to those of the priveious domain update?
  unsigned char _constantGrid; 

  // type of environment
  EntityType _environmentType; 

  // orientation of the data grid
  Orientation _orientation; 

  // valid time of the enviormental data sample, 64 bit unsigned int
  long _sampleTime; 

  // total number of all data values for all pdus for an environmental sample
  unsigned int _totalValues; 

  // total number of data values at each grid point.
  unsigned char _vectorDimension; 

  // padding
  unsigned short _padding1; 

  // padding
  unsigned char _padding2; 

  // Grid data @@@This is wrong
  std::vector<GridAxisRecord> _gridDataList; 


 public:
    GriddedDataPdu();
    virtual ~GriddedDataPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getEnvironmentalSimulationApplicationID(); 
    const EntityID&  getEnvironmentalSimulationApplicationID() const; 
    void setEnvironmentalSimulationApplicationID(const EntityID    &pX);

    unsigned short getFieldNumber() const; 
    void setFieldNumber(unsigned short pX); 

    unsigned short getPduNumber() const; 
    void setPduNumber(unsigned short pX); 

    unsigned short getPduTotal() const; 
    void setPduTotal(unsigned short pX); 

    unsigned short getCoordinateSystem() const; 
    void setCoordinateSystem(unsigned short pX); 

    unsigned char getNumberOfGridAxes() const; 

    unsigned char getConstantGrid() const; 
    void setConstantGrid(unsigned char pX); 

    EntityType& getEnvironmentType(); 
    const EntityType&  getEnvironmentType() const; 
    void setEnvironmentType(const EntityType    &pX);

    Orientation& getOrientation(); 
    const Orientation&  getOrientation() const; 
    void setOrientation(const Orientation    &pX);

    long getSampleTime() const; 
    void setSampleTime(long pX); 

    unsigned int getTotalValues() const; 
    void setTotalValues(unsigned int pX); 

    unsigned char getVectorDimension() const; 
    void setVectorDimension(unsigned char pX); 

    unsigned short getPadding1() const; 
    void setPadding1(unsigned short pX); 

    unsigned char getPadding2() const; 
    void setPadding2(unsigned char pX); 

    std::vector<GridAxisRecord>& getGridDataList(); 
    const std::vector<GridAxisRecord>& getGridDataList() const; 
    void setGridDataList(const std::vector<GridAxisRecord>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const GriddedDataPdu& rhs) const;
};
}

#endif
