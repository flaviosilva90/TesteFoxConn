object frmGerenciamento: TfrmGerenciamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Gerenciamento de Produtos'
  ClientHeight = 367
  ClientWidth = 736
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
  object gridProdutos: TStringGrid
    Left = 0
    Top = 40
    Width = 736
    Height = 327
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
      449
      64
      64
      64)
    RowHeights = (
      24
      24)
  end
  object Atualizar: TButton
    Left = 653
    Top = 9
    Width = 75
    Height = 25
    Caption = '&Atualizar'
    TabOrder = 1
    OnClick = AtualizarClick
  end
end
