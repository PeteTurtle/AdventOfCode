unit TabbedTemplate;

interface

uses
  System.Classes,
  FMX.Forms,
  FMX.Memo.Types,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.ScrollBox,
  FMX.Memo,
  AoC.Frames.Day4,
  AoC.Frames.Day3,
  AoC.Frames.Day2,
  AoC.Frames.Day1,
  FMX.Controls,
  FMX.TabControl,
  FMX.Types,
  AoC.Frames.Day5;

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
    fmDayFour1: TfmDayFour;
    TabItem5: TTabItem;
    StyleBook1: TStyleBook;
    fmDayFive1: TfmDayFive;
  end;

var
  AdventOfCodeMain: TAdventOfCodeMain;

implementation

{$R *.fmx}

end.
