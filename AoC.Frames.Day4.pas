unit AoC.Frames.Day4;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts;

type
  TfmDayFour = class(TFrame)
    Layout1: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Layout2: TLayout;
    Button1: TButton;
    Label2: TLabel;
    Layout3: TLayout;
    Button2: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

implementation

uses
  FMX.Platform,
  System.Hash;

{$R *.fmx}

procedure DoCalc(const aSecretKey: string; aNumZeroes: Integer; aOutputLabel: TLabel);
var
  lClipSvc: IFMXClipboardService;
  lIntCode: NativeUInt;
  lMD5: string;
  lZeroes: string;
begin
  lIntCode := 1;
  lMD5 := THashMD5.GetHashString(aSecretKey + lIntCode.ToString);
  lZeroes := '000000000000000000000000000000'.Substring(1, aNumZeroes);
  while Copy(lMD5, 1, aNumZeroes) <> lZeroes do
  begin
    Inc(lIntCode);
    lMD5 := THashMD5.GetHashString(aSecretKey + lIntCode.ToString);
  end;
  aOutputLabel.Text := Format('Smallest integer value for required MD5 is %d giving a hash of %s', [lIntCode, lMD5]);
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(lClipSvc)) then
    lClipSvc.SetClipboard(lIntCode.ToString);
end;

procedure TfmDayFour.Button1Click(Sender: TObject);
begin
  DoCalc(Edit1.Text, 5, Label2);
end;

procedure TfmDayFour.Button2Click(Sender: TObject);
begin
  DoCalc(Edit1.Text, 6, Label3);
end;

end.
