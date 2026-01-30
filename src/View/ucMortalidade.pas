unit ucMortalidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls;

type
  TfrmMortalidade = class(TForm)
    pnlInfoLote: TPanel;
    pnlInputs: TPanel;
    pnlBotoes: TPanel;
    lblLoteSelecionado: TLabel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    lblData: TLabel;
    dtpDataMortalidade: TDateTimePicker;
    Label1: TLabel;
    edtQuantidade: TEdit;
    lblObs: TLabel;
    memObservacao: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMortalidade: TfrmMortalidade;

implementation

{$R *.dfm}

end.
