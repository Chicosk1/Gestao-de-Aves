unit uDmPesagem;

interface

uses
  System.SysUtils, Data.DB     , FireDAC.Comp.Client,
  uDmBase        , uDmInterface, uInterfaces        ;

type
  TDmPesagem = class(TDmBase, IDmPesagem)
  private
    FQueryLista: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IDmPesagem;
    function Inserir(Entidade: IPesagem): Boolean;
    function ObterPorLote(AIdLote: Integer): TDataSet;
  end;

implementation

{ TDmPesagem }

class function TDmPesagem.New: IDmPesagem;
begin
  Result := Self.Create;
end;

function TDmPesagem.ObterPorLote(AIdLote: Integer): TDataSet;
const
  SQL_PROC = 'SELECT * FROM SP_GET_PESAGENS_LOTE(:ID)';
begin
  if FQueryLista.Active then
    FQueryLista.Close;

  FQueryLista.SQL.Text := SQL_PROC;
  FQueryLista.ParamByName('ID').AsInteger := AIdLote;
  FQueryLista.Open;

  Result := FQueryLista;
end;

constructor TDmPesagem.Create;
begin
  inherited;
  FQueryLista := CriarQuery;
end;

destructor TDmPesagem.Destroy;
begin
  FreeAndNil(FQueryLista);
  inherited;
end;

function TDmPesagem.Inserir(Entidade: IPesagem): Boolean;
const
  SQL_PROC = 'EXECUTE PROCEDURE SP_INS_PESAGEM(:ID_LOTE, :DATA, :QTD, :PESO)';
begin
  Result := ExecutarComando(SQL_PROC,
    procedure(Qry: TFDQuery)
    begin
      Qry.ParamByName('ID_LOTE').AsInteger := Entidade.GetIdLote;
      Qry.ParamByName('DATA').AsDateTime   := Entidade.GetDataPesagem;
      Qry.ParamByName('QTD').AsInteger     := Entidade.GetQuantidadePesada;
      Qry.ParamByName('PESO').AsFloat      := Entidade.GetPesoMedio;
    end);
end;

end.
