program AdventOfCode;

uses
  System.StartUpCopy,
  FMX.Forms,
  TabbedTemplate in 'TabbedTemplate.pas' {AdventOfCodeMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAdventOfCodeMain, AdventOfCodeMain);
  Application.Run;
end.
