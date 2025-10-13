unit uHelper;

interface

uses
  System.SysUtils,
  Grijjy.Bson,
  Grijjy.Bson.IO,
  Grijjy.Bson.Serialization,
  uDataType;

type
  TComposer = class
    class function ComposePacket<T>(var PacketHeader: TPacketHeader;
      data: T): TBytes;
    class procedure DecomposePacket(Packet: TBytes; var packetHeader: TPacketHeader;
    var data: string);
  end;

implementation

class function TComposer.ComposePacket<T>(var PacketHeader: TPacketHeader;
  data: T): TBytes;
begin
  var jd: string;
  TgoBsonSerializer.Serialize<T>(data, TgoJsonWriterSettings.Default, jd);

  var p: TCommPacket;
  p.Header:= PacketHeader;
  //p.Content:= TEncoding.UTF8.GetBytes(jd);
  p.Content:= jd;

  var r: string;
  TgoBsonSerializer.Serialize<TCommPacket>(p, TgoJsonWriterSettings.Default, r);
  Result:= TEncoding.UTF8.GetBytes(r);
end;

class procedure TComposer.DecomposePacket(Packet: TBytes; var packetHeader: TPacketHeader;
  var data: string);
begin
  var p: TCommPacket;
  TgoBsonSerializer.Deserialize<TCommPacket>(TEncoding.UTF8.GetString(Packet), p);
  packetHeader:= p.Header;
  data:= p.Content;
end;

end.
