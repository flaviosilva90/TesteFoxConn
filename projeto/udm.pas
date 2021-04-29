unit udm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, frxClass, frxDBSet;

type
  TDataModule1 = class(TDataModule)
    conexao: TADOConnection;
    qryExecucao: TADOQuery;
    qryConsulta: TADOQuery;
    FxDs_cardapio: TfrxDBDataset;
    cardapio: TfrxReport;
    qryCardapio: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
