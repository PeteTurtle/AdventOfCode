unit AoC.Frames.Day3;

interface

uses
  FMX.Forms, FMX.Memo.Types, FMX.StdCtrls, FMX.Layouts, System.Classes,
  FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type

  TfmDayThree = class(TFrame)
    Day3Memo: TMemo;
    Layout5: TLayout;
    Button5: TButton;
    Label6: TLabel;
    Layout6: TLayout;
    Button6: TButton;
    Label7: TLabel;
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  FMX.Platform;

{$R *.fmx}

type
  THousePos = TPair<Integer, Integer>;
  THouseCounter = TDictionary<THousePos, Integer>;

procedure TfmDayThree.Button5Click(Sender: TObject);
var
  lCurrentPos: THousePos;
  lSantaPos: THousePos;
  lLocationCount: THouseCounter;
  lClipSvc: IFMXClipboardService;
begin
  lLocationCount := THouseCounter.Create;
  lCurrentPos := THousePos.Create(0,0);
  lSantaPos := THousePos.Create(0,0);
  lLocationCount.Add(lCurrentPos, 1);

  for var lChar: Char in Day3Memo.Text do
  begin
    case Ord(LChar) of
      $3C: Dec(lSantaPos.Key); //left
      $5e: Inc(lSantaPos.Value); //up
      $76: Dec(lSantaPos.Value); //down
      $3E: Inc(lSantaPos.Key); //left
    end;
    if not lLocationCount.ContainsKey(lSantaPos) then
      lLocationCount.Add(lSantaPos, 1)
    else
      lLocationCount[lSantaPos] := lLocationCount[lSantaPos] + 1;
  end;
  Label6.Text := Format('%d houses receive at least one present', [lLocationCount.Count]);
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(lClipSvc)) then
    lClipSvc.SetClipboard(lLocationCount.Count.ToString);
end;

procedure TfmDayThree.Button6Click(Sender: TObject);
var
  lText: string;
  lCurrentPos: THousePos;
  lSantaPos: THousePos;
  lRoboPos: THousePos;
  lLocationCount: TDictionary<TPair<Integer, Integer>, Integer>;
  lClipSvc: IFMXClipboardService;

  function GetNewLocation(const aChar: Char; var aHousePos: THousePos): THousePos;
  begin
    case Ord(aChar) of
      $3C: Dec(aHousePos.Key); //left
      $5e: Inc(aHousePos.Value); //up
      $76: Dec(aHousePos.Value); //down
      $3E: Inc(aHousePos.Key); //right
    end;
    Result := aHousePos;
  end;

begin
  lLocationCount := THouseCounter.Create;
  lCurrentPos := THousePos.Create(0,0);
  lSantaPos := THousePos.Create(0,0);
  lRoboPos := THousePos.Create(0,0);
  lLocationCount.Add(lCurrentPos, 2);
  lText := Day3Memo.Text;

  var lPosToAdd: THousePos;
  for var i := 1 to Length(lText) do
  begin
    case i mod 2 of
      0: lPosToAdd := GetNewLocation(lText[i], lRoboPos);
      1: lPosToAdd := GetNewLocation(lText[i], lSantaPos);
    end;
    if not lLocationCount.ContainsKey(lPosToAdd) then
      lLocationCount.Add(lPosToAdd, 1)
    else
      lLocationCount[lPosToAdd] := lLocationCount[lPosToAdd] + 1;
  end;
  Label7.Text := Format('%d houses receive at least one present', [lLocationCount.Count]);
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(lClipSvc)) then
    lClipSvc.SetClipboard(lLocationCount.Count.ToString);
end;

end.
