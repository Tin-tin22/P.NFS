unit uManualInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, uTrackFunction, uData;

type
  TfrmManualInput = class(TForm)
    pnlmanualInput: TPanel;
    pnlInitRangeToTarget: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtRangeToTarget: TEdit;
    pnlMemberOfTIVariant: TPanel;
    Label3: TLabel;
    edtMemberOfTIVariant: TEdit;
    pnlExit: TPanel;
    btnExit: TSpeedButton;
    pnlManualComponentOfTargetInputAttribute: TPanel;
    Label4: TLabel;
    edtManualCompOfTargetAttribute: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    pnlInitTargetBearing: TPanel;
    Label7: TLabel;
    edtTargetOfBearing: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    pnlTargetHeading: TPanel;
    edtTargetHeading: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    pnlTargetSpeed: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtTargetSpeed: TEdit;
    pnlMRSEOfTargetRange: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtMRSEOfTargetRange: TEdit;
    pnlMRSEOfTargetBearing: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtMRSEOfTargetBearing: TEdit;
    pnlMRSEOfTargetSpeed: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtMRSEOfTargetSpeed: TEdit;
    pnlTargetDataAgeingTime: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtTargetDataAgingTime: TEdit;
    pnlTargetType: TPanel;
    Label28: TLabel;
    Label30: TLabel;
    edtTargetType: TEdit;
    pnlCoreRadius: TPanel;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edtCoreRadius: TEdit;
    pnlQuantityOfShipsinFormations: TPanel;
    Label34: TLabel;
    Label37: TLabel;
    edtQuantityOfShipsInFormations: TEdit;
    StrGridShowResult: TStringGrid;
    pnlPosLongTarget: TPanel;
    Label36: TLabel;
    Label38: TLabel;
    edtLongTarget: TEdit;
    pnlPosLatTarget: TPanel;
    Label39: TLabel;
    Label40: TLabel;
    edtLatTarget: TEdit;
    pnlMRSEOfTargetPos: TPanel;
    Label41: TLabel;
    Label42: TLabel;
    edtMRSEOfTargetPos: TEdit;
    Label43: TLabel;
    pnlNumberOfTIVariant: TPanel;
    Label44: TLabel;
    edtNumberOfTIVariant: TEdit;
    pnlMovingCompOfTargetInputAttribute: TPanel;
    Label45: TLabel;
    edtMovingCompOfTargetInputAttribute: TEdit;
    lblErorTIVar: TLabel;
    lblErrorMovCompTIAttribute: TLabel;
    lblErrorRangeTarget: TLabel;
    lblErrorTargetBearing: TLabel;
    lblErrorTargetHeading: TLabel;
    lblErrorTargetSpeed: TLabel;
    lblErrorMrseOfTargetRange: TLabel;
    lblErrorMrseOfTargetBearing: TLabel;
    pnlMRSEOfTargetHeading: TPanel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    lblErrorMRSEOfTargetHeading: TLabel;
    edtMRSEOfTargetHeading: TEdit;
    lblErrorMrseOfTargetSpeed: TLabel;
    lblErrorTargetDataAgeingTime: TLabel;
    lblErrorCoreRadius: TLabel;
    pnlQuantityofShipsInCore: TPanel;
    Label49: TLabel;
    Label50: TLabel;
    edtQuantOfShipsInCore: TEdit;
    lblErrorQuantOfShipsInCore: TLabel;
    lblErrorQuantityOfShipsInFormations: TLabel;
    lblErrorTargetType: TLabel;
    lblErrorMRSEOfTargetPos: TLabel;
    lblErrorLat: TLabel;
    Label33: TLabel;
    Label35: TLabel;
    lblErrorLong: TLabel;
    btnCheat: TButton;
    procedure edtMemberOfTIVariantKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumberOfTIVariantKeyPress(Sender: TObject; var Key: Char);
    procedure edtMovingCompOfTargetInputAttributeKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtRangeToTargetKeyPress(Sender: TObject; var Key: Char);
    procedure edtTargetOfBearingKeyPress(Sender: TObject; var Key: Char);
    procedure edtTargetHeadingKeyPress(Sender: TObject; var Key: Char);
    procedure edtTargetSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure edtMRSEOfTargetRangeKeyPress(Sender: TObject; var Key: Char);
    procedure edtMRSEOfTargetBearingKeyPress(Sender: TObject; var Key: Char);
    procedure edtMRSEOfTargetHeadingKeyPress(Sender: TObject; var Key: Char);
    procedure edtMRSEOfTargetSpeedKeyPress(Sender: TObject; var Key: Char);
    procedure edtTargetDataAgingTimeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCoreRadiusKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantOfShipsInCoreKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantityOfShipsInFormationsKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtTargetTypeKeyPress(Sender: TObject; var Key: Char);
    procedure edtLatTargetKeyPress(Sender: TObject; var Key: Char);
    procedure edtLongTargetKeyPress(Sender: TObject; var Key: Char);
    procedure edtMRSEOfTargetPosKeyPress(Sender: TObject; var Key: Char);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure StrGridShowResultSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnCheatClick(Sender: TObject);

  private
    { Private declarations }
//    isCompletelyInsert : Boolean;

    procedure setStringGrid;
    procedure setSGColumn1_Title;
    procedure setSGColumn2_Value;
    procedure setSGColumn3_Denomination;
    procedure AutoSizeCol(Grid: TStringGrid; Column: integer);

    procedure Normalisasi;
  public
    { Public declarations }
    isCompletelyInsert : Boolean;
    typeOfVariant : Integer;

    Rec_TIVar1 : TRecTIVariant1;
    Rec_TIVar2 : TRecTIVariant2;
  end;

var
  frmManualInput: TfrmManualInput;

implementation

uses
  uMainMM, uYakhontManager, uSelectionTI, uBaseFunction, uBaseConstan;

{$R *.dfm}

procedure TfrmManualInput.edtMemberOfTIVariantKeyPress(Sender: TObject;
  var Key: Char);
begin
   pnlMovingCompOfTargetInputAttribute.BringToFront;
end;

procedure TfrmManualInput.edtNumberOfTIVariantKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToInt(edtNumberOfTIVariant.Text, typeOfVariant);

       if typeOfVariant = 1 then
       begin
          lblErorTIVar.Caption := '';
          pnlMovingCompOfTargetInputAttribute.BringToFront;
          edtMovingCompOfTargetInputAttribute.SetFocus;
       end
       else if typeOfVariant = 2 then
       begin
          lblErorTIVar.Caption := '';
          pnlMovingCompOfTargetInputAttribute.BringToFront;
          edtMovingCompOfTargetInputAttribute.SetFocus;
       end
       else
          lblErorTIVar.Caption := 'ERROR ENTER : Value 1 OR 2';
   end;
end;

procedure TfrmManualInput.edtMovingCompOfTargetInputAttributeKeyPress(
  Sender: TObject; var Key: Char);
var
   typeMovCompOfTIAttribute : Integer;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToInt(edtMovingCompOfTargetInputAttribute.Text, typeMovCompOfTIAttribute);

       if typeOfVariant = 1 then
       begin
          if (typeMovCompOfTIAttribute = 0) or (typeMovCompOfTIAttribute = 1) then
          begin
             lblErrorMovCompTIAttribute.Caption := '';
             Rec_TIVar1.MovingCompTI := typeMovCompOfTIAttribute;
             pnlInitRangeToTarget.BringToFront;
             edtRangeToTarget.SetFocus;
          end
          else
             lblErrorMovCompTIAttribute.Caption := 'ERROR ENTER : Value 0 OR 1';
       end
       else if typeOfVariant = 2 then
       begin
          if (typeMovCompOfTIAttribute = 0) or (typeMovCompOfTIAttribute = 1) then
          begin
             lblErrorMovCompTIAttribute.Caption := '';
             Rec_TIVar2.MovingCompTI := typeMovCompOfTIAttribute;
             pnlPosLatTarget.BringToFront;
             edtLatTarget.SetFocus;
          end
          else
             lblErrorMovCompTIAttribute.Caption := 'ERROR ENTER : Value between 0 OR 1';
       end;
   end;
end;

procedure TfrmManualInput.edtLatTargetKeyPress(Sender: TObject; var Key: Char);
var
   initLat : Double;
   tempLatString : string;
   flag : Boolean;
   temp : Boolean;
begin
   flag := true;
   if Key = #13 then
   begin

//      Try
////        try
////          initLat := StrToFloat(edtLatTarget.Text);
////        except
////          on E : Exception do
//            initLat := dmToLatitude(edtLatTarget.Text);
//            tempLatString := FloatToStr(initLat);
////            tempLatString := FormatFloat('000');
//
//
////            lblErrorLat.Caption := FloatToStr(initLat);
////        end;
//      Except
//        on E : Exception do
//        begin
////          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
//
//          Label33.Caption := 'ERROR ENTER : Format should be ' + '000° 00.00"'+' N';
//          lblErrorLat.Caption := 'Example : ' + '007° 20.45"'+' S';
//
//          edtLatTarget.Text  := '000° 00.00"'+' N';
//
//          pnlPosLatTarget.BringToFront;
//          flag := False;
//        end;
//      end;
//        initLat := dmToLatitude(edtLatTarget.Text);

//      initLat := 0;
      try
      begin
        initLat := dmToLatitude(edtLatTarget.Text);
        flag := False;
        if (initLat = 0) then
        begin
          lblErrorLat.Caption := 'ERROR: Out Of Range';
          edtLatTarget.Text := '';
        end
        else if (initLat = -1) then
        begin
          lblErrorLat.Caption := 'ERROR: Minute Input Not Allowed';
          edtLatTarget.Text := '';
        end
        else if (initLat = -2) then
        begin
          lblErrorLat.Caption := 'ERROR: Second Input Not Allowed';
          edtLatTarget.Text := '';
        end;

        Label33.Caption := 'Format should be: ' + '000.00.00 (Degree.Minute.Second)';
        edtLatTarget.Text := '';
      end;
      finally
        if (initLat <> 0) and (initLat <> -1) and (initLat <> -2) then
          flag := True;
      end;

//      repeat
//        pnlPosLatTarget.BringToFront;
//        initLat := dmToLatitude(edtLatTarget.Text);
//      until
//        (initLat <> 0) and (initLat <> -1) and (initLat <> -2);

//      while (initLat = 0) or (initLat = -1) or (initLat = -2) do
//      begin
//        initLat := dmToLatitude(edtLatTarget.Text);
//        if (initLat = 0) then
//          lblErrorLat.Caption := 'Out Of Range'
//        else if (initLat = -1) then
//          lblErrorLat.Caption := 'Minute Input Not Allowed'
//        else if (initLat = -2) then
//          lblErrorLat.Caption := 'Second Input Not Allowed';
//      end;

//      initLat := dmToLatitude(edtLatTarget.Text);
//      if initLat = 0 then
//      begin
//        flag := False;
//        initLat := dmToLatitude(edtLatTarget.Text);
//      end
//      else if initLat = -1 then
//      begin
//        flag := False;
//        initLat := dmToLatitude(edtLatTarget.Text);
//      end
//      else if initLat = -2 then
//      begin
//        flag := False;
//        initLat := dmToLatitude(edtLatTarget.Text);
//      end;

      if flag then
      begin
        Rec_TIVar2.LattTarget := initLat;
        pnlPosLongTarget.BringToFront;
        edtLongTarget.SetFocus;
      end;
   end;
end;

procedure TfrmManualInput.edtLongTargetKeyPress(Sender: TObject; var Key: Char);
var
   initLong : Double;
   flag : Boolean;
begin
   flag := true;
   if Key = #13 then
   begin
//      Try
////        try
////          initLong := StrToFloat(edtLongTarget.Text);
////        except
////          on E : Exception do
//            initLong := dmToLongitude(edtLongTarget.Text);
////        end;
//      except
//        on E : Exception do
//        begin
////          ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
//
//          Label35.Caption := 'ERROR ENTER : Format should be ' + '000° 00.00"'+' E';
//          lblErrorLong.Caption := 'Example : ' + '112° 07 12"'+' E';
//
//          edtLongTarget.Text  := '000° 00.00"'+' E';
//
//          pnlPosLongTarget.BringToFront;
//
//          flag := False;
//        end;
//      End;

//      initLong := dmToLongitude(edtLongTarget.Text);
//      flag := True;
//
//      if initLong = 0 then
//      begin
//        flag := False;
//        lblErrorLong.Caption := 'Out Of Range';
//        initLong := dmToLongitude(edtLongTarget.Text);
//      end
//      else if initLong = -1 then
//      begin
//        flag := False;
//        lblErrorLong.Caption := 'Minute Input Not Allowed';
//        initLong := dmToLongitude(edtLongTarget.Text);
//      end
//      else if initLong = -2 then
//      begin
//        flag := False;
//        lblErrorLong.Caption := 'Second Input Not Allowed';
//        initLong := dmToLongitude(edtLongTarget.Text);
//      end;

//      initLong := 0;
//      while (initLong = 0) or (initLong = -1) or (initLong = -2) do
//      begin
//        initLong := dmToLongitude(edtLongTarget.Text);
//        if initLong = 0 then
//          lblErrorLong.Caption := 'Out Of Range'
//        else if initLong = -1 then
//          lblErrorLong.Caption := 'Minute Input Not Allowed'
//        else if initLong = -2 then
//          lblErrorLong.Caption := 'Second Input Not Allowed';
//      end;

      try
      begin
        initLong := dmToLongitude(edtLongTarget.Text);
        flag := False;
        if (initLong = 0) then
        begin
          lblErrorLong.Caption := 'ERROR: Out Of Range';
        end
        else if (initLong = -1) then
        begin
          lblErrorLong.Caption := 'ERROR: Minute Input Not Allowed';
        end
        else if (initLong = -2) then
        begin
          lblErrorLong.Caption := 'ERROR: Second Input Not Allowed';
        end;

        Label35.Caption := 'Format should be: ' + '000.00.00 (Degree.Minute.Second)';
        edtLongTarget.Text := '';
      end;
      finally
        if (initLong <> 0) and (initLong <> -1) and (initLong <> -2) then
          flag := True;
      end;

      if flag then
      begin
        Rec_TIVar2.LongTarget := initLong;
        pnlMRSEOfTargetPos.BringToFront;
        edtMRSEOfTargetPos.SetFocus;
      end;
   end;
end;

procedure TfrmManualInput.edtMRSEOfTargetPosKeyPress(Sender: TObject;
  var Key: Char);
var
   initMRSEOfTargetPos : Integer;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToInt(edtMRSEOfTargetPos.Text, initMRSEOfTargetPos);

       if (initMRSEOfTargetPos >= 0) and (initMRSEOfTargetPos <= 10000) then
       begin
         lblErrorMRSEOfTargetPos.Caption := '';
         Rec_TIVar2.MRSE_posTarget := initMRSEOfTargetPos;
         pnlTargetHeading.BringToFront;
         edtTargetHeading.SetFocus;
       end
       else
         lblErrorMRSEOfTargetPos.Caption := 'ERROR ENTER : 0 >= Value <= 10000 m';
   end;
end;

procedure TfrmManualInput.edtRangeToTargetKeyPress(Sender: TObject;
  var Key: Char);
var
   initRangeToTarget : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtRangeToTarget.Text, initRangeToTarget);

       if (initRangeToTarget >= 20) and (initRangeToTarget <= 300) then
       begin
          lblErrorRangeTarget.Caption := '';

          initRangeToTarget     := initRangeToTarget*1000;           { km to m }
          Rec_TIVar1.DistTarget := initRangeToTarget;
          YakhontManager.isTargetInRange := True;

          pnlInitTargetBearing.BringToFront;
          edtTargetOfBearing.SetFocus;
       end
       else
          lblErrorRangeTarget.Caption := 'ERROR ENTER : 20 >= Value <= 300 km';
   end;
end;

procedure TfrmManualInput.edtTargetOfBearingKeyPress(Sender: TObject;
  var Key: Char);
var
   initTargetBearing : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtTargetOfBearing.Text, initTargetBearing);

       if (initTargetBearing >= 0) and (initTargetBearing <= 360) then
       begin
          lblErrorTargetBearing.Caption := '';

          Rec_TIVar1.BearingTarget := initTargetBearing;

          { target heading }
          pnlTargetHeading.BringToFront;
          edtTargetHeading.SetFocus;
       end
       else   // show error bearing target between 0-360 degree
          lblErrorTargetBearing.Caption := 'ERROR ENTER : 0 >= Value <= 360 degree';
   end;
end;

procedure TfrmManualInput.edtTargetHeadingKeyPress(Sender: TObject;
  var Key: Char);
var
   initTargetHeading : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtTargetHeading.Text, initTargetHeading);

       if typeOfVariant = 1 then
       begin
         if (initTargetHeading >= 0) and (initTargetHeading <= 360) then
         begin
            lblErrorTargetHeading.Caption := '';
            Rec_TIVar1.HeadingTarget := initTargetHeading;
            pnlTargetSpeed.BringToFront;
            edtTargetSpeed.SetFocus;
         end
         else
            lblErrorTargetHeading.Caption := 'ERROR ENTER : 0 >= Value <= 360 degree';
       end
       else if typeOfVariant = 2 then
       begin
         if (initTargetHeading >= 0) and (initTargetHeading <= 360) then
         begin
            lblErrorTargetHeading.Caption := '';
            Rec_TIVar2.HeadingTarget := initTargetHeading;
            pnlTargetSpeed.BringToFront;
            edtTargetSpeed.SetFocus;
         end
         else
            lblErrorTargetHeading.Caption := 'ERROR ENTER : 0 >= Value <= 360 degree';
       end;
   end;
end;

procedure TfrmManualInput.edtTargetSpeedKeyPress(Sender: TObject;
  var Key: Char);
var
   initTargetSpeed : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtTargetSpeed.Text, initTargetSpeed);

       if typeOfVariant = 1 then
       begin
         if (initTargetSpeed >=0) and (initTargetSpeed <= 64) then
         begin
            lblErrorTargetSpeed.Caption := '';
            Rec_TIVar1.SpeedTarget := initTargetSpeed;
            pnlMRSEOfTargetRange.BringToFront;
            edtMRSEOfTargetRange.SetFocus;
         end
         else
            lblErrorTargetSpeed.Caption := 'ERROR ENTER : 0 >= Value <= 64 m/s';
       end
       else if typeOfVariant = 2 then
       begin
         if (initTargetSpeed >=0) and (initTargetSpeed <= 64) then
         begin
            lblErrorTargetSpeed.Caption := '';
            Rec_TIVar2.SpeedTarget := initTargetSpeed;
            pnlMRSEOfTargetHeading.BringToFront;
            edtMRSEOfTargetHeading.SetFocus;
         end
         else
            lblErrorTargetSpeed.Caption := 'ERROR ENTER : 0 >= value <= 64 m/s';
       end;
   end;
end;

procedure TfrmManualInput.edtMRSEOfTargetRangeKeyPress(Sender: TObject;
  var Key: Char);
var
   initMrseOfTargetRange : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtMRSEOfTargetRange.Text, initMrseOfTargetRange);

       if (initMrseOfTargetRange > 0) and (initMrseOfTargetRange <= 20) then
       begin
          lblErrorMrseOfTargetRange.Caption := '';

          initMrseOfTargetRange      := initMrseOfTargetRange*1000;   { km to m }
          Rec_TIVar1.MRSE_distTarget := initMrseOfTargetRange;

          { MRSE of bearing to target }
          pnlMRSEOfTargetBearing.BringToFront;
          edtMRSEOfTargetBearing.SetFocus;
       end
       else   // show error mrse range target between 1-20 km
          lblErrorMrseOfTargetRange.Caption := 'ERROR ENTER : 1 >= Value <= 20 km';
   end;
end;

procedure TfrmManualInput.edtMRSEOfTargetBearingKeyPress(Sender: TObject;
  var Key: Char);
var
   initMrseOfTargetbearing : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtMRSEOfTargetBearing.Text, initMrseOfTargetbearing);

       if (initMrseOfTargetbearing >= 0) and (initMrseOfTargetbearing <= 45) then
       begin
          lblErrorMrseOfTargetBearing.Caption := '';

          Rec_TIVar1.MRSE_bearingTarget := initMrseOfTargetbearing;

          { MRSE of heading target }
          pnlMRSEOfTargetHeading.BringToFront;
          edtMRSEOfTargetHeading.SetFocus;
       end
       else   // show error mrse bearing target between 0-45 degree
          lblErrorMrseOfTargetBearing.Caption := 'ERROR ENTER : 0 >= Value <= 45 degree';
   end;
end;

procedure TfrmManualInput.edtMRSEOfTargetHeadingKeyPress(Sender: TObject;
  var Key: Char);
var
   initMrseOfTargetHeading : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtMRSEOfTargetHeading.Text, initMrseOfTargetHeading );

       if typeOfVariant = 1 then
       begin
         if (initMrseOfTargetHeading >= 0) and (initMrseOfTargetHeading <= 20) then
         begin
            lblErrorMRSEOfTargetHeading.Caption := '';
            Rec_TIVar1.MRSE_headingTarget := initMrseOfTargetHeading;
            pnlMRSEOfTargetSpeed.BringToFront;
            edtMRSEOfTargetSpeed.SetFocus;
         end
         else
            lblErrorMRSEOfTargetHeading.Caption := 'ERROR ENTER : 0 >= Value <= 20 degree';
       end
       else if typeOfVariant = 2 then
       begin
         if (initMrseOfTargetHeading >= 0) and (initMrseOfTargetHeading <= 20) then
         begin
            lblErrorMRSEOfTargetHeading.Caption := '';
            Rec_TIVar2.MRSE_headingTarget := initMrseOfTargetHeading;
            pnlMRSEOfTargetSpeed.BringToFront;
            edtMRSEOfTargetSpeed.SetFocus;
         end
         else
            lblErrorMRSEOfTargetHeading.Caption := 'ERROR ENTER : 0 >= Value <= 20 degree';
       end;
   end;
end;

procedure TfrmManualInput.edtMRSEOfTargetSpeedKeyPress(Sender: TObject;
  var Key: Char);
var
   initMrseOfTargetSpeed : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtMRSEOfTargetSpeed.Text, initMrseOfTargetSpeed );

       if typeOfVariant = 1 then
       begin
         if (initMrseOfTargetSpeed >= 0) and (initMrseOfTargetSpeed <= 10) then
         begin
            lblErrorMRSEOfTargetSpeed.Caption := '';
            Rec_TIVar1.MRSE_speedTarget := initMrseOfTargetSpeed;
            pnlTargetDataAgeingTime.BringToFront;
            edtTargetDataAgingTime.SetFocus;
         end
         else
            lblErrorMRSEOfTargetSpeed.Caption := 'ERROR ENTER : 0 >= Value <= 10 m/s';
       end
       else if typeOfVariant = 2 then
       begin
         if (initMrseOfTargetSpeed >= 0) and (initMrseOfTargetSpeed <= 10) then
         begin
            lblErrorMRSEOfTargetSpeed.Caption := '';
            Rec_TIVar2.MRSE_speedTarget := initMrseOfTargetSpeed;
            pnlTargetDataAgeingTime.BringToFront;
            edtTargetDataAgingTime.SetFocus;
         end
         else
            lblErrorMRSEOfTargetSpeed.Caption := 'ERROR ENTER : 0 >= Value <= 10 m/s';
       end;
   end;
end;

procedure TfrmManualInput.edtTargetDataAgingTimeKeyPress(Sender: TObject;
  var Key: Char);
var
   initAgeingTimeOfTargetData : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtTargetDataAgingTime.Text, initAgeingTimeOfTargetData );

       if typeOfVariant = 1 then
       begin
         if (initAgeingTimeOfTargetData >= 0) and (initAgeingTimeOfTargetData <= 2400) then
         begin
            lblErrorTargetDataAgeingTime.Caption := '';
            Rec_TIVar1.AgeingTimeDataTarget := initAgeingTimeOfTargetData;
            pnlTargetType.BringToFront;
            edtTargetType.SetFocus;
            YakhontManager.isTimeAgeStart := True;
            fmMainMM.StartAgingTime := Now;
            YakhontManager.TimeAgeCount := initAgeingTimeOfTargetData;
         end
         else
            lblErrorTargetDataAgeingTime.Caption := 'ERROR ENTER : 0 >= Value <= 2400 s';
       end
       else if typeOfVariant = 2 then
       begin
         if (initAgeingTimeOfTargetData >= 0) and (initAgeingTimeOfTargetData <= 2400) then
         begin
            lblErrorTargetDataAgeingTime.Caption := '';
            Rec_TIVar2.AgeingTimeDataTarget := initAgeingTimeOfTargetData;
            pnlTargetType.BringToFront;
            edtTargetType.SetFocus;
            YakhontManager.isTimeAgeStart := True;
            fmMainMM.StartAgingTime := Now;
            YakhontManager.TimeAgeCount := initAgeingTimeOfTargetData;
         end
         else
            lblErrorTargetDataAgeingTime.Caption := 'ERROR ENTER : 0 >= Value <= 2400 s';
       end;
   end;
end;

procedure TfrmManualInput.edtTargetTypeKeyPress(Sender: TObject; var Key: Char);
var
   initTargetType : Integer;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToInt(edtTargetType.Text, initTargetType );

       if typeOfVariant = 1 then
       begin
         if (initTargetType > 0) and (initTargetType <= 6) then
         begin
            lblErrorTargetType.Caption := '';
            Rec_TIVar1.TypeTarget := initTargetType;
            pnlCoreRadius.BringToFront;
            edtCoreRadius.SetFocus;
         end
         else
            lblErrorTargetType.Caption := 'ERROR ENTER : 1 >= Value <= 6';
       end
       else if typeOfVariant = 2 then
       begin
         if (initTargetType > 0) and (initTargetType <= 6) then
         begin
            lblErrorTargetType.Caption := '';
            Rec_TIVar2.TypeTarget := initTargetType;
            pnlCoreRadius.BringToFront;
            edtCoreRadius.SetFocus;
         end
         else
            lblErrorTargetType.Caption := 'ERROR ENTER : 1 >= Value <= 6';
       end;
   end;
end;

procedure TfrmManualInput.edtCoreRadiusKeyPress(Sender: TObject; var Key: Char);
var
   initCoreRadius : Double;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToFloat(edtCoreRadius.Text, initCoreRadius );

       if typeOfVariant = 1 then
       begin
         if (initCoreRadius >= 0) and (initCoreRadius <= 15000) then
         begin
            lblErrorCoreRadius.Caption := '';
            Rec_TIVar1.CoreRadius := initCoreRadius;
            pnlQuantityofShipsInCore.BringToFront;
            edtQuantOfShipsInCore.SetFocus;
         end
         else
            lblErrorCoreRadius.Caption := 'ERROR ENTER : 0 >= Value <= 15000 m';
       end
       else if typeOfVariant = 2 then
       begin
         if (initCoreRadius >= 0) and (initCoreRadius <= 15000) then
         begin
            lblErrorCoreRadius.Caption := '';
            Rec_TIVar2.CoreRadius := initCoreRadius;
            pnlQuantityofShipsInCore.BringToFront;
            edtQuantOfShipsInCore.SetFocus;
         end
         else
            lblErrorCoreRadius.Caption := 'ERROR ENTER : 0 >= Value <= 15000 m';
       end;
   end;
end;

procedure TfrmManualInput.edtQuantOfShipsInCoreKeyPress(Sender: TObject;
  var Key: Char);
var
   initQuantOfShipInCore : Integer;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToInt(edtQuantOfShipsInCore.Text, initQuantOfShipInCore );

       if typeOfVariant = 1 then
       begin
         if (initQuantOfShipInCore > 0) and (initQuantOfShipInCore <= 31) then
         begin
            lblErrorQuantOfShipsInCore.Caption := '';
            Rec_TIVar1.QuantityOfShipInCore := initQuantOfShipInCore;
            pnlQuantityOfShipsinFormations.BringToFront;
            edtQuantityOfShipsInFormations.SetFocus;
            StrGridShowResult.Visible := False;
         end
         else
            lblErrorQuantOfShipsInCore.Caption := 'ERROR ENTER : 1 >= Value <= 31';
       end
       else if typeOfVariant = 2 then
       begin
         if (initQuantOfShipInCore > 0) and (initQuantOfShipInCore <= 31) then
         begin
            lblErrorQuantOfShipsInCore.Caption := '';
            Rec_TIVar2.QuantityOfShipInCore := initQuantOfShipInCore;
            pnlQuantityOfShipsinFormations.BringToFront;
            edtQuantityOfShipsInFormations.SetFocus;
            StrGridShowResult.Visible := False;
         end
         else
            lblErrorQuantOfShipsInCore.Caption := 'ERROR ENTER : 1 >= Value <= 31';
       end;
   end;
end;

procedure TfrmManualInput.edtQuantityOfShipsInFormationsKeyPress(
  Sender: TObject; var Key: Char);
var
  initQuantOfShipInFormation : Integer;
begin
   if not(Key in [#48 .. #57, #8, #13, #46]) then
      Key := #0;

   if Key = #13 then
   begin
       TryStrToInt(edtQuantityOfShipsInFormations.Text, initQuantOfShipInFormation );

       if typeOfVariant = 1 then
       begin
         if (initQuantOfShipInFormation > 0) and (initQuantOfShipInFormation <= 31) then
         begin
            lblErrorQuantityOfShipsInFormations.Caption := '';
            Rec_TIVar1.QuantityOfShipInFormation := initQuantOfShipInFormation;
            setStringGrid;
            StrGridShowResult.Visible := True;
         end
         else
            lblErrorQuantityOfShipsInFormations.Caption := 'ERROR ENTER : 1 >= Value <= 31';
       end
       else if typeOfVariant = 2 then
       begin
         if (initQuantOfShipInFormation > 0) and (initQuantOfShipInFormation <= 31) then
         begin
            lblErrorQuantityOfShipsInFormations.Caption := '';
            Rec_TIVar2.QuantityOfShipInFormation := initQuantOfShipInFormation;
            setStringGrid;
            StrGridShowResult.Visible := True;
         end
         else
            lblErrorQuantityOfShipsInFormations.Caption := 'ERROR ENTER : 1 >= Value <= 31';
       end;

       with fmMainMM do
       begin
         pnlRTP.Caption   := 'RTP';
//         pnlRange.Caption := 'In Range';
         pnlNext.Caption  := 'TI Accepted';

         lblType.Caption  := 'SSS';

         isCompletelyInsert := true;
         checkerButtonProcedure[1] := 1;
       end;
   end;
end;

procedure TfrmManualInput.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
var
  range : Double;
begin
  if GetKeyState(VK_F8) < 0 then
  begin
//    with fmMainMM do
//    begin
//      if isCompletelyInsert then
//      begin
//        pnlNext.Caption  := 'SD';
//        btnSD.Font.Color := clBlack;
//
//        btnTI.Enabled := false;
//      end;
//    end;
//    Close;

    with fmMainMM do
    begin
      if isCompletelyInsert then
      begin
        if frmSelectionTI.currentSelectionTI = 3 then
        begin
          if typeOfVariant = 1  then
          begin
            if Rec_TIVar1.DistTarget > 19000 then
              YakhontManager.isDistMoreThan19 := True
            else
              YakhontManager.isDistMoreThan19 := False;
          end;

          if typeOfVariant = 2 then
          begin
            range := (CalcRange(YakhontManager.xShip.PositionX, YakhontManager.xShip.PositionY, Rec_TIVar2.longTarget , Rec_TIVar2.lattTarget)) * C_NauticalMiles_TO_Meter;
            if range > 19000 then
              YakhontManager.isDistMoreThan19 := True
            else
              YakhontManager.isDistMoreThan19 := False;
          end;

        end;
        StrGridShowResult.Visible := false;

        pnlNext.Caption  := 'SD';
        btnSD.Font.Color := clBlack;

        btnTI.Enabled := false;
      end;
    end;
    Close;


  end;
end;

procedure TfrmManualInput.FormShow(Sender: TObject);
begin
   Left := fmMainMM.pnlMainMM.Left + fmMainMM.pnlLeftCenter.Left + fmMainMM.fMap.Left + 115;
   Top  := fmMainMM.pnlMainMM.Top + fmMainMM.pnlLeftCenter.Top + fmMainMM.fMap.Top + 70;

   edtLatTarget.Text  := formatDMS_lat (0);
   edtLongTarget.Text := formatDMS_long(0);

   edtLatTarget.Text  := '00° 00.000'''+' N';
   edtLongTarget.Text := '000° 00.000'''+' E';

//   setStringGrid;
   normalisasi;

   edtNumberOfTIVariant.SetFocus;
end;

procedure TfrmManualInput.Normalisasi;
var
   I : Integer;
begin
   { empty record }
   Rec_TIVar1.MovingCompTI                := 0;
   Rec_TIVar1.DistTarget                  := 0;
   Rec_TIVar1.BearingTarget               := 0;
   Rec_TIVar1.HeadingTarget               := 0;
   Rec_TIVar1.SpeedTarget                 := 0;
   Rec_TIVar1.MRSE_distTarget             := 0;
   Rec_TIVar1.MRSE_bearingTarget          := 0;
   Rec_TIVar1.MRSE_headingTarget          := 0;
   Rec_TIVar1.MRSE_speedTarget            := 0;
   Rec_TIVar1.AgeingTimeDataTarget        := 0;
   Rec_TIVar1.TypeTarget                  := 0;
   Rec_TIVar1.CoreRadius                  := 0;
   Rec_TIVar1.QuantityOfShipInCore        := 0;
   Rec_TIVar1.QuantityOfShipInFormation   := 0;
   // --------------------------------------------------------------------------
   Rec_TIVar2.MovingCompTI                := 0;
   Rec_TIVar2.LattTarget                  := 0;
   Rec_TIVar2.LongTarget                  := 0;
   Rec_TIVar2.MRSE_posTarget              := 0;
   Rec_TIVar2.HeadingTarget               := 0;
   Rec_TIVar2.Speedtarget                 := 0;
   Rec_TIVar2.MRSE_headingTarget          := 0;
   Rec_TIVar2.MRSE_speedTarget            := 0;
   Rec_TIVar2.AgeingTimeDataTarget        := 0;
   Rec_TIVar2.TypeTarget                  := 0;
   Rec_TIVar2.CoreRadius                  := 0;
   Rec_TIVar2.QuantityOfShipInCore        := 0;
   Rec_TIVar2.QuantityOfShipInFormation   := 0;

   //---------------------------------------------------------------------------

   Rec_TIVar1.MovingCompTI                := 0;
   Rec_TIVar1.DistTarget                  := 0;
   Rec_TIVar1.BearingTarget               := 0;
   Rec_TIVar1.HeadingTarget               := 0;
   Rec_TIVar1.SpeedTarget                 := 0;
   Rec_TIVar1.MRSE_distTarget             := 0;
   Rec_TIVar1.MRSE_bearingTarget          := 0;
   Rec_TIVar1.MRSE_headingTarget          := 0;
   Rec_TIVar1.MRSE_speedTarget            := 0;
   Rec_TIVar1.AgeingTimeDataTarget        := 0;
   Rec_TIVar1.TypeTarget                  := 0;
   Rec_TIVar1.CoreRadius                  := 0;
   Rec_TIVar1.QuantityOfShipInCore        := 0;
   Rec_TIVar1.QuantityOfShipInFormation   := 0;

   //---------------------------------------------------------------------------

   edtMovingCompOfTargetInputAttribute.Text := '';
   edtRangeToTarget.Text := '';
   edtTargetOfBearing.Text := '';
   edtTargetHeading.Text := '';
   edtTargetSpeed.Text := '';
   edtMRSEOfTargetRange.Text := '0';
   edtMRSEOfTargetBearing.Text := '0';
   edtMRSEOfTargetHeading.Text := '0';
   edtMRSEOfTargetSpeed.Text := '0';
   edtMRSEOfTargetPos.Text := '0';
   edtTargetDataAgingTime.Text := '0';
   edtTargetType.Text := '';
   edtCoreRadius.Text := '0';
   edtQuantOfShipsInCore.Text := '';
   edtQuantityOfShipsInFormations.Text := '';
   edtLongTarget.Text := '';
   edtLatTarget.Text := '';
   edtMemberOfTIVariant.Text := '';
   edtNumberOfTIVariant.Text := '';

   //---------------------------------------------------------------------------
   lblErorTIVar.Caption := '';
   lblErrorMovCompTIAttribute.Caption := '';
   lblErrorLat.Caption := '';
   Label33.Caption := '';
   lblErrorLong.Caption := '';
   Label35.Caption := '';
   lblErrorMRSEOfTargetPos.Caption := '';
   lblErrorRangeTarget.Caption := '';
   lblErrorTargetBearing.Caption := '';
   lblErrorTargetHeading.Caption := '';
   lblErrorTargetSpeed.Caption := '';
   lblErrorMrseOfTargetRange.Caption := '';
   lblErrorMrseOfTargetBearing.Caption := '';
   lblErrorMRSEOfTargetHeading.Caption := '';
   lblErrorMRSEOfTargetSpeed.Caption := '';
   lblErrorTargetDataAgeingTime.Caption := '';
   lblErrorTargetType.Caption := '';
   lblErrorCoreRadius.Caption := '';
   lblErrorQuantOfShipsInCore.Caption := '';
   lblErrorQuantityOfShipsInFormations.Caption := '';

   { empty string grid }
   for I := 0 to StrGridShowResult.RowCount do
       StrGridShowResult.Cells[1,I] := '';

   Label33.Caption      := '';
   lblErrorLat.Caption  := '';
   Label35.Caption      := '';
   lblErrorLong.Caption := '';

   isCompletelyInsert := false;
end;

procedure TfrmManualInput.setStringGrid;
begin
   setSGColumn1_Title;
   setSGColumn2_Value;
   setSGColumn3_Denomination;
end;


procedure TfrmManualInput.StrGridShowResultSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol = 1 then
  begin
    if ARow = 20 then
       pnlMRSEOfTargetRange.BringToFront;
    if ARow = 21 then
       pnlMRSEOfTargetBearing.BringToFront;
    if ARow = 24 then
       pnlMRSEOfTargetPos.BringToFront;
    if ARow = 25 then
       pnlMRSEOfTargetHeading.BringToFront;
    if ARow = 26 then
       pnlMRSEOfTargetSpeed.BringToFront;
    if ARow = 27 then
       pnlTargetDataAgeingTime.BringToFront;
    if ARow = 28 then
       pnlTargetType.BringToFront;
    if ARow = 29 then
       pnlCoreRadius.BringToFront;
    if ARow = 30 then
       pnlQuantityofShipsInCore.BringToFront;
    if ARow = 31 then
       pnlQuantityOfShipsinFormations.BringToFront;
  end;

//  if ACol IN [2,3] then
//  begin
//    if goEditing IN StrGridShowResult.Options then
//      StrGridShowResult.Options := StrGridShowResult.Options-[goEditing];
//  end
//  else
//  begin
//    if NOT (goEditing IN StrGridShowResult.Options) then
//      StrGridShowResult.Options := StrGridShowResult.Options+[goEditing];
//  end;
end;

procedure TfrmManualInput.setSGColumn1_Title;
var
   I : Integer;
begin
   StrGridShowResult.Cells[0,0] := 'Moving Components Of target Input Attribute';                //==
   StrGridShowResult.Cells[0,1] := 'Interval between launchers';
   StrGridShowResult.Cells[0,2] := 'Geographic Latitude Of Ship';
   StrGridShowResult.Cells[0,3] := 'Geographic Longitude Of Ship';
   StrGridShowResult.Cells[0,4] := 'MRSE Of Ship Position';
   StrGridShowResult.Cells[0,5] := 'Ship Heading';
   StrGridShowResult.Cells[0,6] := 'Ship Speed';
   StrGridShowResult.Cells[0,7] := 'Lateral deviation limit at final phase';
   StrGridShowResult.Cells[0,8] := 'Range Limit';
   StrGridShowResult.Cells[0,9] := 'Lateral deviation limit at launch area';
   StrGridShowResult.Cells[0,10] := 'Range limitation within launch area';
   StrGridShowResult.Cells[0,11] := 'Time limitation';
   StrGridShowResult.Cells[0,12] := 'Minimum admissible angle of turn';
   StrGridShowResult.Cells[0,13] := 'Maximum admissible angle of turn';
   StrGridShowResult.Cells[0,14] := 'Number of ASM assigned for target hitting';
   StrGridShowResult.Cells[0,15] := 'Period of saving MDP';
   StrGridShowResult.Cells[0,16] := 'Initial range to target';                                   //==
   StrGridShowResult.Cells[0,17] := 'Initial target bearing';                                    //==
   StrGridShowResult.Cells[0,18] := 'Target heading';                                            //==
   StrGridShowResult.Cells[0,19] := 'Target speed';                                              //==
   StrGridShowResult.Cells[0,20] := 'MRSE Of target range';                                      //==
   StrGridShowResult.Cells[0,21] := 'MRSE Of target bearing';                                    //==
// ============================================================================ //
   StrGridShowResult.Cells[0,22] := 'Geographic Latitude Of Target';                             //==
   StrGridShowResult.Cells[0,23] := 'Geographic Longitude Of Target';                            //==
   StrGridShowResult.Cells[0,24] := 'MRSE of target position';                                   //==
   StrGridShowResult.Cells[0,25] := 'MRSE Of Target Heading';                                    //==
   StrGridShowResult.Cells[0,26] := 'MRSE Of Target Speed';                                      //==
   StrGridShowResult.Cells[0,27] := 'Target Data Ageing Time';                                   //==
   StrGridShowResult.Cells[0,28] := 'Target Type';                                               //==
   StrGridShowResult.Cells[0,29] := 'Core Radius';                                               //==
   StrGridShowResult.Cells[0,30] := 'Number of ship in Core';                                    //==
   StrGridShowResult.Cells[0,31] := 'Quantity Ship in Formation';                                //==

   for i := 0 to StrGridShowResult.ColCount - 1 do
      AutoSizeCol(StrGridShowResult, 0);
end;

procedure TfrmManualInput.setSGColumn2_Value;
var
   I : Integer;
begin
   if typeOfVariant = 1 then
   begin
     StrGridShowResult.Cells[1,0] := IntToStr(typeOfVariant);
     StrGridShowResult.Cells[1,1] := '2.5';
//     StrGridShowResult.Cells[1,2] := '000.00.00';
//     StrGridShowResult.Cells[1,3] := '000.00.00';
     StrGridShowResult.Cells[1,4] := '00000.0';
//     StrGridShowResult.Cells[1,5] := '00.0';
//     StrGridShowResult.Cells[1,6] := '00.0';
     StrGridShowResult.Cells[1,7] := '90000.0';
     StrGridShowResult.Cells[1,8] := '600000.0';
     StrGridShowResult.Cells[1,9] := '90000.0';
     StrGridShowResult.Cells[1,10] := '-600000.0';
     StrGridShowResult.Cells[1,11] := '500.00';
     StrGridShowResult.Cells[1,12] := '-180';
     StrGridShowResult.Cells[1,13] := '180';
     StrGridShowResult.Cells[1,14] := '1';
     StrGridShowResult.Cells[1,15] := '0050';
     StrGridShowResult.Cells[1,16] := FormatFloat('0.00', (Rec_TIVar1.DistTarget/1000));
     StrGridShowResult.Cells[1,17] := FormatFloat('0.00', (Rec_TIVar1.BearingTarget));
     StrGridShowResult.Cells[1,18] := FormatFloat('0.00',  Rec_TIVar1.HeadingTarget);
     StrGridShowResult.Cells[1,19] := FormatFloat('0.00',  Rec_TIVar1.SpeedTarget);
     StrGridShowResult.Cells[1,20] := FormatFloat('0.00', (Rec_TIVar1.MRSE_distTarget/1000));
     StrGridShowResult.Cells[1,21] := FormatFloat('0.00',  Rec_TIVar1.MRSE_bearingTarget);
  // ============================================================================ //
     StrGridShowResult.Cells[1,22] := '00.000.000';
     StrGridShowResult.Cells[1,23] := '000.000.000';
     StrGridShowResult.Cells[1,24] := '0.00';
     StrGridShowResult.Cells[1,25] := FloatToStr(Rec_TIVar1.MRSE_headingTarget);
     StrGridShowResult.Cells[1,26] := FloatToStr(Rec_TIVar1.MRSE_speedTarget);
     StrGridShowResult.Cells[1,27] := FloatToStr(Rec_TIVar1.AgeingTimeDataTarget);
     StrGridShowResult.Cells[1,28] := IntToStr(Rec_TIVar1.TypeTarget);
     StrGridShowResult.Cells[1,29] := FloatToStr(Rec_TIVar1.CoreRadius);
     StrGridShowResult.Cells[1,30] := IntToStr(Rec_TIVar1.QuantityOfShipInCore);
     StrGridShowResult.Cells[1,31] := IntToStr(Rec_TIVar1.QuantityOfShipInFormation);
   end
   else
   begin
     StrGridShowResult.Cells[1,0] := IntToStr(typeOfVariant);
     StrGridShowResult.Cells[1,1] := '2.5';
//     StrGridShowResult.Cells[1,2] := '000.00.00';
//     StrGridShowResult.Cells[1,3] := '000.00.00';
     StrGridShowResult.Cells[1,4] := '00000.0';
//     StrGridShowResult.Cells[1,5] := '00.0';
//     StrGridShowResult.Cells[1,6] := '00.0';
     StrGridShowResult.Cells[1,7] := '90000.0';
     StrGridShowResult.Cells[1,8] := '600000.0';
     StrGridShowResult.Cells[1,9] := '90000.0';
     StrGridShowResult.Cells[1,10] := '-600000.0';
     StrGridShowResult.Cells[1,11] := '500.00';
     StrGridShowResult.Cells[1,12] := '-180';
     StrGridShowResult.Cells[1,13] := '180';
     StrGridShowResult.Cells[1,14] := '1';
     StrGridShowResult.Cells[1,15] := '0050';
     StrGridShowResult.Cells[1,16] := '0';
     StrGridShowResult.Cells[1,17] := '0';
     StrGridShowResult.Cells[1,18] := FormatFloat('0.00', Rec_TIVar2.HeadingTarget);
     StrGridShowResult.Cells[1,19] := FormatFloat('0.00', Rec_TIVar2.SpeedTarget);
     StrGridShowResult.Cells[1,20] := '0';
     StrGridShowResult.Cells[1,21] := '0';
  // ============================================================================ //
     StrGridShowResult.Cells[1,22] := formatDMS_lat(Rec_TIVar2.LattTarget);
     StrGridShowResult.Cells[1,23] := formatDMS_long(Rec_TIVar2.LongTarget);
     StrGridShowResult.Cells[1,24] := FloatToStr(Rec_TIVar2.MRSE_posTarget);
     StrGridShowResult.Cells[1,25] := FloatToStr(Rec_TIVar2.MRSE_headingTarget);
     StrGridShowResult.Cells[1,26] := FloatToStr(Rec_TIVar2.MRSE_speedTarget);
     StrGridShowResult.Cells[1,27] := FloatToStr(Rec_TIVar2.AgeingTimeDataTarget);
     StrGridShowResult.Cells[1,28] := IntToStr(Rec_TIVar2.TypeTarget);
     StrGridShowResult.Cells[1,29] := FloatToStr(Rec_TIVar2.CoreRadius);
     StrGridShowResult.Cells[1,30] := IntToStr(Rec_TIVar2.QuantityOfShipInCore);
     StrGridShowResult.Cells[1,31] := IntToStr(Rec_TIVar2.QuantityOfShipInFormation);
   end;

   for i := 0 to StrGridShowResult.ColCount - 1 do
      AutoSizeCol(StrGridShowResult, 1);
end;

procedure TfrmManualInput.setSGColumn3_Denomination;
var
   I : Integer;
   a : TRecTIVariant1;
   b : TRecTIVariant2;
begin
   StrGridShowResult.Cells[2,0] := '';
   StrGridShowResult.Cells[2,1] := 's';
   StrGridShowResult.Cells[2,2] := 'deg min sec';
   StrGridShowResult.Cells[2,3] := 'deg min sec';
   StrGridShowResult.Cells[2,4] := 'm';
   StrGridShowResult.Cells[2,5] := 'deg';
   StrGridShowResult.Cells[2,6] := 'm/s';
   StrGridShowResult.Cells[2,7] := 'm';
   StrGridShowResult.Cells[2,8] := 'm';
   StrGridShowResult.Cells[2,9] := 'm';
   StrGridShowResult.Cells[2,10] := 'm';
   StrGridShowResult.Cells[2,11] := 's';
   StrGridShowResult.Cells[2,12] := 'deg';
   StrGridShowResult.Cells[2,13] := 'deg';
   StrGridShowResult.Cells[2,14] := 'm/s';
   StrGridShowResult.Cells[2,15] := 'ms';
   StrGridShowResult.Cells[2,16] := 'km';
   StrGridShowResult.Cells[2,17] := 'deg';
   StrGridShowResult.Cells[2,18] := 'deg';
   StrGridShowResult.Cells[2,19] := 'm/s';
   StrGridShowResult.Cells[2,20] := 'km';
   StrGridShowResult.Cells[2,21] := 'deg';
// ============================================================================ //
   StrGridShowResult.Cells[2,22] := 'deg min sec';
   StrGridShowResult.Cells[2,23] := 'deg min sec';
   StrGridShowResult.Cells[2,24] := 'm';
   StrGridShowResult.Cells[2,25] := 'deg';
   StrGridShowResult.Cells[2,26] := 'm/s';
   StrGridShowResult.Cells[2,27] := 's';
   StrGridShowResult.Cells[2,28] := '';
   StrGridShowResult.Cells[2,29] := 'm';
   StrGridShowResult.Cells[2,30] := '';
   StrGridShowResult.Cells[2,31] := '';

   for i := 0 to StrGridShowResult.ColCount - 1 do
      AutoSizeCol(StrGridShowResult, 2);

   { cek record }
   {a.MovingCompTI := Rec_TIVar1.MovingCompTI;
   a.DistTarget := Rec_TIVar1.DistTarget;
   a.BearingTarget := Rec_TIVar1.BearingTarget;
   a.HeadingTarget := Rec_TIVar1.HeadingTarget;
   a.SpeedTarget := Rec_TIVar1.SpeedTarget;
   a.MRSE_distTarget := Rec_TIVar1.MRSE_distTarget;
   a.MRSE_bearingTarget := Rec_TIVar1.MRSE_bearingTarget;
   a.MRSE_headingTarget := Rec_TIVar1.MRSE_headingTarget;
   a.SpeedTarget := Rec_TIVar1.MRSE_speedTarget;
   a.AgeingTimeDataTarget := Rec_TIVar1.AgeingTimeDataTarget;
   a.TypeTarget := Rec_TIVar1.TypeTarget;
   a.CoreRadius := Rec_TIVar1.CoreRadius;
   a.QuantityOfShipInCore := Rec_TIVar1.QuantityOfShipInCore;
   a.QuantityOfShipInFormation := Rec_TIVar1.QuantityOfShipInFormation;

   b.MovingCompTI := Rec_TIVar2.MovingCompTI;
   b.LattTarget := Rec_TIVar2.LattTarget;
   b.LongTarget := Rec_TIVar2.LongTarget;
   b.MRSE_posTarget := Rec_TIVar2.MRSE_posTarget;
   b.HeadingTarget := Rec_TIVar2.HeadingTarget;
   b.Speedtarget := Rec_TIVar2.Speedtarget;
   b.MRSE_headingTarget := Rec_TIVar2.MRSE_headingTarget;
   b.MRSE_speedTarget := Rec_TIVar2.MRSE_speedTarget;
   b.AgeingTimeDataTarget := Rec_TIVar2.AgeingTimeDataTarget;
   b.TypeTarget := Rec_TIVar2.TypeTarget;
   b.CoreRadius := Rec_TIVar2.CoreRadius;
   b.QuantityOfShipInCore := Rec_TIVar2.QuantityOfShipInCore;
   b.QuantityOfShipInFormation := Rec_TIVar2.QuantityOfShipInFormation;   }
end;

procedure TfrmManualInput.AutoSizeCol(Grid: TStringGrid; Column: integer);
var
  i, W, WMax: integer;
begin
  WMax := 0;
  for i := 0 to (Grid.RowCount - 1) do begin
    W := Grid.Canvas.TextWidth(Grid.Cells[Column, i]);
    if W > WMax then
      WMax := W;
  end;
  Grid.ColWidths[Column] := WMax + 50;
end;

procedure TfrmManualInput.btnCheatClick(Sender: TObject);
begin
  typeOfVariant := 1;
  Rec_TIVar1.MovingCompTI              := 1;
  Rec_TIVar1.DistTarget                := 250*1000;
  YakhontManager.isTargetInRange := True;

  Rec_TIVar1.BearingTarget             := 180;
  Rec_TIVar1.HeadingTarget             := 200;
  Rec_TIVar1.SpeedTarget               := 54;
  Rec_TIVar1.MRSE_distTarget           := 15*1000;
  Rec_TIVar1.MRSE_bearingTarget        := 35;
  Rec_TIVar1.MRSE_headingTarget        := 15;
  Rec_TIVar1.MRSE_speedTarget          := 8;
  Rec_TIVar1.AgeingTimeDataTarget      := 1500;
  YakhontManager.isTimeAgeStart := True;
  fmMainMM.StartAgingTime := Now;

  YakhontManager.TimeAgeCount := 1500;
  Rec_TIVar1.TypeTarget                := 1;
  Rec_TIVar1.CoreRadius                := 10000;
  Rec_TIVar1.QuantityOfShipInCore      := 25;
  StrGridShowResult.Visible := False;

  Rec_TIVar1.QuantityOfShipInFormation := 25;
  setStringGrid;
  StrGridShowResult.Visible := True;

  with fmMainMM do
  begin
    pnlRTP.Caption   := 'RTP';
    pnlNext.Caption  := 'TI Accepted';
    lblType.Caption  := 'SSS';

    isCompletelyInsert := true;
    checkerButtonProcedure[1] := 1;
  end;
end;

procedure TfrmManualInput.btnExitClick(Sender: TObject);
var
  range : Double;
begin
  with fmMainMM do
  begin
    if isCompletelyInsert then
    begin
      if frmSelectionTI.currentSelectionTI = 3 then
      begin
        if typeOfVariant = 1  then
        begin
          if Rec_TIVar1.DistTarget > 19000 then
            YakhontManager.isDistMoreThan19 := True
          else
            YakhontManager.isDistMoreThan19 := False;
        end;

        if typeOfVariant = 2 then
        begin
          range := (CalcRange(YakhontManager.xShip.PositionX, YakhontManager.xShip.PositionY, Rec_TIVar2.longTarget , Rec_TIVar2.lattTarget)) * C_NauticalMiles_TO_Meter;
          if range > 19000 then
            YakhontManager.isDistMoreThan19 := True
          else
            YakhontManager.isDistMoreThan19 := False;
        end;

      end;
      StrGridShowResult.Visible := false;

      pnlNext.Caption  := 'SD';
      btnSD.Font.Color := clBlack;

      btnTI.Enabled := false;
    end
    else if frmSelectionTI.currentSelectionTI = 1 then
    begin
      typeOfVariant := 1;
      Rec_TIVar1.MRSE_distTarget           := 15*1000;
      Rec_TIVar1.MRSE_bearingTarget        := 35;
      Rec_TIVar1.MRSE_headingTarget        := 15;
      Rec_TIVar1.MRSE_speedTarget          := 8;
      Rec_TIVar1.AgeingTimeDataTarget      := 1500;
      YakhontManager.isTimeAgeStart        := True;
      fmMainMM.StartAgingTime              := Now;
      YakhontManager.TimeAgeCount          := 1500;
      Rec_TIVar1.TypeTarget                := 1;
      Rec_TIVar1.CoreRadius                := 10000;
      Rec_TIVar1.QuantityOfShipInCore      := 25;
      StrGridShowResult.Visible            := False;

      Rec_TIVar1.QuantityOfShipInFormation := 25;


      with fmMainMM do
      begin
        pnlRTP.Caption   := 'RTP';
        pnlNext.Caption  := 'TI Accepted';
        lblType.Caption  := 'SSS';

        isCompletelyInsert := true;
        checkerButtonProcedure[1] := 1;

        pnlNext.Caption  := 'SD';
        btnSD.Font.Color := clBlack;

        btnTI.Enabled := false;
      end;
    end;
  end;
  Close;
end;

end.
