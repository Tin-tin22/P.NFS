#ifndef ISGROUPOFPDU_H
#define ISGROUPOFPDU_H

#include <DIS/EntityID.h>
#include <DIS/VariableDatum.h>
#include <vector>
#include <DIS/EntityManagementFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.9.2 Information about a particular group of entities grouped together for the purposes of netowrk bandwidth         reduction or aggregation. Needs manual cleanup. The GED size requires a database lookup. UNFINISHED

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO IsGroupOfPdu : public EntityManagementFamilyPdu
{
protected:
  // ID of aggregated entities
  EntityID _groupEntityID; 

  // type of entities constituting the group
  unsigned char _groupedEntityCategory; 

  // Number of individual entities constituting the group
  unsigned char _numberOfGroupedEntities; 

  // padding
  unsigned int _pad2; 

  // latitude
  double _latitude; 

  // longitude
  double _longitude; 

  // GED records about each individual entity in the group. @@@this is wrong--need a database lookup to find the actual size of the list elements
  std::vector<VariableDatum> _groupedEntityDescriptions; 


 public:
    IsGroupOfPdu();
    virtual ~IsGroupOfPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getGroupEntityID(); 
    const EntityID&  getGroupEntityID() const; 
    void setGroupEntityID(const EntityID    &pX);

    unsigned char getGroupedEntityCategory() const; 
    void setGroupedEntityCategory(unsigned char pX); 

    unsigned char getNumberOfGroupedEntities() const; 

    unsigned int getPad2() const; 
    void setPad2(unsigned int pX); 

    double getLatitude() const; 
    void setLatitude(double pX); 

    double getLongitude() const; 
    void setLongitude(double pX); 

    std::vector<VariableDatum>& getGroupedEntityDescriptions(); 
    const std::vector<VariableDatum>& getGroupedEntityDescriptions() const; 
    void setGroupedEntityDescriptions(const std::vector<VariableDatum>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const IsGroupOfPdu& rhs) const;
};
}

#endif
