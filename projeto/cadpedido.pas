unit cadpedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls;

type
  TfrmCadPedido = class(TForm)
    lblPedido: TLabel;
    Label1: TLabel;
    gridProdutos: TStringGrid;
    edtCodLanche: TEdit;
    edtNome: TEdit;
    Button1: TButton;
    pnlIngredientes: TPanel;
    Label2: TLabel;
    edtCodIngrediente: TEdit;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    Edit2: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure edtCodLancheExit(Sender: TObject);
    procedure gridProdutosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure edtCodIngredienteExit(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    valor, valorIngrediente : Double;
    { Private declarations }
    procedure CarregaGrid;
    procedure CarregaTela;
    procedure CalculaTotalPedido;
    procedure CalculaAdicaoIngrediente;
  public
    codpedidoassocia : string;
    { Public declarations }
  end;

var
  frmCadPedido: TfrmCadPedido;

implementation

{$R *.dfm}

uses  udm;

procedure TfrmCadPedido.Button1Click(Sender: TObject);
  function verificacampos:boolean;
  begin
    Result := false;
    if (edtCodLanche.Text = '') and (edtNome.Text = '') then
    begin
      MessageDlg('Preencha o Campo Lanche.',mtWarning,[mbOK],0);
      Exit;
    end;
    Result := True;
  end;
begin
  if not verificacampos then
    exit;

  if (codpedidoassocia = '') then
  begin
    with udm.DataModule1.qryExecucao do
    begin
      close;
      sql.Clear;
      sql.Add('INSERT INTO pedidos (desconto,total,total_final) values ("0,00","0,00","0,00")');
      ExecSQL;
    end;

    with udm.DataModule1.qryConsulta do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT MAX(CODPEDIDO) AS CODPEDIDO FROM PEDIDOS');
      Open;

      if NOT eof then
        codpedidoassocia := FieldByName('codpedido').AsString;
    end;
  end;

  with udm.DataModule1.qryExecucao do
  begin
    close;
    sql.Clear;
    sql.Add('INSERT INTO itens_pedido (codpedido,codlanche,valor) values ('+codpedidoassocia+','+edtCodLanche.Text+','+QuotedStr(floattostr(valor))+')');
    ExecSQL;
    CarregaGrid;
    CalculaTotalPedido;
  end;

end;

procedure TfrmCadPedido.Button2Click(Sender: TObject);
  function verificacampos:boolean;
  begin
    Result := false;
    if (edtCodIngrediente.Text = '') and (Edit1.Text = '') then
    begin
      MessageDlg('Preencha o Campo Lanche.',mtWarning,[mbOK],0);
      Exit;
    end;
    Result := True;
  end;
begin
  if not verificacampos then
    exit;

  CalculaAdicaoIngrediente;

  pnlIngredientes.Visible := false;

  CarregaGrid;
  CalculaTotalPedido;
end;

procedure TfrmCadPedido.Button3Click(Sender: TObject);
begin
  pnlIngredientes.Visible := false;
end;

procedure TfrmCadPedido.CalculaAdicaoIngrediente;
begin
  with udm.DataModule1.qryExecucao do
  begin
    close;
    sql.Clear;
    sql.Add('UPDATE itens_pedido SET valor = valor +'+quotedstr(floattostr(valorIngrediente))+
            ' where coditmpedido = '+gridProdutos.Cells[0,gridProdutos.Row]);
    ExecSQL;
  end;
end;

procedure TfrmCadPedido.CalculaTotalPedido;
var
  desconto, total, total_final : double;
  qtd, i : integer;
begin
  qtd := 0;
  with udm.DataModule1.qryConsulta do
  begin
    close;
    sql.clear;
    sql.Add('SELECT count(codpedido)as qtd FROM itens_pedido WHERE codpedido = '+codpedidoassocia);
    Open;
    if not eof then
    begin
      qtd := FieldByName('qtd').AsInteger;
    end;
  end;

  case qtd of
    0 : exit;
    1 : desconto := 0;
    2 : desconto := 3;
    3 : desconto := 5;
    4 : desconto := 0;
    else
      desconto := 10;
  end;

  for i := 1 to gridProdutos.RowCount do
  begin
    if i < gridProdutos.rowcount then
      total := total + strtofloat(gridProdutos.Cells[2,i]);
  end;

  if desconto > 0 then
    total_final := total-(desconto*total/100)
  else
    total_final := total;

  with udm.DataModule1.qryExecucao do
  begin
    close;
    sql.Clear;
    sql.Add('UPDATE pedidos SET total = '+quotedstr(floattostr(total))+
            ', desconto = '+quotedstr(floattostr(desconto))+
            ', total_final = '+quotedstr(floattostr(total_final))+
            ' where codpedido = '+codpedidoassocia);
    ExecSQL;
  end;

end;

procedure TfrmCadPedido.CarregaGrid;
var
  i : integer;
begin
  with gridProdutos do
  begin
    RowCount := 2;
    Cells[0,0] := 'C�d.ItmPed';
    Cells[1,0] := 'Lanche';
    Cells[2,0] := 'Valor R$';
    Cells[3,0] := 'Extras';
    with udm.DataModule1.qryConsulta do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ip.coditmpedido, l.nome, ip.valor');
      sql.Add('FROM lanches l , pedidos p, itens_pedido ip');
      sql.Add('WHERE  l.codlanche = ip.codlanche');
      sql.Add('AND p.codpedido = ip.codpedido');
      sql.Add('AND p.codpedido ='+ codpedidoassocia);
      Open;
      i := 1;
      while not Eof do
      begin
        Cells[0,i] := FieldByName('coditmpedido').AsString;
        Cells[1,i] := FieldByName('nome').AsString;
        Cells[2,i] := FormatFloat('#,##0.00',strtofloat(FieldByName('valor').AsString));
        Next;
        RowCount:= RowCount +1;
        inc(i);
        if eof then
          RowCount := RowCount -1;
      end;
    end;

  end;


end;

procedure TfrmCadPedido.CarregaTela;
begin
  if codpedidoassocia = '' then
    lblPedido.Caption := 'Pedido : '
  else
    lblPedido.Caption := lblPedido.Caption + codpedidoassocia;
end;

procedure TfrmCadPedido.edtCodIngredienteExit(Sender: TObject);
begin
  if edtCodIngrediente.Text = '' then
    edtNome.Text := ''
  else
  begin
    with udm.DataModule1.qryConsulta do
    begin
      close;
      sql.clear;
      sql.Add('SELECT * FROM ingredientes WHERE codingrediente = '+edtCodIngrediente.Text);
      Open;
      if not eof then
      begin
        Edit1.Text := FieldByName('nome').AsString;
        Edit2.Text := FormatFloat('#,##0.00',FieldByName('valor').AsFloat);
        valorIngrediente := FieldByName('valor').AsFloat;
      end
      else
      begin
        MessageDlg('Ingrediente N�o Encontrado.',mtError,[mbOK],0);
        edtCodIngrediente.Clear;
        edtCodIngrediente.SetFocus;
        edtNome.Clear;
      end;
    end;
  end;
end;

procedure TfrmCadPedido.edtCodLancheExit(Sender: TObject);
begin
  if edtCodLanche.Text = '' then
    edtNome.Text := ''
  else
  begin
    with udm.DataModule1.qryConsulta do
    begin
      close;
      sql.clear;
      sql.Add('SELECT * FROM lanches WHERE total > 0 and codlanche = '+edtCodLanche.Text);
      Open;
      if not eof then
      begin
        edtNome.Text := FieldByName('nome').AsString;
        valor := FieldByName('total').AsFloat;
      end
      else
      begin
        MessageDlg('Lanche N�o Encontrado ou Seu Valor Est� Zerado.',mtError,[mbOK],0);
        edtCodLanche.Clear;
        edtCodLanche.SetFocus;
        edtNome.Clear;
      end;
    end;
  end;
end;

procedure TfrmCadPedido.FormShow(Sender: TObject);
begin
  CarregaTela;
  if codpedidoassocia <> '' then
    CarregaGrid;

  pnlIngredientes.Visible := false;
end;

procedure TfrmCadPedido.gridProdutosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin
  if (ACol = 3) and (ARow <> 0) then
  begin
    gridProdutos.Canvas.FillRect(Rect);
    BUTTON := 0;
    R:=Rect;
    SCapt := 'Adicionar';
    InflateRect(R,0,-1);
    DrawFrameControl(gridProdutos.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gridProdutos.Canvas do
    begin
      Brush.Style := bsClear;
      Font.Color := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);//posicionamentodo bot�o
    end;
  end;


  if (ACol = 4) and (ARow <> 0) then
  begin
    gridProdutos.Canvas.FillRect(Rect);
    BUTTON := 0;
    R:=Rect;
    SCapt := 'Retirar';
    InflateRect(R,0,-1);
    DrawFrameControl(gridProdutos.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gridProdutos.Canvas do
    begin
      Brush.Style := bsClear;
      Font.Color := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);//posicionamentodo bot�o
    end;
  end;

end;

procedure TfrmCadPedido.gridProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = 3) and (CanSelect) and (gridProdutos.Cells[0,ARow] <> '') then
  begin
    pnlIngredientes.Visible := true;
  end;

  if (ACol = 4) and (CanSelect) and (gridProdutos.Cells[0,ARow] <> '') then
  begin
    if MessageDlg('Deseja Excluir o Lanche '+gridProdutos.Cells[1,ARow]+'?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
    begin
      try
        with udm.datamodule1.qryExecucao do
        begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM lanche_ingrediente');
          SQL.Add('WHERE coditmpedido = '+gridProdutos.Cells[0,ARow]);
          ExecSQL;

          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM itens_pedido');
          SQL.Add('WHERE coditmpedido = '+gridProdutos.Cells[0,ARow]);
          ExecSQL;

          ShowMessage('Lanche Exclu�do do Pedido.');
          CarregaGrid;
          CalculaTotalPedido;
        end;
      except
       ShowMessage('Erro ao tentar excluir Lanche!');
      end;
    end;
  end;
end;

end.
