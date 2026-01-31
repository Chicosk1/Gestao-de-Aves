unit ucPesagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics  , Vcl.Controls   , Vcl.Forms      , Vcl.Dialogs    , Vcl.ExtCtrls  ,
  Vcl.StdCtrls  , Vcl.Buttons    , Vcl.ComCtrls   ;

type
  TfrmPesagem = class(TForm)
    pnlInfoLote       : TPanel         ;
    pnlInputs         : TPanel         ;
    pnlBotoes         : TPanel         ;
    lblLoteSelecionado: TLabel         ;
    btnSalvar         : TBitBtn        ;
    lblData           : TLabel         ;
    lblPeso           : TLabel         ;
    lblQtd            : TLabel         ;
    edtPesoMedio      : TEdit          ;
    edtQuantidade     : TEdit          ;
    dtpDataPesagem    : TDateTimePicker;
    btnCancelar       : TBitBtn        ;
    procedure btnSalvarClick(Sender: TObject);
  private
    FIdLote        : Integer;
    FQtdInicialLote: Integer;
  public
    procedure PrepararLancamentos(AIdLote: Integer; ADescricao: string; AQtdInicial: Integer);
    property IdLote        : Integer read FIdLote        ;
    property QtdInicialLote: Integer read FQtdInicialLote;
  end;

var
  frmPesagem: TfrmPesagem         ;

implementation

{$R *.dfm}

uses
  cOperacoes, uInterfaces, uPesagem;

{ TfrmPesagem }

procedure TfrmPesagem.btnSalvarClick(Sender: TObject);
var
  Controller : TControllerOperacoes;
  Pesagem    : IPesagem;
  QtdDigitada: Integer;
begin
  inherited;

  QtdDigitada := StrToIntDef(edtQuantidade.Text, 0);

  if StrToFloatDef(edtPesoMedio.Text, 0) <= 0 then
  begin
    ShowMessage('Informe um peso médio válido maior que zero.');
    if edtPesoMedio.CanFocus then edtPesoMedio.SetFocus;
    Exit;
  end;

  if StrToIntDef(edtQuantidade.Text, 0) <= 0 then
  begin
    ShowMessage('Informe a quantidade de aves pesadas.');
    if edtQuantidade.CanFocus then edtQuantidade.SetFocus;
    Exit;
  end;

  if QtdDigitada > FQtdInicialLote then
  begin
    ShowMessage(Format('A quantidade pesada (%d) não pode ser maior que a quantidade inicial do lote (%d).',
      [QtdDigitada, FQtdInicialLote]));
    if edtQuantidade.CanFocus then edtQuantidade.SetFocus;
    Exit;
  end;

  Pesagem := TPesagem.New;
  Pesagem.SetIdLote(IdLote)
         .SetDataPesagem(dtpDataPesagem.Date)
         .SetPesoMedio(StrToFloat(edtPesoMedio.Text))
         .SetQuantidadePesada(QtdDigitada);

  Controller := TControllerOperacoes.Create;
  try
    try
      if Controller.SalvarPesagem(Pesagem) then
      begin
        ShowMessage('Pesagem registrada com sucesso!');
        ModalResult := mrOk;
      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao registrar pesagem: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(Controller);
  end;
end;

procedure TfrmPesagem.PrepararLancamentos(AIdLote: Integer; ADescricao: string; AQtdInicial: Integer);
begin
  FIdLote                    := AIdLote    ;
  FQtdInicialLote            := AQtdInicial;

  lblLoteSelecionado.Caption := ADescricao;

  dtpDataPesagem.Date := Date;
  edtPesoMedio.Clear;
  edtQuantidade.Clear;
end;

end.
