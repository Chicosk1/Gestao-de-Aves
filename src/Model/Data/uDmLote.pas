unit uDmLote;

interface

uses
  System.SysUtils, Data.DB    , FireDAC.Comp.Client, FireDAC.DApt,
  uDmInterface   , uInterfaces, uDmBase            , dmConexao   ;

type
  TDmLote = class(TDmBase, IDmLote)
  private
    FStoredProc: TFDStoredProc;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IDmLote;

    function ObterTodos: TDataSet;
  end;

implementation

{ TDmLote }

constructor TDmLote.Create;
begin
  FStoredProc := TFDStoredProc.Create(nil);
  FStoredProc.Connection := GetConexao;
end;

destructor TDmLote.Destroy;
begin
  FStoredProc.Free;
  inherited;
end;

class function TDmLote.New: IDmLote;
begin
  Result := Self.Create;
end;

function TDmLote.ObterTodos: TDataSet;
begin
  if FStoredProc.Active then
    FStoredProc.Close;

  FStoredProc.StoredProcName := 'SP_GET_LOTES';
  FStoredProc.Prepare;
  FStoredProc.Open;
  Result := FStoredProc;
end;

end.
