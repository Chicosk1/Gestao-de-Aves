unit TestFrameIndicador;

interface

uses
  DUnitX.TestFramework, uFrameIndicador;

type
  [TestFixture]
  TTestFrameIndicador = class
  private
    FFrame: TFrameIndicador;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    [TestCase('CT01', '4.99;NORMAL;clGreen'    , ';')]
    [TestCase('CT02', '5.00;ATENÇÃO;clYellow'  , ';')]
    [TestCase('CT03', '10.00;ATENÇÃO;clYellow' , ';')]
    [TestCase('CT04', '10.01;CRÍTICO;clRed'    , ';')]
    procedure ClassificaPercentual(const APercentual, AStatus, ACor: string);
  end;

implementation

uses
  System.SysUtils, System.UITypes, Vcl.Graphics;

{ TTestFrameIndicador }

procedure TTestFrameIndicador.Setup;
begin
  FFrame := TFrameIndicador.Create(nil);
end;

procedure TTestFrameIndicador.TearDown;
begin
  FreeAndNil(FFrame);
end;

procedure TTestFrameIndicador.ClassificaPercentual(const APercentual, AStatus, ACor: string);
begin
  FFrame.AtualizarSaude(StrToFloat(APercentual, TFormatSettings.Invariant));

  Assert.AreEqual(AStatus, FFrame.lblStatus.Caption                   , 'Status');
  Assert.AreEqual(ACor   , ColorToString(FFrame.shpFarol.Brush.Color), 'Cor do farol');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestFrameIndicador);

end.
