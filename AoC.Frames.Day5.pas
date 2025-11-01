unit AoC.Frames.Day5;

interface

uses
  System.Classes,
  FMX.Forms,
  FMX.Memo.Types,
  FMX.StdCtrls,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Types,
  FMX.Layouts, FMX.ListBox;

type

  TfmDayFive = class(TFrame)
    Layout1: TLayout;
    Memo1: TMemo;
    lblWordcount: TLabel;
    Layout2: TLayout;
    Button1: TButton;
    Label2: TLabel;
    Layout3: TLayout;
    Button2: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FrameResized(Sender: TObject);
  private
    FNiceStringCount: Integer;
    function CheckString(const aString: string): Boolean;
    function CheckString2(const aString: string): Boolean;
    function Part1_1(const aString: string): Boolean;
    function Part1_2(const aString: string): Boolean;
    function Part1_3(const aString: string): Boolean;
    function Part2_1(const aString: string): Boolean;
    function Part2_2(const aString: string): Boolean;
  public
    procedure Loaded; override;
  end;

implementation

uses
  System.SysUtils,
  System.Threading,
  System.SyncObjs,
  System.Diagnostics;

{$R *.fmx}

const
  cVowels: TSysCharSet = ['a', 'e', 'i' ,'o', 'u'];
  cBadStrs: TArray<string> = ['ab', 'cd', 'pq', 'xy'];
var
  lDoubleChars: TArray<string>;

procedure TfmDayFive.Button1Click(Sender: TObject);
begin
  FNiceStringCount := 0;
  var lSW := TStopwatch.StartNew;
  try
    for var i := 0 to Memo1.Lines.Count - 1 do
      if Part1_1(Memo1.Lines[i])
        and Part1_2(Memo1.Lines[i])
        and Part1_3(Memo1.Lines[i]) then
          inc(FNiceStringCount);
  finally
    lSW.Stop;
    Label2.Text := Format('%d nice strings (%dms)', [FNiceStringCount, lSW.ElapsedMilliseconds]);
  end;
end;

procedure TfmDayFive.Button2Click(Sender: TObject);
begin
//  FNiceStringCount := 0;
//  var lSW := TStopwatch.StartNew;
//  try
//    Listbox1.BeginUpdate;
//    for var i := 0 to Memo1.Lines.Count - 1 do
//      if CheckString2(Memo1.Lines[i]) then
//      begin
//        inc(FNiceStringCount);
//        ListBox1.Items.Add(Memo1.Lines[i]);
//      end;
//  finally
//    lSW.Stop;
//    Label1.Text := Format('%d nice strings (%dms)', [FNiceStringCount, lSW.ElapsedMilliseconds]);
//    ListBox1.EndUpdate;
//  end;
  FNiceStringCount := 0;
  var lSW := TStopwatch.StartNew;
  try
    for var i := 0 to Memo1.Lines.Count - 1 do
      if Part2_1(Memo1.Lines[i])
        and Part2_2(Memo1.Lines[i]) then
          inc(FNiceStringCount);
  finally
    lSW.Stop;
    Label2.Text := Format('%d nice strings (%dms)', [FNiceStringCount, lSW.ElapsedMilliseconds]);
  end;
end;

procedure TfmDayFive.Loaded;
begin
  SetLength(lDoubleChars, 26);
  for var lChar := 'a' to 'z' do
    lDoubleChars[Ord(lChar) - Ord('a')] := lChar+lChar;
end;

function TfmDayFive.Part1_1(const aString: string): Boolean;
begin
  Result := True;
  for var lBad in cBadStrs do
    if Pos(lBad, aString) > 0 then
      Exit(False);
end;

function TfmDayFive.Part1_2(const aString: string): Boolean;
begin
  Result := False;
  var lNoVowels := 0;
  for var i := 1 to aString.Length do
    if CharInSet(aString[i], cVowels) then
    begin
      inc(lNoVowels);
      if lNoVowels = 3 then
        Exit(True);
    end;
end;

function TfmDayFive.Part1_3(const aString: string): Boolean;
begin
  Result := False;
  for var lCh in lDoubleChars do
    if Pos(lCh, aString) > 0 then
      Exit(True);
end;

function TfmDayFive.Part2_1(const aString: string): Boolean;
begin
  Result := False;
  for var i := 1 to aString.Length - 2 do
    if aString[i] = aString[i+2] then
      Exit(True);
end;

function TfmDayFive.Part2_2(const aString: string): Boolean;
begin
  Result := False;
  for var i := 1 to aString.Length - 3 do
  begin
    var lpair := aString.Substring(i, 2);
    if Pos(lPair, aString, i + 2) > 0 then
      Exit(True);
  end;
end;

function TfmDayFive.CheckString(const aString: string): Boolean;
var
  HasBad: Boolean;
  Has3Vowels: Boolean;
  HasDouble: Boolean;
begin
   HasBad := False;
   Has3Vowels := False;
   HasDouble := False;

  // check the bad strings first
  for var lBad in cBadStrs do
    if Pos(lBad, aString) > 0 then
    begin
      HasBad := True;
      Break;
    end;

  var lNoVowels := 0;
  for var i := 1 to aString.Length do
    if CharInSet(aString[i], cVowels) then
    begin
      inc(lNoVowels);
      if lNoVowels = 3 then
      begin
        Has3Vowels := True;
        Break;
      end;
    end;

  // and now the double-letters
  for var lCh in lDoubleChars do
    if Pos(lCh, aString) > 0 then
    begin
      HasDouble := True;
      Break;
    end;
  Exit(Has3Vowels and HasDouble and not HasBad);
end;

function TfmDayFive.CheckString2(const aString: string): Boolean;
var
  lFirst, lSecond: Boolean;
begin
  lFirst := False;
  lSecond := False;
  for var i := 1 to aString.Length - 2 do
    if aString[i] = aString[i+2] then
    begin
      lFirst := True;
      Break;
    end;
  Result := lFirst;

  for var i := 1 to aString.Length - 4 do
  begin
    var lpair := aString.Substring(i, 2);
    if Pos(lPair, aString, i + 2) > 0 then
    begin
      lSecond := True;
      Break;
    end;
  end;
//  Result := lFirst and lSecond;
end;

procedure TfmDayFive.FrameResized(Sender: TObject);
begin
  if lblWordcount.Text.IsEmpty then
    lblWordcount.Text := Format('%d words', [Memo1.Lines.count]);
end;

end.
