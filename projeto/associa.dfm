object frmAssocia: TfrmAssocia
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Lanches X Ingredientes'
  ClientHeight = 370
  ClientWidth = 683
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
  object lblLanche: TLabel
    Left = 24
    Top = 22
    Width = 76
    Height = 19
    Caption = 'LANCHE : '
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
    Width = 72
    Height = 13
    Caption = 'Ingredientes .:'
  end
  object gridProdutos: TStringGrid
    Left = 0
    Top = 104
    Width = 683
    Height = 266
    Align = alBottom
    Color = clAqua
    ColCount = 4
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
      413
      104
      87)
    RowHeights = (
      24
      24)
  end
  object edtCodIngrediente: TEdit
    Left = 24
    Top = 77
    Width = 41
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    OnExit = edtCodIngredienteExit
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
    Caption = 'Associar'
    TabOrder = 3
    OnClick = Button1Click
  end
end
