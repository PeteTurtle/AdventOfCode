unit AoC.Frames.Day2;

interface

uses
  FMX.Forms, FMX.Layouts, FMX.ListBox, FMX.StdCtrls, FMX.Controls,
  FMX.Controls.Presentation, System.Classes, FMX.Types;

type

  TfmDayTwo = class(TFrame)
    Layout3: TLayout;
    Button3: TButton;
    Label4: TLabel;
    Layout4: TLayout;
    Button4: TButton;
    Label5: TLabel;
    ListBox1: TListBox;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  FMX.Platform;

{$R *.fmx}

procedure TfmDayTwo.Button3Click(Sender: TObject);

  function PaperFor(const aDimensions: string): Integer;
  var
    lSides: TArray<Integer>;
  begin
    var lStrVals := aDimensions.Split(['x']);
    SetLength(lSides, Length(lStrVals));
    for var i := Low(lStrVals) to High(lStrVals) do
      lSides[i] := lStrVals[i].ToInteger;
    TArray.Sort<Integer>(lSides);
    Result := 3 * (lSides[0] * lSides[1]) + 2 * (lSides[1] * lSides[2] + lSides[0] * lSides[2]);
  end;

begin
  var lTotal := 0;
  for var lParcel in ListBox1.Items do
    lTotal := lTotal + PaperFor(lParcel);
  Label4.Text := Format('Santa needs %d square feet of paper!', [lTotal]);
end;

procedure TfmDayTwo.Button4Click(Sender: TObject);

  function RibbonFor(const aDimensions: string): Integer;
  var
    lSides: TArray<Integer>;
  begin
    var lStrVals := aDimensions.Split(['x']);
    SetLength(lSides, Length(lStrVals));
    for var i := Low(lStrVals) to High(lStrVals) do
      lSides[i] := lStrVals[i].ToInteger;
    TArray.Sort<Integer>(lSides);
    Result := 2 * (lSides[0] + lSides[1]) + (lSides[0] * lSides[1] * lSides[2]);
  end;

var
  lClipSvc: IFMXClipboardService;

begin
  var lTotal := 0;
  for var lParcel in ListBox1.Items do
    lTotal := lTotal + RibbonFor(lParcel);
  Label5.Text := Format('Santa needs %d feet of ribbon!', [lTotal]);
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, IInterface(lClipSvc)) then
    lClipSvc.SetClipboard(lTotal.ToString);
end;

end.
