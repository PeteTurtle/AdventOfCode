program AdventOfCode;

uses
  System.StartUpCopy,
  FMX.Forms,
  TabbedTemplate in 'TabbedTemplate.pas' {AdventOfCodeMain},
  AoC.Frames.Day1 in 'AoC.Frames.Day1.pas' {fmDayOne: TFrame},
  AoC.Frames.Day2 in 'AoC.Frames.Day2.pas' {fmDayTwo: TFrame},
  AoC.Frames.Day3 in 'AoC.Frames.Day3.pas' {fmDayThree: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAdventOfCodeMain, AdventOfCodeMain);
  Application.Run;
end.
