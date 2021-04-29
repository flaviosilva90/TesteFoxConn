unit menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmMenu = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    Image2: TImage;
    Label2: TLabel;
    Panel3: TPanel;
    Image3: TImage;
    Label3: TLabel;
    Panel4: TPanel;
    Image4: TImage;
    Label4: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses  udm, cadastro, gerenciamento, gestaopedido;

procedure TfrmMenu.Image1Click(Sender: TObject);
begin
  Application.CreateForm(cadastro.TfrmCadastro, frmCadastro);
  try
    frmCadastro.ShowModal;
  finally
    FreeAndNil(frmCadastro);
  end;
end;

procedure TfrmMenu.Image2Click(Sender: TObject);
begin
    with udm.DataModule1 do
    begin
      qryCardapio.Close;
      qryCardapio.Open;
      cardapio.ShowReport;
    end;
end;

procedure TfrmMenu.Image3Click(Sender: TObject);
begin
  Application.CreateForm(gerenciamento.TfrmGerenciamento, frmGerenciamento);
  try
    frmGerenciamento.ShowModal;
  finally
    FreeAndNil(frmGerenciamento);
  end;
end;

procedure TfrmMenu.Image4Click(Sender: TObject);
begin
  Application.CreateForm(gestaopedido.TfrmGestaoPedido, frmGestaoPedido);
  try
    frmGestaoPedido.ShowModal;
  finally
    FreeAndNil(frmGestaoPedido);
  end;
end;

end.
