unit uLibSound; //wrapper of BASS

interface

uses
  Bass, Windows, SysUtils, Math;

type
  ChannelData = record
    UID : String;
    SoundFName : String;
    handle : HStream;
  end;

  TSoundPlayer = class
  private
    strs: array[0..128] of ChannelData;
    strc : integer;
    Handle : HWND;
    FDistFactor : double;
    FMaxDistance : double;
    FListenerPos : BASS_3DVECTOR;
    FListenerOrient : BASS_3DVECTOR;
    FListenerVel : BASS_3DVECTOR;
    FVolume: integer;

    procedure Error(msg: string);
    procedure SetVolume(const Value: integer);
  public
    constructor Create(const winHandle: HWND);
    procedure Setup2D(const UnitOfLength: string; const maxDistance : double);
    procedure SetListener2DPos(const posx: double;const posy:double;
      const facingDeg: double;const vel : double); //posx,posy : units; facing : cartesian degree; vel : units/s
    function PlayMP3(const UID:string; const FileName: string;
      const Volume: integer;const loop : boolean): Boolean;
    function Play2DMP3(const UID:string; const FileName: string;
      const posx: double;const posy:double;const speed:double;
      const Volume : integer;const loop : boolean): Boolean;   //posx +ve = right, -ve = left;posy +ve = front, -ve = behind.
    function PauseMP3(const UID:string; const FileName: string): Boolean;
    function StopMP3(const UID:string; const FileName: string): Boolean;
    procedure StopAllMP3;
    procedure MuteAllMP3;
    procedure ClearAllMP3;
    function GetMP3ChannelData(const UID: string): byte;
    function isMP3Playing(const UID: string; const fname: string):boolean;
  published
    property Volume: integer read FVolume write SetVolume;
  end;

implementation

{ TSoundPlayer }

constructor TSoundPlayer.Create(const winHandle: HWND);
begin
  strc := 0;
  Handle := winHandle;
  FDistFactor := 1;
  FMaxDistance := 100000.0;
  // Initialize audio - default device, 44100hz, stereo, 16 bits
	if not BASS_Init(-1, 44100, BASS_DEVICE_3D, winHandle, nil) then
		Error('Error initializing audio!');
end;

procedure TSoundPlayer.Error(msg: string);
var
	s: string;
begin
	s := msg + #13#10 + '(Error code: ' + IntToStr(BASS_ErrorGetCode) + ')';
	MessageBox(Handle, PChar(s), 0, 0);
end;

function TSoundPlayer.PlayMP3(const UID:string; const FileName: string;
  const Volume: integer;const loop : boolean): Boolean;
var
	f: PChar;
  i: integer;
  soundIndex : integer;
  newSound : boolean;
  freq,vol : Cardinal;
  pan : integer;
  mode : Cardinal;
begin
  BASS_Start;
  newSound := true;
  soundIndex := strc;

  for i := 0 to 128 do begin
    if strs[i].UID = UID then begin
      if strs[i].SoundFName = FileName then begin
        newSound := false;
        soundIndex := i;
        break;
      end;
    end;
  end;

  if newSound then begin
    f := PChar(FileName);
    if loop then mode := BASS_SAMPLE_LOOP
    else mode := 0;
    strs[soundIndex].handle := BASS_StreamCreateFile(False, f, 0, 0, mode);
    if strs[soundIndex].handle <> 0 then
    begin
      strs[soundIndex].UID := UID;
      strs[soundIndex].SoundFName := FileName;
      Inc(strc);
      if strc > 128 then strc := 0;
    end
    Else Error('file not opened')

  end;

  BASS_ChannelGetAttributes(strs[soundIndex].handle,freq,vol,pan);
  if vol <> Volume then begin
    BASS_ChannelSetAttributes(strs[soundIndex].handle,freq,Volume,pan);

    if BASS_ChannelIsActive(strs[soundIndex].handle) <> BASS_ACTIVE_PLAYING then
      Result := BASS_ChannelPlay(strs[soundIndex].handle, true)
    else
      Result := BASS_ChannelPlay(strs[soundIndex].handle, false)
  end
  else begin
    if BASS_ChannelIsActive(strs[soundIndex].handle) <> BASS_ACTIVE_PLAYING then
      Result := BASS_ChannelPlay(strs[soundIndex].handle, true);
  end;
end;

procedure TSoundPlayer.StopAllMP3;
var
  i: integer;
begin
  for i := 0 to 128 do begin
    if strs[i].handle <> 0 then
      BASS_ChannelStop(strs[i].handle);
  end;
  BASS_Pause;
end;

function TSoundPlayer.GetMP3ChannelData(const UID: string): byte;
var
  buf : array [0 .. 5] of byte;
  i, index : integer;
  total : integer;
begin
  //get data for oscilloscope
  index := 0;
  for i := 0 to 128 do begin
    if (strs[i].UID = UID) then begin
      if BASS_ChannelIsActive(strs[i].handle) = BASS_ACTIVE_PLAYING then begin
        index := i;
        break;
      end;
    end;
  end;

  if strs[index].handle <> 0 then begin
    BASS_ChannelGetData(strs[index].handle,@buf,SizeOf(buf));
  end;

  total := 0;
  for i := 0 to 5 do begin
    total := total + buf[i];
  end;

  Result := round(total/length(buf));
end;

function TSoundPlayer.Play2DMP3(const UID, FileName: string; const posx,
  posy: double;const speed:double;const Volume : integer;
  const loop : boolean): Boolean;
var
	f: PChar;
  i: integer;
  soundIndex : integer;
  newSound : boolean;
  pos, orient, vel : BASS_3DVECTOR;
  info : BASS_CHANNELINFO;
  deg : double;
  freq,vol : Cardinal;
  pan : integer;
  mode : Cardinal;
begin
  BASS_Start;
  newSound := true;
  soundIndex := strc;

  for i := 0 to 128 do begin
    if strs[i].UID = UID then begin
      if strs[i].SoundFName = FileName then begin
        newSound := false;
        soundIndex := i;
        break;
      end;
    end;
  end;

  if newSound then begin
    f := PChar(FileName);
    if loop then mode := BASS_SAMPLE_3D or BASS_SAMPLE_LOOP
    else mode := BASS_SAMPLE_3D;
    strs[soundIndex].handle := BASS_StreamCreateFile(False, f, 0, 0, mode);
    if strs[soundIndex].handle <> 0 then
    begin
      strs[soundIndex].UID := UID;
      strs[soundIndex].SoundFName := FileName;
      Inc(strc);
      if strc > 128 then strc := 0;
      if not BASS_ChannelGetInfo(strs[soundIndex].handle,info) then
        Error('ChannelGetInfo');
      if (info.flags and BASS_SAMPLE_3D) = 0  then begin
        Error('3D sound not supported');
        exit;
      end;
      if not BASS_Set3DFactors(FDistFactor,1.0,1.0) then
        Error('Set3DFactor');
      if not BASS_ChannelSet3DAttributes(strs[soundIndex].handle,
        BASS_3DMODE_RELATIVE,0,FMaxDistance,-1,-1,0) then
        Error('SetChannel3DAttributes');
    end
    Else Error('file not opened')
  end;

  if strs[soundIndex].handle <> 0 then begin
    if not BASS_ChannelGet3DPosition(strs[soundIndex].handle,pos,orient,vel) then
      Error('GetChannel3DPos');
    pos.x := posx; //0 .. 1
    pos.y := 0;
    pos.z := posy; //0 .. 1
    deg := ArcTan(posy/posx);
    vel.x := speed * Cos(deg);
    vel.y := 0;
    vel.z := speed * Sin(deg);
    if not BASS_ChannelSet3DPosition(strs[soundIndex].handle,pos,orient,vel) then
      Error('SetChannel3DPos');
    BASS_Apply3D;

    BASS_ChannelGetAttributes(strs[soundIndex].handle,freq,vol,pan);
    if vol <> Volume then begin
      BASS_ChannelSetAttributes(strs[soundIndex].handle,freq,Volume,pan);

      if BASS_ChannelIsActive(strs[soundIndex].handle) <> BASS_ACTIVE_PLAYING then
        Result := BASS_ChannelPlay(strs[soundIndex].handle, true)
      else
        Result := BASS_ChannelPlay(strs[soundIndex].handle, false)
    end
    else begin
      if BASS_ChannelIsActive(strs[soundIndex].handle) <> BASS_ACTIVE_PLAYING then
        Result := BASS_ChannelPlay(strs[soundIndex].handle, true);
    end;
  end;
  {
  if BASS_ChannelIsActive(strs[soundIndex].handle) = 0 then
    Result := BASS_ChannelPlay(strs[soundIndex].handle, true)
  else
    Result := BASS_ChannelPlay(strs[soundIndex].handle, false)
  }
end;

procedure TSoundPlayer.Setup2D(const UnitOfLength: string;
  const maxDistance: double);
begin
  if UnitOfLength = 'm' then
    FDistFactor := 1.0
  else if UnitOfLength = 'yd' then
    FDistFactor := 0.9144
  else if UnitOfLength = 'ft' then
    FDistFactor := 0.3048
  else if UnitOfLength <> '' then begin
    try
      FDistFactor := StrToFloat(UnitOfLength);
    except
      on E: Exception do Error(E.Message);
    end;
  end;

  FMaxDistance := maxDistance;
end;

procedure TSoundPlayer.SetListener2DPos(const posx, posy, facingDeg,
  vel: double);
var
  ListenerPos,ListenerVel,ListenerOrient,Top : BASS_3DVECTOR;
begin
  //set listener position at [posx,0,posy],
  //facing [cos(facingDeg),0,sin(facingDeg)]
  //and forward velocity
  if FMaxDistance > 0 then begin
    if not BASS_Get3DPosition(ListenerPos,ListenerVel,ListenerOrient,Top) then
      Error('Get3DPos');
    FListenerPos.x := posx/FMaxDistance; //+ve = right, -ve = left.
    FListenerPos.y := 0;    //+ve = up, -ve = down.
    FListenerPos.z := posy/FMaxDistance; //+ve = front, -ve = behind.

    FListenerOrient.x := cos(DegToRad(facingDeg));
    FListenerOrient.y := 0;
    FListenerOrient.z := sin(DegToRad(facingDeg));

    FListenerVel.x := vel*cos(DegToRad(facingDeg));
    FListenerVel.x := 0;
    FListenerVel.x := vel*sin(DegToRad(facingDeg));

    if not BASS_Set3DPosition(FListenerPos,FListenerVel,FListenerOrient,Top) then
      Error('Set3DPos');
  end;
end;

procedure TSoundPlayer.SetVolume(const Value: integer);
begin
  FVolume := Value;
  BASS_SetVolume(Value);
end;

procedure TSoundPlayer.MuteAllMP3;
var
  i: integer;
  freq,vol : Cardinal;
  pan : integer;
begin
  for i := 0 to 128 do begin
    if strs[i].handle <> 0 then begin
      BASS_ChannelGetAttributes(strs[i].handle,freq,vol,pan);
      BASS_ChannelSetAttributes(strs[i].handle,freq,0,pan);
    end;
  end;
end;

function TSoundPlayer.isMP3Playing(const UID, fname: string): boolean;
var
  i: integer;
  found : boolean;
begin
  //is the sound playing ?
  found := false;
  for i := 0 to 128 do begin
    if strs[i].UID = UID then begin
      if strs[i].SoundFName = fname then begin
        if BASS_ChannelIsActive(strs[i].handle) = BASS_ACTIVE_PLAYING then begin
          found := true;
        end
        else begin
          found := false;
        end;
        break;
      end;
    end;
  end;
  Result := found;
end;

procedure TSoundPlayer.ClearAllMP3;
var
  i: integer;
begin
  for i := 0 to 128 do begin
    if strs[i].handle <> 0 then begin
      BASS_ChannelStop(strs[i].handle);
      if BASS_StreamFree(strs[i].handle) then begin
        strs[i].handle := 0;
        strs[i].UID := '';
        strs[i].SoundFName := '';
      end;
    end;
  end;
  BASS_Pause;
end;

function TSoundPlayer.PauseMP3(const UID, FileName: string): Boolean;
var
  i: integer;
  played : boolean;
begin
  //DONE : pause a sound, start using play
  played := false;
  for i := 0 to 128 do begin
    if strs[i].UID = UID then begin
      if strs[i].SoundFName = FileName then begin
        if BASS_ChannelPAUSE(strs[i].handle) then begin
          played := true;
        end;
        break;
      end;
    end;
  end;
  Result := played;
end;

function TSoundPlayer.StopMP3(const UID, FileName: string): Boolean;
var
  i: integer;
  played : boolean;
begin
  //DONE : stop sound, start using play
  played := false;
  for i := 0 to 128 do begin
    if strs[i].UID = UID then begin
      if strs[i].SoundFName = FileName then begin
        if BASS_ChannelStop(strs[i].handle) then begin
          played := true;
        end;
        break;
      end;
    end;
  end;
  Result := played;
end;

end.
