program pTesteFoxConn;

uses
  Vcl.Forms,
  menu in 'menu.pas' {frmMenu},
  udm in 'udm.pas' {DataModule1: TDataModule},
  cadastro in 'cadastro.pas' {frmCadastro},
  gerenciamento in 'gerenciamento.pas' {frmGerenciamento},
  associa in 'associa.pas' {frmAssocia},
  gestaopedido in 'gestaopedido.pas' {frmGestaoPedido},
  cadpedido in 'cadpedido.pas' {frmCadPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmGestaoPedido, frmGestaoPedido);
  Application.CreateForm(TfrmCadPedido, frmCadPedido);
  Application.Run;
end.
