{ ******************************* }
{                                 }
{    VERTICAL MAPPER 2.6 SDK      }
{        TYPE DEFINITION          }
{ MODIFIED BY ANANG AFANDI, S.KOM } 
{                                 }
{ ******************************* }


unit vmSDK26;

interface

uses windows;

const
     VM_CURRENT_REV       = 2.60;
     ZUNIT_MILES          = 0;
     ZUNIT_KILOMETERS     = 1;
     ZUNIT_KILOMETRES     = 1;
     ZUNIT_INCHES         = 2;
     ZUNIT_FEET           = 3;
     ZUNIT_YARDS          = 4;
     ZUNIT_MILLIMETERS    = 5;
     ZUNIT_MILLIMETRES    = 5;
     ZUNIT_CENTIMETERS    = 6;
     ZUNIT_CENTIMETRES    = 6;
     ZUNIT_METERS         = 7;
     ZUNIT_METRES         = 7;
     ZUNIT_SURVEY_FT      = 8;
     ZUNIT_NAUTICAL_MILES = 9;
     ZUNIT_LINKS          = 30;
     ZUNIT_CHAINS         = 31;
     ZUNIT_RODS           = 32;
     ZUNIT_DEGREES        = 64;   //radial degrees
     ZUNIT_USER           = 65;
     ZUNIT_dB             = 128;
     ZUNIT_dBm            = 129;
     ZUNIT_dBW            = 130;
     ZUNIT_dBuV_m         = 131;  //dB uVolts / meter
     ZUNIT_RAD            = 132;  //radians

     //Grid Math Constants
     ID_PLUS		= 101;
     ID_MINUS		= 102;
     ID_MULTIPLY	= 103;
     ID_DIVIDE		= 104;
     ID_SINE		= 105;
     ID_COS		= 106;
     ID_TAN		= 107;
     ID_COTAN		= 108;
     ID_LOG10		= 109;
     ID_LN		= 110;
     ID_ABS		= 111;
     ID_POWER		= 112;
     ID_SQR 		= 113;
     ID_SQRT		= 114;
     ID_DEG 		= 115;
     ID_RAD		= 116;
     ID_MIN		= 117;
     ID_MAX		= 118;
     ID_NEG 		= 119;
     ID_NOTHING		= 120;
     ID_ARCSIN 		= 121;
     ID_ARCCOS		= 122;
     ATTRIB_NAME_LEN    = 32;
     VM_SURFACE_GRID    = 1;
     VM_CLASSIFIED_GRID = 2;

type

  RGB_TRIPLE = packed record     // RGB Value broken into component parts
		bRed   : BYTE;	 // Red byte
		bGreen : BYTE;	 // Green byte
		bBlue  : BYTE;	 // Blue byte
               end;
  pRGB_TRIPLE = ^RGB_TRIPLE;

  INFLECTION_DESC = packed record       // Describes an colour inflection point
                     fZValue : single;	// Specific Z Value
                     Red     : byte;    // Red byte (from RGB)
                     Green   : byte;	// Green byte (from RGB)
                     Blue    : byte;	// Blue byte (from RGB)
                    end;

  PACKED_PNT3D = packed record  // A packed 3D point
                  dX : double;  // X Coordinate
                  dY : double;	// Y Coordinate
                  fZ : single;	// Z Coordinate
                 end;

  PNT3D = packed record      // A 3D point with status byte
           x      : double;  // X Coordinate
           y      : double;  // Y Coordinate
           z      : double;  // Z coordinate
           status : byte;    // 0 = NULL , 1 = z is valid
          end;

  PNT2D = packed record  // A 2D point
           x : double;   // X Coordinate
           y : double;   // Y Coordinate
          end;

  POINT_3D_FILE_HEADER = packed record               // The header on a 3D Point file.
                          ID: array [0..4] of char;  //"HGPC."
                          fVersion: single;          // "fVersion 1.0"
                          dXmin: double;             // Minimum X coordinate of points
                          dXmax: double;	     // Maximum X coordinate of points
                          dYmin: double;             // Minimum Y coordinate of points
                          dYmax: double;             // Minimum Y coordinate of points
                          fZmin: single;             // Minimum Z value of points
                          fZmax: single;             // Minimum Z value of points
                          dwNumPnts: dword;                                  // Number of points in file
                          szTableName: array [0..MAX_PATH - 1] of char;      // Source Tab name
                          szZColName: array [0..ATTRIB_NAME_LEN -1] of char; // Source Z Column Name
                          szCoordSys: array [0..255] of char;		     // Source Coordsys
                          szXYUnits: array [0..31] of char;		     // Source XY Units of Coordsys
                          szDataDesc: array [0..31] of char;		     // User Data Description
                          szZUnits: array [0..31] of char;                   // Source Z Unit description
                          ZUnitType: byte;				     // Z Unit identifier byte
                          //the rest of the file is dwNumPnts of PACKED_PNT3D's
                         end;

  dword_array = array [word] of dword;

  HISTOGRAM = packed record                // Information about a grid's values
	       dZmin: double;		   // Minimum Z value
	       dZmax: double;		   // Maximum Z value
	       dwNumNonNullCells: dword;   // number of cells in the grid that are not null
	       dwNumValues: dword;	   // size of the histogram (currently 65536)
               pdwHistogram: ^dword_array; // pointer to the counts
              end;
  pHistogram = ^HISTOGRAM;

  GRDINFO = packed record					 // Information about a numeric grid (GRD)
	     dZmin: double;					 // Minimum Z value
             dZmax: double;					 // Maximum Z value
	     ZUnitType: byte;					 // Z unit identifier byte
	     pszZUnits: pchar;					 // Z unit text description
	     fLightAzimuth: single;				 // Relief Shading Azimuth (if any)
	     fLightAngle: single;				 // Relief Shading Angle (if any)
	     uNumInflections: word;				 // Number of colour inflection points for grid
	     stInflectionDesc: array [1..64] of INFLECTION_DESC; // Array of colour inflection points for grid.
	     pstHist: pHistogram;				 // Pointer to histogram information
            end;

  GRC_DICT = packed record         // Information about a specific class from a classified grid (GRC)
              Res1: byte;	   // Reserved
              Red: byte;	   // Red byte (from RGB) for class colour
              Green: byte;	   // Green byte (from RGB) for class colour
              Blue: byte;	   // Blue byte (from RGB) for class colour
              Res2: byte;	   // Reserved
              pszDescr: pchar;	   // if Byte 1023 bit 4 is FALSE then Class Names go here
              dClassValue: double; // if Byte 1023 bit 4 is TRUE then Class Values go here (NOT IMPLEMENTED)
             end;

  pGRC_DICT = ^GRC_DICT;

  GRC_DICT_ARRAY = array [word] of pGRC_DICT;

  pGRC_DICT_ARRAY = ^ GRC_DICT_ARRAY;

  GRCINFO = packed record                  // Information about a classified Grid (GRC)
             NumEntries: word;		   // being we allow holes in the dictionary NumEntries may be < MaxEntry
             MaxEntry: word;		   // the maximum index value defined in the Dictionary
             ClassDataType: word;	   // 0 = Classes are of String Type (*pszDescr = Name) 1 = Numeric Classes fzValue = Class Value (NOT IMPLEMENTED)
             pstGRC_Dict: pGRC_DICT_ARRAY; // Pointer to an array of GRC_DICT structures
            end;

  pGRCINFO = ^GRCINFO;

  GRID = packed record              // Information about a Grid (GRD or GRC)
          pszName: pchar;	    // Grid File Name
          lGridID: dword;	    // Our internal ID number
          hGridFile: thandle;	    // Handle to the file object
          pszTableName: pchar;	    // The tab file (not sure we can fill this one)
	  pszCoordSys: pchar;	    // MapInfo Coordsys string
	  pszCoordName: pchar;	    // The CoordSys Name as in mapinfo.prj
	  pszZDesc: pchar;	    // User supplied desciption
	  pszXYUnitName: pchar;	    // Units string value from Coordsys
	  lCoordUnits: dword;	    // mapinfo UnitVal equivelnt of pszXYUnits
	  dXmin: double;	    // minimum X coordinate bounds to the node (center of the grid cells)
	  dXmax: double;	    // maximum X coordinate bounds to the node (center of the grid cells)
	  dYmin: double;	    // minimum Y coordinate bounds to the node (center of the grid cells)
	  dYmax: double;	    // maximum Y coordinate bounds to the node (center of the grid cells)
	  uGridWidth: word;	    // num of cells wide
	  uGridLength: word;	    // num of rows
	  dCellSize: double;	    // simply the range / nCells  (our cells are always square)
	  fVersionNumber: single;   // currently 2.0
	  byDisplayStatus: byte;    // Bit 7 - Show color gradient using inflection points
                                    // Bit 6 - Show hill shading if bit 7 is true or mono
				    // image it bit 7 is off
				    // Bit 5 - 0 - reserved
                                    // Bit 0 - Set if a Viewshed Grid
          byGridDataType: byte;     // Value  Node Data Type	GRD Return Type		GRC Return Type
                                    //  -----|----------------|------------------|------------------
                                    //	0x00   16bit uint	double			szString
                                    //	0x01   32 bit		double			NOT IMPLEMENTED
                                    //  0x02   8 bit		NOT IMPLEMENTED		szString
                                    //	0x10   16bit uint	NOT IMPLEMENTED		double
                                    //  0x12   8 bit		NOT IMPLEMENTED		double
          byNumBytesPerRawVal: byte;           // how big is each raw grid value (from byGridDataType
	  byResBlock1: array [1..131] of byte; // currently not used
	  byResBlock2: array [1..49] of byte;  // used by dBmapper
	  lGridType: longInt;		       // VM_SURFACE_GRID or VM_CLASSIFIED_GRID
	  pstGRDInfo: ^GRDInfo;                // Pointer to GRDInfo struct (if valid)
	  pstGRCInfo: pGRCINFO;                // Pointer to GRCInfo struct (if valid)
	  byGridModified: byte;		       // TRUE if the grid params have been changed from the original
	  hRHGRD: dword;                       // a pointer to the Color Structures in the Raster Handler
	end;

  pGrid = ^GRID;

  ppGrid = Array[word] of pGrid;

  CROSS_SECTION_POINT = packed record                       // Information returned by a Point-to-Point visibility function
                         Dist: double;			    // Distance from start of line
                         Elevation: double;		    // Elevation of grid at distance
                         viewableElevation: double;	    // Elevation that is viewable at distance
                         relativeElevation: double;	    // relative elevation of grid at distance (using earth curvature)
                         RelativeViewableElevation: double; // elevation that is viewable at distance (using earth curvature)
                        end;

  VIEWSHED_PARAMETERS = packed record		 // Information about each point to consider for viewshed operation
                         uViewShedOption: word;  // Toggles Simple / Complex
    	                                         //  0 = Simple Viweshed
                                                 //  1 = Complex Viewshed
                         byRadiusUnitType: word;	
                         dXObsPosn: double;      // X coordinate
                         dYObsPosn: double;	 // Y coordinate
                         dZObsPosn: double;	 // Z offset above grid
                         dVeiwHeight: double;	 // receiver height offset above grid
                         dViewRadius: double;	 // viewing radius for point
                        end;

  X_SECT_DATA = packed record        // Information returned by a call to vmXSect (Cross Section)
                 fValue: single;     // Grid Value
                 fDist: single;      // Distance from start of line
                 fTrueDist: single;  // Surface distance from start of line
                 fX: single;         // X Coordinate of location
                 fY: single;         // Y Coordinate of location
                end;

  CONTOUR = packed record               // Information sent to the contour function
	     Elev: double;		// Value for contour interval
	     PenWidth: longint;		// Pen Width (see Map Basic Reference manual)
	     PenPattern: longint;	// Pen Pattern (see Map Basic Reference manual)
	     PenColor: longint;		// Pen Colour (see Map Basic Reference manual)
	     BrushPattern: longint;	// Brush Pattern (see Map Basic Reference manual)
	     BrushForeColor: longint;	// Brush Foreground colour (see Map Basic Reference manual)
	     BrushBackColor: longint;	// Brush Background colour (see Map Basic Reference manual)
      					// Use -1 for transparent background colour
            end;

  REGION_STYLE = packed record               // Information about a region's pen & brush style
                  PenWidth: longint;	     // Pen Width (see Map Basic Reference manual)
                  PenPattern: longint;	     // Pen Pattern (see Map Basic Reference manual)
                  PenColor: longint;	     // Pen Colour (see Map Basic Reference manual)
                  BrushPattern: longint;     // Brush Pattern (see Map Basic Reference manual)
                  BrushForecolor: longint;   // Brush Foreground colour (see Map Basic Reference manual)
                  BrushBackcolor: longint;   // Brush Background colour (see Map Basic Reference manual)
      					     // Use -1 for transparent background colour
                 end;

  AGG_FILE_HEADER = packed record                    // Information at the top of an aggregated point file that lets you get the new MBR
                     reserved: array[1..5] of byte;
                     dMinX: double;		     // Minimum X Coordinate of aggregated points.
                     dMaxX: double;		     // Maximum X Coordinate of aggregated points.
                     dMinY: double;		     // Minimum Y Coordinate of aggregated points.
                     dMaxY: double;		     // Maximum Y Coordinate of aggregated points.
                    end;

  REG_STATS = packed record            // Information concerning the grid cells inspected for a MapInfo region.
	       dMin: double;
	       dMax: double;
	       dPct: double;
	       dMean: double;
	       dMedian: double;
	       dNumCells: double;
	       dRange: double;
	       dStdDev: double;
	       dCoeffOfVar: double;
	       dVolume: double;
	       dSum: double;
	       stMinPos: PNT2D;
	       stMaxPos: PNT2D;
              end;

  ReclassInfo = packed Record
                 Value: double;
                 newValue: double;
                 newClass: pchar;
                 newClassColour: integer;
                 vmReserved: smallint;
                end;

  OperationList = packed record
                   dArg1: ^double;
                   dArg2: ^double;
                   dDest: ^double;
                   iGrid1ID: integer;
                   iGrid2ID: integer;
                   iOpID: integer;
                   pNextOperation: pointer;
                  end;

  tClause = packed record
             grid: pointer;
             operator: word;
             value: double;
             filePointer: pointer;
            end;

  importInfo = packed record
                dwTypeIn: dword;
                dwTypeOut: dword;
                dwErr: dword;
                dwAskMask: dword;
                dwValidMask: dword;
                unWidth: dword;
                unHeight: dword;
                dXMin: double;
                dXMax: double;
                dYMin: double;
                dYMax: double;
                dCellSize: double;
                szDesc: packed array [0..31] of char;
                szCoordsys: packed array [0..255] of char;
                byUnit: byte;
                szUnit: packed array [0..31] of char;
                dNoData: double;
                szErr: packed array [0..255] of char;
               end;

  tVMDT = packed record
           nst: integer;
           co: single;
           it: packed array[0..5] of integer;
           range: packed array[0..5] of single;
           sill: packed array[0..5] of single;
           angle: packed array[0..5] of single;
           anis: packed array[0..5] of single;
           AnisFlag: integer;
          end;

  tVCDT = packed record
           NDir: integer;
           NVarg: integer;
           NLag: integer;
           XLag: single;
           Hlag: pointer;
           Azm: packed array [0..5] of single;
           Atol: packed array [0..5] of single;
           tMin: single;
           tMax: single;
           ivType: packed array [0..5] of single;
          end;

  tInfoProj = packed record
               dNewMaxX:double;
               dNewMinX:double;
               dNewMaxY:double;
               dNewMinY:double;
               dNewMaxCellSize:double;
               dNewMinCellSize:double;
               lX : double;
               lY : double;
               lNumCells:double;
              end;


  function vmAddGRCDictItem(pstGridID, plDictionaryIndex: pointer; pszClassName: pchar; dVal: double; dwColor: DWORD): DWORD;  cdecl; external 'vmAPI.dll';

  function vmAddMetaData(szTabFile, szKey, szVal: pchar): DWORD; cdecl; external 'vmAPI.dll';

  function vmAreGridsJoinable(pstGridID1, pstGridID2: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmCalcSlopeAspect(pstGridID: pointer; pszSlopeTableName, pszAspectTableName, pszSlopeDescription,
   			     pszAspectDescriptio: pchar; dwAdjustAspect, dwSlopeAsGrade: dword; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmCancelGridCreate(pstGridID: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmCheckReprojectParameters(pstGridID: pointer; pszNewCoordSys: pchar; pstInfoProj: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmCloseGrid(pstGridID: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmColorizeGRD(pstGridID: pointer; bAskHillShade, bSaveChanges: longBool): dword; cdecl; external 'vmAPI.dll';

  function vmCreateGrid(ppstNewGrid: pointer; szTabFile, szCoordSys: pchar; dXmin, dXmax, dYmin, dYmax: double; wGridWidth,
			wGridLength: WORD; lGridType: DWORD; byGridDataFormat: byte; szZDesc: pchar): dword; cdecl; external 'vmAPI.dll';

  function vmExportGrid(pstGridID: pointer; dwExportFormat: dword; pszExportFileName: pchar; dNullValue: double; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmFinishGridCreate(pstGridId: pointer):DWORD; cdecl; external 'vmAPI.dll';

  procedure vmGetErrorText(ErrorNum: dword; ErrMessage: pchar); cdecl; external 'vmAPI.dll';

  function vmGetGridValue(dXCoordinate, dYcoordinate: double; pstGridID: pointer; plReturnType, pdGRDValue, ppszGRCValue: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmGetMappableTable3dPoints(pszTableName,  psz3DPointFilev: pchar; lZColumnNumber: longint; bIgnoreZeros: longbool;
  		 		      pszDataDescription, pszZUnitDescription: pchar; lZUnitType: longint;
                                      PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';
                                      
  function vmGetNumGridsOpen: DWORD; cdecl; external 'vmAPI.dll';

  function vmGetOpenGridStructs(pstGridIDs: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmGetRevision: double; cdecl; external 'vmAPI.dll';

  function vmGetRGBColorForValue(pstGRDID: pointer; Value: double; pstRGB: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmGetUnmappableTable3dPoints(pszTableName, psz3DPointFile, pszCoordSysString: pchar; lXColumnNumber, lYColumnNumber,
  					lZColumnNumber: longint; bIgnoreZeros: longBool; pszDataDescription,
                                        pszZUnitDescription: pchar; lZUnitType: longint; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmGridCalculator(pOperations: pointer; pszOutputTableName, pszGridDescription, pszZUnitDescription: pchar; wZUnitIdentifier: word; PROGRESS_CALL_BACK: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmGridQuery(pszOutputGridName, pszGridDescription: pchar;
		dCellSize, dXMin, dXMax, dYMin, dYMax: double;
		wPassedtokensIn: pointer; dwNumClauses: dword; clauses: pointer;
		wOutputType, wTrimNulls, wTrueMethod: word;
                dTrueValueIn: double; pstTrueGrid: pointer; pszTrueClass: pchar; dwTrueColour: dword;
		wFalseMethod: word; dFalseValueIn: double; pstFalseGrid: pointer; psFzalseClass: pchar; dwTalseColour: dword;
		PROGRESS_CALL_BACK: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmHillShadeGRD(pstGrid: pointer; SunAzimuthDeg, SunAngleDeg: double; byHsBrt, byHsCon: byte; PROGRESS_CALL_BACK: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmInit(pszCharSet: pchar; dwVmReserved: dword): dword; cdecl; external 'vmAPI.dll';

  function vmInterVisibility(pstGRIDID: pointer; pszResultsMIF, pszLineMIF: pchar; pdFromX, pdFromY, pdFromZAdjust, pdToX, pdToY,
  			     pdToZAdjust, pdEarthCurvature: pointer; pszZUnitDescription: pchar; pdwReceiverVisible,
                             pdObstructionHeight, pdToAdjustment, pdFromAdjustment, pdwNumberofSamples,
                             pstPointtoPointData: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmOpenGrid(pszTabFileName: pchar; dwVmReserved: dword): pointer; cdecl; external 'vmAPI.dll';

  function vmPointInspection(pszTabFileName: pchar; pnColumnIDs: pointer; wNumberofGrids: word; ppstGRIDIDs,
   			     PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmPoly2Pnt(pszInTable, pszOutTable: pchar; dMaxNodeDist: double; bUseMaxNodeDist, bDoPolyLine, bDoRegion, bDoPoint: longBool;
	              plNumPointIn, plNumRegIn, plNumPlineIn, plNumPointOut: pointer; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmReadGRCRow(pstGRIDID: pointer; dwRow, dwStart, dwCells: dword; pwCellVal: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmReadGRDRow(pstGRIDID: pointer; dwRow, dwStart, dwCells: dword; pfCellVal: pointer): dword; cdecl; external 'vmAPI.dll';
  
  function vmReadGRDBlock(pstGRIDID:pointer; wRowStart,wColStart,wNumRows,wNumCols:dword; pfCellVal:pointer): dword; cdecl; external 'vmAPI.dll';  
  
  function vmRegionInspection(pszTabFileName: pchar; pnColumnIDs: pointer; wNumberofGrids: word; ppstGRIDIDs: pointer;
  			      wNumberofStats: word; pwStatistics, PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmRegionStats(pszTabFileName: pchar; dwRegionRowID: dword; pstGridID, pstRegStats: pointer;
   	                 PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmRegionToGrid(pszTabFileName: pchar; lZColumnNumber: longint; pszOutputGridName: pchar; dCellSize: double;
   		          pszDataDescription: pchar; lGridType: longint; byZUnitType: byte; pszZUnitDescription: pchar): dword; cdecl; external 'vmAPI.dll';

  function vmReprojectGrid(pstGRIDID: pointer; pszGridTableName, pszNewCoordSys: pchar; dNewCellSize: double;
   			   PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmResizeGrid(pstGridID: pointer; dCellSize: double; pszGridTableName: pchar; PROGRESS_CALL_BACK: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmSetInflections(pstGridID: pointer; wIps: WORD; pInflection_desc: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmSpliceGrids(ppstGridIDs: pointer; dwNumGrids, dwMergeType: DWORD; pszGridTableName: pchar; PROGRESS_CALL_BACK: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmTerm:longint; cdecl; external 'vmAPI.dll';

  function vmTrimGrid(pszTrimTableName: pchar; dwTrimRow: longint; pstGRIDID: pointer; pszGridTableName: pchar;
   		      PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmUpdateClassColor(pstGridID: pointer; wClassNum: word; NewColor: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmUpdateClassString(pstGridID: pointer; wClassNum: word; pszNewName: pchar): DWORD; cdecl; external 'vmAPI.dll';

  function vmViewShed(wNumberofPoints: word; pstViewShedInfo, pstGRIDID: pointer; pszViewshedTableName, pszZUnitDescription: pchar;
   		      wEarthCorrection: word; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmAPI.dll';
   		      
  function VBViewShedStdCall(wNumberofPoints:word; pstViewShedInfo,GridID:pointer; pszViewshedTableName,pszZUnitDescription:PChar; wEarthCorrection:word; PROGRESS_CALL_BACK: pointer):dword; stdcall; external 'vmAPI.dll';

  function vmWorldToGrid(pstGridID:Pointer; dXPosWorld,dYPosWorld:Double; plRow,plColumn:Pointer):DWORD; cdecl; external 'vmAPI.dll';
  
  function vmGridToWorld(pstGridID:Pointer; lRow,lColumn:LongInt; pdXPosWorld,pdYPosWorld:Pointer):DWORD; cdecl; external 'vmAPI.dll';  
  
  function vmWriteGRCNullRow(pstGridID: pointer; wRowNum: WORD): DWORD; cdecl; external 'vmAPI.dll';

  function vmWriteGRDNullRow(pstGridID: pointer; wRowNum: WORD): DWORD; cdecl; external 'vmAPI.dll';

  function vmWriteGRCRow(pstGrid: pointer; wRowNum, wStartNode, wNumNodes: WORD; pwZRow: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmWriteGRDRow(pstGrid: pointer; wRowNum, wStartNode, wNumNodes: WORD; pdZRow: pointer): DWORD; cdecl; external 'vmAPI.dll';

  function vmXSection(pstGridID: pointer; pdwNumberOfNodes, pstNodes, pdwCrossSectionPoints, pstCrossSectionData: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmReprojectPoints(pLnumPnts, pst2dPnt: pointer; szCoordsysFrom, szCoordsysTo: pchar; Reserved1, Reserved2: pointer): dword; cdecl; external 'vmAPI.dll';

  function vmGetCurrentGrid: pointer; cdecl; external 'vmGridMan.dll';

  function vmInitProgress(captionText: pchar): dword; cdecl; external 'vmGridMan.dll';

  function vmUpdateProgress(position: dword): dword; cdecl; external 'vmGridMan.dll';

  function vmUpdateProgressText(captionText: pchar): dword; cdecl; external 'vmGridMan.dll';

  function vmGetProgressCallback: pointer; cdecl; external 'vmGridMan.dll';

  function vmDestroyProgress: dword;  cdecl; external 'vmGridMan.dll';

  function vmKriging(szPntFile, pszKrigName, pszVarName: pchar; krigType, useBlock, xBlockSize,
   		     yBlockSize: integer; searchRadius, meanValue: double; minPoints, maxPoints: integer;
                     trendCoefficents: pointer; cellSize: double; VMDT: pointer; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'KrigDll.dll';

  function vmComplexAggregation(psz3DPointFile, pszBSOFileName: pchar; wAggregationType: word; dDensityFactor,
   				dCoincidentPointDist: double; wCoincidentPointMethod: word; dAggregationDist: double;
                                wAggregationMethod: word; dWeightExponent: double; wPrintAggPointsTable, wPrintRegionTable: word;
                                PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmNatNeigh.dll';

  function vmNatNeigh(szAggFileName, szTabFile: pchar; uHullOption: word; dMaxTriangleSide, dHullMargin, dMaxDelArc: double;
   		      uSaveBoundary, uStopAfterBoundary: word; szBoundingRegionTab: pchar; lBoundingRegionRowID: longint;
                      dCellSize: double; uNaturalMethod: word; dSkewFactor: double; uHermitianOption: word;
                      dSlopeWeightFactor, dSlopeWeightExponent: double; uPreventOvershoot: word; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmNatNeigh.dll';

  function vmGRCContour(pstGridFromMI: pointer; RegionTabFile: pchar; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmContour.dll';

  function vmPlineContour(pstGRIDID: pointer; pszTableName: pchar; lNumContours: longint; pstContours: pointer;
   			  PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmContour.dll';

  function vmReclass(pstGrid: pointer; TabFile: pchar; dwNewGridType, dwNumContours: dword; pstReclass: pointer;
   		     PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmContour.dll';

  function vmRegionContour(pstGRIDID: pointer; pszTableName: pchar; lNumContours: longint; pstContours: pointer;
   			   bExceed32kNodes: longbool; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmContour.dll';

  function vmInvDistWeighting(psz3DPointFile, pszTableName: pchar; dCellSize, dSearchRadius, dExponent, dDisplayRadius,
    			      dOrientation, dRadiusMultiplier: double; lMinimumPoints, lMaximumPoints, lNumberofZones: longint;
                              PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmMFI.dll';

  function vmRectangularInterpolation(szPntFile, outfile: pchar; dCellSize, dSearchRadius:double; 
                                      PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmMFI.dll';

  function vmHuffModel(psz3DPointFile, pszTableName: pchar; dCellSize, dSearchRadius, dDecayCoefficient, dDisplayRadius: double;
   		       lCrowFlyOption: longint; dAttractiveness: double; lReferencePoint: longint;
                       PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmMFI.dll';

  function vmLocationProfiler(psz3DPointFile, pszTableName: pchar; dCellSize, dSearchRadius, dDisplayRadius: double;
   			      lMinimumPoints, lMaximumPoints: longint; dExclusionRadius: double; lVmReserved: longint;
                              dXInflection, dYInflection, dSlopeInflection, dExclusionX, dExclusionY, dExclusionSlope: double;
                              PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmMFI.dll';

  function vmGetTriangles(psz3DPointFile, pszTRIName: pchar; dMaxTriangleSide, dSamePointDistance: double;
   			  lSamePointMethod: longint; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmTIN.dll';

  function vmSimpleAggregation(psz3DPointFile, pszTableName: pchar; dCoincidentPointDistance: double;
   			       lAggregationTechnique: longint; dwMode: DWORD; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmTIN.dll';

  function vmCellTriLinearRun(pszTRIName, pszTableName: pchar; dCellSize: double; lCreateMif: longint;
   			      pszMifFileName: pchar; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmTIN.dll';

  function vmCellTriAkimaRun(pszTRIName, pszTableName: pchar; dCellSize, dWeightFactor, dWeightExponent: double; lCreateMif: longint; pszMifFileName: pchar; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmTIN.dll';

  function vmVoronoi(pszTRIFile, pszTableName, psz3DpointsName: pchar; lHullMode: longint; dHullMargin: double;
   		     lFunctionMethod, lDissolveMode: longint; dBoundarySmoothness: double; pstRegionStyle: pointer;
                     pszBoundaryTabName: pchar; dwBoundaryRowID: dword; PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'vmTIN.dll';

  function vmVariogram(szPntFile: pchar; VCDT, VMDT: pointer; VD0, VD1, VD2, VD3, VD4, VD5, PROGRESS_CALL_BACK: pointer): dword; cdecl; external 'Vario.dll';

  function vmVariogramModel(VCDT, VMD_Trans, VD0, VD1, VD2, VD3, VD4, VD5: pointer): dword; cdecl; external 'Vario.dll';
  
  function vmImportVarA(wMode:Word; pstImportInfo:pointer; pszImportFileName,pszOutputFileName:PChar; ProgressUpdate,ProgressTextUpdate:Pointer):dword; cdecl; external 'vmImp.dll';
   			   
implementation

end.