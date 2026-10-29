program LoteAvesTests;

{$APPTYPE CONSOLE}
{$STRONGLINKTYPES ON}

uses
  System.SysUtils         ,
  DUnitX.TestFramework    ,
  DUnitX.Loggers.Console  ,
  DUnitX.Loggers.Xml.NUnit,
  uFrameIndicador in '..\src\View\Components\uFrameIndicador.pas' {FrameIndicador: TFrame},
  TestFrameIndicador in 'TestFrameIndicador.pas';

var
  Runner : ITestRunner;
  Results: IRunResults;
begin
  try
    TDUnitX.CheckCommandLine;

    Runner                  := TDUnitX.CreateRunner;
    Runner.UseRTTI          := True;
    Runner.FailsOnNoAsserts := True;

    Runner.AddLogger(TDUnitXConsoleLogger.Create(False));
    Runner.AddLogger(TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile));

    Results := Runner.Execute;

    if not Results.AllPassed then
      System.ExitCode := 1;
  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := 2;
    end;
  end;
end.
