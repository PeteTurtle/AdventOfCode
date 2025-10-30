program AdventOfCode;

uses
  System.StartUpCopy,
  FMX.Forms,
  TabbedTemplate in 'TabbedTemplate.pas' {AdventOfCodeMain},
  AoC.Frames.Day1 in 'AoC.Frames.Day1.pas' {fmDayOne: TFrame},
  AoC.Frames.Day2 in 'AoC.Frames.Day2.pas' {fmDayTwo: TFrame},
  AoC.Frames.Day3 in 'AoC.Frames.Day3.pas' {fmDayThree: TFrame},
  AoC.Frames.Day4 in 'AoC.Frames.Day4.pas' {fmDayFour: TFrame},
  AoC.Frames.Day5 in 'AoC.Frames.Day5.pas' {fmDayFive: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAdventOfCodeMain, AdventOfCodeMain);
  Application.Run;
end.
