object fPedido: TfPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pedido de Venda'
  ClientHeight = 611
  ClientWidth = 884
  Color = 16642787
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
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
    Color = 16506555
    ParentBackground = False
    TabOrder = 1
    object lblNúmeroPedido: TLabel
      Left = 16
      Top = 19
      Width = 104
      Height = 15
      Caption = 'N'#250'mero do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblDataEmissao: TLabel
      Left = 304
      Top = 19
      Width = 89
      Height = 15
      Caption = 'Data de Emiss'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2171169
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 80
      Top = 76
      Width = 40
      Height = 15
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2171169
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtNumeroPedido: TEdit
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
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
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
      OnClick = btnBuscarClienteClick
    end
  end
  object pnlAdicionarProduto: TPanel
    Left = 0
    Top = 180
    Width = 884
    Height = 80
    Align = alTop
    Color = 16506555
    ParentBackground = False
    TabOrder = 2
    object lblProduto: TLabel
      Left = 74
      Top = 16
      Width = 46
      Height = 15
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2171169
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 55
      Top = 48
      Width = 65
      Height = 15
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2171169
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblValorUnitario: TLabel
      Left = 233
      Top = 48
      Width = 74
      Height = 15
      Caption = 'Valor Unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2171169
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtCodigoProduto: TEdit
      Left = 136
      Top = 6
      Width = 65
      Height = 23
      TabOrder = 0
      OnChange = edtCodigoProdutoChange
      OnExit = edtCodigoProdutoExit
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
      OnClick = btnBuscarProdutoClick
    end
    object edtQuantidade: TEdit
      Left = 136
      Top = 43
      Width = 65
      Height = 23
      TabOrder = 3
    end
    object edtValorUnitario: TEdit
      Left = 313
      Top = 43
      Width = 106
      Height = 23
      ReadOnly = True
      TabOrder = 4
    end
    object btnAdicionarItem: TBitBtn
      Left = 428
      Top = 44
      Width = 97
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 5
      OnClick = btnAdicionarItemClick
    end
  end
  object dbgItensPedido: TDBGrid
    Left = 0
    Top = 260
    Width = 884
    Height = 271
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = dbgItensPedidoKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Caption = 'C'#243'digo Produto'
        Width = 176
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Quantidade'
        Width = 213
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlr_unitario'
        Title.Caption = 'Vlr. Unit'#225'rio'
        Width = 221
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlr_total'
        Title.Caption = 'Vlr. Total'
        Width = 254
        Visible = True
      end>
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 531
    Width = 884
    Height = 80
    Align = alBottom
    TabOrder = 4
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
      OnClick = btnCarregarClick
    end
    object btnCancelar: TBitBtn
      Left = 153
      Top = 40
      Width = 120
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btn_GrvarPedido: TBitBtn
      Left = 496
      Top = 40
      Width = 120
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 3
      OnClick = btn_GrvarPedidoClick
    end
  end
  object dsItensPedido: TDataSource
    DataSet = mtItensPedido
    Left = 784
    Top = 448
  end
  object mtItensPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 784
    Top = 384
    object mtItensPedidoid_produto: TIntegerField
      FieldName = 'id_produto'
    end
    object mtItensPedidonumero_pedido: TIntegerField
      DisplayLabel = 'N'#250'mero Pedido'
      FieldName = 'numero_pedido'
    end
    object mtItensPedidocodigo_produto: TIntegerField
      DisplayLabel = 'C'#243'digo Produto'
      FieldName = 'codigo_produto'
    end
    object mtItensPedidoquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object mtItensPedidovlr_unitario: TCurrencyField
      DisplayLabel = 'Vlr. Unit'#225'rio'
      FieldName = 'vlr_unitario'
    end
    object mtItensPedidovlr_total: TCurrencyField
      DisplayLabel = 'Vlr. Total'
      FieldName = 'vlr_total'
    end
  end
end
