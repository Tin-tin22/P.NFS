unit uBaseConst;

interface

const
C_2_Pi          = 2.0 * Pi;
  C_RadToDeg      = 180.0 / Pi;
  C_DegToRad      = Pi / 180.0;
  C_DegToMiliRad   = C_DegToRad * 1000;
  C_MiliRadToDeg   = C_RadToDeg / 1000;

  C_Degree_To_NauticalMile    = 60.0;
  C_Degree_To_DataMile        = 60.0 *  6000.0 / 6076.11549;
  C_Degree_To_Meter           = 60.0 * 1852.0;

  C_NauticalMile_To_Degree    = 1.0 /60.0;
  C_NauticalMile_To_Metre     = 1852.0;
  C_NauticalMile_To_Feet      = 6076.11549;
  C_NauticalMile_To_Yards     = 2025.37183;
  C_NauticalMile_To_DataMile  = 6076.11549 / 6000.0;  // nm to feet / nm to DM

  C_MperS2_to_KnotperS = 1.9438;
  C_MperS_to_FtperMinutes = 196.85;
  C_DM_to_Knots = 0.868976241901;
  C_Knots_to_DMH = 1 / C_DM_to_Knots;

  C_DataMile_To_Feet          = 6000.0;
  C_DataMile_To_NauticalMile  = 6000.0 / 6076.11549;
  C_DataMile_To_yard          = 2000.0;
  C_DataMile_To_degree        = 1.0 / C_Degree_To_DataMile;
  C_DataMile_To_Metre         = 1828.8;
  C_DataMile_To_kyard         = C_DataMile_To_yard / 1000;

  C_Feet_To_Meter             = 0.3048;
  C_Meter_To_NauticalMile     = 1.0 / C_NauticalMile_To_Metre;
  C_Meter_To_Feet             = 3.2808399;
  C_Meter_To_DataMile         = 1.0 / C_DataMile_To_Metre;
  C_HFeet_To_Meter            = C_Feet_To_Meter * 100;
  C_Meter_To_HFeet            = 1.0 / C_HFeet_To_Meter;
  C_HFeet_To_Feet             = 100;
  C_Feet_To_HFeet             = 1.0/100;

  C_Meter_To_Degree           = C_Meter_To_NauticalMile * C_NauticalMile_To_Degree;
  C_Degree_To_Feet            = C_Degree_To_NauticalMile * C_NauticalMile_To_Feet;

  C_Yards_To_NauticalMile     = 1.0 / C_NauticalMile_To_Yards;
  C_Yards_To_DataMile         = 1.0 / C_DataMile_To_yard;

  C_KYards_To_DataMile        = 1.0 / C_DataMile_To_yard * 1000;
  C_KYards_To_NauticalMile    = 1.0 / C_NauticalMile_To_Yards * 1000;


  C_NauticalMile_To_KYards    = C_NauticalMile_To_Yards / 1000;


  C_Yards_To_Meter            = 0.9144;
  C_Meter_To_Yards            = 1 / C_Yards_To_Meter;

  C_Kyards_To_Metre           = C_Yards_To_Meter * 1000;

  C_Hour_to_Second            = 3600;
  C_Second_to_Hour            = 1/3600;
  C_Minute_to_Second          = 60;

  C_KNOT_TO_METER_PERSEC = 0.514444;
  C_INSTALLATION_HEIGHT = 5.0;
  C_MUZZLE_VELOCITY_DIS = 500.0 * C_KNOT_TO_METER_PERSEC; // m/s
  C_MUZZLE_VELOCITY_SED = 300.0 * C_KNOT_TO_METER_PERSEC; // m/s
  C_TUBE_TILT_ANGLE = 45.0; // degrees

  C_FPS_TO_MPS = C_Feet_To_Meter / C_Minute_to_Second;
  C_MPS_TO_FPS = 1 / C_FPS_TO_MPS;


implementation

end.
