unit AoC.Frames.Day1;

interface

uses
  FMX.Forms, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls,
  FMX.Controls, FMX.Controls.Presentation, System.Classes, FMX.Types,
  FMX.Layouts;

type

  TfmDayOne = class(TFrame)
    Layout1: TLayout;
    Button1: TButton;
    Label2: TLabel;
    Layout2: TLayout;
    Button2: TButton;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

implementation

uses
  System.SysUtils;

{$R *.fmx}

procedure TfmDayOne.Button1Click(Sender: TObject);
begin
  // Opening parenthesis  = 40
  // Closing parenthesis = 41
  // so Ord(X) mod 2 = 0 then 1 else -1
  var lTotal := 0;
  for var X in Memo1.Text do
    lTotal := lTotal + if Ord(X) mod 2 = 0 then 1 else -1;
  Label2.Text := Format('Santa ends up on floor %d', [lTotal]);
end;

procedure TfmDayOne.Button2Click(Sender: TObject);
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

end.
