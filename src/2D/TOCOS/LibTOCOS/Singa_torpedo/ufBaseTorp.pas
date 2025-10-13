unit ufBaseTorp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, SpeedButtonImage, uLibTDCClass;

type
  TfrmBaseTorp = class(TForm)
    ilBlueBox: TImageList;
    ilGreenBox: TImageList;
    ilOrangeBox: TImageList;
    ilRedBox: TImageList;
    ilGreenRound: TImageList;
    ilOrangeRound: TImageList;
    ilRedRound: TImageList;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
     //procedure LoadImageFile(fName: string; imgL: TImageList);
     //procedure UpdateSpeedBtn;
  public
     image_path : string;
     TDCInterface : TGenericTDCInterface;

     //procedure LoadImageList; virtual;
     //procedure SetLocalVariable(tdc :TGenericTDCInterface); virtual;
  end;

var
  frmBaseTorp: TfrmBaseTorp;

implementation

{$R *.dfm}

procedure TfrmBaseTorp.FormCreate(Sender: TObject);
begin
  {image_path := ExtractFilePath(Application.ExeName) + 'images\';

  LoadImageList;

  UpdateSpeedBtn; }
end;

end.
