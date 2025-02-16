object FrmPedidoVenda: TFrmPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Pedidos de Vendas'
  ClientHeight = 423
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = [fsBold]
  OnCreate = FormCreate
  TextHeight = 15
  object CodProduto: TLabel
    Left = 8
    Top = 115
    Width = 106
    Height = 15
    Caption = 'C'#243'digo do Produto:'
  end
  object Quantidade: TLabel
    Left = 144
    Top = 115
    Width = 67
    Height = 15
    Caption = 'Quantidade:'
  end
  object ValorUnit: TLabel
    Left = 280
    Top = 115
    Width = 79
    Height = 15
    Caption = 'Valor Unit'#225'rio:'
  end
  object CodCliente: TLabel
    Left = 8
    Top = 35
    Width = 100
    Height = 15
    Caption = 'C'#243'digo do Cliente:'
  end
  object NomeCliente: TLabel
    Left = 144
    Top = 35
    Width = 96
    Height = 15
    Caption = 'Nome do Cliente:'
  end
  object edtCodCliente: TEdit
    Left = 8
    Top = 56
    Width = 121
    Height = 23
    TabOrder = 1
    OnExit = edtCodClienteExit
  end
  object edtNomeCliente: TEdit
    Left = 144
    Top = 56
    Width = 257
    Height = 23
    ReadOnly = True
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 388
    Width = 634
    Height = 35
    Align = alBottom
    TabOrder = 9
    ExplicitTop = 481
    ExplicitWidth = 632
    object lblTotal: TLabel
      Left = 7
      Top = 13
      Width = 61
      Height = 15
      Caption = 'Valor Total:'
    end
    object btnGravarPedido: TButton
      Left = 463
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarPedidoClick
    end
    object btnSair: TButton
      Left = 544
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Sair'
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object gridProdutos: TStringGrid
    Left = 0
    Top = 179
    Width = 634
    Height = 209
    Align = alBottom
    FixedCols = 0
    TabOrder = 8
    OnDragDrop = gridProdutosDragDrop
    ExplicitTop = 272
    ExplicitWidth = 632
    ColWidths = (
      64
      64
      64
      64
      64)
  end
  object edCodProduto: TEdit
    Left = 8
    Top = 136
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object edQuantidade: TEdit
    Left = 144
    Top = 136
    Width = 121
    Height = 23
    TabOrder = 4
  end
  object edValorUnit: TEdit
    Left = 280
    Top = 136
    Width = 121
    Height = 23
    TabOrder = 5
    OnExit = edValorUnitExit
    OnKeyPress = edValorUnitKeyPress
  end
  object btnInserirPedido: TButton
    Left = 417
    Top = 134
    Width = 64
    Height = 25
    Caption = 'Inserir'
    TabOrder = 6
    OnClick = btnInserirPedidoClick
  end
  object btnCarregarPedido: TButton
    Left = 417
    Top = 55
    Width = 66
    Height = 25
    Caption = 'Carregar'
    TabOrder = 0
    OnClick = btnCarregarPedidoClick
  end
  object btnCancelarPedido: TButton
    Left = 487
    Top = 134
    Width = 66
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 7
    OnClick = btnCancelarPedidoClick
  end
  object tDialogs: TTaskDialog
    Buttons = <>
    RadioButtons = <>
    Left = 592
    Top = 8
  end
end
