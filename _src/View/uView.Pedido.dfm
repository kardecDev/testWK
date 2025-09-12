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
  OnClose = FormClose
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
    Height = 91
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
      Font.Color = clBlack
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
      Top = 55
      Width = 48
      Height = 15
      Caption = 'Cliente: *'
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
      Enabled = False
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
      OnChange = dtpDataEmissaoChange
    end
    object edtCodigoCliente: TEdit
      Left = 136
      Top = 52
      Width = 65
      Height = 23
      TabOrder = 2
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
    end
    object edtNomeCliente: TEdit
      Left = 207
      Top = 52
      Width = 387
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 3
    end
    object btnBuscarCliente: TBitBtn
      Left = 600
      Top = 52
      Width = 97
      Height = 25
      Caption = 'Buscar Cliente'
      TabOrder = 4
      TabStop = False
      OnClick = btnBuscarClienteClick
    end
  end
  object pnlAdicionarProduto: TPanel
    Left = 0
    Top = 151
    Width = 884
    Height = 80
    Align = alTop
    Color = 16506555
    ParentBackground = False
    TabOrder = 2
    object lblProduto: TLabel
      Left = 74
      Top = 16
      Width = 54
      Height = 15
      Caption = 'Produto: *'
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
      Width = 73
      Height = 15
      Caption = 'Quantidade: *'
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
      Width = 82
      Height = 15
      Caption = 'Valor Unit'#225'rio: *'
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
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
    object btnBuscarProduto: TBitBtn
      Left = 600
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Buscar Produto'
      TabOrder = 5
      TabStop = False
      OnClick = btnBuscarProdutoClick
    end
    object edtQuantidade: TEdit
      Left = 136
      Top = 43
      Width = 65
      Height = 23
      TabOrder = 2
    end
    object edtValorUnitario: TEdit
      Left = 325
      Top = 43
      Width = 106
      Height = 23
      TabOrder = 3
    end
    object btnAdicionarItem: TBitBtn
      Left = 440
      Top = 43
      Width = 97
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 4
      OnClick = btnAdicionarItemClick
    end
  end
  object dbgItensPedido: TDBGrid
    Left = 0
    Top = 231
    Width = 884
    Height = 302
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo Produto'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o'
        Width = 330
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'quantidade'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'vlr_unitario'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Unit'#225'rio'
        Width = 150
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'vlr_total'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Total'
        Width = 150
        Visible = True
      end>
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 533
    Width = 884
    Height = 78
    Align = alBottom
    TabOrder = 4
    object lblTotalPedido: TLabel
      Left = 542
      Top = 17
      Width = 100
      Height = 21
      Caption = 'Total Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 13
      Top = 58
      Width = 247
      Height = 15
      Caption = '* Indica campos de preenchimento obrigat'#243'rio'
    end
    object edtTotalPedido: TEdit
      Left = 648
      Top = 9
      Width = 229
      Height = 38
      TabStop = False
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object btnCarregar: TBitBtn
      Left = 148
      Top = 6
      Width = 120
      Height = 45
      Caption = 'Carregar Pedido'
      TabOrder = 1
      OnClick = btnCarregarClick
    end
    object btnCancelar: TBitBtn
      Left = 281
      Top = 6
      Width = 120
      Height = 45
      Caption = 'Cancelar Pedido'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnGrvarPedido: TBitBtn
      Left = 413
      Top = 6
      Width = 120
      Height = 45
      Caption = 'Gravar Pedido'
      TabOrder = 3
      OnClick = btnGrvarPedidoClick
    end
    object btnNovoPedido: TBitBtn
      Left = 16
      Top = 6
      Width = 120
      Height = 45
      Caption = 'Novo Pedido'
      TabOrder = 0
      OnClick = btnNovoPedidoClick
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
    object mtItensPedidodescricao: TStringField
      FieldName = 'descricao'
      Size = 255
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
    object mtItensPedidoUID: TStringField
      FieldName = 'UID'
      Size = 100
    end
  end
end
