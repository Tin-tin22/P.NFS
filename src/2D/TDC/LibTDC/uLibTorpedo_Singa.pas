unit uLibTorpedo_Singa;

interface

uses
  uLibTDCClass, uMainCtrlPanel, uDisplaySinga, uTechnicalCtrlPanel,
  uDisplayCtrlPanelLeft, uDisplayCtrlPanelBottom;

type

//==============================================================================
  TTorpedoInterface = class (TGenericTDCInterface)
  protected

  public
    vDisplay : TfrmLPDTorpedo;
    vMainCtrlPanel: TvMainCtrlPanel;
    vTechnicalCtrlPanel: TvTechnicalCtrlPanel;
    vDisplayCtrlPanelLeft: TvDisplayCtrlPanelLeft;
    vDisplayCtrlPanelBottom: TvDisplayCtrlPanelBottom;



    constructor Create;
    destructor Destroy; override;

    procedure ShowAllForm; override;



  end;

implementation

uses
  SysUtils, uFormUtil;

//==============================================================================
{ TTDC_NalaInterface }


constructor TTorpedoInterface.Create;
begin
  inherited;

  frmTengah  :=  TfrmLPDTorpedo.Create(nil);
  (frmTengah as TfrmLPDTorpedo).TDCInterface := self;
  frmTengah.Caption := ' Torpedo Control Console ';

  vDisplay := frmTengah as TfrmLPDTorpedo;

  vMainCtrlPanel   := TvMainCtrlPanel.Create(nil);
  vMainCtrlPanel.SetLocalVariable(self);
  vMainCtrlPanel.Show;

  vTechnicalCtrlPanel := TvTechnicalCtrlPanel.Create(nil);
  vTechnicalCtrlPanel.SetLocalVariable(self);
  vTechnicalCtrlPanel.Show;

  vDisplayCtrlPanelLeft := TvDisplayCtrlPanelLeft.Create(nil);
  vDisplayCtrlPanelLeft.SetLocalVariable(self);
  vDisplayCtrlPanelLeft.Show;

  vDisplayCtrlPanelBottom := TvDisplayCtrlPanelBottom.Create(nil);
  vDisplayCtrlPanelBottom.SetLocalVariable(self);
  vDisplayCtrlPanelBottom.Show;

  FC1 := TFireControl.Create;
  FC1.Name := 'FC1';
  FC2 := TFireControl.Create;
  FC2.Name := 'FC2';
  FC3 := TFireControl.Create;
  FC3.Name := 'FC3';
  FC4 := TFireControl.Create;
  FC4.Name := 'FC4';

end;

destructor TTorpedoInterface.Destroy;
begin
  FreeAndNil(FC1);
  FreeAndNil(FC2);
  FreeAndNil(FC3);
  FreeAndNil(FC4);

  if Assigned(frmTengah) then  FreeAndNil(frmTengah);

  if Assigned(vMainCtrlPanel) then  FreeAndNil(vMainCtrlPanel);
  if Assigned(vTechnicalCtrlPanel) then  FreeAndNil(vTechnicalCtrlPanel);
  if Assigned(vDisplayCtrlPanelLeft  ) then FreeAndNil(vDisplayCtrlPanelLeft);
  if Assigned(vDisplayCtrlPanelBottom) then FreeAndNil(vDisplayCtrlPanelBottom);
  inherited;
end;



procedure TTorpedoInterface.ShowAllForm;
begin
  //inherited;

    if Assigned(vDisplay               ) then vDisplay.Show;
    if Assigned(vMainCtrlPanel         ) then vMainCtrlPanel.Show;
    if Assigned(vTechnicalCtrlPanel    ) then vTechnicalCtrlPanel.Show;
    if Assigned(vDisplayCtrlPanelLeft  ) then vDisplayCtrlPanelLeft.Show;
    if Assigned(vDisplayCtrlPanelBottom) then vDisplayCtrlPanelBottom.Show;

end;

end.
