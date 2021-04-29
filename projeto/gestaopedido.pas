unit gestaopedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls;

type
  TfrmGestaoPedido = class(TForm)
    btnnovo: TButton;
    gridProdutos: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure gridProdutosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridProdutosSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnnovoClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarGrid;
  public
    { Public declarations }
  end;

var
  frmGestaoPedido: TfrmGestaoPedido;

implementation

{$R *.dfm}
uses udm, cadpedido;

procedure TfrmGestaoPedido.btnnovoClick(Sender: TObject);
begin
    Application.CreateForm(cadpedido.TfrmCadPedido, frmCadPedido);
    try
      frmCadPedido.codpedidoassocia := '';
      frmCadPedido.ShowModal;
      CarregarGrid;
    finally
      FreeAndNil(frmCadPedido);
    end;
end;

procedure TfrmGestaoPedido.CarregarGrid;
var
  i : integer;
begin
  with gridProdutos do
  begin
    RowCount := 2;
    Cells[0,0] := 'Pedido';
    Cells[1,0] := 'Desconto %';
    Cells[2,0] := 'Valor R$';
    Cells[3,0] := 'Total � Pagar R$';
    with udm.DataModule1.qryConsulta do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT *');
      sql.Add('FROM pedidos');
      Open;
      i := 1;
      while not Eof do
      begin
        Cells[0,i] := FieldByName('codpedido').AsString;
        Cells[1,i] := FormatFloat('#,##0.00',strtofloat(FieldByName('desconto').AsString));
        Cells[2,i] := FormatFloat('#,##0.00',strtofloat(FieldByName('total').AsString));
        Cells[3,i] := FormatFloat('#,##0.00',strtofloat(FieldByName('total_final').AsString));
        Next;
        RowCount:= RowCount +1;
        inc(i);
        if eof then
          RowCount := RowCount -1;
      end;
    end;

  end;

end;

procedure TfrmGestaoPedido.FormShow(Sender: TObject);
begin
  CarregarGrid;
end;

procedure TfrmGestaoPedido.gridProdutosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  SCapt : string;
begin

  if (ACol = 4) and (ARow <> 0) then
  begin
    gridProdutos.Canvas.FillRect(Rect);
    BUTTON := 0;
    R:=Rect;
    SCapt := 'Editar';
    InflateRect(R,0,-1);
    DrawFrameControl(gridProdutos.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
    with gridProdutos.Canvas do
    begin
      Brush.Style := bsClear;
      Font.Color := clBtnText;
      TextRect(Rect, (Rect.Left + Rect.Right - TextWidth(SCapt)) div 2, (Rect.Top + Rect.Bottom - TextHeight(SCapt)) div 2, SCapt);//posicionamentodo bot�o
    end;
  end;

  if (ACol = 5) and (ARow <> 0) then
  begin
    gridProdutos.Canvas.FillRect(Rect);
    BUTTON := 0;
    R:=Rect;
    SCapt := 'Excluir';
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

procedure TfrmGestaoPedido.gridProdutosSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

  if (ACol = 4) and (CanSelect) and (gridProdutos.Cells[0,ARow] <> '') then
  begin
    Application.CreateForm(cadpedido.TfrmCadPedido, frmCadPedido);
    try
      frmCadPedido.codpedidoassocia := gridProdutos.Cells[0,ARow];
      frmCadPedido.ShowModal;
      CarregarGrid;
    finally
      FreeAndNil(frmCadPedido);
    end;
  end;

  if (ACol = 5) and (CanSelect) and (gridProdutos.Cells[0,ARow] <> '') then
  begin
    if MessageDlg('Deseja Excluir o Pedido '+gridProdutos.Cells[0,ARow]+'?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
    begin
      try
        with udm.datamodule1.qryExecucao do
        begin
          {Close;
          SQL.Clear;
          SQL.Add('DELETE FROM lanche_ingrediente');
          SQL.Add('WHERE coditmpedido in (select coditmpedido from itens_pedido i');
          SQL.Add(' inner join pedidos p on p.codpedido = i.codpedido and');
          SQL.Add(' p.codpedido = '+gridProdutos.Cells[0,ARow]+')');
          ExecSQL;
          }
          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM itens_pedido');
          SQL.Add('WHERE codpedido = '+gridProdutos.Cells[0,ARow]);
          ExecSQL;

          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM pedidos WHERE codpedido = '+gridProdutos.Cells[0,ARow]);
          ExecSQL;

          ShowMessage('Pedido Exclu�do da Base de Dados.');
          CarregarGrid;
        end;
      except
       ShowMessage('Erro ao tentar excluir Pedido!');
      end;
    end;
  end;
end;

end.
