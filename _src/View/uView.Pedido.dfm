object fPedido: TfPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pedido de Venda'
  ClientHeight = 611
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 60
    Align = alTop
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 1
      Top = 1
      Width = 882
      Height = 58
      Align = alClient
      Alignment = taCenter
      Caption = 'Pedido de Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 176
      ExplicitTop = 16
      ExplicitWidth = 215
      ExplicitHeight = 37
    end
  end
  object pnlCabecalhoPedido: TPanel
    Left = 0
    Top = 60
    Width = 884
    Height = 120
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 65
    object lblNúmeroPedido: TLabel
      Left = 16
      Top = 19
      Width = 104
      Height = 15
      Caption = 'N'#250'mero do Pedido:'
    end
    object lblDataEmissao: TLabel
      Left = 304
      Top = 19
      Width = 89
      Height = 15
      Caption = 'Data de Emiss'#227'o:'
    end
    object Label1: TLabel
      Left = 80
      Top = 76
      Width = 40
      Height = 15
      Caption = 'Cliente:'
    end
    object edtNúmeroPedido: TEdit
      Left = 136
      Top = 16
      Width = 137
      Height = 23
      ReadOnly = True
      TabOrder = 0
    end
    object dtpDataEmissao: TDateTimePicker
      Left = 408
      Top = 16
      Width = 186
      Height = 23
      Date = 45899.000000000000000000
      Time = 0.727017858793260500
      TabOrder = 1
    end
    object edtCodigoCliente: TEdit
      Left = 136
      Top = 73
      Width = 65
      Height = 23
      TabOrder = 2
    end
    object edtNomeCliente: TEdit
      Left = 207
      Top = 73
      Width = 387
      Height = 23
      ReadOnly = True
      TabOrder = 3
    end
    object btnBuscarCliente: TBitBtn
      Left = 600
      Top = 73
      Width = 97
      Height = 25
      Caption = 'Buscar Cliente'
      TabOrder = 4
    end
  end
  object pnlAdicionarProduto: TPanel
    Left = 0
    Top = 180
    Width = 884
    Height = 80
    Align = alTop
    TabOrder = 2
    object lblProduto: TLabel
      Left = 74
      Top = 16
      Width = 46
      Height = 15
      Caption = 'Produto:'
    end
    object lblQuantidade: TLabel
      Left = 55
      Top = 48
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
    end
    object lblValorUnitario: TLabel
      Left = 207
      Top = 48
      Width = 74
      Height = 15
      Caption = 'Valor Unit'#225'rio:'
    end
    object edtCodigoProduto: TEdit
      Left = 136
      Top = 6
      Width = 65
      Height = 23
      TabOrder = 0
    end
    object edtDescricaoProduto: TEdit
      Left = 207
      Top = 6
      Width = 387
      Height = 23
      ReadOnly = True
      TabOrder = 1
    end
    object btnBuscarProduto: TBitBtn
      Left = 600
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Buscar Produto'
      TabOrder = 2
    end
    object edtQuantidade: TEdit
      Left = 136
      Top = 43
      Width = 65
      Height = 23
      TabOrder = 3
    end
    object Edit1: TEdit
      Left = 287
      Top = 43
      Width = 106
      Height = 23
      ReadOnly = True
      TabOrder = 4
    end
    object btnAdicionarItem: TBitBtn
      Left = 408
      Top = 35
      Width = 97
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 5
    end
  end
  object dbgItensPedido: TDBGrid
    Left = 0
    Top = 260
    Width = 884
    Height = 271
    Align = alClient
    DataSource = dsItensPedido
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 531
    Width = 884
    Height = 80
    Align = alBottom
    TabOrder = 4
    ExplicitLeft = 1
    object lblTotalPedido: TLabel
      Left = 640
      Top = 32
      Width = 69
      Height = 15
      Caption = 'Total Pedido:'
    end
    object edtTotalPedido: TEdit
      Left = 715
      Top = 27
      Width = 157
      Height = 38
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnCarregar: TBitBtn
      Left = 18
      Top = 40
      Width = 120
      Height = 25
      Caption = 'Carregar Pedido'
      TabOrder = 1
    end
    object btnCancelar: TBitBtn
      Left = 153
      Top = 40
      Width = 120
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 496
      Top = 40
      Width = 120
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 3
    end
  end
  object cdsItensPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 784
    Top = 376
  end
  object dsItensPedido: TDataSource
    DataSet = cdsItensPedido
    Left = 784
    Top = 448
  end
end
