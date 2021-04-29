unit cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCadastro = class(TForm)
    rgTipo: TRadioGroup;
    edtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtValor: TEdit;
    btnSalvar: TButton;
    btnLimpar: TButton;
    procedure FormShow(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure rgTipoClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCampos;
    procedure CarregaLanche(cod : string);
  public
    codlanche : string;
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}

uses  udm;

procedure TfrmCadastro.btnSalvarClick(Sender: TObject);
  function VerificaCampos : boolean;
  begin
    Result := false;
    if (edtNome.Text = '') then
    begin
      MessageDlg('Campo Nome est� vazio!',mtWarning,[mbOK],0);
      exit;
    end;

    if (rgTipo.ItemIndex = 1) and ((edtValor.Text = '')or(strtofloat(edtValor.Text) = 0)) then
    begin
      MessageDlg('Campo Valor est� zerado!',mtWarning,[mbOK],0);
      exit;
    end;

    Result := true;
  end;

begin
  if not VerificaCampos then
    exit;

  if rgTipo.ItemIndex = 0 then
  begin
    with udm.DataModule1.qryExecucao do
    begin
      Close;
      SQL.Clear;
      if codlanche <> '' then
        SQL.Add('UPDATE lanches SET nome='+QuotedStr(edtNome.Text)+' WHERE codlanche = '+codlanche)
      else
        SQL.Add('INSERT INTO lanches (nome, total) VALUES ('+QuotedStr(edtNome.Text)+',0.00)');
      ExecSQL;
      MessageDlg('Cadastro Efetuado',mtConfirmation,[mbOK],0);
      if codlanche <> '' then
      begin
        codlanche := '';
        frmCadastro.Close;
      end
      else
        LimparCampos;
    end;
  end
  else
  begin
    with udm.DataModule1.qryExecucao do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO ingredientes (nome,valor) VALUES ('+QuotedStr(edtNome.Text)+','+quotedstr(edtValor.Text)+')');
      ExecSQL;
      MessageDlg('Cadastro Efetuado',mtConfirmation,[mbOK],0);
      LimparCampos;
    end;
  end;
end;

procedure TfrmCadastro.CarregaLanche(cod: string);
begin
  with udm.DataModule1.qryConsulta do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM lanches where codlanche='+cod);
    Open;
    if not eof then
      edtNome.Text := FieldByName('nome').AsString;
  end;
end;

procedure TfrmCadastro.btnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure TfrmCadastro.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',',',#8]) then
    key :=#0;
end;

procedure TfrmCadastro.FormShow(Sender: TObject);
begin
  LimparCampos;
  if codlanche <> '' then
  begin
    rgTipo.Enabled := false;
    btnLimpar.Enabled := false;
    CarregaLanche(codlanche);
  end;
end;

procedure TfrmCadastro.LimparCampos;
begin
  btnLimpar.Enabled := true;
  rgTipo.Enabled := true;
  rgTipo.ItemIndex := 0;
  edtValor.Clear;
  edtValor.Enabled := false;
  edtNome.Clear;
  rgTipo.SetFocus;
end;

procedure TfrmCadastro.rgTipoClick(Sender: TObject);
begin
  if rgTipo.ItemIndex = 1 then
    edtValor.Enabled := true
  else
    edtValor.Enabled := false;
end;

end.
