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
    GestureManager1: TGestureManager;
    Memo1: TMemo;
    Label1: TLabel;
    Layout1: TLayout;
    Button1: TButton;
    Label2: TLabel;
    Layout2: TLayout;
    Button2: TButton;
    Label3: TLabel;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  AdventOfCodeMain: TAdventOfCodeMain;

implementation

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

procedure TAdventOfCodeMain.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
end;

end.
