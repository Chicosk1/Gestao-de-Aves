unit uDmInterface;

interface

uses
  Data.DB, uInterfaces;

type
  IDmLote = interface
    ['{6763D563-1768-4504-8902-86101416962A}']
    function ObterTodos: TDataSet;
  end;

  IDmPesagem = interface
    ['{23206775-4309-4809-9060-70808381123B}']
    function Inserir(Entidade: IPesagem): Boolean;
  end;

  IDmMortalidade = interface
    ['{10906233-5601-4190-8022-83908381123C}']
    function Inserir(Entidade: IMortalidade): Boolean;
  end;

implementation

end.
