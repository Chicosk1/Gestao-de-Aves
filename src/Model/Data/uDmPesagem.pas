unit uDmPesagem;

interface

uses
  System.SysUtils, Data.DB     , FireDAC.Comp.Client,
  uDmBase        , uDmInterface, uInterfaces        ;

type
  TDmPesagem = class(TDmBase, IDmPesagem)
  public
    class function New: IDmPesagem;
    function Inserir(Entidade: IPesagem): Boolean;
  end;

implementation

{ TDmPesagem }

class function TDmPesagem.New: IDmPesagem;
begin
  Result := Self.Create;
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
