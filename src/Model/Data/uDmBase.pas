unit uDmBase;

interface

uses
  System.SysUtils, Data.DB, FireDAC.Comp.Client,
  dmConexao      ;

type
  TDmBase = class(TInterfacedObject)
  protected
    function GetConexao: TFDConnection;
    function ExecutarComando(const ASQL: String; APreencherParams: TProc<TFDQuery> = nil): Boolean;
    function CriarQuery: TFDQuery;
  end;

implementation

{ TDmBase }

function TDmBase.GetConexao: TFDConnection;
begin
  Result := TfdmConexao.GetConexao;
end;

function TDmBase.CriarQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := GetConexao;
end;

function TDmBase.ExecutarComando(const ASQL: String; APreencherParams: TProc<TFDQuery>): Boolean;
var
  Qry: TFDQuery;
begin
  Result := False;
  Qry := CriarQuery;
  try
    Qry.SQL.Text := ASQL;

    if Assigned(APreencherParams) then
      APreencherParams(Qry);

    Qry.ExecSQL;
    Result := True;
  finally
    FreeAndNil(Qry);
  end;
end;

end.
