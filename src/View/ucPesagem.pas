unit ucPesagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics  , Vcl.Controls   , Vcl.Forms      , Vcl.Dialogs    , Vcl.ExtCtrls  ,
  Vcl.StdCtrls  , Vcl.Buttons    , Vcl.ComCtrls   , cOperacoes     , uInterfaces   ,
  uPesagem      ;

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
    FIdLote   : Integer;
  public
    procedure PrepararLancamentos(AIdLote: Integer; ADescricao: string);
    property IdLote   : Integer read FIdLote   ;
  end;

var
  frmPesagem: TfrmPesagem         ;

implementation

{$R *.dfm}

{ TfrmPesagem }

procedure TfrmPesagem.btnSalvarClick(Sender: TObject);
var
  Controller: TControllerOperacoes;
  Pesagem   : IPesagem;
begin
  inherited;

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

  Pesagem := TPesagem.New;
  Pesagem.SetIdLote(IdLote)
         .SetDataPesagem(dtpDataPesagem.Date)
         .SetPesoMedio(StrToFloat(edtPesoMedio.Text))
         .SetQuantidadePesada(StrToInt(edtQuantidade.Text));

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

procedure TfrmPesagem.PrepararLancamentos(AIdLote: Integer; ADescricao: string);
begin
  FIdLote := AIdLote;
  lblLoteSelecionado.Caption := ADescricao;

  dtpDataPesagem.Date := Date;
  edtPesoMedio.Clear;
  edtQuantidade.Clear;
end;

end.
