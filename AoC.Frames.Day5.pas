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
  FMX.Layouts;

type

  TfmDayFive = class(TFrame)
    Layout1: TLayout;
    Memo1: TMemo;
    lblWordcount: TLabel;
    Layout2: TLayout;
    Button1: TButton;
    Label2: TLabel;
    procedure FrameResized(Sender: TObject);
  public
    procedure Loaded; override;
  end;

implementation

uses
  System.SysUtils;

{$R *.fmx}

const
  cVowels: TSysCharSet = ['a', 'e', 'i' ,'o', 'u'];
  cBadStrs: TArray<string> = ['ab', 'cd', 'pq', 'xy'];
var
  lDoubleChars: TArray<string>;

procedure TfmDayFive.Loaded;
begin
  SetLength(lDoubleChars, 26);
  for var lChar := 'a' to 'z' do
    lDoubleChars[Ord(lChar) - Ord('a')] := lChar+lChar;
end;

procedure TfmDayFive.FrameResized(Sender: TObject);
begin
  if lblWordcount.Text.IsEmpty then
    lblWordcount.Text := Format('%d words', [Memo1.Lines.count]);
end;

end.
