unit cLote;

interface

uses
  Data.DB,
  uDmInterface,
  uDmLote;

type
  TControllerLote = class
  private
    FLoteDAO: ILoteDAO;
  public
    constructor Create;
    function BuscarLotes: TDataSet;
  end;

implementation

{ TControllerLote }

constructor TControllerLote.Create;
begin
  FLoteDAO := TDmLote.New;
end;

function TControllerLote.BuscarLotes: TDataSet;
begin
  Result := FLoteDAO.ObterTodos;
end;

end.
