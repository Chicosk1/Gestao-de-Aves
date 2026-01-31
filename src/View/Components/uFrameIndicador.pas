unit uFrameIndicador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics  , Vcl.Controls   , Vcl.Forms      , Vcl.Dialogs    , Vcl.StdCtrls  ,
  Vcl.ExtCtrls  ;

type
  TFrameIndicador = class(TFrame)
    shpFarol : TShape;
    lblStatus: TLabel;
  private
  public
    procedure AtualizarSaude(APercentual: Double);
  end;

implementation

{$R *.dfm}

{ TFrameIndicador }

procedure TFrameIndicador.AtualizarSaude(APercentual: Double);
begin
  if APercentual > 10.0 then
  begin
    shpFarol.Brush.Color := clGreen;
    lblStatus.Caption := 'NORMAL';
    lblStatus.Font.Color := clGreen;
  end
  else if (APercentual >= 5.0) and (APercentual <= 10.0) then
  begin
    shpFarol.Brush.Color := clYellow;
    lblStatus.Caption := 'ATENÇÃO';
    lblStatus.Font.Color := $000080FF;
  end
  else if APercentual < 5.0 then
  begin
    shpFarol.Brush.Color := clRed;
    lblStatus.Caption := 'CRÍTICO';
    lblStatus.Font.Color := clRed;
  end;
end;

end.
