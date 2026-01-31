unit uMortalidade;

interface

uses
  uInterfaces;

type
  TMortalidade = class(TInterfacedObject, IMortalidade)
  private
    FId             : Integer  ;
    FIdLote         : Integer  ;
    FDataMortalidade: TDateTime;
    FQuantidadeMorta: Integer  ;
    FObservacao     : string   ;
  public
    class function New: IMortalidade;

    function SetId(Value: Integer): IMortalidade;
    function GetId: Integer;
    function SetIdLote(Value: Integer): IMortalidade;
    function GetIdLote: Integer;
    function SetDataMortalidade(Value: TDateTime): IMortalidade;
    function GetDataMortalidade: TDateTime;
    function SetQuantidadeMorta(Value: Integer): IMortalidade;
    function GetQuantidadeMorta: Integer;
    function SetObservacao(Value: string): IMortalidade;
    function GetObservacao: string;
  end;

implementation

{ TMortalidade }

class function TMortalidade.New: IMortalidade;
begin
  Result := Self.Create;
end;

function TMortalidade.SetId(Value: Integer): IMortalidade;
begin
  Result := Self;
  FId := Value;
end;

function TMortalidade.GetId: Integer;
begin
  Result := FId;
end;

function TMortalidade.SetIdLote(Value: Integer): IMortalidade;
begin
  Result := Self;
  FIdLote := Value;
end;

function TMortalidade.GetIdLote: Integer;
begin
  Result := FIdLote;
end;

function TMortalidade.SetDataMortalidade(Value: TDateTime): IMortalidade;
begin
  Result := Self;
  FDataMortalidade := Value;
end;

function TMortalidade.GetDataMortalidade: TDateTime;
begin
  Result := FDataMortalidade;
end;

function TMortalidade.SetQuantidadeMorta(Value: Integer): IMortalidade;
begin
  Result := Self;
  FQuantidadeMorta := Value;
end;

function TMortalidade.GetQuantidadeMorta: Integer;
begin
  Result := FQuantidadeMorta;
end;

function TMortalidade.SetObservacao(Value: string): IMortalidade;
begin
  Result := Self;
  FObservacao := Value;
end;

function TMortalidade.GetObservacao: string;
begin
  Result := FObservacao;
end;

end.
