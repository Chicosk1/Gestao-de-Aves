unit uDmMortalidade;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  uDmBase,
  uDmInterface,
  uInterfaces;

type
  TDmMortalidade = class(TDmBase, IDmMortalidade)
  public
    class function New: IDmMortalidade;
    function Inserir(Entidade: IMortalidade): Boolean;
  end;

implementation

{ TDmMortalidade }

class function TDmMortalidade.New: IDmMortalidade;
begin
  Result := Self.Create;
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
