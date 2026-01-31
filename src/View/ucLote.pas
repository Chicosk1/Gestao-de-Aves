unit ucLote;

interface

uses
  Winapi.Windows , Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics   , Vcl.Controls   , Vcl.Forms      , Vcl.Dialogs    , Vcl.ExtCtrls  ,
  Vcl.StdCtrls   , Data.DB        , Vcl.Grids      , Vcl.DBGrids    , cLote         ,
  uFrameIndicador;

type
  TfrmLote = class(TForm)
    pnlTopo           : TPanel     ;
    pnlGrid           : TPanel     ;
    lblTitulo         : TLabel     ;
    btnNovaPesagem    : TButton    ;
    btnNovaMortalidade: TButton    ;
    gridLotes         : TDBGrid    ;
    pnlRodape         : TPanel     ;
    dsLotes           : TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovaPesagemClick(Sender: TObject);
    procedure btnNovaMortalidadeClick(Sender: TObject);
  private
    FController: TControllerLote;
    FIndicador : TFrameIndicador;
    procedure ListarLotes;
    procedure OnLoteSelecionado(Sender: TObject; Field: TField);
  public
  end;

var
  frmLote: TfrmLote;

implementation

uses
  ucPesagem, ucMortalidade;

{$R *.dfm}

procedure TfrmLote.btnNovaMortalidadeClick(Sender: TObject);
var
  View                        : TfrmMortalidade;
  IdLote, QtdInicial, QtdAtual: Integer        ;
  Descricao                   : string         ;
begin
  if dsLotes.DataSet.IsEmpty then
    Exit;

  IdLote     := dsLotes.DataSet.FieldByName('ID_LOTE').AsInteger           ;
  Descricao  := dsLotes.DataSet.FieldByName('DESCRICAO').AsString          ;
  QtdAtual   := dsLotes.DataSet.FieldByName('QUANTIDADE_ATUAL').AsInteger  ;
  QtdInicial := dsLotes.DataSet.FieldByName('QUANTIDADE_INICIAL').AsInteger;

  View := TfrmMortalidade.Create(Self);
  try
    View.PrepararLancamentos(IdLote, QtdInicial, QtdAtual, Descricao);

    if View.ShowModal = mrOk then
      ListarLotes;
  finally
    FreeAndNil(View)
  end;
end;

procedure TfrmLote.btnNovaPesagemClick(Sender: TObject);
var
  View      : TfrmPesagem;
  IdLote    : Integer    ;
  Descricao : string     ;
  QtdInicial: Integer    ;
begin
  if dsLotes.DataSet.IsEmpty then
    Exit;

  IdLote     := dsLotes.DataSet.FieldByName('ID_LOTE').AsInteger           ;
  Descricao  := dsLotes.DataSet.FieldByName('DESCRICAO').AsString          ;
  QtdInicial := dsLotes.DataSet.FieldByName('QUANTIDADE_INICIAL').AsInteger;

  View := TfrmPesagem.Create(Self);
  try
    View.PrepararLancamentos(IdLote, Descricao, QtdInicial);

    if View.ShowModal = mrOk then
      ListarLotes;
  finally
    FreeAndNil(View);
  end;
end;

procedure TfrmLote.FormCreate(Sender: TObject);
begin
  FController := TControllerLote.Create;

  FIndicador                  := TFrameIndicador.Create(Self);
  FIndicador.Parent           := pnlRodape;
  FIndicador.Align            := alLeft;
  FIndicador.Margins.Left     := 10;
  FIndicador.AlignWithMargins := True;

  dsLotes.OnDataChange := OnLoteSelecionado;

  ListarLotes;
end;

procedure TfrmLote.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FController);
  FreeAndNil(FIndicador);
end;

procedure TfrmLote.ListarLotes;
begin
  dsLotes.DataSet := FController.BuscarLotes;
end;

procedure TfrmLote.OnLoteSelecionado(Sender: TObject; Field: TField);
var
  nPercMortalidade: Double;
begin
  if (dsLotes.DataSet <> nil) and (not dsLotes.DataSet.IsEmpty) then
  begin
    nPercMortalidade := dsLotes.DataSet.FieldByName('PERCENTUAL_MORTALIDADE').AsFloat;

    FIndicador.AtualizarSaude(nPercMortalidade);
    FIndicador.Visible := True;
  end
  else
  begin
    FIndicador.Visible := False;
  end;
end;

end.
