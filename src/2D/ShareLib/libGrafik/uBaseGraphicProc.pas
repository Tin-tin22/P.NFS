unit uBaseGraphicProc;

(*
   -------------------------
   started    : 30 Juli 2007
   created by : Andy Sucipto.
*)

interface

uses
  Classes, Windows, Graphics;


const

  C_DefaultPixelFormat = pf24Bit;

//==============================================================================
type

  TPolygon = array of TPoint;

  PDWordArray = ^TDWordArray;
  TDWordArray = array[0..2047] of LongWord;

  TRgbArray = array[0..2047] of TRGBTriple;
  PRGBArray = ^TRgbArray;



//==============================================================================
  function PtToRect(const pt: TPoint; const rx, ry: integer): TRect;

  procedure OffsetPolygon(var aPoly : TPolygon; const aOff: TPoint);

//- Bitmap operation -----

  procedure BitmapFillBlack(bmp: TBitmap); overload
  procedure BitmapFillBlack(bmp: TBitmap; const x: integer;const y:integer;
                            const width: integer;const height: integer); overload

  procedure BitmapMultiply(bmp: TBitmap; const aAmt: single);
  procedure BitmapAdd(bmp: TBitmap; const aAmt: single);
  procedure BitmapSubstract(bmp: TBitmap; const aAmt: byte);

  procedure BitmapBlur(bmp: TBitmap);
  procedure BitmapNoise(bmp: TBitmap; const percentage: single; const maxColor: TColor);
  procedure BitmapNoiseLine(bmp: TBitmap; const y: integer;const percentage: single;
                            const maxColor: TColor; const maxLength: integer);
  procedure BitmapBlend(bmpDst: TBitmap;const leftdst: integer;const topdst:integer;
                        const bmpSrc: TBitmap;const leftsrc: integer;const topsrc:integer;
                        const srcWidth: integer;const srcHeight:integer;
                        const maxColor: TColor);

  procedure BitmapChangeMonochromeColor(bmp : TBitmap; const maxColor: TColor);
  procedure BitmapMonochromeFilter(bmp: TBitmap; const t : byte);

  procedure DestroyBitmap(var bmp: TBitmap);

  procedure DrawTransparent(aCnv: TCanvas; const r: TRect; const aValue: byte;
      var abmp :TBitmap);

  procedure DarkColor(var acl: TColor; const amt: byte);
  procedure LightColor(var acl: TColor; const amt: byte);

  procedure Bitmap_COPY(bSrc, bDst: TBitmap);

  procedure BitmapBlend_AVG(bSrc, bDst: TBitmap);
  procedure BitmapBlend_AND(bSrc, bDst: TBitmap);
  procedure BitmapBlend_MAX(bSrc, bDst: TBitmap);


implementation

uses
  SysUtils, Math;

procedure OffsetPolygon(var aPoly : TPolygon; const aOff: TPoint);
var i: integer;
begin
  for i := Low(aPoly) to HIGH(aPoly) do begin
    aPoly[i].X := aPoly[i].X + aOff.X;
    aPoly[i].Y := aPoly[i].Y + aOff.Y;
  end;

end;

//------------------------------------------------------------------------------
function PtToRect(const pt: TPoint; const rx, ry: integer): TRect;
begin
  with result do begin
    Left    := pt.x - rx;
    Right   := pt.x + rx;
    Top     := pt.y - ry;
    Bottom  := pt.y + ry;
  end;
end;

//------------------------------------------------------------------------------
procedure BitmapFillBlack(bmp: TBitmap);
var j, maxI : integer;
    pA : pByteArray;
begin
  maxI := (bmp.Width) * 3;
  for j := 0 to bmp.height-1 do begin
    pA := bmp.ScanLine[j];
    FillChar(pA[0], maxI, 0);
  end;
end;


procedure BitmapFillBlack(bmp: TBitmap; const x: integer;const y:integer;
                            const width: integer;const height: integer);
var j, maxI : integer;
    pA : pByteArray;
    xProc, yProc, widthProc, heightProc : integer;
begin
  //Assert(x < bmp.Width);
  if x < 0 then xProc := 0
  else xProc := x;
  //Assert(y < bmp.Height);
  if y < 0 then yProc := 0
  else yProc := y;
  //Assert(width > 0);
  if width+xProc > bmp.Width then widthProc := bmp.Width - xProc
  else widthProc := width;
  //Assert(height > 0);
  if height+yProc > bmp.Height then heightProc := bmp.Height - yProc
  else heightProc := height;

  if (x < bmp.Width) and (y < bmp.Height) and (width > 0) and (height > 0) then begin
    maxI := (widthProc) * 3;
    for j := yProc to yProc+heightProc-1 do begin
      pA := bmp.ScanLine[j];
      FillChar(pA[xProc*3], maxI, 0);
    end;
  end
  else
end;


procedure BitmapBlur(bmp: TBitmap);
var i,j, maxI : integer;
    pA,pB,pC : PByteArray;
begin
  j := 1;
  maxI := (bmp.Width) * 3 -1;

  while j < bmp.height-2 do begin
    pA := bmp.ScanLine[j-1];
    pB := bmp.ScanLine[j];
    pC := bmp.ScanLine[j+1];
    i := 3;
    while i< MaxI do  begin
      pB[i] := (       pA[i]
                +pB[i-3] +   pB[i+3]
                     + pC[i]   ) shr 2;
      inc(i);
    end;
    inc(j);
  end;
{ abot.
  //                    pA[i]
  //            +pB[i-3] + pB[I] + pB[i+3]
  //                     + pC[i]   ) div 5;

  //    pB[i] := (       pA[i]
  //              +pB[i-3] +   pB[i+3]
  //                   + pC[i]   ) shr 2;

  //    pB[i] := ( pA[i-3] + pA[i] + pA[i+3]
  //              +pB[i-3]         + pB[i+3]
  //              +pC[i-3] + pC[i] + pC[i+3]
  //                      ) shr 3;
}
end;

procedure BitmapMultiply(bmp: TBitmap; const aAmt: single);
{ mengalikan setiap pixel di bmp dengan aAmt;
  (--> contras) ;
  input : aAmt  (0.0 -- ???)
}
var i,j, maxI : integer;
    pA : pByteArray;
    s : single;
begin
  maxI := (bmp.Width) * 3;
  with bmp do begin
    PixelFormat := C_DefaultPixelFormat;
    if abs(aAmt) < 0.00001 then
      for j := 0 to height-1 do begin
        pA := ScanLine[j];
        FillChar(pA[0], maxI, 0);
      end
    else

    for j := 0 to Height-1 do begin
      pA := ScanLine[j];
      for i := 0 to maxI-1 do
        if (pA[i] <> 0) then begin
           s := pA[i]*aAmt;
           if s <= 0 then
             pA[i] := 0
           else if s >= 255 then
             pA[i] := 255
           else
             pA[i] := Round(s);
        end
    end; {for j}
  end; {with bmp}
end;

//------------------------------------------------------------------------------
procedure BitmapAdd(bmp: TBitmap; const aAmt: single);
{ menambahkan setiap pixel di bmp dengan aAmt;
   --> brighthess modifier;
  input : aAmt  (-255 .. +255)
}
var i,j, maxI : integer;
    pA : pByteArray;
    s : single;
begin
  if abs(aAmt) < 0.00001 then exit;

  maxI := (bmp.Width) * 3;
  with bmp do begin
    PixelFormat := C_DefaultPixelFormat;

    for j := 0 to Height-1 do begin
      pA := ScanLine[j];
      for i := 0 to maxI-1 do begin
        s := pA[i] + aAmt;
        if s <= 0 then
          pA[i] := 0
        else
          if s >= 255 then
            pA[i] := 255
          else
            pA[i] := Round(s);
      end;
    end; {for j}
  end; {with bmp}
end;

//------------------------------------------------------------------------------
procedure BitmapSubstract(bmp: TBitmap; const aAmt: byte);
{menggelapkan bitmap}
var i, j : word;
    w1: LongWord;
    maxH,  maxW : word;
    pRGB : PDWordArray;
begin
  asm
    mov al, aAmt;
    mov ah, al;
    mov dx, ax;
    shl eax, 16;
    mov ax, dx;
    movd mm1, EAX;
  end;

  bmp.PixelFormat := pf24bit;
  maxW := (bmp.Width * 3 div 4) - 1;
  maxH := bmp.Height - 1;
  for j := 0 to maxH do  begin
    pRGB := bmp.ScanLine[j];
    for i := 0 to maxW do begin
      w1 := pRGB[i];
      asm
        movd    mm0, w1;
        pSubUSB mm0, mm1;
        movd    w1, mm0;
      end;
      pRGB[i] := w1;
    end;

   end;
  asm
     emms;
  end;

end;
//------------------------------------------------------------------------------
procedure BitmapMonochromeFilter(bmp: TBitmap; const t : byte);
{ memfilter setiap pixel di bmp dengan t;
  pixel yang intensitas cahayanya dibawah t akan dihapus ;
  input : t  (1 .. +255)
}
var                 //asumsi max putih
  pA: pByteArray;
  x,y, lineSize: integer;
  rgbcounter : integer;
  highest : integer;
begin
  lineSize := (bmp.Width-1)*3;

  with bmp do begin
    for y := 0 to Bmp.Height-1 do begin
      pA := ScanLine[y];
      rgbcounter := 0;
      for x := 0 to lineSize-1 do begin
        if rgbcounter = 0 then begin  //blue
          highest := pA[x];
        end
        else if rgbcounter = 1 then begin //green
          if pA[x] > highest then highest := pA[x];
        end
        else begin //red
          if pA[x] > highest then highest := pA[x];  //intensity

          if highest < t then begin
            pA[x] := 0;
            pA[x-1] := 0;
            pA[x-2] := 0;
          end;
        end;
        inc(rgbcounter);
        if rgbcounter = 3 then rgbcounter := 0;
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
procedure BitmapNoise(bmp: TBitmap; const percentage: single; const maxColor: TColor);
{
  membuat random noise sebanyak percentage persen dari total pixel;
  maxColor untuk menentukan warna maksimum dari noise;
  hasil Bitmap monokrom;
}
var
  i : integer;
  numPx : integer;
  x,y : integer;
  pxColor : TColor;
  pA : pByteArray;
  r, g, b : integer;
begin
  with bmp do begin
    Randomize;
    numPx := floor((percentage * (Width * Height))/100.0);

    for i := 0 to numPx-1 do begin
      x := Random(Width-1);
      y := Random(Height-1);
      pxColor :=  maxColor;
      DarkColor(pxColor, random(254));
      r := pxColor and $ff;
      g := (pxColor shr 8)  and $000000ff;
      b := (pxColor shr 16) and $000000ff;

      pA := ScanLine[y];
      pA[x*3] := b;
      pA[(x*3)+1] := g;
      pA[(x*3)+2] := r;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure BitmapNoiseLine(bmp: TBitmap; const y: integer;const percentage: single;
                          const maxColor: TColor; const maxLength : integer);
var
  i,j : integer;
  randomVal : integer;
  x : integer;
  pxColor : TColor;
  pA : pByteArray;
  r, g, b : integer;
  randomwidth : integer;
begin
  with bmp do begin
    Randomize;
    randomVal := random(100);

    if randomVal < percentage then begin
      pA := ScanLine[y];
      pxColor :=  maxColor;
      DarkColor(pxColor, random(254));
      r := pxColor and $ff;
      g := (pxColor shr 8)  and $000000ff;
      b := (pxColor shr 16) and $000000ff;
      x := Random(Width-1);
      randomwidth := Random(maxLength);
      for j := x to x+randomwidth do begin
        pA[j*3] := b;
        pA[(j*3)+1] := g;
        pA[(j*3)+2] := r;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
procedure BitmapBlend(bmpDst: TBitmap;const leftdst: integer;const topdst:integer;
                        const bmpSrc: TBitmap;const leftsrc: integer;const topsrc:integer;
                        const srcWidth: integer;const srcHeight:integer;
                        const maxColor: TColor);
var
  pSrc, pDst: pByteArray;
  x,y, curXsrc, curXdst : integer;
  r, g, b : integer;
  width, height: integer;
  xsrc,ysrc,xdst,ydst : integer;
  addResult: integer;
begin
  //Assert(srcWidth <= bmpDst.Width-xdst,'source to large');
  //Assert(srcHeight <= bmpDst.Height-ydst,'source to large');
//  Assert(xsrc <= bmpSrc.Width-1,'x source out of bound');
//  Assert(ysrc <= bmpSrc.Height-1,'y source out of bound');
//  Assert(xdst <= bmpDst.Width-1,'x destination out of bound');
//  Assert(ydst <= bmpDst.Height-1,'y destination out of bound');
  //if (srcWidth <= bmpDst.Width-xdst) and (srcHeight <= bmpDst.Height-ydst) and
  //if (xsrc >= 0) and (ysrc >= 0) and (xdst >= 0) and (ydst >= 0) and
  if (leftsrc < 0) then xsrc := 0
  else xsrc := leftsrc;
  if (topsrc < 0) then ysrc := 0
  else ysrc := topsrc;
  if (leftdst < 0) then xdst := 0
  else xdst := leftdst;
  if (topdst < 0) then ydst := 0
  else ydst := topdst;
  if (xsrc <= bmpSrc.Width-1) and (ysrc <= bmpSrc.Height-1) and
     (xdst <= bmpDst.Width-1) and (ydst <= bmpDst.Height-1) then  begin
    r := maxColor and $ff;
    g := (maxColor shr 8)  and $000000ff;
    b := (maxColor shr 16) and $000000ff;
    if (srcWidth <= bmpDst.Width-xdst) then width := srcWidth
    else width := bmpDst.Width-xdst;
    if (srcHeight <= bmpDst.Height-ydst) then height := srcHeight
    else height := bmpDst.Height-ydst;
    for y := 0 to height-1 do begin
      pDst := bmpDst.ScanLine[ydst + y];
      pSrc := bmpSrc.ScanLine[ysrc + y];
      for x:= 0 to width-1 do begin
        curXsrc := (xsrc + x)*3; //blue
        curXdst := (xdst + x)*3;
        addResult := pDst[curXdst]+pSrc[curXsrc];
        if addResult > b then begin
          pDst[curXdst] := b;
        end
        else begin
          pDst[curXdst] := pDst[curXdst]+pSrc[curXsrc];
        end;
        curXsrc := ((xsrc + x)*3)+1; //green
        curXdst := ((xdst + x)*3)+1;
        addResult := pDst[curXdst]+pSrc[curXsrc];
        if addResult > g then begin
          pDst[curXdst] := g;
        end
        else begin
          pDst[curXdst] := pDst[curXdst]+pSrc[curXsrc];
        end;
        curXsrc := ((xsrc + x)*3)+2; //red
        curXdst := ((xdst + x)*3)+2;
        addResult := pDst[curXdst]+pSrc[curXsrc];
        if addResult > r then begin
          pDst[curXdst] := r;
        end
        else begin
          pDst[curXdst] := pDst[curXdst]+pSrc[curXsrc];
        end;
      end;
    end;
  end;
end;

procedure BitmapChangeMonochromeColor(bmp : TBitmap; const maxColor: TColor);
var                 //asumsi max putih
  pA: pByteArray;
  x,y, lineSize: integer;
  r, g, b : integer;
  rgbcounter : integer;
  highest : integer;
  curColor : TColor;
begin
  lineSize := (bmp.Width-1)*3;

  with bmp do begin
    for y := 0 to Bmp.Height-1 do begin
      pA := ScanLine[y];
      rgbcounter := 0;
      for x := 0 to lineSize-1 do begin
        if rgbcounter = 0 then begin  //blue
          highest := pA[x];
        end
        else if rgbcounter = 1 then begin //green
          if pA[x] > highest then highest := pA[x];
        end
        else begin //red
          if pA[x] > highest then highest := pA[x];

          curColor := maxColor;
          DarkColor(curColor,255-highest);
          r := curColor and $ff;
          g := (curColor shr 8)  and $000000ff;
          b := (curColor shr 16) and $000000ff;
          pA[x] := r;
          pA[x-1] := g;
          pA[x-2] := b;
        end;
        inc(rgbcounter);
        if rgbcounter = 3 then rgbcounter := 0;
      end;
    end;
  end;
end;

//======================================================================== //
  { implement global function }
procedure DestroyBitmap(var bmp: TBitmap);
begin
  Bmp.Width := 0;
  Bmp.Height := 0;
  Bmp.Dormant;             // Free up GDI resources
  Bmp.FreeImage;           // Free up Memory.
  Bmp.ReleaseHandle;       // Free up Handle.

  Bmp.Free;
  Bmp := nil;
end;

procedure DrawTransparent(aCnv: TCanvas; const r: TRect; const aValue: byte;
      var abmp :TBitmap);
var rW, rH : integer;
    blen: BLENDFUNCTION;
begin
  rW := r.Right  - r.Left;
  rH := r.Bottom - r.Top;

  with blen do begin
    BlendOp     := AC_SRC_OVER;
    BlendFlags  := 0;
    AlphaFormat := 0; // AC_SRC_ALPHA ;
    SourceConstantAlpha := aValue;
  end;

  Windows.AlphaBlend(aCnv.handle, r.Left,  r.Top,  rw,  rH,
    abmp.Canvas.Handle,  0,  0,  rw,  rh,  blen);
end;

procedure LightColor(var acl: TColor; const amt: byte);
asm
  movd mm0, dword ptr[eax];
  push ebx;
  mov dh, dl;
  mov bx, dx;
  shl edx, 16;
  and edx, $00FFFFFF;
  mov dx, bx;
  movd mm1, edx;
  paddusb mm0,mm1;
  pop ebx;
  movd dword ptr[eax], mm0;
  emms;
end;

procedure DarkColor(var acl: TColor; const amt: byte);
asm
  movd mm0, dword ptr[eax];
  push ebx;
  mov dh, dl;
  mov bx, dx;
  shl edx, 16;
  and edx, $00FFFFFF;
  mov dx, bx;
  movd mm1, edx;
  psubusb mm0,mm1;
  pop ebx;
  movd dword ptr[eax], mm0;
  emms;
end;
procedure Bitmap_COPY(bSrc, bDst: TBitmap);
var i, j : word;
    maxH,  maxW : word;
    pSRC, pDST : PDWordArray;
begin
  maxH := Max(bSrc.Height, bDst.Height) -1;
  maxW := (Max(bSrc.Width, bDst.Width) * 3 div 4) -1;
  bSrc.PixelFormat := pf24bit;
  bDst.PixelFormat := pf24Bit;

  for j := 0 to maxH do  begin
    pSRC := bSrc.ScanLine[j];
    pDST := bDst.ScanLine[j];
    for i := 0 to maxW do
      pDST[i] := pSrc[i];
   end;
end;


procedure BitmapBlend_AVG(bSrc, bDst: TBitmap);
var i, j : word;
    w1, w2: LongWord;
    maxH,  maxW : word;
    pSRC, pDST : PDWordArray;
begin
  maxH := Max(bSrc.Height, bDst.Height) -1;
  maxW := (Max(bSrc.Width, bDst.Width) * 3 div 4) -1;
  bSrc.PixelFormat := pf24bit;
  bDst.PixelFormat := pf24Bit;

  for j := 0 to maxH do  begin
    pSRC := bSrc.ScanLine[j];
    pDST := bDst.ScanLine[j];
    for i := 0 to maxW do begin
      w1 := pDst[i];
      w2 := pSrc[i];
      asm
        movd    mm0, w1;
        movd    mm1, w2;
        pAVGB mm0, mm1;
//        pAddUSB mm0, mm1;
        movd    w1, mm0;
      end;
      pDST[i] := w1;
    end;
   end;
  asm
     emms;
  end;

end;

procedure BitmapBlend_AND(bSrc, bDst: TBitmap);
var i, j : word;
    w1, w2: LongWord;
    maxH,  maxW : word;
    pSRC, pDST : PDWordArray;
begin
  maxH := Max(bSrc.Height, bDst.Height) -1;
  maxW := (Max(bSrc.Width, bDst.Width) * 3 div 4) -1;
  bSrc.PixelFormat := pf24bit;
  bDst.PixelFormat := pf24Bit;

  for j := 0 to maxH do  begin
    pSRC := bSrc.ScanLine[j];
    pDST := bDst.ScanLine[j];
    for i := 0 to maxW do begin
      w1 := pDst[i];
      w2 := pSrc[i];
      asm
        movd    mm0, w1;
        movd    mm1, w2;
        pAND mm0, mm1;
        movd    w1, mm0;
      end;
      pDST[i] := w1;
    end;
   end;
  asm
     emms;
  end;

end;

procedure BitmapBlend_MAX(bSrc, bDst: TBitmap);
var i, j : word;
    w1, w2: LongWord;
    maxH,  maxW : word;
    pSRC, pDST : PDWordArray;
begin
  maxH := Max(bSrc.Height, bDst.Height) -1;
  maxW := (Max(bSrc.Width, bDst.Width) * 3 div 4) -1;
  bSrc.PixelFormat := pf24bit;
  bDst.PixelFormat := pf24Bit;

  for j := 0 to maxH do  begin
    pSRC := bSrc.ScanLine[j];
    pDST := bDst.ScanLine[j];
    for i := 0 to maxW do begin
      w1 := pDst[i];
      w2 := pSrc[i];
      asm
        movd    mm0, w1;
        movd    mm1, w2;
        pmaxub mm0, mm1;
        movd    w1, mm0;
      end;
      pDST[i] := w1;
    end;
   end;
  asm
     emms;
  end;

end;


end.
