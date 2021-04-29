object frmGestaoPedido: TfrmGestaoPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Pedidos'
  ClientHeight = 439
  ClientWidth = 483
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
  object btnnovo: TButton
    Left = 8
    Top = 17
    Width = 75
    Height = 25
    Caption = '&Novo'
    TabOrder = 0
    OnClick = btnnovoClick
  end
  object gridProdutos: TStringGrid
    Left = 0
    Top = 56
    Width = 483
    Height = 383
    Align = alBottom
    Color = clAqua
    ColCount = 6
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
    TabOrder = 1
    OnDrawCell = gridProdutosDrawCell
    OnSelectCell = gridProdutosSelectCell
    ExplicitWidth = 464
    ColWidths = (
      64
      82
      84
      93
      71
      70)
    RowHeights = (
      24
      24)
  end
end
