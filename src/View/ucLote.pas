unit ucLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids;

type
  TfrmLote = class(TForm)
    pnlTopo: TPanel;
    pnlGrid: TPanel;
    lblTitulo: TLabel;
    btnNovaPesagem: TButton;
    btnNovaMortalidade: TButton;
    gridLotes: TDBGrid;
    pnlRodape: TPanel;
    dsLotes: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLote: TfrmLote;

implementation

{$R *.dfm}

end.
