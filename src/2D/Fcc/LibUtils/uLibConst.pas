unit uLibConst;

interface

const
  // WHOLE COLOR ===============================================================
	// Default Theme [ Disabled]
  CForegroundColor = $00FFC68C;//RGB(140,198,255);

	// FCC MAP COLOR ===========================================================
	CBackgroundMapColor = $000000000;

  // Misc ======================================================================
	CBaseAngle = 360.0;


  //Status Range
  CRangeOperation : array[0..5] of double = (1500,3000,6000,12000,24000,48000);
	CCountRange = 6;
type
  TStatusRings          = (srgRingsOff,srgRingsOn);
implementation

end.
