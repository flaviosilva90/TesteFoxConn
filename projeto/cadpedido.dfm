object frmCadPedido: TfrmCadPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Pedidos'
  ClientHeight = 414
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblPedido: TLabel
    Left = 24
    Top = 22
    Width = 74
    Height = 19
    Caption = 'PEDIDO : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 56
    Width = 50
    Height = 13
    Caption = 'Lanches .:'
  end
  object gridProdutos: TStringGrid
    Left = 0
    Top = 112
    Width = 692
    Height = 302
    Align = alBottom
    Color = clAqua
    Ctl3D = True
    DoubleBuffered = False
    FixedCols = 0
    RowCount = 2
    GradientEndColor = clBlack
    GradientStartColor = clBlack
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnDrawCell = gridProdutosDrawCell
    OnSelectCell = gridProdutosSelectCell
    ColWidths = (
      64
      337
      104
      87
      83)
    RowHeights = (
      24
      24)
  end
  object edtCodLanche: TEdit
    Left = 24
    Top = 77
    Width = 41
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    OnExit = edtCodLancheExit
  end
  object edtNome: TEdit
    Left = 80
    Top = 77
    Width = 473
    Height = 21
    Enabled = False
    NumbersOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 559
    Top = 74
    Width = 98
    Height = 25
    Caption = 'Incluir'
    TabOrder = 3
    OnClick = Button1Click
  end
  object pnlIngredientes: TPanel
    Left = 192
    Top = 168
    Width = 321
    Height = 89
    TabOrder = 4
    object Label2: TLabel
      Left = 24
      Top = 17
      Width = 72
      Height = 13
      Caption = 'Ingredientes .:'
    end
    object Label3: TLabel
      Left = 268
      Top = 17
      Width = 40
      Height = 13
      Caption = 'Valor R$'
    end
    object edtCodIngrediente: TEdit
      Left = 25
      Top = 36
      Width = 41
      Height = 21
      NumbersOnly = True
      TabOrder = 0
      OnExit = edtCodIngredienteExit
    end
    object Edit1: TEdit
      Left = 80
      Top = 36
      Width = 153
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 1
    end
    object Button2: TButton
      Left = 167
      Top = 61
      Width = 66
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 242
      Top = 61
      Width = 66
      Height = 25
      Caption = 'Fechar'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Edit2: TEdit
      Left = 239
      Top = 36
      Width = 69
      Height = 21
      Enabled = False
      NumbersOnly = True
      TabOrder = 4
    end
  end
end
