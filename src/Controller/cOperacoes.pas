unit cOperacoes;

interface

uses
  System.SysUtils, uInterfaces   , uDmInterface,
  uDmPesagem     , uDmMortalidade;

type
  TControllerOperacoes = class
  private
    FDmPesagem    : IDmPesagem;
    FDmMortalidade: IDmMortalidade;
  public
    constructor Create;
    function SalvarPesagem(AModel: IPesagem): Boolean;
    function SalvarMortalidade(AModel: IMortalidade): Boolean;
    function GetPesagensPorLote(AIdLote: Integer): TDataSet;
    function GetMortalidadesPorLote(AIdLote: Integer): TDataSet;
  end;

implementation

{ TControllerOperacoes }

constructor TControllerOperacoes.Create;
begin
  FDmPesagem     := TDmPesagem.New;
  FDmMortalidade := TDmMortalidade.New;
end;

function TControllerOperacoes.GetMortalidadesPorLote(
  AIdLote: Integer): TDataSet;
begin
  Result := FDmMortalidade.ObterPorLote(AIdLote);
end;

function TControllerOperacoes.GetPesagensPorLote(AIdLote: Integer): TDataSet;
begin
  Result := FDmPesagem.ObterPorLote(AIdLote)
end;

function TControllerOperacoes.SalvarMortalidade(AModel: IMortalidade): Boolean;
begin
  Result := FDmMortalidade.Inserir(AModel);
end;

function TControllerOperacoes.SalvarPesagem(AModel: IPesagem): Boolean;
begin
  Result := FDmPesagem.Inserir(AModel);
end;

end.
