unit uNFS_Object;

interface

uses
  Classes, Windows, Graphics, SysUtils,
  uCoordConverter, uSimContainers,
  uMovingObject, uNFS_TCPDatatype, uObjectVisuals,
  uTrackView, uTCMSColors, uBaseCoordSystem;

type
  TNFS_Platform = class(TMovingObject)
  private
    { NFS Combination ID For Weapon }
    FNFS_ShipID : Word;
    FNFS_WeaponID : Word;
    FNFS_LauncherID : Word;
    FNFS_MissileID : Word;
    FNFS_MissileNumber : Word;
    { Drawing Properties }
    FTacticalSymbol : TTacticalSymbolRemaster;
    FSimpleText : TSimpleTextView;
    FObjectColor : TColor;

    function GetPrefixNameOfWeapon: string;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure UpdateNetDataPosition(aPosX, aPosY, aElevation, aSpeed, aHeading : Double;
                                    aOffsetx, aOffsety: Double);
                                    
    procedure SetObjectProperties(aNFS_ShipID, aNFS_WeaponID, aNFS_LauncherID,
              aNFS_MissileID, aNFS_MissileNumber : Word);

    procedure Move(const aSeconds : double; aSimPlatform, aSimDetect : TSimContainer); override;
    procedure UpdateVisual(aCvt :TCoordConverter); override;
    procedure Draw(aCnv: tCanvas); override;

    procedure InitSymbols(aBmpOrg, aBmpClrSym, aBmpSym: TBitmap);

  published
    property NFS_ShipID : Word read FNFS_ShipID;
    property NFS_WeaponID : Word read FNFS_WeaponID;
    property NFS_LauncherID : Word read FNFS_LauncherID;
    property NFS_MissileID : Word read FNFS_MissileID;
    property NFS_MissileNumber : Word read FNFS_MissileNumber;
  end;

implementation

{ TNFS_Platform }

constructor TNFS_Platform.Create;
begin
  inherited;
  FTacticalSymbol := TTacticalSymbolRemaster.Create;
  FTacticalSymbol.TextVisual.FontName := 'Arial';
  FSimpleText := TSimpleTextView.Create;
  FObjectColor := CL_TRACK_RED;
end;

destructor TNFS_Platform.Destroy;
begin
  inherited;
end;

procedure TNFS_Platform.Draw(aCnv: tCanvas);
begin
  inherited;
  if not Visible then Exit;

  FSimpleText.Color := clWhite;
  FSimpleText.Caption := ObjectName;
  FSimpleText.Visible := Visible;
  FSimpleText.Draw(aCnv);

  FTacticalSymbol.Visible := Visible;
  FTacticalSymbol.TextVisual.Size := 6;
  FTacticalSymbol.Draw(aCnv);
end;

function TNFS_Platform.GetPrefixNameOfWeapon: string;
begin
  case FNFS_WeaponID of
    C_DBID_ASROC : Result := 'ASROC';
    C_DBID_RBU6000 : Result := 'RBU6000';
    C_DBID_TORPEDO_A244S : Result := 'TORPEDO-A244';
    C_DBID_TORPEDO_SUT : Result := 'TORPEDO_SUT';
    C_DBID_TETRAL : Result := 'TETRAL';
    C_DBID_YAKHONT : Result := 'YAKHONT';
    C_DBID_C802 : Result := 'C-802';
    C_DBID_MISTRAL : Result := 'MISTRAL';
    C_DBID_STRELA : Result := 'STRELLA';
    C_DBID_EXOCET_MM40 : Result := 'EXOCET-MM40';
  end;
end;

procedure TNFS_Platform.InitSymbols(aBmpOrg, aBmpClrSym, aBmpSym: TBitmap);
begin
  FTacticalSymbol.Initialize(aBmpOrg, aBmpClrSym, aBmpSym, FObjectColor);
end;

procedure TNFS_Platform.Move(const aSeconds : double; aSimPlatform, aSimDetect : TSimContainer);
begin
  inherited;
end;

procedure TNFS_Platform.SetObjectProperties(aNFS_ShipID, aNFS_WeaponID,
  aNFS_LauncherID, aNFS_MissileID, aNFS_MissileNumber: Word);
begin
  FNFS_ShipID := aNFS_ShipID;
  FNFS_WeaponID := aNFS_WeaponID;
  FNFS_LauncherID := aNFS_LauncherID;
  FNFS_MissileID := aNFS_MissileID;
  FNFS_MissileNumber := aNFS_MissileNumber;

  ObjectName := GetPrefixNameOfWeapon;
end;

procedure TNFS_Platform.UpdateNetDataPosition(aPosX, aPosY, aElevation, aSpeed, aHeading : Double;
                                              aOffsetx, aOffsety: Double);
begin
  PosX := aPosX + aOffSetX;
  PosY := aPosY + aOffSetY;
  Elevation := aElevation;
  Speed := aSpeed * C_MperS2_to_KnotperS / C_DM_to_Knots;
  Heading := aHeading;
end;

procedure TNFS_Platform.UpdateVisual(aCvt: TCoordConverter);
var
  pt : TPoint; 
begin
  inherited;
  aCvt.ConvertToScreen(posX, posY, pt.X, pt.Y);
  
  FTacticalSymbol.Center := pt;
  FTacticalSymbol.ConvertCoord(aCvt);
  FSimpleText.Center := pt;
  FSimpleText.Offset.X := 18;
  FSimpleText.Offset.Y := -7;
end;

end.
