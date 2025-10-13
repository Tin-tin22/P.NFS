unit uYakhont_Object;

interface

type

  TYakhont_Object = class
   const
      C_noState   = 10;
      C_canceled  = 0;
      C_passed    = 3;
   private
      FDis   : Double;  // Distance
      FBrg   : Double;  // Bearing

    public
      isReady : Boolean;
      state   : Integer;   { state for -> wheater isReady is false because passed or canceled ? }
                           { state netral   = C_noState,
                             state canceled = 0,
                             state passed   = 3 }

    published
      property Dis : Double read FDis write FDis;
      property Brg : Double read FBrg write FBrg;

  end;

implementation

end.
