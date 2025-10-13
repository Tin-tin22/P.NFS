unit ufAScope;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  uAScopeDisplay, uBaseConstan;

type
  TfrmAScope = class(TForm)
    m1: TPanel;
    mPanel: TPanel;
    lmpimg1: TImage;
    lbl15: TLabel;
    procedure FormCreate(Sender: TObject);
  protected
    ScopeView : TAScopeDisplay;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowItem(const aMark: TASMark; const posx: double; const IsLower: boolean);
    procedure ClearView;
  end;

implementation

uses
  uTDCConstan;

{$R *.dfm}

procedure TfrmAScope.FormCreate(Sender: TObject);
begin
  DoubleBuffered := TRUE;

  ScopeView := TAScopeDisplay.Create(Self.mPanel);
  ScopeView.Parent := Self.mPanel;
  ScopeView.Left := 0;
  ScopeView.Top := 0;
  ScopeView.Width := self.mPanel.Width;
  ScopeView.Height := self.mPanel.Height;

  ScopeView.SetMapBoundary(0,1,1,0);
  //ScopeView.CenterX := 1.0; //0.7
  //ScopeView.CenterY := 1.0; //0.4
  ScopeView.BackgroundColor := clBlack;
  ScopeView.LineColor := RGB(00,60,00);  // clLime; // clLtGray;
  ScopeView.MarkerColor := clblack;
  ScopeView.Visible := true;
  ScopeView.TransparentBackground := false;

  ScopeView.DrawLines := ScopeView.GambarGaris;

  self.Left := 0;
  self.Top := 0;
end;

procedure TfrmAScope.ShowItem(const aMark: TASMark; const posx: double; const IsLower: boolean);
var fName : String;
begin
  case aMark of
    tamNone     : fName := '';
    tamBGate    : fName := C_IMAGES_PATH + 'BGate.bmp';
    tamBGateEcho: fName := C_IMAGES_PATH + 'BGateEcho.bmp';
    tamNGate    : fName := C_IMAGES_PATH + 'NGate.bmp';
    tamEcho     : fName := C_IMAGES_PATH + 'Echo.bmp';
  end;
  if IsLower then begin
    ScopeView.AddItem('lower', posx, 1/3,fName,clLime);
  end
  else begin
    ScopeView.AddItem('upper', posx, 2/3,fName,clLime); //clGray
  end;

  self.mPanel.Repaint;
end;

procedure TfrmAScope.ClearView;
begin
  ScopeView.ClearItems;
end;

end.
