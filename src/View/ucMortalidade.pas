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
    FIdLote   : Integer;
  public
    procedure PrepararLancamentos(AIdLote: Integer; ADescricao: string);
    property IdLote   : Integer read FIdLote   ;
  end;

var
  frmMortalidade: TfrmMortalidade;

implementation

{$R *.dfm}

{ TfrmMortalidade }

procedure TfrmMortalidade.btnSalvarClick(Sender: TObject);
var
  Controller: TControllerOperacoes;
  Mortalidade: IMortalidade;
  IndiceAtual: Double;
begin
  inherited;

  if StrToIntDef(edtQuantidade.Text, 0) <= 0 then
  begin
    ShowMessage('Informe a quantidade de aves mortas.');
    if edtQuantidade.CanFocus then edtQuantidade.SetFocus;
    Exit;
  end;

  Mortalidade := TMortalidade.New;
  Mortalidade.SetIdLote(IdLote)
             .SetDataMortalidade(dtpDataMortalidade.Date)
             .SetQuantidadeMorta(StrToInt(edtQuantidade.Text))
             .SetObservacao(memObservacao.Text);

  Controller := TControllerOperacoes.Create;
  try
    try
      ShowMessage('Mortalidade registrada com sucesso!');
      ModalResult := mrOk;
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

procedure TfrmMortalidade.PrepararLancamentos(AIdLote: Integer;
  ADescricao: string);
begin
  FIdLote := AIdLote;
  lblLoteSelecionado.Caption := ADescricao;

  dtpDataMortalidade.Date := Date;
  edtQuantidade.Clear;
  memObservacao.Clear;
end;

end.
