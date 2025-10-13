unit uFormUtil;

interface

uses
  Forms, Classes;


type
  TAlignPos = (apNone, apLeftTop, apRightTop, apLeftBottom, apRightBottom, apCenter, apCenterBottom);

  TVerticalAlign   = (vaNone, vaTop, vaCenter, vaBottom);
  THorizontalAlign = (haNone, haLeft, haCenter, haRight);

  procedure AlignFormToMonitor(const monNum: byte;
    const aPos: TAlignPos;
    const offX, offY: integer; var frm: Tform);


  procedure PlaceFormToMonitor(const monNum: byte;
    const hAlign: THorizontalAlign;
    const vAlign: TVerticalAlign;
    const offX, offY: integer; var frm: Tform);

  function  CreateForm_(const fclass: TComponentClass; var f: TForm) : TForm;

  procedure HideTaskbar;
  procedure showTaskbar;

implementation

uses Types, SysUtils, windows;



procedure AlignFormToMonitor(const monNum: byte;
 const aPos: TAlignPos;
 const offX, offY: integer; var frm: Tform);
begin
  if frm = nil then exit;
  frm.DefaultMonitor := dmDesktop;
  case aPos of
    apLeftTop    : begin
      frm.Left := offX + Screen.Monitors[monNum].BoundsRect.Left;
      frm.Top  := offY + Screen.Monitors[monNum].BoundsRect.Top;
    end;
    apRightTop    : begin
      frm.Left  := offX + Screen.Monitors[monNum].BoundsRect.Right - frm.Width;
      frm.Top   := offY + Screen.Monitors[monNum].BoundsRect.Top;
    end;
    apLeftBottom    : begin
      frm.Left  := offX + Screen.Monitors[monNum].BoundsRect.Left;
      frm.Top   := offY + Screen.Monitors[monNum].BoundsRect.Bottom - frm.Height;
    end;
    apRightBottom    : begin
      frm.Left  := offX + Screen.Monitors[monNum].BoundsRect.Right - frm.Width;
      frm.Top   := offY + Screen.Monitors[monNum].BoundsRect.Bottom - frm.Height;
    end;
    apCenter        : begin
      frm.Left  := offX + ((Screen.Monitors[monNum].WorkareaRect.Right - Screen.Monitors[monNum].WorkareaRect.Left) div 2) - (frm.Width div 2);
      frm.Top   := offY + ((Screen.Monitors[monNum].WorkareaRect.Bottom - Screen.Monitors[monNum].WorkareaRect.Top) div 2) - (frm.Height div 2);
    end;
    apCenterBottom  : begin
      frm.Left  := offX + ((Screen.Monitors[monNum].WorkareaRect.Right - Screen.Monitors[monNum].WorkareaRect.Left) div 2) - (frm.Width div 2);
      frm.Top   := offY + Screen.Monitors[monNum].WorkareaRect.Bottom - frm.Height;
    end;
  end;
end;

  procedure PlaceFormToMonitor(const monNum: byte;
    const hAlign: THorizontalAlign;
    const vAlign: TVerticalAlign;
    const offX, offY: integer; var frm: Tform);
var
  setNum : byte;
begin
  if frm = nil then exit;
  frm.DefaultMonitor := dmPrimary;

  setNum := monNum;
  if monNum >= Screen.MonitorCount
    then setNum := Screen.MonitorCount-1;

  with Screen.Monitors[setNum].WorkareaRect do
  case hAlign of
    haLeft   :
      frm.Left := offX + Left ;
    haRight  :
      frm.Left  := offX + Right - frm.Width;
    haCenter :
      frm.Left  := offX + Left + ((Right - Left) div 2) - (frm.Width div 2);
  end;

  with Screen.Monitors[setNum].WorkareaRect do
  case vAlign of
     vaTop    :
      frm.Top  := offY + Top;
     vaCenter :
      frm.Top   := offY + Top + ((Bottom - Top) div 2) - (frm.Height div 2);
     vaBottom :
      frm.Top   := offY + Bottom  - frm.Height;
  end;
end;

  function  CreateForm_(const fclass: TComponentClass; var f: TForm) : TForm;
  begin
    if not assigned(f) then
      Application.CreateForm(fclass, f);
    result := f;
  end;


procedure HideTaskbar;
var
  wndHandle: THandle;
  wndClass: array[0..50] of Char;
begin
  StrPCopy(@wndClass[0], 'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  ShowWindow(wndHandle, SW_HIDE);
end;

procedure showTaskbar;
var
  wndHandle: THandle;
  wndClass: array[0..50] of Char;
begin
  StrPCopy(@wndClass[0], 'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  ShowWindow(wndHandle, SW_RESTORE);
end;


end.
