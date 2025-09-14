unit TabbedTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Memo.Types, FMX.Layouts,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.ListBox;

type

  TAdventOfCodeMain = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Memo1: TMemo;
    Label1: TLabel;
    Layout1: TLayout;
    Button1: TButton;
    Label2: TLabel;
    Layout2: TLayout;
    Button2: TButton;
    Label3: TLabel;
    ListBox1: TListBox;
    Layout3: TLayout;
    Button3: TButton;
    Label4: TLabel;
    Layout4: TLayout;
    Button4: TButton;
    Label5: TLabel;
    Day3Memo: TMemo;
    Layout5: TLayout;
    Button5: TButton;
    Label6: TLabel;
    Layout6: TLayout;
    Button6: TButton;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  end;

var
  AdventOfCodeMain: TAdventOfCodeMain;

implementation

uses
  System.Generics.Collections,
  FMX.Platform;

{$R *.fmx}

procedure TAdventOfCodeMain.Button1Click(Sender: TObject);
begin
  // Opening parenthesis  = 40
  // Closing parenthesis = 41
  // so Ord(X) mod 2 = 0 then 1 else -1
  var lTotal := 0;
  for var X in Memo1.Text do
    lTotal := lTotal + if Ord(X) mod 2 = 0 then 1 else -1;
  Label2.Text := Format('Santa ends up on floor %d', [lTotal]);
end;

procedure TAdventOfCodeMain.Button2Click(Sender: TObject);
var
  i: NativeUInt;
begin
  var lTotal := 0;
  for i := 1 to Length(Memo1.Text) do
  begin
    lTotal := lTotal + if Ord(Memo1.Text[i]) mod 2 = 0 then 1 else -1;
    if lTotal < 0 then
      Break;
  end;
  Label3.Text := Format('Santa goes down to the basement at position %d', [i]);
end;

procedure TAdventOfCodeMain.Button3Click(Sender: TObject);

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

procedure TAdventOfCodeMain.Button4Click(Sender: TObject);

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

type
  THousePos = TPair<Integer, Integer>;
  THouseCounter = TDictionary<THousePos, Integer>;

procedure TAdventOfCodeMain.Button5Click(Sender: TObject);
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

procedure TAdventOfCodeMain.Button6Click(Sender: TObject);
var
  lText: string;
  lCurrentPos: THousePos;
  lSantaPos: THousePos;
  lRoboPos: THousePos;
  lLocationCount: TDictionary<TPair<Integer, Integer>, Integer>;
  lClipSvc: IFMXClipboardService;

  function GetNewLocation(const aChar: Char; aHousePos: THousePos): THousePos;
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

procedure TAdventOfCodeMain.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
end;

end.
