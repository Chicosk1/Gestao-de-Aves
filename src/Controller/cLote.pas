unit cLote;

interface

uses
  Data.DB,
  uDmInterface,
  uDmLote;

type
  TControllerLote = class
  private
    FDmLote: IDmLote;
  public
    constructor Create;
    function BuscarLotes: TDataSet;
  end;

implementation

{ TControllerLote }

constructor TControllerLote.Create;
begin
  FDmLote := TDmLote.New;
end;

function TControllerLote.BuscarLotes: TDataSet;
begin
  Result := FDmLote.ObterTodos;
end;

end.
