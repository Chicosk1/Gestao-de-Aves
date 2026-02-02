unit uDmMortalidade;

interface

uses
  System.SysUtils, Data.DB     , FireDAC.Comp.Client,
  uDmBase        , uDmInterface, uInterfaces        ;

type
  TDmMortalidade = class(TDmBase, IDmMortalidade)
  private
    FQueryLista: TFDQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IDmMortalidade;
    function Inserir(Entidade: IMortalidade): Boolean;
    function ObterPorLote(AIdLote: Integer): TDataSet;
  end;

implementation

{ TDmMortalidade }

constructor TDmMortalidade.Create;
begin
  inherited;
  FQueryLista := CriarQuery;
end;

destructor TDmMortalidade.Destroy;
begin
  FreeAndNil(FQueryLista);
  inherited;
end;

class function TDmMortalidade.New: IDmMortalidade;
begin
  Result := Self.Create;
end;

function TDmMortalidade.ObterPorLote(AIdLote: Integer): TDataSet;
const
  SQL_PROC = 'SELECT * FROM SP_GET_MORTALIDADES_LOTE(:ID)';
begin
  if FQueryLista.Active then
    FQueryLista.Close;

  FQueryLista.SQL.Text := SQL_PROC;
  FQueryLista.ParamByName('ID').AsInteger := AIdLote;
  FQueryLista.Open;

  Result := FQueryLista;
end;

function TDmMortalidade.Inserir(Entidade: IMortalidade): Boolean;
const
  SQL_PROC = 'EXECUTE PROCEDURE SP_INS_MORTALIDADE(:ID_LOTE, :DATA, :QTD, :OBS)';
begin
  Result := ExecutarComando(SQL_PROC,
    procedure(Qry: TFDQuery)
    begin
      Qry.ParamByName('ID_LOTE').AsInteger := Entidade.GetIdLote;
      Qry.ParamByName('DATA').AsDateTime   := Entidade.GetDataMortalidade;
      Qry.ParamByName('QTD').AsInteger     := Entidade.GetQuantidadeMorta;
      Qry.ParamByName('OBS').AsString      := Entidade.GetObservacao;
    end);
end;

end.
