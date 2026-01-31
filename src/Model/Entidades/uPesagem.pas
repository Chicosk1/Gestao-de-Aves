unit uPesagem;

interface

uses
  uInterfaces;

type
  TPesagem = class(TInterfacedObject, IPesagem)
  private
    FId: Integer;
    FIdLote: Integer;
    FDataPesagem: TDateTime;
    FPesoMedio: Double;
    FQuantidadePesada: Integer;
  public
    class function New: IPesagem;

    function SetId(Value: Integer): IPesagem;
    function GetId: Integer;
    function SetIdLote(Value: Integer): IPesagem;
    function GetIdLote: Integer;
    function SetDataPesagem(Value: TDateTime): IPesagem;
    function GetDataPesagem: TDateTime;
    function SetPesoMedio(Value: Double): IPesagem;
    function GetPesoMedio: Double;
    function SetQuantidadePesada(Value: Integer): IPesagem;
    function GetQuantidadePesada: Integer;
  end;

implementation

{ TPesagem }

class function TPesagem.New: IPesagem;
begin
  Result := Self.Create;
end;

function TPesagem.SetId(Value: Integer): IPesagem;
begin
  Result := Self;
  FId := Value;
end;

function TPesagem.GetId: Integer;
begin
  Result := FId;
end;

function TPesagem.SetIdLote(Value: Integer): IPesagem;
begin
  Result := Self;
  FIdLote := Value;
end;

function TPesagem.GetIdLote: Integer;
begin
  Result := FIdLote;
end;

function TPesagem.SetDataPesagem(Value: TDateTime): IPesagem;
begin
  Result := Self;
  FDataPesagem := Value;
end;

function TPesagem.GetDataPesagem: TDateTime;
begin
  Result := FDataPesagem;
end;

function TPesagem.SetPesoMedio(Value: Double): IPesagem;
begin
  Result := Self;
  FPesoMedio := Value;
end;

function TPesagem.GetPesoMedio: Double;
begin
  Result := FPesoMedio;
end;

function TPesagem.SetQuantidadePesada(Value: Integer): IPesagem;
begin
  Result := Self;
  FQuantidadePesada := Value;
end;

function TPesagem.GetQuantidadePesada: Integer;
begin
  Result := FQuantidadePesada;
end;

end.
