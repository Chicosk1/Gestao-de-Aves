unit ucLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics  , Vcl.Controls   , Vcl.Forms      , Vcl.Dialogs    , Vcl.ExtCtrls  ,
  Vcl.StdCtrls  , Data.DB        , Vcl.Grids      , Vcl.DBGrids    , cLote         ;

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
    procedure gridLotesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnNovaPesagemClick(Sender: TObject);
    procedure btnNovaMortalidadeClick(Sender: TObject);
  private
    FController: TControllerLote;
    procedure ListarLotes;
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
  View: TfrmMortalidade;
  IdLote: Integer;
  Descricao: string;
begin
  if dsLotes.DataSet.IsEmpty then
    Exit;

  IdLote    := dsLotes.DataSet.FieldByName('ID_LOTE').AsInteger ;
  Descricao := dsLotes.DataSet.FieldByName('DESCRICAO').AsString;

  View := TfrmMortalidade.Create(Self);
  try
    View.PrepararLancamentos(IdLote, Descricao);

    if View.ShowModal = mrOk then
      ListarLotes;
  finally
    FreeAndNil(View)
  end;
end;

procedure TfrmLote.btnNovaPesagemClick(Sender: TObject);
var
  View: TfrmPesagem;
  IdLote: Integer;
  Descricao: string;
begin
  if dsLotes.DataSet.IsEmpty then
    Exit;

  IdLote    := dsLotes.DataSet.FieldByName('ID_LOTE').AsInteger ;
  Descricao := dsLotes.DataSet.FieldByName('DESCRICAO').AsString;

  View := TfrmPesagem.Create(Self);
  try
    View.PrepararLancamentos(IdLote, Descricao);

    if View.ShowModal = mrOk then
      ListarLotes;
  finally
    FreeAndNil(View);
  end;
end;

procedure TfrmLote.FormCreate(Sender: TObject);
begin
  FController := TControllerLote.Create;
  ListarLotes;
end;

procedure TfrmLote.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TfrmLote.ListarLotes;
begin
  dsLotes.DataSet := FController.BuscarLotes;
end;

procedure TfrmLote.gridLotesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  nPercMortalidade: Double;
begin
  if not dsLotes.DataSet.IsEmpty then
  begin
    nPercMortalidade := dsLotes.DataSet.FieldByName('PERCENTUAL_MORTALIDADE').AsFloat;

    if      nPercMortalidade > 10 then
      gridLotes.Canvas.Brush.Color := $00CCCCFF
    else if nPercMortalidade > 5  then
      gridLotes.Canvas.Brush.Color := $00CCFFFF
    else
      gridLotes.Canvas.Brush.Color := $00CCFFCC;
  end;

  if gdSelected in State then
    begin
      gridLotes.Canvas.Brush.Color := clHighlight;
      gridLotes.Canvas.Font.Color  := clHighlightText;
    end;

  gridLotes.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

end.
