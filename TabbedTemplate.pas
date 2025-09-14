unit TabbedTemplate;

interface

uses
  FMX.Forms, AoC.Frames.Day3, AoC.Frames.Day2, AoC.Frames.Day1, FMX.Controls,
  FMX.TabControl, System.Classes, FMX.Types;

type

  TAdventOfCodeMain = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    fmDayOne1: TfmDayOne;
    fmDayTwo1: TfmDayTwo;
    fmDayThree1: TfmDayThree;
    procedure FormCreate(Sender: TObject);
  end;

var
  AdventOfCodeMain: TAdventOfCodeMain;

implementation

{$R *.fmx}

procedure TAdventOfCodeMain.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
end;

end.
