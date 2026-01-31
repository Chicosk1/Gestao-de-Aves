unit ucMortalidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics  , Vcl.Controls   , Vcl.Forms      , Vcl.Dialogs    , Vcl.ExtCtrls  ,
  Vcl.StdCtrls  , Vcl.Buttons    , Vcl.ComCtrls   , cOperacoes     , uInterfaces   ,
  uMortalidade  ;

type
  TfrmMortalidade = class(TForm)
    pnlInfoLote       : TPanel         ;
    pnlInputs         : TPanel         ;
    pnlBotoes         : TPanel         ;
    lblLoteSelecionado: TLabel         ;
    btnSalvar         : TBitBtn        ;
    btnCancelar       : TBitBtn        ;
    lblData           : TLabel         ;
    dtpDataMortalidade: TDateTimePicker;
    Label1            : TLabel         ;
    edtQuantidade     : TEdit          ;
    lblObs            : TLabel         ;
    memObservacao     : TMemo          ;
    procedure btnSalvarClick(Sender: TObject);
  private
    FIdLote    : Integer;
    FQtdInicial: Integer;
    FQtdAtual  : Integer;
  public
    procedure PrepararLancamentos(AIdLote, AQtdInicial, AQtdAtual: Integer; ADescricao: string);
    property IdLote    : Integer read FIdLote    ;
    property QtdInicial: Integer read FQtdInicial;
    property QtdAtual  : Integer read FQtdAtual  ;
  end;

var
  frmMortalidade: TfrmMortalidade;

implementation

{$R *.dfm}

{ TfrmMortalidade }

procedure TfrmMortalidade.btnSalvarClick(Sender: TObject);
var
  Controller              : TControllerOperacoes;
  Mortalidade             : IMortalidade        ;
  QtdDigitada             : Integer             ;
  TotalMortosJaRegistrados: Integer             ;
begin
  inherited;

  QtdDigitada := StrToIntDef(edtQuantidade.Text, 0);
  TotalMortosJaRegistrados := FQtdInicial - FQtdAtual;

  if StrToIntDef(edtQuantidade.Text, 0) <= 0 then
  begin
    ShowMessage('Informe a quantidade de aves mortas.');
    if edtQuantidade.CanFocus then edtQuantidade.SetFocus;
    Exit;
  end;

  if (QtdDigitada + TotalMortosJaRegistrados) > FQtdInicial then
  begin
    ShowMessage(Format('A quantidade informada (%d) somada às mortalidades anteriores (%d) ultrapassa a quantidade inicial do lote (%d).' + sLineBreak +
                       'Máximo permitido (aves vivas): %d',
                       [QtdDigitada, TotalMortosJaRegistrados, FQtdInicial, FQtdAtual]));
    if edtQuantidade.CanFocus then edtQuantidade.SetFocus;
    Exit;
  end;

  Mortalidade := TMortalidade.New;
  Mortalidade.SetIdLote(IdLote)
             .SetDataMortalidade(dtpDataMortalidade.Date)
             .SetQuantidadeMorta(QtdDigitada)
             .SetObservacao(memObservacao.Text);

  Controller := TControllerOperacoes.Create;
  try
    try
      if Controller.SalvarMortalidade(Mortalidade) then
      begin
        ShowMessage('Mortalidade registrada com sucesso!');
        ModalResult := mrOk;
      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao registrar mortalidade: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(Controller);
  end;
end;

procedure TfrmMortalidade.PrepararLancamentos(AIdLote, AQtdInicial, AQtdAtual: Integer; ADescricao: string);
begin
  FIdLote                    := AIdLote    ;
  FQtdInicial                := AQtdInicial;
  FQtdAtual                  := AQtdAtual  ;

  lblLoteSelecionado.Caption := ADescricao;

  dtpDataMortalidade.Date := Date;
  edtQuantidade.Clear;
  memObservacao.Clear;
end;

end.
